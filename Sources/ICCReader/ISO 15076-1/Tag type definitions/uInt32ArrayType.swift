//
//  uInt32ArrayType.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// [ICC.1:2010] 10.25 uInt32ArrayType
/// This type represents an array of generic 4–byte (32-bit) quantity. The number of values is determined from the size of the tag.
/// When used the byte assignment and encoding shall be as given in Table 78.
public struct uInt32ArrayType {
    public let sig: TagTypeSignature
    public let reserved: uInt32Number
    public let values: [UInt32]
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position
        
        guard size >= 8 && (size - 8) % 4 == 0 else {
            throw ICCReadError.corrupted
        }
        
        /// 0 to 3 4 ‘ui32’ (75693332h) type signature
        self.sig = try TagTypeSignature(dataStream: &dataStream)
        guard self.sig ==  .uInt32ArrayType else {
            throw ICCReadError.corrupted
        }
        
        /// 4 to 7 4 Reserved, shall be set to 0
        self.reserved = try dataStream.read(endianess: .bigEndian)
        
        /// 8 to end Variable An array of unsigned 32-bit integers
        var values: [UInt32] = []
        let count = (Int(size) - 8) / 4
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
