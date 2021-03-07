//
//  ICCColorProfileFlags.swift
//  
//
//  Created by Hugh Bellamy on 07/03/2021.
//

import DataStream

/// 7.2.13 Profile flags field (bytes 44 to 47)
/// The profile flags field shall contain flags to indicate various hints for the CMM such as distributed processing and caching options.
/// The least-significant 16 bits are reserved for the ICC. Flags in bit positions 0, 1 and 2 shall be used as indicated in Table 18.
/// Bit 2 shall define MCS subset requirements for connecting profiles. When bit 2 is set the CMM shall be instructed to fail the
/// linking of the profile containing this bit (containing profile) to another profile (second profile) using an MCS based connection if
/// the second profile does not contain all the channels in its MCS (defined in second profile’s multiplexTypeArrayTag, see 9.2.85)
/// that the containing profile has in its MCS (defined in the containing profile’s multiplexTypeArrayTag, see 9.2.85).
public struct ICCColorProfileFlags {
    public let reserved: UInt16
    public let embedded: Bool
    public let cannotBeUsedIndependentlyFromEmbeddedColorData: Bool
    public let mcsChannelsSubsetOfMcsChannelsInProfile: Bool
    public let unused: UInt16
    
    public init(dataStream: inout DataStream) throws {
        self.reserved = try dataStream.read(endianess: .bigEndian)

        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .bigEndian)
        
        /// 0 1 Embedded profile (0 if not embedded, 1 if embedded in file)
        self.embedded = flags.readBit()
        
        /// 1 1 Profile cannot be used independently of the embedded colour data (set to 1 if true, 0 if false)
        self.cannotBeUsedIndependentlyFromEmbeddedColorData = flags.readBit()
        
        /// 2 1 MCS channels in this profile shall be a subset of the MCS channels in the profile it is connected to
        /// (set to 1 if true, 0 if false)
        self.mcsChannelsSubsetOfMcsChannelsInProfile = flags.readBit()
        
        self.unused = flags.readRemainingBits()
    }
}
