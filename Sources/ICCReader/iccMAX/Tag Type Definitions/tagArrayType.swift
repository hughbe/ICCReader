//
//  tagArrayType.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// [ICC.2:2019] 10.2.22 tagArrayType
/// The tagArrayType structure encodes an array of tags that have an identical tag type. Clause 13 defines valid tag arrays with their
/// associated array type identifiers.
/// The structure type indentifiers may vary when tag array elements are of tagStructType. How they vary shall be associated with the
/// array type identifier. (See Clause 13).
/// The format of the tagArrayType structure can be found in Table 72.
/// Each tag array element has an offset and size. Each offset is relative to the beginning of the associated tagArrayType structure.
/// Tag array elements should always begin at an offset divisible by 4 with padding between elements as needed.
/// The Element tag type signature shall match the signature of the tag type for all tag elements in the array.
/// The Element tag type signature can be the signature of any valid profile tag type.
/// If the Element tag type signature is ‘tags’ (74616773h) then the tag array is an array of tagStructType tags. In this case the Element
/// struct type identifier shall be the same as the Struct Type Identifier (Byte position 8..11) in each of the tagStructType tags.
/// If the Element tag type signature is not ‘tags’ (74616773h) then the Element struct type identifier shall be zero (0h).
/// The Offset of multiple tag elements can be the same (IE tag elements can share tag data).
public struct tagArrayType {
    public let sig: ICCSignature
    public let reserved: uInt32Number
    public let typeIdentifier: ICCSignature
    public let count: UInt32
    public let values: [[UInt8]]
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position

        guard size >= 16 else {
            throw ICCReadError.corrupted
        }
        
        /// 0..3 4 ‘tary’ (74617279h) type signature
        self.sig = try ICCSignature(dataStream: &dataStream)
        guard self.sig ==  ICCTagTypeSignature.tagArray else {
            throw ICCReadError.corrupted
        }
        
        /// 4..7 4 Reserved, shall be 0
        self.reserved = try dataStream.read(endianess: .bigEndian)
        
        /// 8..11 4 Array Type Identifier 4-byte signature
        self.typeIdentifier = try ICCSignature(dataStream: &dataStream)
        
        /// 12..15 4 Number of tag elements in array (N) uInt32Number
        let count: UInt32 = try dataStream.read(endianess: .bigEndian)
        guard 16 + count * 8 <= size else {
            throw ICCReadError.corrupted
        }
        
        self.count = count

        /// 16..23 8 Tag element 1 position positionNumber
        /// … … … …
        /// 16+(N-1)*8 ..16+N*8-1 8 Tag element N position positionNumber
        /// 16+N*8 .. end Tag element data
        var values: [[UInt8]] = []
        values.reserveCapacity(Int(self.count))
        for _ in 0..<self.count {
            let position = try positionNumber(dataStream: &dataStream)
            
            let oldPosition = dataStream.position
            guard position.offset % 4 == 0 &&
                    position.offset >= 16 + count * 8 &&
                    position.offset + position.size <= size else {
                throw ICCReadError.corrupted
            }
            
            let dataStartPosition = startPosition + Int(position.offset)
            dataStream.position = dataStartPosition
            values.append(try dataStream.readBytes(count: Int(position.size)))
            
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
}
