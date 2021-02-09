//
//  signatureType.swift
//  
//
//  Created by Hugh Bellamy on 12/12/2020.
//

import DataStream

/// [ICC.1:2010] 10.21 signatureType
/// The signatureType contains a 4-byte sequence, such as those defined in Table 22. Sequences of less than four characters are padded
/// at the end with spaces, 20h. Typically this type is used for registered tags that can be displayed on many development systems as a
/// sequence of four characters.
/// When used the byte assignment and encoding shall be as given in Table 74.
public struct signatureType {
    public let sig: ICCSignature
    public let reserved: uInt32Number
    public let signature: ICCSignature
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position
        
        guard size == 12 else {
            throw ICCReadError.corrupted
        }
        
        /// 0 to 3 4 ‘sig ’ (73696720h) type signature
        self.sig = try ICCSignature(dataStream: &dataStream)
        guard self.sig ==  ICCTagTypeSignature.Signature else {
            throw ICCReadError.corrupted
        }
        
        /// 4 to 7 4 Reserved, shall be set to 0
        self.reserved = try dataStream.read(endianess: .bigEndian)
        
        /// 8 to 11 4 4-byte signature
        self.signature = try ICCSignature(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }
}
