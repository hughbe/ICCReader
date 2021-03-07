//
//  ICCFile.swift
//
//
//  Created by Hugh Bellamy on 30/11/2020.
//

import DataStream
import Foundation

/// 7.1 General
/// An ICC profile shall include the following elements, in the order shown, as a single file:
/// a) a 128-byte profile header as defined in 7.2;
/// b) a profile tag table as defined in 7.3;
/// c) profile tagged element data as defined in 7.4.
/// This is illustrated in Figure 5.
/// The required tags for each profile type are tabulated in Clause 8. The definition of all publicly available tags and their signatures is
/// contained in Clause 9 along with the permitted tag types for each tag. Tag types are defined in Clause 10. Extended ICC profiles
/// may support tags defined as using either the multiProcessElementsType or the tagStructType. Multiple processing elements are
/// defined in Clause 11.
/// Tag structure types are defined in Clause 12. Tag array types are defined in Clause 13.
/// Within the profile structure:
/// a) all profile data shall be encoded as big-endian;
/// b) the first set of tagged element data shall immediately follow the tag table;
/// c) all tagged element data, including the last, shall be padded by no more than three following pad bytes to reach a 4-byte boundary;
/// d) all pad bytes shall be NULL (ISO 646, character 0/0).
/// NOTE 1 This implies that the length of the file is a multiple of four.
/// NOTE 2 The above restrictions result in two key benefits. First, the likelihood of two profiles which contain the same tag data, yet
/// have different checksum values, is reduced. Second, all profiles are reduced to a minimum size.
public struct ICCColorProfile {
    public let header: ICCColorProfileHeader
    public let tags: [ICCTag]
    private let tagsDictionary: [String: ICCTag]
    
    public init(data: Data) throws {
        var dataStream = DataStream(data)
        try self.init(dataStream: &dataStream)
    }

    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// a) a 128-byte profile header as defined in 7.2;
        self.header = try ICCColorProfileHeader(dataStream: &dataStream)

        /// b) a profile tag table as defined in 7.3;
        let iccTagTable = try ICCTagTable(dataStream: &dataStream)
        let endPosition = dataStream.position
        
        var tags: [ICCTag] = []
        tags.reserveCapacity(Int(iccTagTable.count))
        
        var tagsDictionary: [String: ICCTag] = [:]
        tagsDictionary.reserveCapacity(Int(iccTagTable.count))

        /// c) a profile tagged element data as defined in 7.4.
        /// 7.4 Tag data
        /// The first set of tag data elements shall immediately follow the tag table and all tag data elements, including the last tag
        /// data element, shall be padded by no more than three following pad bytes to reach a 4-byte boundary. The size of individual
        /// tag data elements and the accumulated size of all tag data elements shall only be restricted by the limits imposed by the
        /// 32-bit tag data offset value and the 32-bit tag data element size value.
        for tag in iccTagTable.tags {
            guard tag.offset >= endPosition &&
                    tag.offset + tag.size <= dataStream.count else {
                throw ICCReadError.corrupted
            }
            
            let dataStartPosition = startPosition + Int(tag.offset)
            dataStream.position = dataStartPosition
            
            let tagValue = try ICCTag(signature: tag.sig, dataStream: &dataStream, size: tag.size, header: self.header)
            tags.append(tagValue)
            tagsDictionary[tagValue.signature.rawValue] = tagValue
        }
        
        self.tags = tags
        self.tagsDictionary = tagsDictionary
    }
    
    public func getTag(signature: String) -> ICCTag? {
        return tagsDictionary[signature]
    }
    
    public func getTag(signature: ICCSignature) -> ICCTag? {
        return getTag(signature: signature.rawValue)
    }
}
