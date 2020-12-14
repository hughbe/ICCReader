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
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position
        
        guard size >= 4 else {
            throw ICCReadError.corrupted
        }
        
        /// 0..3 type signature
        let sig = try dataStream.peekString(count: 4, encoding: .ascii)!
        switch sig {
        case TagTypeSignature.lut8Type.rawValue:
            self = .lut8(try lut8Type(dataStream: &dataStream, size: size))
        case TagTypeSignature.lut16Type.rawValue:
            self = .lut16(try lut16Type(dataStream: &dataStream, size: size))
        case TagTypeSignature.lutAToBType.rawValue:
            self = .lutAToB(try lutAToBType(dataStream: &dataStream, size: size))
        case TagTypeSignature.lutBToAType.rawValue:
            self = .lutBToA(try lutBToAType(dataStream: &dataStream, size: size))
        case TagTypeSignature.multiProcessElementsType.rawValue:
            self = .multiProcessElements(try multiProcessElementsType(dataStream: &dataStream, size: size))
        default:
            throw ICCReadError.corrupted
        }
        
        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }
}
