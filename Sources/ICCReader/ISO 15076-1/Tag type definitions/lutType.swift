//
//  lutType.swift
//  
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// Tag Type : lut8Type xor lut16Type xor  lutAToBTyp
public enum lutType {
    case lut8(_: lut8Type)
    case lut16(_: lut16Type)
    case lutAToB(_: lutAToBType)
    case lutBToA(_: lutBToAType)
    case multiProcessElements(_: multiProcessElementsType)
    
    public init(dataStream: inout DataStream, size: UInt32, header: ICCColorProfileHeader) throws {
        let startPosition = dataStream.position
        
        guard size >= 4 else {
            throw ICCReadError.corrupted
        }
        
        let data = try ICCTagData(dataStream: &dataStream, size: size, header: header)
        switch data {
        case let .lut8(value):
            self = .lut8(value)
        case let .lut16(value):
            self = .lut16(value)
        case let .lutAToB(value):
            self = .lutAToB(value)
        case let .lutBToA(value):
            self = .lutBToA(value)
        case let .multiProcessElements(value):
            self = .multiProcessElements(value)
        default:
            throw ICCReadError.corrupted
        }
        
        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }
}
