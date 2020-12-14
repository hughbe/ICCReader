//
//  textType.swift
//  
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// [ICC.1:2010] 10.22 textType
/// The textType is a simple text structure that contains a 7-bit ASCII text string. The length of the string is obtained by subtracting 8
/// from the element size portion of the tag itself. This string shall be terminated with a 00h byte.
/// When used the byte assignment and encoding shall be as given in Table 75.
public struct textType {
    public let sig: TagTypeSignature
    public let reserved: uInt32Number
    public let data: String
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position
        
        guard size >= 8 else {
            throw ICCReadError.corrupted
        }
        
        /// 0 to 3 4 ‘text’ (74657874h) type signature
        self.sig = try TagTypeSignature(dataStream: &dataStream)
        guard self.sig ==  .textType else {
            throw ICCReadError.corrupted
        }
        
        /// 4 to 7 4 Reserved, shall be set to 0
        self.reserved = try dataStream.read(endianess: .bigEndian)
        
        /// 8 to end Variable A string of (element size 8) 7-bit ASCII characters
        self.data = try dataStream.readString(count: Int(size - 8), encoding: .ascii)!.trimmingCharacters(in: ["\0"])
        
        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }
}
