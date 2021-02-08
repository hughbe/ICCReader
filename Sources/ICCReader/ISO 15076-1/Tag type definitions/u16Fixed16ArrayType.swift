//
//  u16Fixed16ArrayType.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// [ICC.1:2010] 10.23 u16Fixed16ArrayType
/// This type represents an array of generic 4-byte (32-bit) quantity. The number of values is determined from the size of the tag.
/// When used the byte assignment and encoding shall be as given in Table 76.
public struct u16Fixed16ArrayType {
    public let sig: ICCSignature
    public let reserved: uInt32Number
    public let values: [s15Fixed16Number]
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position
        
        guard size >= 8 && (size - 8) % 4 == 0 else {
            throw ICCReadError.corrupted
        }
        
        /// 0 to 3 4 ‘uf32’ (75663332h) type signature
        self.sig = try ICCSignature(dataStream: &dataStream)
        guard self.sig ==  ICCTagTypeSignature.u16Fixed16Array else {
            throw ICCReadError.corrupted
        }
        
        /// 4 to 7 4 Reserved, shall be set to 0
        self.reserved = try dataStream.read(endianess: .bigEndian)
        
        /// 8 to end Variable An array of u16Fixed16Number values 
        var values: [s15Fixed16Number] = []
        let count = (Int(size) - 8) / 4
        values.reserveCapacity(count)
        for _ in 0..<count {
            values.append(try s15Fixed16Number(dataStream: &dataStream))
        }
        
        self.values = values
        
        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }
}
