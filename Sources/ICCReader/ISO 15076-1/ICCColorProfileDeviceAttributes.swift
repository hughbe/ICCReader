//
//  ICCColorProfileDeviceAttributes.swift
//  
//
//  Created by Hugh Bellamy on 07/03/2021.
//

import DataStream

/// 7.2.16 Device attributes field (bytes 56 to 63)
/// The device attributes field shall contain flags used to identify attributes unique to the particular device setup for which the
/// profile is applicable. The least-significant 32 bits of this 64-bit value are defined by the ICC. Bit usage shall be used as shown
/// in Table 19.
public struct ICCColorProfileDeviceAttributes {
    public let transparent: Bool
    public let matte: Bool
    public let negativeMediaPolarity: Bool
    public let blackAndWhite: Bool
    public let nonPaperBased: Bool
    public let textured: Bool
    public let nonIsotropic: Bool
    public let selfLuminous: Bool
    public let reserved: uInt32Number
    public let vendorSpecific: UInt32
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .bigEndian)
        
        /// 0 1 Reflective (0) or transparency (1)
        self.transparent = flags.readBit()
        
        /// 1 1 Glossy (0) or matte (1)
        self.matte = flags.readBit()
        
        /// 2 1 Media polarity, positive (0) or negative (1)
        self.negativeMediaPolarity = flags.readBit()
        
        /// 3 1 Colour media (0), black and white media (1)
        self.blackAndWhite = flags.readBit()
        
        /// 4 1 Paper/paperboard (0), non-paper-based (1)
        self.nonPaperBased = flags.readBit()
        
        /// 5 1 Non-textured (0), textured (1)
        self.textured = flags.readBit()
        
        /// 6 1 Isotropic (0), non-isotropic (1)
        self.nonIsotropic = flags.readBit()
        
        /// 7 1 Non self-luminous (0) or self-luminous (1)
        self.selfLuminous = flags.readBit()
        
        /// 8 to 31 24 Reserved (set to binary zero)
        self.reserved = flags.readRemainingBits()
        
        /// 32 to 63 32 Use not defined by ICC (vendor specific)
        self.vendorSpecific = try dataStream.read(endianess: .bigEndian)
    }
}
