//
//  textOrMultiLocalizedUnicodeTextType.swift
//  
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// Tag Type : textType xor multiLocalizedUnicodeType
public enum textOrMultiLocalizedUnicodeTextType {
    case text(_: String)
    case multiLocalizedUnicode(_: [multiLocalizedUnicodeType.LocalizedString])
    
    public init(dataStream: inout DataStream, size: UInt32, header: ExtendedProfileHeader) throws {
        let startPosition = dataStream.position
        
        guard size >= 4 else {
            throw ICCReadError.corrupted
        }
        
        let data = try ICCTagData(dataStream: &dataStream, size: size, header: header)
        switch data {
        case let .text(value):
            self = .text(value)
        case let .multiLocalizedUnicode(value):
            self = .multiLocalizedUnicode(value)
        default:
            throw ICCReadError.corrupted
        }
        
        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }
}
