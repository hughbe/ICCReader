//
//  multiplexDefaultValuesType.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// Tag Type : uInt8ArrayType xor uInt16ArrayType xor float16ArrayType xor float32NumberArray
public enum multiplexDefaultValuesType {
    case uInt8Array(_: uInt8ArrayType)
    case uInt16Array(_: uInt16ArrayType)
    case float16Array(_: float16ArrayType)
    case float32Array(_: float32ArrayType)
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position
        
        guard size >= 4 else {
            throw ICCReadError.corrupted
        }
        
        /// 0..3 type signature
        let sig = try dataStream.peekString(count: 4, encoding: .ascii)!
        switch sig {
        case TagTypeSignature.uInt8ArrayType.rawValue:
            self = .uInt8Array(try uInt8ArrayType(dataStream: &dataStream, size: size))
        case TagTypeSignature.uInt16ArrayType.rawValue:
            self = .uInt16Array(try uInt16ArrayType(dataStream: &dataStream, size: size))
        case TagTypeSignature.float16ArrayType.rawValue:
            self = .float16Array(try float16ArrayType(dataStream: &dataStream, size: size))
        case TagTypeSignature.float32ArrayType.rawValue:
            self = .float32Array(try float32ArrayType(dataStream: &dataStream, size: size))
        default:
            throw ICCReadError.corrupted
        }
        
        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }
}
