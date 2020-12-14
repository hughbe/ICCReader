//
//  dictType.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// [ICC.2:2019] 10.2.5 dictType
/// The dictTypeStructure contains a dictionary array of name-value pairs with each name being uniquely associated with a single value.
/// Each name and value can optionally be associated with localized text strings for display purposes.
/// The byte assignment and encoding shall be as given in Table 40 and Table 41.
/// The value in the length of each name-value record filed (N) shall determine how many entries shall be present in each name-value record.
/// — When the length value is 16, each name-value record shall be 16 bytes long and only the positionNumber values for the name and
/// value items shall be present.
/// — When the length value is 24, each name-value record shall be 24 bytes long and only the positionNumber values for the name,
/// value and display name items shall be present.
/// — When the length value is 32, each name-value record shall be 32 bytes long and the positionNumber values for the name,
/// value, display name, and display value items shall be present.
/// In the general use of dictType, there may be no localized values, so a name-value record length of 16 would be appropriate.
/// In other use cases, localized display values are needed, and 32 would be used. When using localization for value fields and not
/// localizing names, use 32-byte name-value records with the display name positionNumber fields set to zero.
/// A name string shall be present for each name-value record and name string positionNumber size shall be greater than zero.
/// Other data items referenced by the name-value record are optional according to dictType, although particular dictType tag definitions my impose restrictions.
/// Both the name string and value string shall be encoded as UTF-16 strings and shall NOT be zero terminated.
/// Name strings shall contain at least one Unicode character, and the string contents of each name string shall be unique within a
/// dictTypeTag. In general, a zero-length string (NUL) is valid for value strings, and shall be indicated by a non-zero value string
/// positionNumber offset and a value string positionNumber size equal to zero.
/// NOTE Value string = NUL may be restricted for particular dictType tags.
/// A positionNumber offset of zero shall indicate that the corresponding data item is not present as it is undefined. When a
/// positionNumber offset is zero, the meaning of the corresponding positionNumber size is undefined and shall be zero. When a
/// localized display name or display value positionNumber is undefined (positionNumber offset equal to zero), no translation is provided
/// for the corresponding name string or value string, and the name string or value string may be displayed. This is equivalent to
/// the behaviour for all name string and value strings when the name-value record length is 16.
/// Alternatively, a defined display name element positionNumber offset (non-zero) with a display name element positionNumber size
/// equal to zero indicates that the name string is not intended for display.
/// Similarly a defined display value element positionNumberOffset (non-zero) with a display value element size equal to zero indicates
/// that the value string, if provided, is not intended for display. A localized display value may be provided without a localized display name.
/// Data may be shared between the name-value records of a dictType tag. For example, the offsets for the value strings can be identical,
/// as well as the offsets for display value elements can be identical.
/// The following pseudocode can be used to determine string validity where pos is value string positionNumber, display name
/// positionNumber, or display value positionNumber:
/// If pos.offset == 0
/// Then item is undefined (pos.length can be ignored when pos.offset is zero)
/// Else
/// If ((pos.offset >= 20+N*M) && ((pos.length>= minSizeofItemType) || (Length=0)) &&
/// (pos.offset + pos.length <=end+1)
/// Then item is defined.
/// If ((item == value string) &&( pos.length==0)
/// Then value string is NUL string
/// Else if ((item== display name element) && (pos.length)==0)
/// Then name string is not for display use and no display name is provided
/// Else if ((item==display name element) && pos.length)==0)
/// Then value string is not for display use and no display value is provided
/// Else
/// THROW_ERROR(“pos.offset is not zero and pos.offset or pos.length are invalid”)
/// Unless otherwise stated, numbers shall be encoded in the string value as follows:
/// — A number shall be encoded as zero or more blanks and/or tabs, an optional ‘+’ or ‘−‘ sign, a string of
/// decimal digits that contain one decimal point ‘.’, and an optional exponent part. The exponent part
/// shall consist of ‘e’ or ‘E’, an optional ‘+’ or ‘−‘ sign, and one or two decimal digits. The exponent shall
/// indicate a power of 10.
/// — Multiple numbers stored in a single string shall be separated by one comma ‘,’ between adjacent
/// numbers.
public struct dictType {
    public let sig: TagTypeSignature
    public let reserved: uInt32Number
    public let count: UInt32
    public let recordLength: UInt32
    public let values: [NameValueRecordComplete]
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position

        guard size >= 16 else {
            throw ICCReadError.corrupted
        }
        
        /// 0 to 3 4 ‘dict’ (64696374h) type signature
        self.sig = try TagTypeSignature(dataStream: &dataStream)
        guard self.sig ==  .dictType else {
            throw ICCReadError.corrupted
        }
        
        /// 4 to 7 4 Reserved, shall be 0
        self.reserved = try dataStream.read(endianess: .bigEndian)
        
