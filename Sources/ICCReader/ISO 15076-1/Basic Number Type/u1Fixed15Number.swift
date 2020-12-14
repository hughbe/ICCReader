//
//  u1Fixed15Number.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// [ICC.1:2010] 4.8 u1Fixed15Number
/// A u1Fixed15Number is a fixed unsigned 2-byte (16-bit) quantity having15 fractional bits as shown in Table 6.
public struct u1Fixed15Number {
    public let iPart: UInt8
    public let fPart: UInt16
    
    public var value: Float {
        Float(iPart) + Float(fPart) / 32768
    }
    
    public init(rawValue: UInt16) {
        self.fPart = UInt16(rawValue & 0x7FFF)
        self.iPart = UInt8(rawValue >> 15)
    }
    
    public init(dataStream: inout DataStream) throws {
        self.init(rawValue: try dataStream.read(endianess: .bigEndian))
    }
}
