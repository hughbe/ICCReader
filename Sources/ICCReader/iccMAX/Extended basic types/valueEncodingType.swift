//
//  valueEncodingType.swift
//
//
//  Created by Hugh Bellamy on 14/12/2020.
//

import DataStream

/// [ICC.2:2019] 4.2.9 valueEncodingType
/// When encoding values in sampled curves and colour lookup tables (CLUTs) the exact data encoding type used shall be specified
/// using a valueEncodingType parameter. Values for a valueEncodingType parameter shall be as defined in Table 8. Encoded values
/// for the float32Number and float16Number types shall represent the actual encoding number. Encoded values for the uInt16Number
/// and uInt8Number types shall represent an encoding between the range of 0,0 to 1,0.
/// Values for a valueEncodingType may be encoded as either a uInt16Number or a uInt32Number.
public enum valueEncodingType: UInt16 {
    /// 0 float32Number
    case float32 = 0
    
    /// 1 float16Number
    case float16 = 1
    
    /// 2 uInt16Number
    case uint16 = 2
    
    /// 3 uInt8Number
    case uint8 = 3
    
    public init(dataStream: inout DataStream) throws {
        let rawValue: UInt16 = try dataStream.read(endianess: .bigEndian)
        guard let value = Self(rawValue: rawValue) else {
            throw ICCReadError.corrupted
        }
        
        self = value
    }
}
