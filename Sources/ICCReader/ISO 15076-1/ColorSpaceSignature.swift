//
//  ColorSpaceSignature.swift
//  
//
//  Created by Hugh Bellamy on 07/03/2021.
//

/// 7.2.8 Data colour space field (Bytes 16 to 20)
/// This field shall contain the signature of the data colour space expected on the A side of the profile transforms.
/// The names and Signatures of the permitted data colour spaces shall be as shown in Table 15.
/// Channel encoding order shall be associated with the order that channel names are identified in the signature (for example given
/// Signature ‘RGB’ the channel order shall be channel 1 – R, channel 2 – G, channel 3 – B) with the following exceptions: for the
/// Signature ‘GRAY’ there is only 1 channel; for the signature ‘YCbr’ the channel order shall be channel 1 – Y, channel 2 – Cb,
/// channel 3 – Cr; for xCLR and N channel data the order shall be the same as the incoming device channel order.
/// For abstract profiles the data colour space signature shall one of the signatures in Table 15. If set to zero the spectral PCS
/// Signature and spectral range fields shall be used to define the A side of the transform.
/// For MultiplexLink and MultiplexVisualization profiles the data colour space signature shall be zero.
public enum ColorSpaceSignature {
    /// nCIEXYZ or PCSXYZa ‘XYZ ’ 58595A20h
    /// a The Signature 'XYZ ' refers to nCIEXYZ or PCSXYZ, depending upon the context.
    public static let xyz: ICCSignature = "XYZ "
    
    /// CIELAB or PCSLABb ‘Lab ’ 4C616220h
    /// b The Signature 'Lab' refers to CIELAB or PCSLAB, depending upon the context.
    public static let lab: ICCSignature = "Lab "
    
    /// CIELUV ‘Luv ’ 4C757620h
    public static let cieluv: ICCSignature = "Luv "

    /// YCbCr ‘YCbr’ 59436272h
    public static let yCbCr: ICCSignature = "YCbr"
    
    /// CIEYxy ‘Yxy ’ 59787920h
    public static let yxy: ICCSignature = "Yxy "
    
    /// LMS ‘LMS ‘ 4C4D5320h
    public static let lms: ICCSignature = "LMS "
    
    /// RGB ‘RGB ’ 52474220h
    public static let rgb: ICCSignature = "RGB "
    
    /// Gray ‘GRAY’ 47524159h
    public static let gray: ICCSignature = "GRAY"
    
    /// HSV ‘HSV ’ 48535620h
    public static let hsv: ICCSignature = "HSV "
    
    /// HLS ‘HLS ’ 484C5320h
    public static let hls: ICCSignature = "HLS "
    
    /// CMYK ‘CMYK’ 434D594Bh
    public static let cmyk: ICCSignature = "CMYK"
    
    /// CMY ‘CMY ’ 434D5920h
    public static let cmy: ICCSignature = "CMY "
    
    /// 2 colour ‘2CLR’ 32434C52h
    public static let twoColor: ICCSignature = "2CLR"
    
    /// 3 colour (other than those listed above) ‘3CLR’ 33434C52h
    public static let threeColor: ICCSignature = "3CLR"
    
    /// 4 colour (other than CMYK) ‘4CLR’ 34434C52h
    public static let fourColor: ICCSignature = "4CLR"
    
    /// 5 colour ‘5CLR’ 35434C52h
    public static let fiveColor: ICCSignature = "5CLR"
    
    /// 6 colour ‘6CLR’ 36434C52h
    public static let sixColor: ICCSignature = "6CLR"
    
    /// 7 colour ‘7CLR’ 37434C52h
    public static let sevenColor: ICCSignature = "7CLR"
    
    /// 8 colour ‘8CLR’ 38434C52h
    public static let eightColor: ICCSignature = "8CLR"
    
    /// 9 colour ‘9CLR’ 39434C52h
    public static let nineColor: ICCSignature = "9CLR"
    
    /// 10 colour ‘ACLR’ 41434C52h
    public static let tenColor: ICCSignature = "10CLR"
    
    /// 11 colour ‘BCLR’ 42434C52h
    public static let elevenColor: ICCSignature = "BCLR"
    
    /// 12 colour ‘CCLR’ 43434C52h
    public static let twelveColor: ICCSignature = "CCLR"
    
    /// 13 colour ‘DCLR’ 44434C52h
    public static let thirteenColor: ICCSignature = "DCLR"
    
    /// 14 colour ‘ECLR’ 45434C52h
    public static let fourteenColor: ICCSignature = "ECLR"
    
    /// 15 colour ‘FCLR’ 46434C52h
    public static let fifteenColor: ICCSignature = "FCLR"
    
    /// None 0 00000000h
    public static let none: ICCSignature = "\0\0\0\0"
}
