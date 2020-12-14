//
//  uInt64ArrayType.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// [ICC.1:2010] 10.26 uInt64ArrayType
/// This type represents an array of generic 8–byte (64-bit) quantity. The number of values is determined from the size of the tag.
/// When used the byte assignment and encoding shall be as given in Table 79.
public struct uInt64ArrayType {
    public let sig: TagTypeSignature
    public let reserved: uInt32Number
    public let values: [UInt64]
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position
        
        guard size >= 8 && (size - 8) % 8 == 0 else {
            throw ICCReadError.corrupted
        }
        
        /// 0 to 3 4 ‘ui64’ (75693634h) type signature
        self.sig = try TagTypeSignature(dataStream: &dataStream)
        guard self.sig ==  .uInt64ArrayType else {
            throw ICCReadError.corrupted
        }
        
        /// 4 to 7 4 Reserved, shall be set to 0
        self.reserved = try dataStream.read(endianess: .bigEndian)
        
        /// 8 to end Variable An array of unsigned 64-bit integers
        var values: [UInt64] = []
        let count = (Int(size) - 8) / 16
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
