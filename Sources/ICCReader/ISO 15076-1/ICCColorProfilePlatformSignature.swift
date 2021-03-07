//
//  ICCColorProfilePlatformSignature.swift
//  
//
//  Created by Hugh Bellamy on 07/03/2021.
//

/// 7.2.12 Primary platform field (bytes 40 to 43)
/// This field may be used to identify the primary platform/operating system framework for which the profile was created.
/// The primary platforms that have been identified and the signatures that shall be used are shown in Table 17.
/// If no primary platform is identified, this field shall be zero (00000000h).
public enum ICCColorProfilePlatformSignature {
    /// Apple Computer, Inc. ‘APPL’ 4150504Ch
    public static let appleComputer: ICCSignature = "APPL"
    
    /// Microsoft Corporation ‘MSFT’ 4D534654h
    public static let microsoftCorporation: ICCSignature = "MSFT"
    public static let microsoftCorporation2: ICCSignature = "msft"
    
    /// Silicon Graphics, Inc. ‘SGI ’ 53474920h
    public static let siliconGraphics: ICCSignature = "SGI "
    
    /// Sun Microsystems, Inc. ‘SUNW’ 53554E57h
    public static let sunMicrosystems: ICCSignature = "SUNW"
    
    /// [Removed] Taligent, Inc. ‘TGNT ‘ 54474E54h
    public static let taligent: ICCSignature = "TGNT"
    
    /// [Unknown]
    public static let unix: ICCSignature = "*nix"
    
    public static let none: ICCSignature = "\0\0\0\0"
}
