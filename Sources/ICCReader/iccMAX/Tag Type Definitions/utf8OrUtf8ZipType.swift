//
//  utf8OrUtf8ZipType.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// Tag Type : utf8Type xor utf8ZipType
public enum utf8OrUtf8ZipType {
    case utf8(_: utf8Type)
    case utf8Zip(_: utf8ZipType)
    case zxml(_: TagFactory.unknownType)
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position
        
        guard size >= 4 else {
            throw ICCReadError.corrupted
        }
        
        /// 0..3 type signature
        let sig = try dataStream.peekString(count: 4, encoding: .ascii)!
        switch sig {
        case TagTypeSignature.utf8Type.rawValue:
            self = .utf8(try utf8Type(dataStream: &dataStream, size: size))
        case TagTypeSignature.utf8ZipType.rawValue:
            self = .utf8Zip(try utf8ZipType(dataStream: &dataStream, size: size))
        case "ZXML":
            self = .zxml(try TagFactory.unknownType(dataStream: &dataStream, size: size))
        default:
            throw ICCReadError.corrupted
        }
        
        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }
}
