//
//  response16Number.swift
//  
//
//  Created by Hugh Bellamy on 14/12/2020.
//

import DataStream

/// [ICC.1:2010] 4.5 response16Number
/// A response16Number is an 8-byte value, used to associate a normalized device code with a measurement value, where byte usage
/// shall be assigned as specified in Table 3.
public struct response16Number {
    public let deviceCode: uInt16Number
    public let reserved: uInt16Number
    public let measurementValue: s15Fixed16Number
    
    public init(dataStream: inout DataStream) throws {
        /// 0 to 1 2 16-bit number in the interval [DeviceMin to DeviceMax]a uInt16Number
        self.deviceCode = try dataStream.read(endianess: .bigEndian)
        
        /// 2 to 3 2 Reserved, shall be zero
        self.reserved = try dataStream.read(endianess: .bigEndian)
        
        /// 4 to 7 4 Measurement value s15Fixed16Number
        self.measurementValue = try s15Fixed16Number(dataStream: &dataStream)
    }
}
