//
//  u8Fixed8Number.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// [ICC.1:2010] 4.9 u8Fixed8Number
/// A u8Fixed8Numberfixed is an unsigned 2-byte (16-bit) quantity having 8 fractional bits as shown in Table 7.
public struct u8Fixed8Number {
    public let iPart: UInt8
    public let fPart: UInt8
    
    public var value: Float {
        Float(iPart) + Float(fPart) / 256
    }
    
    public init(rawValue: UInt16) {
        self.fPart = UInt8(rawValue & 0xFF)
        self.iPart = UInt8(rawValue >> 8)
    }
    
    public init(dataStream: inout DataStream) throws {
        self.init(rawValue: try dataStream.read(endianess: .bigEndian))
    }
}
