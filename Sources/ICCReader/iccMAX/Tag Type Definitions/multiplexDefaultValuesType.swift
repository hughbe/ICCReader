//
//  multiplexDefaultValuesType.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// Tag Type : uInt8ArrayType xor uInt16ArrayType xor float16ArrayType xor float32NumberArray
public enum multiplexDefaultValuesType {
    case uInt8Array(_: [UInt8])
    case uInt16Array(_: [UInt16])
    case float16Array(_: [UInt16])
    case float32Array(_: [Float])
    
    public init(dataStream: inout DataStream, size: UInt32, header: ExtendedProfileHeader) throws {
        let startPosition = dataStream.position
        
        guard size >= 4 else {
            throw ICCReadError.corrupted
        }
        
        let data = try ICCTagData(dataStream: &dataStream, size: size, header: header)
        switch data {
        case .uInt8Array(let values):
            self = .uInt8Array(values)
        case .uInt16Array(let values):
            self = .uInt16Array(values)
        case .float16Array(let values):
            self = .float16Array(values)
        case .float32Array(let values):
            self = .float32Array(values)
        default:
            throw ICCReadError.corrupted
        }
        
        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }
}
