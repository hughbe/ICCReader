//
//  namedColor2OrTagArrayType.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// Tag Type : namedColor2Type xor tagArrayType
public enum namedColor2OrTagArrayType {
    case namedColor2(_: namedColor2Type)
    case tagArray(_: tagArrayType)
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position
        
        guard size >= 4 else {
            throw ICCReadError.corrupted
        }
        
        /// 0..3 type signature
        let sig = try dataStream.peekString(count: 4, encoding: .ascii)!
        switch sig {
        case TagTypeSignature.namedColor2Type.rawValue:
            self = .namedColor2(try namedColor2Type(dataStream: &dataStream, size: size))
        case TagTypeSignature.tagArrayType.rawValue:
            self = .tagArray(try tagArrayType(dataStream: &dataStream, size: size))
        default:
            throw ICCReadError.corrupted
        }
        
        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }
}
