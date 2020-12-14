//
//  XYZNumber.swift
//  
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// 4.14 XYZNumber
/// An XYZNumber is a set of three fixed signed 4-byte (32-bit) quantities used to encode CIEXYZ, nCIEXYZ, and PCSXYZ tristimulus
/// values where byte usage is assigned as specified in Table 8. Although the CIE specifies that for reflecting and transmitting media Y
/// should be normalized such that it has the value 100,0 for the perfect diffusing reflector or transmitter, in this , for reasons of coding
/// efficiency, Y is specified such that it has the value 1,0 for the perfect diffusing reflector or transmitter for nCIEXYZ.
/// NOTE 1 Signed numbers are employed for this type to accommodate negative values arising during calculations.
public struct XYZNumber {
    public let x: s15Fixed16Number
    public let y: s15Fixed16Number
    public let z: s15Fixed16Number
    
    public init(dataStream: inout DataStream) throws {
        /// 0 to 3 4 CIEXYZ X, nCIEXYZ X, or PCSXYZ X s15Fixed16Number
        self.x = try s15Fixed16Number(dataStream: &dataStream)
        
        /// 4 to 7 4 CIEXYZ Y, nCIEXYZ Y, or PCSXYZ Y s15Fixed16Number
        self.y = try s15Fixed16Number(dataStream: &dataStream)
        
        /// 8 to 11 4 CIEXYZ Z, nCIEXYZ Z, or PCSXYZ Z s15Fixed16Number
        self.z = try s15Fixed16Number(dataStream: &dataStream)
    }
}
