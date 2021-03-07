//
//  ICCColorProfileRenderingIntent.swift
//  
//
//  Created by Hugh Bellamy on 07/03/2021.
//

import DataStream

/// 7.2.17 Rendering intent field (bytes 64 to 67)
/// The rendering intent field shall specify the rendering intent that should be used (or, in the case of a DeviceLink profile, was used)
/// when this profile is (was) combined with another profile. In a sequence of more than two profiles, it applies to the combination of
/// this profile and the next profile in the sequence and not to the entire sequence. Typically, the user or application selects the
/// rendering intent dynamically at runtime or embedding time. Therefore, this flag may not have any meaning until the profile is used
/// in some context, for example in a DeviceLink or an embedded source profile.
/// The field is a uInt32Number in which the least-significant 16 bits shall be used to encode the rendering intent. The most significant
/// 16 bits shall be zero (0000h).
/// The defined rendering intents are perceptual, media-relative colorimetric, saturation and ICC-absolute colorimetric. These shall
/// be identified using the values shown in Table 20.
public enum ICCColorProfileRenderingIntent: UInt32 {
    /// Perceptual 0
    case perceptual = 0
    
    /// Media-relative colorimetric 1
    case mediaRelativeColorimetric = 1
    
    /// Saturation 2
    case saturation = 2
    
    /// ICC-absolute colorimetric 3
    case iccAbsoluteColorimetric = 3
    
    case unknown = 0xFF
    
    public init(dataStream: inout DataStream) throws {
        let rawValue: UInt32 = try dataStream.read(endianess: .bigEndian)
        guard let value = ICCColorProfileRenderingIntent(rawValue: rawValue) else {
            self = .unknown
            return
        }
        
        self = value
    }
}
