//
//  float16ArrayType.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// [ICC.2:2019] 10.2.8 float16ArrayType
/// This type represents an array of generic 16-bit encoded half-precision floating point values. The number of values is determined
/// from the size of the tag.
/// When used, the byte assignment and encoding shall be as given in Table 48.
public struct float16ArrayType {
    public let sig: TagTypeSignature
    public let reserved: uInt32Number
    public let values: [UInt16]
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position
        
        guard size >= 8 && (size - 8) % 2 == 0 else {
            throw ICCReadError.corrupted
        }
        
        /// 0..3 4 'fl16' (666c3136h) type signature
        self.sig = try TagTypeSignature(dataStream: &dataStream)
        guard self.sig ==  .float16ArrayType else {
            throw ICCReadError.corrupted
        }
        
        /// 4..7 4 Reserved, shall be 0
        self.reserved = try dataStream.read(endianess: .bigEndian)
        
        /// 8..end 2N An array of 16-bit half-precision floating point numbers float16Number[...]
        var values: [UInt16] = []
        let count = (Int(size) - 8) / 2
        values.reserveCapacity(count)
        for _ in 0..<count {
            values.append(try dataStream.read(endianess: .bigEndian))
        }
        
        self.values = values
        
        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }
}
