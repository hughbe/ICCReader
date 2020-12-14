//
//  utf16Type.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// [ICC.2:2019] 10.2.29 utf16Type
/// This tag structure contains a text structure that contains a 16-bit UTF-16 string. The length of the string is obtained by subtracting
/// 8 from the element size portion of the tag itself. For the specification of Unicode, see The Unicode Standard published by The
/// Unicode Consortium or visit http://www.unicode.org.
/// The format of the utf16Type structure can be found in Table 79
public struct utf16Type {
    public let sig: TagTypeSignature
    public let reserved: uInt32Number
    public let data: String
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position
        
        guard size >= 8 && (size - 8) % 2 == 0 else {
            throw ICCReadError.corrupted
        }
        
        /// 0..3 4 ‘ut16’ (75743136h) type signature
        self.sig = try TagTypeSignature(dataStream: &dataStream)
        guard self.sig ==  .utf16Type else {
            throw ICCReadError.corrupted
        }
        
        /// 4..7 4 Reserved, shall be 0
        self.reserved = try dataStream.read(endianess: .bigEndian)
        
        /// 8..end UTF-16 data uInt16Number[…]
        self.data = try dataStream.readString(count: Int(size - 8), encoding: .utf16BigEndian)!.trimmingCharacters(in: ["\0"])
        
        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }
}
