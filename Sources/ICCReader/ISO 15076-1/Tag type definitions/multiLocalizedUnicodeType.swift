//
//  multiLocalizedUnicodeType.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// 10.13 multiLocalizedUnicodeType
/// This tag structure contains a set of records each referencing a multilingual Unicode string associated with a profile. Each string is
/// referenced in a separate record with the information about what language and region the string is for.
/// The byte assignment and encoding shall be as given in Table 51.
/// Note that the fourth field of this tag, the record size should, for the time being, contain the value 12, which corresponds to the size
/// in bytes of each record. Any code that needs to access the nth record should determine the record’s offset by multiplying n by the
/// contents of this size field and adding 16. This minor extra effort allows for future expansion of the record encoding, should the need
/// arise, without having to define a new tag type.
/// Multiple strings within this tag may share storage locations. For example, en/US and en/UK can refer to the same string data.
/// For the specification of Unicode, see The Unicode Standard published by The Unicode Consortium or visit their website at
/// http://www.unicode.org. For the definition of language codes and country codes, see respectively ISO 639-1 and ISO 3166-1.
/// The Unicode strings in storage should be encoded as 16-bit big-endian, UTF-16BE, and should not be NULL terminated.
/// NOTE For additional clarification on the encodings used, see the ICC technical note 01-2002 available on www.color.org.
/// If the specific record for the desired region is not stored in the tag, the record with the same language code should be used. If the
/// specific record for the desired language is not stored in the tag, the first record in the tag is used if no other user preference is available.
public struct multiLocalizedUnicodeType {
    public let sig: ICCSignature
    public let reserved: uInt32Number
    public let numberOfRecords: UInt32
    public let recordSize: UInt32
    public let values: [LocalizedString]
    
    public init(dataStream: inout DataStream, size: UInt32?) throws {
        let startPosition = dataStream.position
        
        if let size = size {
            guard size >= 12 else {
                throw ICCReadError.corrupted
            }
        }
        
        /// 0 to 3 4 ‘mluc’ (0x6D6C7563) type signature
        self.sig = try ICCSignature(dataStream: &dataStream)
        guard self.sig ==  ICCTagTypeSignature.multiLocalizedUnicode else {
            throw ICCReadError.corrupted
        }
        
        /// 4 to 7 4 Reserved, shall be set to 0
        self.reserved = try dataStream.read(endianess: .bigEndian)
        
        /// 8 to 11 4 Number of records (n) uInt32Number
        self.numberOfRecords = try dataStream.read(endianess: .bigEndian)
        if let size = size {
            guard 12 + self.numberOfRecords * 12 <= size else {
                throw ICCReadError.corrupted
            }
        }
        
        let dataPosition = 12 + self.numberOfRecords * 12
        
        /// 12 to 15 4 Record size: the length in bytes of every record. The value is 12. 0000000Ch
        self.recordSize = try dataStream.read(endianess: .bigEndian)
        guard self.recordSize == 0x0000000C else {
            throw ICCReadError.corrupted
        }
        
        /// 28 to 28+[12(n−1)]−1 (or 15+12n) 12(n−1) Additional records as needed
        /// 28+[12(n−1)] (or 16+12n) to end Variable Storage area of strings of Unicode characters
        var endPosition = dataStream.position
        var values: [LocalizedString] = []
        values.reserveCapacity(Int(self.numberOfRecords))
        for _ in 0..<self.numberOfRecords {
            let record = try Record(dataStream: &dataStream)
            guard record.offset >= dataPosition &&
                    record.offset + record.length <= size ?? UInt32(dataStream.remainingCount) else {
                throw ICCReadError.corrupted
            }

            let oldPosition = dataStream.position
            
            dataStream.position = startPosition + Int(record.offset)
            let string = try dataStream.readString(count: Int(record.length), encoding: .utf16BigEndian)!
            let localizedString = LocalizedString(languageCode: record.languageCode,
                                                  countryCode: record.countryCode,
                                                  string: string)
            values.append(localizedString)
            endPosition = max(dataStream.position, endPosition)
            dataStream.position = oldPosition
        }
        
        self.values = values
        
        if let size = size {
            /// Skip the data we've already read.
            dataStream.position = startPosition + Int(size)

            guard dataStream.position - startPosition == size else {
                throw ICCReadError.corrupted
            }
        } else {
            dataStream.position = endPosition
        }
    }
    
    public struct LocalizedString {
        public let languageCode: UInt16
        public let countryCode: UInt16
        public let string: String
    }
    
    public struct Record {
        public let languageCode: UInt16
        public let countryCode: UInt16
        public let length: UInt32
        public let offset: UInt32
        
        public init(dataStream: inout DataStream) throws {
            /// 16 to 17 2 First record language code: in accordance with the language code specified in ISO 639-1 uInt16Number
            self.languageCode = try dataStream.read(endianess: .bigEndian)
            
            /// 18 to 19 2 First record country code: in accordance with the country code specified in ISO 3166-1 uInt16Number
            self.countryCode = try dataStream.read(endianess: .bigEndian)
            
            /// 20 to 23 4 First record string length: the length in bytes of the string uInt32Number
            self.length = try dataStream.read(endianess: .bigEndian)
            
            /// 24 to 27 4 First record string offset: the offset from the start of the tag to the start of the string, in bytes uInt32Number
            self.offset = try dataStream.read(endianess: .bigEndian)
        }
    }
}
