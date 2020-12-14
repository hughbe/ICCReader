//
//  utf8Type.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// [ICC.2:2019] 10.2.30 utf8Type
/// This tag structure contains a text structure that contains an 8-bit UTF-8 string. The length of the string is obtained by subtracting
/// 8 from the element size portion of the tag itself. For the specification of Unicode, see The Unicode Standard published by The
/// Unicode Consortium or visit http://www.unicode.org.
/// The format of the utf8Type structure can be found in Table 80.
public struct utf8Type {
    public let sig: TagTypeSignature
    public let reserved: uInt32Number
    public let data: String
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position
        
        guard size >= 8 else {
            throw ICCReadError.corrupted
        }
        
        /// 0..3 4 ‘utf8’ (75746638h) type signature
        self.sig = try TagTypeSignature(dataStream: &dataStream)
        guard self.sig ==  .utf8Type else {
            throw ICCReadError.corrupted
        }
        
        /// 4..7 4 Reserved, shall be 0
        self.reserved = try dataStream.read(endianess: .bigEndian)
        
        /// 8..end UTF-8 data
        self.data = try dataStream.readString(count: Int(size - 8), encoding: .utf8)!.trimmingCharacters(in: ["\0"])
        
        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }
}
