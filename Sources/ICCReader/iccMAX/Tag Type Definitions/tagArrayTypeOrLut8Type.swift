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
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position
        
        guard size >= 4 else {
            throw ICCReadError.corrupted
        }
        
        /// 0..3 type signature
        let sig = try dataStream.peekString(count: 4, encoding: .ascii)!
        switch sig {
        case TagTypeSignature.tagArrayType.rawValue:
            self = .tagArray(try tagArrayType(dataStream: &dataStream, size: size))
        case TagTypeSignature.lut8Type.rawValue,
             TagTypeSignature.lut16Type.rawValue,
             TagTypeSignature.lutAToBType.rawValue,
             TagTypeSignature.lutBToAType.rawValue:
            self = .lut(try lutType(dataStream: &dataStream, size: size))
        default:
            throw ICCReadError.corrupted
        }
        
        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }
}
