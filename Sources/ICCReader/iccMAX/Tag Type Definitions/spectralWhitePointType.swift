//
//  spectralWhitePointType.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// Tag Type : float16ArrayType xor float32ArrayType xor uInt16ArrayType
public enum spectralWhitePointType {
    case float16Array(_: [UInt16])
    case float32Array(_: [Float])
    case uInt16Array(_: [UInt16])
    case sparseMatrixArray(_: sparseMatrixArrayType)
    
    public init(dataStream: inout DataStream, size: UInt32, header: ICCColorProfileHeader) throws {
        let startPosition = dataStream.position
        
        guard size >= 4 else {
            throw ICCReadError.corrupted
        }

        let data = try ICCTagData(dataStream: &dataStream, size: size, header: header)
        switch data {
        case let .float16Array(value):
            self = .float16Array(value)
        case let .float32Array(value):
            self = .float32Array(value)
        case let .uInt16Array(value):
            self = .uInt16Array(value)
        case let .sparseMatrixArray(value):
            self = .sparseMatrixArray(value)
        default:
            throw ICCReadError.corrupted
        }
        
        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }
}
