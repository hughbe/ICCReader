//
//  zipXmlType.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// [ICC.2:2019] 10.2.33 zipXmlType
/// This tag structure is a container for XML formatted data that has been compressed using the DEFLATE compression method specified
/// by RFC 1951 (http://tools.ietf.org/html/rfc1951) into the compressed data format specified by RFC 1950
/// (http://tools.ietf.org/html/rfc1950).
/// NOTE This is equivalent to the Zip data format produced by the ZLIB data compression library.
/// The length of the compressed data stream can be determined by subtracting 8 from the element size portion of the tag itself.
/// The data that is compressed shall be encoded using XML. For the specification of XML, see the XML 1.0 specification[14] published
/// by the World Wide Web Consortium or visit http://www.w3.org/TR/REC-xml.
/// The format of the zipXmlType structure can be found in Table 83.
public struct zipXmlType {
    public let sig: TagTypeSignature
    public let reserved: uInt32Number
    public let compressedData: [UInt8]
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position
        
        guard size >= 8 else {
            throw ICCReadError.corrupted
        }
        
        /// 0..3 4 ‘zxml’ (7a786d6ch) type signature
        self.sig = try TagTypeSignature(dataStream: &dataStream)
        guard self.sig ==  .zipXmlType else {
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
