//
//  viewingConditionsType.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// [ICC.1:2010] 10.28 viewingConditionsType
/// This type represents a set of viewing condition parameters. When used the byte assignment and encoding shall be as given in Table 81.
/// The viewing condition described in this tag is the actual viewing condition assumed for the media for which the profile is defined,
/// specified in un-normalized CIEXYZ values. Note that the luminanceTag shall be the same as the Y value given in this tag.
public struct viewingConditionsType {
    public let sig: ICCSignature
    public let reserved: uInt32Number
    public let illuminant: XYZNumber
    public let surround: XYZNumber
    public let stdIluminant: measurementType.Illuminant
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position
        
        guard size == 36 else {
            throw ICCReadError.corrupted
        }
        
        /// 0 to 3 4 ‘view’ (76696577h) type signature
        self.sig = try ICCSignature(dataStream: &dataStream)
        guard self.sig ==  ICCTagTypeSignature.viewingConditions else {
            throw ICCReadError.corrupted
        }
        
        /// 4 to 7 4 Reserved, shall be set to 0
        self.reserved = try dataStream.read(endianess: .bigEndian)
        
        /// 8 to 19 12 Un-normalized CIEXYZ values for illuminant (in which Y is in cd/m2) XYZNumber
        self.illuminant = try XYZNumber(dataStream: &dataStream)
        
        /// 20 to 31 12 Un-normalized CIEXYZ values for surround (in which Y is in cd/m2) XYZNumber
         self.surround = try XYZNumber(dataStream: &dataStream)
        
        /// 32 to 35 4 Illuminant type As described in measurementType
        guard let stdIluminant = measurementType.Illuminant(rawValue: try dataStream.read(endianess: .bigEndian)) else {
            throw ICCReadError.corrupted
        }
        
        self.stdIluminant = stdIluminant
        
        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }
}
