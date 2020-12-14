//
//  textDescriptionOrMultiLocalizedUnicodeTextType.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// Tag Type : textDescriptionType xor multiLocalizedUnicodeType
public enum textDescriptionOrMultiLocalizedUnicodeTextType {
    case textDescription(_: textDescriptionType)
    case multiLocalizedUnicode(_: multiLocalizedUnicodeType)
    
    public init(dataStream: inout DataStream, size: UInt32?) throws {
        let startPosition = dataStream.position
        
        if let size = size {
            guard size >= 4 else {
                throw ICCReadError.corrupted
            }
        }
        
        /// 0..3 type signature
        let sig = try dataStream.peekString(count: 4, encoding: .ascii)!
        switch sig {
        case TagTypeSignature.textDescriptionType.rawValue:
            self = .textDescription(try textDescriptionType(dataStream: &dataStream, size: size))
        case TagTypeSignature.multiLocalizedUnicodeType.rawValue:
            self = .multiLocalizedUnicode(try multiLocalizedUnicodeType(dataStream: &dataStream, size: size))
        default:
            throw ICCReadError.corrupted
        }
        
        if let size = size {
            guard dataStream.position - startPosition == size else {
                throw ICCReadError.corrupted
            }
        }
    }
}
