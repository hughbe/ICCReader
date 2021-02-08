//
//  float64ArrayType.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// [ICC.2:2019] 10.2.10 float64ArrayType
/// This type represents an array of generic 64-bit encoded double-precision floating point numbers values. The number of values is
/// determined from the size of the tag.
/// When used, the byte assignment and encoding shall be as given in Table 50.
public struct float64ArrayType {
    public let sig: ICCSignature
    public let reserved: uInt32Number
    public let values: [Double]
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position
        
        guard size >= 8 && (size - 8) % 8 == 0 else {
            throw ICCReadError.corrupted
        }
        
        /// 0..3 4 'fl64' (666c3634h) type signature
        self.sig = try ICCSignature(dataStream: &dataStream)
        guard self.sig ==  ICCTagTypeSignature.float64Array else {
            throw ICCReadError.corrupted
        }
        
        /// 4..7 4 Reserved, shall be 0
        self.reserved = try dataStream.read(endianess: .bigEndian)
        
        /// 8..end 8N An array of 64-bit double-precision floating point numbers float64Number[...]
        var values: [Double] = []
        let count = (Int(size) - 8) / 8
        values.reserveCapacity(count)
        for _ in 0..<count {
            values.append(try dataStream.readDouble(endianess: .bigEndian))
        }
        
        self.values = values
        
        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }
}
