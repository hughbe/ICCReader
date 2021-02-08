//
//  XYZType.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// 6.5.22 XYZType
/// The XYZType contains an array of three encoded values for the XYZ tristimulus values. The number of sets of values is determined
/// from the size of the tag. The byte stream is given below. Tristimulus values must be non-negative, the signed encoding allows for
/// implementation optimizations by minimizing the number of fixed formats.
public struct XYZType {
    public let sig: ICCSignature
    public let reserved: uInt32Number
    public let values: [XYZNumber]
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position
        
        guard size >= 8 && (size - 8) % 12 == 0 else {
            throw ICCReadError.corrupted
        }
        
        /// 0-3 ‘XYZ ‘(58595A20h) type descriptor
        self.sig = try ICCSignature(dataStream: &dataStream)
        guard self.sig ==  ICCTagTypeSignature.xyz else {
            throw ICCReadError.corrupted
        }
        
        /// 4-7 reserved, must be set to 0
        self.reserved = try dataStream.read(endianess: .bigEndian)
        
        /// 8-n an array of XYZ numbers XYZNumber
        let count = (Int(size) - 8) / 12
        var values: [XYZNumber] = []
        values.reserveCapacity(count)
        for _ in 0..<count {
            values.append(try XYZNumber(dataStream: &dataStream))
        }
        
        self.values = values
        
        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }
}
