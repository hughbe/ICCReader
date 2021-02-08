//
//  ICCTagTable.swift
//  
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// 7.3.1 Overview
/// The tag table acts as a table of contents for the tags and an index into the tag data element in the profiles. It shall consist of a 4-byte
/// entry that contains a count of the number of tags in the table followed by a series of 12-byte entries with one entry for each tag. The
/// tag table therefore contains 4+12n bytes where n is the number of tags contained in the profile. The entries for the tags within the
/// table are not required to be in any particular order nor are they required to match the sequence of tag data element within the profile.
/// Each 12-byte tag entry following the tag count shall consist of a 4-byte tag signature, a 4-byte offset to define the beginning of the
/// tag data element, and a 4-byte entry identifying the length of the tag data element in bytes. Table 24 illustrates the structure for thi
/// tag table. 7.3.2 to 7.3.5 specify the position and content of the entries composing the tag table.
public struct ICCTagTable {
    public let count: UInt32
    public let tags: [Tag]
    
    public init(dataStream: inout DataStream) throws {
        /// 0 to 3 4 Tag count (n)
        /// 7.3.2 Tag count (byte position 0 to 3)
        /// Byte positions 0 to 3 shall specify the number of tags contained in the tag table, encoded as a uInt32Number.
        self.count = try dataStream.read(endianess: .bigEndian)
        
        var tags: [Tag] = []
        tags.reserveCapacity(Int(self.count))
        for _ in 0..<self.count {
            tags.append(try Tag(dataStream: &dataStream))
        }
        
        self.tags = tags
    }
    
    /// Individual Tag Structures Within Tag Table
    public struct Tag {
        public let sig: ICCSignature
        public let offset: UInt32
        public let size: UInt32
        
        public init(dataStream: inout DataStream) throws {
            /// 4 to 7 4 Tag Signature
            /// Byte positions 4 to 7 (and repeating at 12-byte intervals) shall specify the signature of a tag listed in Clause 10, or
            /// of a private tag. Signatures of private tags shall be registered with the ICC as defined in Clause 5.
            self.sig = try ICCSignature(dataStream: &dataStream)

            /// 8 to 11 4 Offset to beginning of tag data element ulnt32Number
            /// 7.3.4 Offset to beginning of tag data element (byte position 8 to 11 and repeating)
            /// Byte positions 8 to 11 (and repeating at 12-byte intervals) shall specify the address of the beginning of the tag data
            /// element, with respect to the beginning of the profile data stream (which has an address of zero), encoded as a ulnt32Number.
            /// NOTE 1 For profiles that are not embedded, the number specified is the same as the file offset.
            /// All tag data elements shall start on a 4-byte boundary (relative to the start of the profile data stream) and the two
            /// least-significant bits of each tag data offset shall be zero. This means that a tag starting with a 32-bit value will be
            /// properly aligned without the tag handler needing to know the contents of the tag.
            /// NOTE 2 A data element is aligned with respect to a data type if the address of the data element is an integral multiple
            /// of the number of bytes in the data type.
            self.offset = try dataStream.read(endianess: .bigEndian)
            guard self.offset % 4 == 0 else {
                throw ICCReadError.corrupted
            }
            
            /// 12 to 15 4 Size of tag data element ulnt32Number
            /// 7.3.5 Tag data element size (byte position 12 to 15 and repeating)
            /// The tag data element size shall be the number of bytes in the tag data element encoded as a ulnt32Number.
            /// The value of the tag data element size shall be the number of actual data bytes and shall not include any padding
            /// at the end of the tag data element.
            self.size = try dataStream.read(endianess: .bigEndian)
        }
    }
}
