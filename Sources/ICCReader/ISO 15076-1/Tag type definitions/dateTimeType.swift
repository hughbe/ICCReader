//
//  dateTimeType.swift
//
//
//  Created by Hugh Bellamy on 12/12/2020.
//

import DataStream

/// [ICC.1:2010] 10.7 dateTimeType
/// This dateTimeType is a 12-byte value representation of the time and date. The actual values are encoded as a dateTimeNumber
/// described in 4.2. When used the byte assignment shall be as given in Table 36.
public struct dateTimeType {
    public let sig: TagTypeSignature
    public let reserved: uInt32Number
    public let date: dateTimeNumber
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position
        
        guard size == 20 else {
            throw ICCReadError.corrupted
        }
        
        /// 0 to 3 4 ‘dtim’ (6474696Dh) type signature
        self.sig = try TagTypeSignature(dataStream: &dataStream)
        guard self.sig ==  .dateTimeType else {
            throw ICCReadError.corrupted
        }
        
        /// 4 to 7 4 Reserved, shall be set to 0
        self.reserved = try dataStream.read(endianess: .bigEndian)
        
        /// 8 to 19 12 Date and time dateTimeNumber
        self.date = try dateTimeNumber(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }
}
