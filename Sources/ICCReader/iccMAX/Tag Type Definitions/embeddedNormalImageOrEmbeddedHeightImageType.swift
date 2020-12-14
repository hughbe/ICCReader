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
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position
        
        guard size >= 4 else {
            throw ICCReadError.corrupted
        }
        
        /// 0..3 type signature
        let sig = try dataStream.peekString(count: 4, encoding: .ascii)!
        switch sig {
        case TagTypeSignature.embeddedNormalImageType.rawValue:
            self = .embeddedNormalImage(try embeddedNormalImageType(dataStream: &dataStream, size: size))
        case TagTypeSignature.embeddedHeightImageType.rawValue:
            self = .embeddedHeightImage(try embeddedHeightImageType(dataStream: &dataStream, size: size))
        default:
            throw ICCReadError.corrupted
        }
        
        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }
}
