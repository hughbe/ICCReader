//
//  ICCColorProfileVersion.swift
//  
//
//  Created by Hugh Bellamy on 07/03/2021.
//

import DataStream

/// 7.2.6 Profile version and sub-version field (bytes 8 to 11)
/// The profile version with which the profile conforms shall be encoded as binary-coded decimal in the profile version field.
/// The first byte (byte 8) shall identify the major version and byte 9 shall identify the minor version and bug fix version in each
/// 4-bit half of the byte. Bytes 10 and 11 shall be used to identify the profile sub-class version where byte 10 shall be used to
/// identify the sub-class major version and byte 11 shall be used to identify the sub-class minor version. When a sub-class is
/// not associated with a profile (when the Pprofile/device sub-class field is zero) then bytes 10 and 11 shall be zero. The major
/// and minor versions are set by the International Color Consortium (ICC). Profile sub-class versions shall be established by
/// profile sub-class specification documents. The profile version and sub-version number consistent with this specification is
/// "5.0.0.0" (encoded as 05000000h).
/// NOTE A major version number change occurs only when changes made to this document require that both CMMs and profile
/// generating software be upgraded in order to correctly produce or use profiles conforming to the revised specification. A minor
/// version number change occurs when profiles conforming to the revised specification can be processed by existing CMMs.
/// For example, adding a new required tag would necessitate a major revision to the specification, whereas adding an optional
/// tag would only require a minor revision.
public struct ICCColorProfileVersion {
    public let rawValue: UInt32
    
    /// 0 Major Revision in BCD
    public var majorVersion: UInt8 {
        return UInt8(rawValue & 0xFF)
    }
    
    /// 1 Minor Revision & Bug Fix Revision in each nibble in BCD
    public var minorVersion: UInt8 {
        return UInt8((rawValue >> 12) & 0x0F)
    }
    
    public var bugFixVersion: UInt8 {
        return UInt8((rawValue >> 8) & 0x0F)
    }
    
    public var subClassMajorVersion: UInt8 {
        return UInt8((rawValue >> 16) & 0xFF)
    }
    
    public var subClassMinorVersion: UInt8 {
        return UInt8((rawValue >> 16) & 0xFF)
    }
    
    public init(dataStream: inout DataStream) throws {
        self.rawValue = try dataStream.read(endianess: .littleEndian)
    }
}
