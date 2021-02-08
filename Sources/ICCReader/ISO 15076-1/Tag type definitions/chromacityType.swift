//
//  chromacityType.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// [ICC.1:2010] 10.2 chromaticityType
/// The chromaticity tag type provides basic chromaticity data and type of phosphors or colorants of a monitor to applications and utilities.
/// When used, the byte assignment shall be as given in Table 30. The CIE xy values shall be as measured, and shall not be chromatically
/// adapted to the PCS adopted white.
/// When using this type, it is necessary to assign each colour component to a device channel. Table 38 “lut16Type channel encodings”
/// shows these assignments.
/// The encoding for byte positions 10 and 11 is shown in Table 31. If the value is 0001h to 0004h, the number of channels shall be three
/// and the phosphor chromaticities in byte positions 12 to 35 shall match those listed in the appropriate row of Table 31.
/// When the encoded value in byte position 10 and 11 is 0000h, the actual set of chromaticity values shall be described.
public struct chromacityType {
    public let sig: ICCSignature
    public let reserved: uInt32Number
    public let numberOfDeviceChannels: UInt16
    public let phosphorOrColorantType: PhosphorOrColorantType
    public let values: [(x: u16Fixed16Number, y: u16Fixed16Number)]
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position
        
        guard size >= 12 && (size - 12) % 8 == 0 else {
            throw ICCReadError.corrupted
        }
        
        /// 0 to 3 4 ’chrm’ (6368726Dh) type signature
        self.sig = try ICCSignature(dataStream: &dataStream)
        guard self.sig ==  ICCTagTypeSignature.chromacity else {
            throw ICCReadError.corrupted
        }
        
        /// 4 to 7 4 Reserved, shall be set to 0
        self.reserved = try dataStream.read(endianess: .bigEndian)
        
        /// 8 to 9 2 Number of device channels (n) uInt16Number
        self.numberOfDeviceChannels = try dataStream.read(endianess: .bigEndian)
        guard 12 + self.numberOfDeviceChannels * 8 == size else {
            throw ICCReadError.corrupted
        }
        
        /// 10 to 11 2 Encoded value of phosphor or colorant type see Table 31
        let phosphorOrColorantTypeRaw: UInt16 = try dataStream.read(endianess: .bigEndian)
        guard let phosphorOrColorantType = PhosphorOrColorantType(rawValue: phosphorOrColorantTypeRaw) else {
            throw ICCReadError.corrupted
        }
        
        self.phosphorOrColorantType = phosphorOrColorantType
        
        /// 12 to 19 8 CIE xy coordinate values of channel 1 u16Fixed16Number[2]
        /// 20 to end 8(n−1) CIE xy coordinate values of other channels (if needed) u16Fixed16Number [...]
        var values: [(u16Fixed16Number, u16Fixed16Number)] = []
        values.reserveCapacity(Int(self.numberOfDeviceChannels))
        for _ in 0..<self.numberOfDeviceChannels {
            values.append((try u16Fixed16Number(dataStream: &dataStream),
                           try u16Fixed16Number(dataStream: &dataStream)))
        }
        
        self.values = values
        
        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }
    
    /// 10 to 11 2 Encoded value of phosphor or colorant type see Table 31
    public enum PhosphorOrColorantType: UInt16 {
        /// Unknown 0000h Any Any Any
        case unknown = 0x0000
        
        /// ITU-R BT.709-2 0001h (0,640, 0,330) (0,300, 0,600) (0,150, 0,060)
        case ituRBT092 = 0x0001
        
        /// SMPTE RP145 0002h (0,630, 0,340) (0,310, 0,595) (0,155, 0,070)
        case smpteRP145 = 0x0002
        
        /// EBU Tech. 3213-E 0003h (0,640 0,330) (0,290, 0,600) (0,150, 0,060)
        case ebuTech3213E = 0x0003
        
        /// P22 0004h (0,625, 0,340) (0,280, 0,605) (0,155, 0,070)
        case p22 = 0x0004
    }
}
