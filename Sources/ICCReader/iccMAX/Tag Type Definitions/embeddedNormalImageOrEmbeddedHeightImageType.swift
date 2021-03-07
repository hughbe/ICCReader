//
//  embeddedNormalImageOrEmbeddedHeightImageType.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// Tag Type : embeddedNormalImageType xor embeddedHeightImageType
public enum embeddedNormalImageOrEmbeddedHeightImageType {
    case embeddedNormalImage(_: embeddedNormalImageType)
    case embeddedHeightImage(_: embeddedHeightImageType)
    
    public init(dataStream: inout DataStream, size: UInt32, header: ICCColorProfileHeader) throws {
        let startPosition = dataStream.position
        
        guard size >= 4 else {
            throw ICCReadError.corrupted
        }
        
        let data = try ICCTagData(dataStream: &dataStream, size: size, header: header)
        switch data {
        case let .embeddedNormalImage(value):
            self = .embeddedNormalImage(value)
        case let .embeddedHeightImage(value):
            self = .embeddedHeightImage(value)
        default:
            throw ICCReadError.corrupted
        }
        
        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }
}
