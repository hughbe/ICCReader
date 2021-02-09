//
//  uInt8ArrayType.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// [ICC.1:2010] 10.27 uInt8ArrayType
/// This type represents an array of generic 1–byte (8-bit) quantity. The number of values is determined from the size of the tag.
/// When used the byte assignment and encoding shall be as given in Table 80.
public struct uInt8ArrayType {
    public let sig: ICCSignature
    public let reserved: uInt32Number
    public let values: [UInt8]
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position
        
        guard size >= 8 else {
            throw ICCReadError.corrupted
        }
        
        /// 0 to 3 4 ‘ui08’ (75693038h) type signature
        self.sig = try ICCSignature(dataStream: &dataStream)
        guard self.sig ==  ICCTagTypeSignature.uInt8Array else {
            throw ICCReadError.corrupted
        }
        
        /// 4 to 7 4 Reserved, shall be set to 0
        self.reserved = try dataStream.read(endianess: .bigEndian)
        
        /// 8 to end Variable An array of unsigned 8-bit integers
        self.values = try dataStream.readBytes(count: Int(size) - 8)
        
        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }
}
