//
//  dataType.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// [ICC.1:2010] 10.6 dataType
/// The dataType is a simple data structure that contains either 7-bit ASCII or binary data, i.e. textType data or transparent 8-bit bytes.
/// The length of the string is obtained by subtracting 12 from the tag data element size portion of the tag itself as defined in 7.3.5.
/// If this type is used for ASCII data, it shall be terminated with a 00h byte. When used, the byte assignment shall be as given in Table 35.
public struct dataType {
    public let sig: TagTypeSignature
    public let reserved: uInt32Number
    public let dataFlag: UInt32
    public let data: [UInt8]
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position
        
        guard size >= 12 else {
            throw ICCReadError.corrupted
        }
        
        /// 0 to 3 4 ‘data’ (64617461h) type signature
        self.sig = try TagTypeSignature(dataStream: &dataStream)
        guard self.sig ==  .dataType else {
            throw ICCReadError.corrupted
        }
        
        /// 4 to 7 4 Reserved, shall be set to 0
        self.reserved = try dataStream.read(endianess: .bigEndian)
        
        /// 8 to 11 4 Data flag, 00000000h represents ASCII data, 00000001h represents binary data, other values are reserved for
        /// future use
        self.dataFlag = try dataStream.read(endianess: .bigEndian)
        
        /// 12 to end (tag data element size) − 12 A string of [(tag data element size) − 12] ASCII characters or
        /// [(tag data element size) − 12] bytes
        self.data = try dataStream.readBytes(count: Int(size - 12))
        
        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }
}
