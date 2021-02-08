//
//  uInt16ArrayType.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// [ICC.1:2010] 10.24 uInt16ArrayType
/// This type represents an array of generic 2-byte (16-bit) quantity. The number of values is determined from the size of the tag.
/// When used the byte assignment and encoding shall be as given in Table 77.
public struct uInt16ArrayType {
    public let sig: ICCSignature
    public let reserved: uInt32Number
    public let values: [UInt16]
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position
        
        guard size >= 8 && (size - 8) % 2 == 0 else {
            throw ICCReadError.corrupted
        }
        
        /// 0 to 3 4 ‘ui16’ (75693136h) type signature
        self.sig = try ICCSignature(dataStream: &dataStream)
        guard self.sig ==  ICCTagTypeSignature.uInt16Array else {
            throw ICCReadError.corrupted
        }
        
        /// 4 to 7 4 Reserved, shall be set to 0
        self.reserved = try dataStream.read(endianess: .bigEndian)
        
        /// 8 to end Variable An array of unsigned 16bit integers
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
