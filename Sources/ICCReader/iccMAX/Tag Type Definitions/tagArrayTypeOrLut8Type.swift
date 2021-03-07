//
//  tagArrayTypeOrLutType.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// Tag Type : tagArrayType xor lutType
public enum tagArrayTypeOrLutType {
    case tagArray(_: tagArrayType)
    case lut(_: lutType)
    
    public init(dataStream: inout DataStream, size: UInt32, header: ICCColorProfileHeader) throws {
        let startPosition = dataStream.position
        
        guard size >= 4 else {
            throw ICCReadError.corrupted
        }
        
        let data = try ICCTagData(dataStream: &dataStream, size: size, header: header)
        switch data {
        case let .tagArray(value):
            self = .tagArray(value)
        case let .lut8(value):
            self = .lut(.lut8(value))
        case let .lut16(value):
            self = .lut(.lut16(value))
        case let .lutAToB(value):
            self = .lut(.lutAToB(value))
        case let .lutBToA(value):
            self = .lut(.lutBToA(value))
        default:
            throw ICCReadError.corrupted
        }
        
        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }
}
