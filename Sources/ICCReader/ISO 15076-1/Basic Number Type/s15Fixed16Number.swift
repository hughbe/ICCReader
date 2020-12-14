//
//  s15Fixed16Number.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// [ICC.1:2010] 4.6 s15Fixed16Number
/// An s15Fixed16Number is a fixed signed 4-byte (32-bit) quantity which has 16 fractional bits as shown in Table 4.
/// Table 4 —
/// s15Fixed16Number Number Encoded as
/// −32 768,0 80000000h
/// 0 00000000h
/// 1,0 00010000h
/// 32 767 + (65 535/65 536) 7FFFFFFFh
public struct s15Fixed16Number {
    public let iPart: Int16
    public let fPart: UInt16
    
    public var value: Float {
        Float(iPart) + Float(fPart) / 65536
    }
    
    public init(rawValue: UInt32) {
        self.fPart = UInt16(rawValue & 0xFFFF)
        self.iPart = Int16(bitPattern: UInt16(rawValue >> 16))
    }
    
    public init(dataStream: inout DataStream) throws {
        self.init(rawValue: try dataStream.read(endianess: .bigEndian))
    }
}
