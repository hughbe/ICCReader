//
//  utf8ZipType.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// [ICC.2:2019] 10.2.31 utf8ZipType
/// This tag structure is a container for a UTF-8 string that has been compressed using the DEFLATE compression method specified by
/// RFC 1951 (http://tools.ietf.org/html/rfc1951) into the compressed data format specified by RFC 1950
/// (http://tools.ietf.org/html/rfc1950).
/// NOTE This is equivalent to the Zip data format produced by the ZLIB data compression library.
/// The length of the compressed data stream can be determined by subtracting 8 from the element size portion of the tag itself.
/// The data that is compressed is a UTF-8 string. For the specification of Unicode, see The Unicode Standard published by The
/// Unicode Consortium or visit http://www.unicode.org.
/// The format of the utf8ZipType structure can be found in Table 81.
public struct utf8ZipType {
    public let sig: ICCSignature
    public let reserved: uInt32Number
    public let compressedData: [UInt8]
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position
        
        guard size >= 8 else {
            throw ICCReadError.corrupted
        }
        
        /// 0..3 4 ‘zut8’ (7a757438h) type signature
        self.sig = try ICCSignature(dataStream: &dataStream)
        guard self.sig ==  ICCTagTypeSignature.utf8Zip else {
            throw ICCReadError.corrupted
        }
        
        /// 4..7 4 Reserved, shall be 0
        self.reserved = try dataStream.read(endianess: .bigEndian)
        
        /// 8..end Compressed data stream
        self.compressedData = try dataStream.readBytes(count: Int(size - 8))
        
        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }
}
