//
//  u16Fixed16Number.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// [ICC.1:2010] 4.7 u16Fixed16Number
/// A u16Fixed16Number is a fixed unsigned 4-byte (32-bit) quantity having 16 fractional bits as shown in Table 5.
public struct u16Fixed16Number {
    public let iPart: UInt16
    public let fPart: UInt16
    
    public var value: Float {
        Float(iPart) + Float(fPart) / 65536
    }
    
    public init(rawValue: UInt32) {
        self.fPart = UInt16(rawValue & 0xFFFF)
        self.iPart = UInt16(rawValue >> 16)
    }
    
    public init(dataStream: inout DataStream) throws {
        self.init(rawValue: try dataStream.read(endianess: .bigEndian))
    }
}
