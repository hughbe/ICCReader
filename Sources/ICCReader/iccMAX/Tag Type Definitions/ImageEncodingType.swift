//
//  ImageEncodingType.swift
//  
//
//  Created by Hugh Bellamy on 14/12/2020.
//

import DataStream

/// [ICC.2:2019] 12 to 15 4 Height image encoding format See Table 44
/// The image data shall be encoded using the image file format defined by the Displacement Image Format field which can have the
/// values given in Table 44.
public enum ImageEncodingType: UInt16 {
    /// PNG 0
    case png = 0
    
    /// TIFF 1
    case tiff = 1
    
    public init(dataStream: inout DataStream) throws {
        let rawValue: UInt16 = try dataStream.read(endianess: .bigEndian)
        guard let value = Self(rawValue: rawValue) else {
            throw ICCReadError.corrupted
        }
        
        self = value
    }
}
