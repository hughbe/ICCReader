//
//  sparseMatrixEncodingType.swift
//  
//
//  Created by Hugh Bellamy on 14/12/2020.
//

import DataStream

/// [ICC.2:2019] 4.2.6 sparseMatrixEncodingType
/// When encoding sparse matrices the exact data encoding type used shall be specified using a sparseMatrixEncodingType parameter.
/// Where used, values for a sparseMatrixEncodingType parameter shall be encoded as defined in Table 5.
public enum sparseMatrixEncodingType: UInt16 {
    /// 1 sparsematrixUInt8
    case uInt8 = 1
    
    /// 2 sparseMatrixUInt16
    case uInt16 = 2
    
    /// 3 sparseMatrixFloat16
    case float16 = 3
    
    /// 4 sparseMatrixFloat32
    case float32 = 4
    
    public init(dataStream: inout DataStream) throws {
        let rawValue: UInt16 = try dataStream.read(endianess: .bigEndian)
        guard let value = Self(rawValue: rawValue) else {
            throw ICCReadError.corrupted
        }
        
        self = value
    }
}
