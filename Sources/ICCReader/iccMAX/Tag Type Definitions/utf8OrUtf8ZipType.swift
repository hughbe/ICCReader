//
//  utf8OrUtf8ZipType.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// Tag Type : utf8Type xor utf8ZipType
public enum utf8OrUtf8ZipType {
    case utf8(_: String)
    case utf8Zip(_: [UInt8])
    case zxml(_: [UInt8])
    
    public init(dataStream: inout DataStream, size: UInt32, header: ExtendedProfileHeader) throws {
        let startPosition = dataStream.position
        
        guard size >= 4 else {
            throw ICCReadError.corrupted
        }
        
        let tag = try ICCTagData(dataStream: &dataStream, size: size, header: header)
        switch tag {
        case let .utf8(value):
            self = .utf8(value)
        case let .utf8Zip(value):
            self = .utf8Zip(value)
        case let .unknown("ZXML", value):
            self = .zxml(value)
        default:
            throw ICCReadError.corrupted
        }
        
        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }
}
