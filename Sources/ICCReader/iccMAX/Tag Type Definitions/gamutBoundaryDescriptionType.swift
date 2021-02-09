//
//  gamutBoundaryDescriptionType.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// [ICC.2:2019] 10.2.11 gamutBoundaryDescriptionType
/// The GamutBoundaryDescriptionType structure encodes a collection of vertices and faces that describe a gamut boundary. The vertices
/// contain a PCS value and an optional device value. The faces contain a list of vertex IDs. The order of the vertex IDs shall be clockwise
/// when viewed from outside of the gamut. The encoding shall be as shown in Table 51.
/// The number of PCS channels (P) shall be three or greater. The number of output channels (Q) can be zero if device values are not
/// included.
/// The number of vertices shall be four or greater.
/// The number of faces shall be four or greater.
/// The array of vertex IDs is an array that specifies the IDs of each vertex of each face. The array is organized so that the three IDs of
/// the first face are specified first, the three IDs of the second face next, and so on.
/// The ID of the vertex is a number that shall be between 0 and V-1. This ID corresponds to the order of the vertices in the vertex array.
/// The array of vertex PCS values contains one PCS value for each vertex. The order of the vertices corresponds with the vertex IDS
/// from the face description. The range of the Output Channels is the range of values that can be represented as float32Number.
/// The optional array of device values contains one device value for each vertex. The order of the vertices
/// DS from the face description. The range of the Output Channels is the range of values that can be represented as float32Number.
/// The set of faces should constitute a closed volume.
/// NOTE Euler’s formula can be used to verify that the volume is closed.
/// Annex B provides details of the encoding and use of a gamutBoundaryDescriptionType.
public struct gamutBoundaryDescriptionType {
    public let sig: ICCSignature
    public let reserved: uInt32Number
    public let numberOfPCSChannels: UInt16
    public let numberOfDeviceChannels: UInt16
    public let numberOfVertices: UInt32
    public let numberOfFaces: UInt32
    public let vertexIDs: [(UInt32, UInt32, UInt32)]
    public let pcsCoordinates: [Float]
    public let deviceCoordinates: [Float]
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position

        guard size >= 20 else {
            throw ICCReadError.corrupted
        }
        
        /// 0..3 4 'gbd ' (67626420h) type signature
        self.sig = try ICCSignature(dataStream: &dataStream)
        guard self.sig ==  ICCTagTypeSignature.gamutBoundaryDescription else {
            throw ICCReadError.corrupted
        }
        
        /// 4..7 4 Reserved, shall be 0
        self.reserved = try dataStream.read(endianess: .bigEndian)
        
        /// 8..9 2 Number of PCS channels (P) uInt16Number
        self.numberOfPCSChannels = try dataStream.read(endianess: .bigEndian)
        
        /// 10..11 2 Number of device channels (Q) uInt16Number
        self.numberOfDeviceChannels = try dataStream.read(endianess: .bigEndian)
        
        /// 16..19 4 Number of vertices (V) uInt32Number
        self.numberOfVertices = try dataStream.read(endianess: .bigEndian)

        /// 16..19 4 Number of faces (F) uInt32Number
        self.numberOfFaces = try dataStream.read(endianess: .bigEndian)
        
        let pcsCoordinateCount = Int(self.numberOfPCSChannels) * Int(self.numberOfVertices)
        let deviceCoordinateCount = Int(self.numberOfDeviceChannels) * Int(self.numberOfVertices)
        guard 20 + Int(self.numberOfFaces) * 12 + pcsCoordinateCount * 4 + deviceCoordinateCount * 4 <= size else {
            throw ICCReadError.corrupted
        }
        
        /// 20 .. 19+F*12 F*12 Array of vertex IDs for each face uInt32Number
        var vertexIDs: [(UInt32, UInt32, UInt32)] = []
        vertexIDs.reserveCapacity(Int(self.numberOfFaces))
        for _ in 0..<self.numberOfFaces {
            vertexIDs.append((
                try dataStream.read(endianess: .bigEndian),
                try dataStream.read(endianess: .bigEndian),
                try dataStream.read(endianess: .bigEndian)
            ))
        }
        
        self.vertexIDs = vertexIDs

        /// 20+F*12 .. 19+F*12+V*P*4 V*P*4 Array of PCS coordinates for each vertex float32Number
        var pcsCoordinates: [Float] = []
        pcsCoordinates.reserveCapacity(pcsCoordinateCount)
        for _ in 0..<pcsCoordinateCount {
            pcsCoordinates.append(try dataStream.readFloat(endianess: .bigEndian))
        }
        
        self.pcsCoordinates = pcsCoordinates

        /// 20+F*12+V*P*4 … end V*Q*4 Array of device coordinates for each vertex float32Number
        var deviceCoordinates: [Float] = []
        deviceCoordinates.reserveCapacity(deviceCoordinateCount)
        for _ in 0..<deviceCoordinateCount {
            deviceCoordinates.append(try dataStream.readFloat(endianess: .bigEndian))
        }
        
        self.deviceCoordinates = deviceCoordinates
        
        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }
}
