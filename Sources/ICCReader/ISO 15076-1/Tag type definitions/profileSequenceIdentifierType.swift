//
//  profileSequenceIdentifierType.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// [ICC.1:2010] 10.18 profileSequenceIdentifierType
/// [ICC.1:2010] 10.18.1 General
/// This type is an array of structures, each of which contains information for identification of a profile used in a sequence.
/// When used, the byte assignment and encoding shall be as given in Table 68.
/// The offsets stored in the positions table shall be relative to the start of the tag.
/// It is permitted for profile identifier structures to be shared. So it is possible that a positionNumber in the positions table is identical
/// to another positionNumber in the positions table.
/// Each profile identifier structure shall start on a 4-byte boundary. To achieve this, each structure shall be followed by up to three
/// 00h pad bytes as needed.
/// Each profile identifier structure has the format shown in Table 69.
public struct profileSequenceIdentifierType {
    public let sig: TagTypeSignature
    public let reserved: uInt32Number
    public let count: UInt32
    public let values: [ProfileIdentifier]
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position
        
        guard size >= 12 else {
            throw ICCReadError.corrupted
        }
        
        /// 0 to 3 4 ‘psid’ (70736964h) type signature
        self.sig = try TagTypeSignature(dataStream: &dataStream)
        guard self.sig ==  .profileSequenceIdentifierType else {
            throw ICCReadError.corrupted
        }
        
        /// 4 to 7 4 Reserved, shall be set to 0
        self.reserved = try dataStream.read(endianess: .bigEndian)
        
        /// 8 to 11 4 Count (n), specifying number of structures in the array uInt32Number
        let count: UInt32 = try dataStream.read(endianess: .bigEndian)
        guard 12 + count * 8 + count * 16 <= size else {
            throw ICCReadError.corrupted
        }
        
        self.count = count
        
        /// 12 to 11+8n 8n Positions table for profile identifiers positionNumber[…]
        /// 12+8n to end Profile identifier structures, see Table 69
        var values: [ProfileIdentifier] = []
        values.reserveCapacity(Int(self.count))
        for _ in 0..<self.count {
            let position = try positionNumber(dataStream: &dataStream)
            
            let oldPosition = dataStream.position
            guard position.offset % 4 == 0 &&
                    position.offset >= 12 + count * 8 &&
                    position.offset + position.size <= size else {
                throw ICCReadError.corrupted
            }
            
            let dataStartPosition = startPosition + Int(position.offset)
            dataStream.position = dataStartPosition
            values.append(try ProfileIdentifier(dataStream: &dataStream, size: position.size))
            
            guard dataStream.position - dataStartPosition == position.size else {
                throw ICCReadError.corrupted
            }
            
            dataStream.position = oldPosition
        }
        
        self.values = values
        
        /// Skip the data we've already read.
        dataStream.position = startPosition + Int(size)
        
        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }
    
    public struct ProfileIdentifier {
        public let profileID: [UInt8]
        public let profileDescription: textDescriptionOrMultiLocalizedUnicodeTextType
        
        public init(dataStream: inout DataStream, size: UInt32) throws {
            guard size >= 16 else {
                throw ICCReadError.corrupted
            }

            /// 0 to 15 16 Profile ID (see below) See 7.2.18
            /// 10.18.2 Profile ID
            /// If a profile contains a Profile ID in the Profile Header, it shall be used in the Profile Identifier structure. If a profile
            /// does not contain a Profile ID in the Profile Header, either an all-zero Profile ID or a computed Profile ID shall be
            /// used in the Profile Identifier structure.
            self.profileID = try dataStream.readBytes(count: 16)
            
            /// 16 to end variable Profile Description (see below) multiLocalizedUnicodeType
            /// 10.18.3 Profile Description
            /// For profiles conforming to ICC Profile Specification ICC.1:2001-12 (ICC V4.0.0) and later, the entire
            /// multiLocalizedUnicodeType contents of the Profile Description Tag shall be included in the Profile Identifier
            /// structure. For profiles conforming to ICC Profile Specification ICC.1:2001-04 (ICC V2.4.0) and earlier, the
            /// contents of the textDescriptionType Profile Description Tag shall be converted to multiLocalizedUnicodeType
            /// and used in the Profile Identifier structure.
            /// NOTE One way of creating a multiLocalizedUnicodeType from a textDescriptionType is by converting the 7-bit ASCII
            /// part of the textDescriptionType to a 'enUS' Unicode string by mapping the 7-bit ASCII characters to 16-bit Unicode
            /// characters, and storing the 'enUS' Unicode string in the multiLocalizedUnicodeType.
            self.profileDescription = try textDescriptionOrMultiLocalizedUnicodeTextType(dataStream: &dataStream, size: size - 16)
        }
    }
}
