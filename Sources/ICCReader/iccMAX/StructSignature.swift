//
//  StructSignature.swift
//  
//
//  Created by Hugh Bellamy on 14/12/2020.
//

public enum StructSignature: String {
    /// icSigBRDFStruct                     = 0x62726466,  /* 'brdf' */
    case brdg = "brdf"
    
    /// icSigColorantInfoStruct             = 0x63696e66,  /* 'cinf' */
    case colorantInfo = "cinf"
    
    /// icSigColorEncodingParamsSruct       = 0x63657074,  /* 'cept' */
    case colorEncodingParams = "cept"
    
    /// icSigMeasurementInfoStruct          = 0x6d656173,  /* 'meas' */
    case meas = "meas"
    
    /// icSigNamedColorStruct               = 0x6e6d636c,  /* 'nmcl' */
    case namedColor = "nmcl"
    
    /// icSigProfileInfoStruct              = 0x70696e66,  /* 'pinf' */
    case profileInfo = "pinf"
    
    /// icSigTintZeroStruct                 = 0x746e7430,  /* 'tnt0' */
    case tintZero = "tnt0"
    
    /// icSigUndefinedStruct                = 0x00000000,
    case undefined = "\0\0\0\0"
}
