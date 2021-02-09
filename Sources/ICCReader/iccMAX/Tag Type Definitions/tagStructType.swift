//
//  tagStructType.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// [ICC.2:2019] 10.2.23 tagStructType
/// The tagStructType structure allows a collection of tag elements to be grouped into a single structure.
/// The format of the tagStructType structure can be found in Table 73.
/// Each tag element (or sub-tag) of a tagStructType has a tag signature, offset and size. Each offset is relative to the beginning of the
/// associated tagStructType structure. All elements should begin at an offset divisible by 4 with padding between tag elements as
/// needed. The struct type identifier shall be used to identify the required and optional sub-tag elements in the tag structure.
/// (See Clause 12 for publicly defined tagStructType structure definitions.)
/// Tag elements can be any valid profile tag type.
/// Tag element signatures shall be unique within a tagStructType structure.
/// The Offset of multiple elements can be the same (i.e. elements can share tag data).
public struct tagStructType {
    public let sig: ICCSignature
    public let reserved: uInt32Number
    public let typeIdentifier: ICCSignature
    public let count: UInt32
    public let elements: [ICCSignature: ICCTagData]
    
    public init(dataStream: inout DataStream, size: UInt32, header: ExtendedProfileHeader) throws {
        let startPosition = dataStream.position

        guard size >= 20 else {
            throw ICCReadError.corrupted
        }
        
        /// 0..3 4 ‘tstr’ (74737472h) tagStructtype signature
        self.sig = try ICCSignature(dataStream: &dataStream)
        guard self.sig ==  ICCTagTypeSignature.tagStruct else {
            throw ICCReadError.corrupted
        }
        
        /// 4..7 4 Reserved, shall be 0
        self.reserved = try dataStream.read(endianess: .bigEndian)
        
        /// 8..11 4 Struct type Identifier 4-byte signature
        self.typeIdentifier = try ICCSignature(dataStream: &dataStream)
        
        /// 12..15 4 Number of tag elements N in structure uInt32Number
        let count: UInt32 = try dataStream.read(endianess: .bigEndian)
        guard 16 + count * 12 <= size else {
            throw ICCReadError.corrupted
        }
        
        self.count = count
        
        /// 16..19 4 Tag element 1 Signature 4-byte signature
        /// 20..27 8 Tag element 1 position positionNumber
        /// … … … …
        /// N*12+4..N*12+7 4 Tag element N Signature 4-byte signature
        /// N*12+8..N*12+15 8 Tag element N position positionNumber
        /// N*12+16..end Tag element data
        var elements: [ICCSignature: ICCTagData] = [:]
        elements.reserveCapacity(Int(self.count))
        for _ in 0..<self.count {
            let signature = try ICCSignature(dataStream: &dataStream)
            let position = try positionNumber(dataStream: &dataStream)
            
            let oldPosition = dataStream.position
            guard position.offset % 4 == 0 &&
                    position.offset >= 16 + count * 8 &&
                    position.offset + position.size <= size else {
                throw ICCReadError.corrupted
            }
            
            let dataStartPosition = startPosition + Int(position.offset)
            dataStream.position = dataStartPosition
            elements[signature] = try ICCTagData(dataStream: &dataStream, size: position.size, header: header)
            
            guard dataStream.position - dataStartPosition == position.size else {
                throw ICCReadError.corrupted
            }
            
            dataStream.position = oldPosition
        }
        
        self.elements = elements
        
        /// Skip the data we've already read.
        dataStream.position = startPosition + Int(size)
        
        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }
}
