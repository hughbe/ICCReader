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
    
    public init(dataStream: inout DataStream, size: UInt32, header: ICCColorProfileHeader) throws {
        let startPosition = dataStream.position
        
        guard size >= 4 else {
            throw ICCReadError.corrupted
        }
        
        let data = try ICCTagData(dataStream: &dataStream, size: size, header: header)
        switch data {
        case let .namedColor2(value):
            self = .namedColor2(value)
        case let .tagArray(value):
            self = .tagArray(value)
        default:
            throw ICCReadError.corrupted
        }
        
        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }
}
