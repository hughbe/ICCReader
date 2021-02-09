//
//  multiProcessElementsType.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// [ICC.1:2010] 10.14 multiProcessElementsType
/// 10.14.1 General
/// This structure represents a colour transform, containing a sequence of processing elements. The processing elements contained in
/// the structure are defined in the structure itself, allowing for a flexible structure. Currently supported processing elements are: a set
/// of one dimensional curves, a matrix with offset terms, and a multidimensional lookup table (CLUT). Other processing element types
/// may be added in the future. Each type of processing element may be contained any number of times in the structure. The processing
/// elements support float32Number-encoded input and output ranges.
/// If undefined processing element types are present in a multiProcessElementsType tag, the multiProcessElementsType tag shall not
/// be used and fall back behaviour shall be followed.
/// When using this type, it is necessary to assign each colour space component to an input and output channel.
/// These assignments shall be as shown in Table 38.
/// When used, the byte assignment and encoding shall be as given in Table 52.
/// The number of processing elements (n) shall be greater than or equal to 1. The process element positions table contains information
/// on where and how large the process elements are. Offset locations are relative to the start of the multiProcessElementsType tag.
/// Thus the offset of first stored process element shall be 16+8n.
/// Each processing element shall start on a 4-byte boundary. To achieve this, each item shall be followed by up to three 00h pad
/// bytes as needed.
/// It is permitted to share data between processing elements. For example, the offsets for some processing elements can be identical.
public struct multiProcessElementsType {
    public let sig: ICCSignature
    public let reserved: uInt32Number
    public let numberOfInputChannels: UInt16
    public let numberOfOutputChannels: UInt16
    public let numberOfProcessingElements: UInt32
    public let values: [[UInt8]]
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position
        
        guard size >= 16 else {
            throw ICCReadError.corrupted
        }
        
        /// 0 to 3 4 ‘mpet’ (6D706574h) [multi-process elements table] type signature
        self.sig = try ICCSignature(dataStream: &dataStream)
        guard self.sig ==  ICCTagTypeSignature.multiProcessElements else {
            throw ICCReadError.corrupted
        }
        
        /// 4 to 7 4 Reserved, shall be set to 0
        self.reserved = try dataStream.read(endianess: .bigEndian)
        
        /// 8 to 9 2 Number of input channels uInt16Number
        self.numberOfInputChannels = try dataStream.read(endianess: .bigEndian)
        
        /// 10 to 11 2 Number of output channels uInt16Number
        self.numberOfOutputChannels = try dataStream.read(endianess: .bigEndian)
        
        /// 12 to 15 2 Number of processing elements (n) uInt32Number
        let numberOfProcessingElements: UInt32 = try dataStream.read(endianess: .bigEndian)
        guard 16 + numberOfProcessingElements * 8 <= size else {
            throw ICCReadError.corrupted
        }
        
        self.numberOfProcessingElements = numberOfProcessingElements
        
        /// 16 to 15+8n 8n Process element positions table positionNumber[...]
        /// 16+8n to end Data
        var values: [[UInt8]] = []
        values.reserveCapacity(Int(self.numberOfProcessingElements))
        for _ in 0..<self.numberOfProcessingElements {
            let position = try positionNumber(dataStream: &dataStream)
            
            let oldPosition = dataStream.position
            guard position.offset % 4 == 0 &&
                    position.offset >= 16 + numberOfProcessingElements * 8 &&
                    position.offset + position.size <= size else {
                throw ICCReadError.corrupted
            }
            
            let dataStartPosition = startPosition + Int(position.offset)
            dataStream.position = dataStartPosition
            values.append(try dataStream.readBytes(count: Int(position.size)))
            
            guard dataStream.position - dataStartPosition == position.size else {
                throw ICCReadError.corrupted
            }
            
            dataStream.position = oldPosition
        }
        
        self.values = values
        
        /// Skip the data we've already read.
        dataStream.position = startPosition + Int(size)
        
        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }
}