        /// 8 to 11 4 Number of name-value records (M) uInt32Number
        let count: UInt32 = try dataStream.read(endianess: .bigEndian)
        self.count = count
        
        /// 12 to 15 4 The length of each name-value record, in bytes (N). The value shall be 16, 24, or 32 uInt32Number
        let recordLength: UInt32 = try dataStream.read(endianess: .bigEndian)
        guard recordLength == 16 || recordLength == 24 || recordLength == 32 else {
            throw ICCReadError.corrupted
        }
        guard 16 + count * recordLength <= size else {
            throw ICCReadError.corrupted
        }
        
        self.recordLength = recordLength

        /// 16 to 15+N N The first name-value record See Table 41 16+N to 15+M*N N*(M-1) Additional name-value records
        /// as needed
        /// 16+M*N to end (tag data element size) – (16+M*N) Storage area of strings of Unicode characters and multiLocalizedType
        /// tags
        var values: [NameValueRecordComplete] = []
        values.reserveCapacity(Int(self.count))
        for _ in 0..<self.count {
            let record = try NameValueRecord(dataStream: &dataStream, recordLength: self.recordLength)
            
            func readUTF16TextArray(position: positionNumber) throws -> String {
                guard position.size != 0 else {
                    return ""
                }
                
                let oldPosition = dataStream.position
                guard position.offset % 4 == 0 &&
                        position.offset >= 16 + count * recordLength &&
                        position.offset + position.size <= size &&
                        position.size % 2 == 0 else {
                    throw ICCReadError.corrupted
                }
                
                let dataStartPosition = startPosition + Int(position.offset)
                dataStream.position = dataStartPosition
                let value = try dataStream.readString(count: Int(position.size), encoding: .utf16BigEndian)!
                
                guard dataStream.position - dataStartPosition == position.size else {
                    throw ICCReadError.corrupted
                }
                
                dataStream.position = oldPosition
                return value
            }

            func readMultiLocalizedUnicodeType(position: positionNumber?) throws -> multiLocalizedUnicodeType? {
                guard let position = position, position.size != 0 else {
                    return nil
                }
                
                let oldPosition = dataStream.position
                guard position.offset % 4 == 0 &&
                        position.offset >= 16 + count * recordLength &&
                        position.offset + position.size <= size &&
                        position.size % 2 == 0 else {
                    throw ICCReadError.corrupted
                }
                
                let dataStartPosition = startPosition + Int(position.offset)
                dataStream.position = dataStartPosition
                let value = try multiLocalizedUnicodeType(dataStream: &dataStream, size: position.size)
                
                guard dataStream.position - dataStartPosition == position.size else {
                    throw ICCReadError.corrupted
                }
                
                dataStream.position = oldPosition
                return value
            }

            let nameString = try readUTF16TextArray(position: record.nameStringPosition)
            let valueString = try readUTF16TextArray(position: record.valueStringPosition)
            let displayNameString = try readMultiLocalizedUnicodeType(position: record.displayNameStringPosition)
            let displayValueString = try readMultiLocalizedUnicodeType(position: record.displayValueStringPosition)
            let value = NameValueRecordComplete(nameString: nameString,
                                                valueString: valueString,
                                                displayNameString: displayNameString,
                                                displayValueString: displayValueString)
            values.append(value)
        }
        
        self.values = values
        
        /// Skip the data we've already read.
        dataStream.position = startPosition + Int(size)
        
        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }
    
    public struct NameValueRecordComplete {
        public let nameString: String
        public let valueString: String
        public let displayNameString: multiLocalizedUnicodeType?
        public let displayValueString: multiLocalizedUnicodeType?
    }
    
    /// 16 to 15+N N The first name-value record See Table 41 16+N to 15+M*N N*(M-1) Additional name-value records
    /// as needed
    public struct NameValueRecord {
        public let nameStringPosition: positionNumber
        public let valueStringPosition: positionNumber
        public let displayNameStringPosition: positionNumber?
        public let displayValueStringPosition: positionNumber?
        
        public init(dataStream: inout DataStream, recordLength: UInt32) throws {
            /// 0 to 7 8 Name string position of UTF16 text array positionNumber
            self.nameStringPosition = try positionNumber(dataStream: &dataStream)
            
            /// 8 to 15 8 Value string position of UTF-16 text array positionNumber
            self.valueStringPosition = try positionNumber(dataStream: &dataStream)
            
            if recordLength == 16 {
                self.displayNameStringPosition = nil
                self.displayValueStringPosition = nil
                return
            }
            
            /// 16 to 23 8 Display name element position of multiLocalizedType tag element positionNumber
            self.displayNameStringPosition = try positionNumber(dataStream: &dataStream)
            
            if recordLength == 24 {
                self.displayValueStringPosition = nil
                return
            }
            
            /// 24 to 31 8 Display value element position of multiLocalizedType tag element positionNumber
            self.displayValueStringPosition = try positionNumber(dataStream: &dataStream)
        }
    }
}
