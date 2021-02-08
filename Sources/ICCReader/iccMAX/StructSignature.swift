//
//  StructSignature.swift
//  
//
//  Created by Hugh Bellamy on 14/12/2020.
//

public enum StructSignature {
    /// icSigBRDFStruct                     = 0x62726466,  /* 'brdf' */
    public static let brdg: ICCSignature = "brdf"
    
    /// icSigColorantInfoStruct             = 0x63696e66,  /* 'cinf' */
    public static let colorantInfo: ICCSignature = "cinf"
    
    /// icSigColorEncodingParamsSruct       = 0x63657074,  /* 'cept' */
    public static let colorEncodingParams: ICCSignature = "cept"
    
    /// icSigMeasurementInfoStruct          = 0x6d656173,  /* 'meas' */
    public static let meas: ICCSignature = "meas"
    
    /// icSigNamedColorStruct               = 0x6e6d636c,  /* 'nmcl' */
    public static let namedColor: ICCSignature = "nmcl"
    
    /// icSigProfileInfoStruct              = 0x70696e66,  /* 'pinf' */
    public static let profileInfo: ICCSignature = "pinf"
    
    /// icSigTintZeroStruct                 = 0x746e7430,  /* 'tnt0' */
    public static let tintZero: ICCSignature = "tnt0"
    
    /// icSigUndefinedStruct                = 0x00000000,
    public static let undefined: ICCSignature = "\0\0\0\0"
}
