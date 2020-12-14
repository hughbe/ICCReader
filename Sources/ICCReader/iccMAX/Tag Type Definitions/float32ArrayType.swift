//
//  float32ArrayType.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// [ICC.2:2019] 10.2.9 float32ArrayType
/// This type represents an array of generic 32-bit encoded single-precision floating point numbers values. The number of values is
/// determined from the size of the tag.
/// When used, the byte assignment and encoding shall be as given in Table 49.
public struct float32ArrayType {
    public let sig: TagTypeSignature
    public let reserved: uInt32Number
    public let values: [Float]
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position
        
        guard size >= 8 && (size - 8) % 4 == 0 else {
            throw ICCReadError.corrupted
        }
        
        /// 0..3 4 'fl32' (666c3332h) type signature
        self.sig = try TagTypeSignature(dataStream: &dataStream)
        guard self.sig ==  .float32ArrayType else {
            throw ICCReadError.corrupted
        }
        
        /// 4..7 4 Reserved, shall be 0
        self.reserved = try dataStream.read(endianess: .bigEndian)
        
        /// 8..end 4N An array of 32-bit single-precision floating point numbers float32Number[...]
        var values: [Float] = []
        let count = (Int(size) - 8) / 4
        values.reserveCapacity(count)
        for _ in 0..<count {
            values.append(try dataStream.readFloat(endianess: .bigEndian))
        }
        
        self.values = values
        
        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }
}
