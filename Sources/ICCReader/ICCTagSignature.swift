//
//  ICCTagSignature.swift
//  
//
//  Created by Hugh Bellamy on 11/12/2020.
//

/// [ICC.1:2010] 9.2 Tag listing
public enum ICCTagSignature {
    /// [ICC.1:2010] 9.2.1 AToB0Tag
    public static let aToB0: ICCSignature = "A2B0"
    
    /// [ICC.1:2010] 9.2.2 AToB1Tag
    public static let aToB1: ICCSignature = "A2B1"
    
    /// [ICC.1:2010] 9.2.3 AToB2Tag
    public static let aToB2: ICCSignature = "A2B2"
    
    /// [ICC.1:2010] 9.2.4 blueMatrixColumnTag
    /// [ICC.1:2001-04] 6.4.4 blueColorantTag
    public static let blueMatrixColumn: ICCSignature = "bXYZ"
    
    /// [ICC.1:2010] 6.4.4 blueColorantTag
    public static let blueTRC: ICCSignature = "bTRC"
    
    /// [ICC.1:2010] 9.2.6 BToA0Tag
    public static let bToA0: ICCSignature = "B2A0"
    
    /// [ICC.1:2010] 9.2.7 BToA1Tag
    public static let bToA1: ICCSignature = "B2A1"
    
    /// [ICC.1:2010] 9.2.8 BToA2Tag
    public static let bToA2: ICCSignature = "B2A2"
    
    /// [ICC.1:2010] 9.2.9 BToD0Tag
    public static let bToD0: ICCSignature = "B2D0"
    
    /// [ICC.1:2010] 9.2.10 BToD1Tag
    public static let bToD1: ICCSignature = "B2D1"
    
    /// [ICC.1:2010] 9.2.11 BToD2Tag
    public static let bToD2: ICCSignature = "B2D2"
    
    /// [ICC.1:2010] 9.2.12 BToD3Tag
    public static let bToD3: ICCSignature = "B2D3"

    /// [ICC.1:2010] 9.2.13 calibrationDateTimeTag
    public static let calibrationDateTime: ICCSignature = "calt"
    
    /// [ICC.1:2010] 9.2.14 charTargetTag
    public static let charTarget: ICCSignature = "targ"
    
    /// [ICC.1:2010] 9.2.15 chromaticAdaptationTag
    public static let chromaticAdaptation: ICCSignature = "chad"
    
    /// [ICC.1:2010] 9.2.16 chromaticityTag
    public static let chromacity: ICCSignature = "chrm"
    
    /// [ICC.1:2010] 9.2.17 colorantOrderTag
    public static let colorantOrder: ICCSignature = "clro"
    
    /// [ICC.1:2010] 9.2.18 colorantTableTag
    public static let colorantTable: ICCSignature = "clrt"
    
    /// [ICC.1:2010] 9.2.19 colorantTableOutTag
    public static let colorantTableOut: ICCSignature = "clot"
    
    /// [ICC.1:2010] 9.2.20 colorimetricIntentImageStateTag
    public static let colorimetricIntentImageState: ICCSignature = "ciis"
    
    /// [ICC.1:2010] 9.2.21 copyrightTag
    public static let copyright: ICCSignature = "cprt"
    
    /// [ICC.1:2010] 9.2.22 deviceMfgDescTag
    public static let deviceMfgDesc: ICCSignature = "dmnd"
    
    /// [ICC.1:2010] 9.2.23 deviceModelDescTag
    public static let deviceModelDesc: ICCSignature = "dmdd"
    
    /// [ICC.1:2010] 9.2.24 DToB0Tag
    public static let dToB0: ICCSignature = "D2B0"
    
    /// [ICC.1:2010] 9.2.25 DToB1Tag
    public static let dToB1: ICCSignature = "D2B1"
    
    /// [ICC.1:2010] 9.2.26 DToB2Tag
    public static let dToB2: ICCSignature = "D2B2"
    
    /// [ICC.1:2010] 9.2.27 DToB3Tag
    public static let dToB3: ICCSignature = "D2B3"
    
    /// [ICC.1:2010] 9.2.28 gamutTag
    public static let gamut: ICCSignature = "gamt"
    
    /// [ICC.1:2010] 9.2.29 grayTRCTag
    public static let grayTRC: ICCSignature = "kTRC"
    
    /// [ICC.1:2010] 9.2.30 greenMatrixColumnTag
    /// [ICC.1:2001-04] 6.4.20 greenColorantTag
    public static let greenMatrixColumn: ICCSignature = "gXYZ"
    
    /// [ICC.1:2010] 9.2.31 greenTRCTag
    public static let greenTRC: ICCSignature = "gTRC"
    
    /// [ICC.1:2010] 9.2.32 luminanceTag
    public static let luminance: ICCSignature = "lumi"
    
    /// [ICC.1:2010] 9.2.33 measurementTag
    public static let measurement: ICCSignature = "meas"
    
    /// [ICC.1:2010] 9.2.34 mediaWhitePointTag
    public static let mediaWhitePoint: ICCSignature = "wtpt"
    
    /// [ICC.1:2010] 9.2.35 namedColor2Tag
    public static let namedColor2: ICCSignature = "ncl2"
    
    /// [ICC.1:2010] 9.2.36 outputResponseTag
    public static let outputResponse: ICCSignature = "resp"
    
    /// [ICC.1:2010] 9.2.37 perceptualRenderingIntentGamutTag
    public static let perceptualRenderingIntentGamut: ICCSignature = "rig0"
    
    /// [ICC.1:2010] 9.2.38 preview0Tag
    public static let preview0: ICCSignature = "pre0"
    
    /// [ICC.1:2010] 9.2.39 preview1Tag
    public static let preview1: ICCSignature = "pre1"
    
    /// [ICC.1:2010] 9.2.40 preview2Tag
    public static let preview2: ICCSignature = "pre2"
    
    /// [ICC.1:2010] 9.2.41 profileDescriptionTag
    public static let profileDescription: ICCSignature = "desc"
    
    /// [ICC.1:2010] 9.2.42 profileSequenceDescTag
    public static let profileSequenceDesc: ICCSignature = "pseq"
    
    /// [ICC.1:2010] 9.2.43 profileSequenceIdentifierTag
    public static let profileSequenceIdentifier: ICCSignature = "psid"
    
    /// [ICC.1:2010] 9.2.44 redMatrixColumnTag
    /// [ICC.1:2010] 6.4.40 redColorantTag
    public static let redMatrixColumn: ICCSignature = "rXYZ"
    
    /// [ICC.1:2010] 9.2.45 redTRCTag
    public static let redTRC: ICCSignature = "rTRC"
    
    /// [ICC.1:2010] 9.2.46 saturationRenderingIntentGamutTag
    public static let saturationRenderingIntentGamut: ICCSignature = "rig2"
    
    /// [ICC.1:2010] 9.2.47 technologyTag
    public static let technology: ICCSignature = "tech"
    
    /// [ICC.1:2010]
    public static let ucrBg: ICCSignature = "bfd "
    
    /// [ICC.1:2010]
    public static let viewingCondDesc: ICCSignature = "vued"
    
    /// [ICC.1:2010]
    public static let viewingConditions: ICCSignature = "view"
    
    /* Removed */
    /// [ICC.1:2001-04] 6.4.14 crdInfoTag
    public static let crdInfo: ICCSignature = "crdi"
    
    /// [ICC.1:2001-04] 6.4.17 deviceSettingsTag
    public static let deviceSettings: ICCSignature = "devs"
    
    /// [ICC.1:2001-04] 6.4.24 mediaBlackPointTag
    public static let mediaBlackPoint: ICCSignature = "bkpt"
    
    /// [ICC.1:2001-40] 6.4.26 namedColorTag
    public static let namedColor: ICCSignature = "ncol"
    
    /// [ICC.1:2001-04] 6.4.34 ps2CRD0Tag
    public static let ps2CRD0: ICCSignature = "psd0"
    
    /// [ICC.1:2001-4] 6.4.35 ps2CRD1Tag
    public static let ps2CRD1: ICCSignature = "psd1"
    
    /// [ICC.1:2001-4] 6.4.36 ps2CRD2Tag
    public static let ps2CRD2: ICCSignature = "psd2"
    
    /// [ICC.1:2001-4] 6.4.37 ps2CRD3Tag
    public static let ps2CRD3: ICCSignature = "psd3"
    
    /// [ICC.1:2001-4] 6.4.38 ps2CSATag
    public static let ps2CSA: ICCSignature = "ps2s"
    
    /// [ICC.1:2001-4] 6.4.39 ps2RenderingIntentTag
    public static let ps2RenderingIntent: ICCSignature = "ps2i"
    
    /// [ICC.1:2001-4] 6.4.42 screeningDescTag
    public static let screeningDesc: ICCSignature = "scrd"
    
    /// [ICC.1:2001-4] 6.4.43 screeningTag
    public static let screening: ICCSignature = "scrn"
    
    /* ICC Max */
    /// [ICC.2:2019] 9.2.4 AToB3Tag
    public static let aToB3: ICCSignature = "A2B3"
    
    /// [ICC.2:2019] 9.2.5 AToM0Tag
    public static let aToM0: ICCSignature = "A2M0"
    
    /// [ICC.2:2019] 9.2.6 brdfColorimetricParameter0Tag
    public static let brdfColorimetricParameter0: ICCSignature = "bcp0"
    
    /// [ICC.2:2019] 9.2.7 brdfColorimetricParameter1Tag
    public static let brdfColorimetricParameter1: ICCSignature = "bcp1"
    
    /// [ICC.2:2019] 9.2.8 brdfColorimetricParameter2Tag
    public static let brdfColorimetricParameter2: ICCSignature = "bcp2"
    
    /// [ICC.2:2019] 9.2.9 brdfColorimetricParameter3Tag
    public static let brdfColorimetricParameter3: ICCSignature = "bcp3"
    
    /// [ICC.2:2019] 9.2.10 brdfSpectralParameter0Tag
    public static let brdfSpectralParameter0: ICCSignature = "bsp0"
    
    /// [ICC.2:2019] 9.2.11 brdfSpectralParameter1Tag
    public static let brdfSpectralParameter1: ICCSignature = "bsp1"
    
    /// [ICC.2:2019] 9.2.12 brdfSpectralParameter2Tag
    public static let brdfSpectralParameter2: ICCSignature = "bsp2"
    
    /// [ICC.2:2019] 9.2.13 brdfSpectralParameter3Tag
    public static let brdfSpectralParameter3: ICCSignature = "bsp3"
    
    /// [ICC.2:2019] 9.2.14 brdfAToB0Tag
    public static let brdfAToB0: ICCSignature = "bAB0"
    
    /// [ICC.2:2019] 9.2.15 brdfAToB1Tag
    public static let brdfAToB1: ICCSignature = "bAB1"
    
    /// [ICC.2:2019] 9.2.16 brdfAToB2Tag
    public static let brdfAToB2: ICCSignature = "bAB2"
    
    /// [ICC.2:2019] 9.2.17 brdfAToB3Tag
    public static let brdfAToB3: ICCSignature = "bAB3"
    
    /// [ICC.2:2019] 9.2.18 brdfBToA0Tag
    public static let brdfBToA0: ICCSignature = "bBA0"
    
    /// [ICC.2:2019] 9.2.19 brdfBToA1Tag
    public static let brdfBToA1: ICCSignature = "bBA1"
    
    /// [ICC.2:2019] 9.2.20 brdfBToA2Tag
    public static let brdfBToA2: ICCSignature = "bBA2"
    
    /// [ICC.2:2019] 9.2.21 brdfBToA3Tag
    public static let brdfBToA3: ICCSignature = "bBA3"
    
    /// [ICC.2:2019] 9.2.22 brdfBToD0Tag
    public static let brdfBToD0: ICCSignature = "bBD0"
    
    /// [ICC.2:2019] 9.2.23 brdfBToD1Tag
    public static let brdfBToD1: ICCSignature = "bBD1"
    
    /// [ICC.2:2019] 9.2.24 brdfBToD2Tag
    public static let brdfBToD2: ICCSignature = "bBD2"
    
    /// [ICC.2:2019] 9.2.25 brdfBToD3Tag
    public static let brdfBToD3: ICCSignature = "bBD3"
    
    /// [ICC.2:2019] 9.2.26 brdfDToB0Tag
    public static let brdfDToB0: ICCSignature = "bDB0"
    
    /// [ICC.2:2019] 9.2.27 brdfDToB1Tag
    public static let brdfDToB1: ICCSignature = "bDB1"
    
    /// [ICC.2:2019] 9.2.28 brdfDToB2Tag
    public static let brdfDToB2: ICCSignature = "bDB2"
    
    /// [ICC.2:2019] 9.2.29 brdfDToB3Tag
    public static let brdfDToB3: ICCSignature = "bDB3"
    
    /// [ICC.2:2019] 9.2.30 brdfMToB0Tag
    public static let brdfMToB0: ICCSignature = "bMB0"
    
    /// [ICC.2:2019] 9.2.31 brdfMToB1Tag
    public static let brdfMToB1: ICCSignature = "bMB1"
    
    /// [ICC.2:2019] 9.2.32 brdfMToB2Tag
    public static let brdfMToB2: ICCSignature = "bMB2"
    
    /// [ICC.2:2019] 9.2.33 brdfMToB3Tag
    public static let brdfMToB3: ICCSignature = "bMB3"
    
    /// [ICC.2:2019] 9.2.34 brdfMToS0Tag
    public static let brdfMToS0: ICCSignature = "bMS0"
    
    /// [ICC.2:2019] 9.2.35 brdfMToS1Tag
    public static let brdfMToS1: ICCSignature = "bMS1"
    
    /// [ICC.2:2019] 9.2.36 brdfMToS2Tag
    public static let brdfMToS2: ICCSignature = "bMS2"
    
    /// [ICC.2:2019] 9.2.37 brdfMToS3Tag
    public static let brdfMToS3: ICCSignature = "bMS3"
    
    /// [ICC.2:2019] 9.2.41 BToA3Tag
    public static let bToA3: ICCSignature = "B2A3"
    
    /// [ICC.2:2019] 9.2.48 colorEncodingParamsTag
    public static let colorEncodingParams: ICCSignature = "cept"
    
    /// [ICC.2:2019] 9.2.49 colorSpaceNameTag
    public static let colorSpaceName: ICCSignature = "csnm"
    
    /// [ICC.2:2019] 9.2.52 colorantInfoTag
    public static let colorantInfo: ICCSignature = "clin"
    
    /// [ICC.2:2019] 9.2.53 colorantInfoOutTag
    public static let colorantInfoOut: ICCSignature = "clio"
    
    /// [ICC.2:2019] 9.2.56 customToStandardPccTag
    public static let customToStandardPcc: ICCSignature = "c2sp"
    
    /// [ICC.2:2019] 9.2.57 cxfTag
    public static let cxf: ICCSignature = "CxF "
    
    /// [ICC.2:2019] 9.2.60 directionalAToB0Tag
    public static let directionalAToB0: ICCSignature = "dAB0"
    
    /// [ICC.2:2019] 9.2.61 directionalAToB1Tag
    public static let directionalAToB1: ICCSignature = "dAB1"
    
    /// [ICC.2:2019] 9.2.62 directionalAToB2Tag
    public static let directionalAToB2: ICCSignature = "dAB2"
    
    /// [ICC.2:2019] 9.2.63 directionalAToB3Tag
    public static let directionalAToB3: ICCSignature = "dAB3"
    
    /// [ICC.2:2019] 9.2.64 directionalBToA0Tag
    public static let directionalBToA0: ICCSignature = "dBA0"
    
    /// [ICC.2:2019] 9.2.65 directionalBToA1Tag
    public static let directionalBToA1: ICCSignature = "dBA1"
    
    /// [ICC.2:2019] 9.2.66 directionalBToA2Tag
    public static let directionalBToA2: ICCSignature = "dBA2"
    
    /// [ICC.2:2019] 9.2.67 directionalBToA3Tag
    public static let directionalBToA3: ICCSignature = "dBA3"
    
    /// [ICC.2:2019] 9.2.68 directionalBToD0Tag
    public static let directionalBToD0: ICCSignature = "dBD0"
    
    /// [ICC.2:2019] 9.2.69 directionalBToD1Tag
    public static let directionalBToD1: ICCSignature = "dBD1"
    
    /// [ICC.2:2019] 9.2.70 directionalBToD2Tag
    public static let directionalBToD2: ICCSignature = "dBD2"
    
    /// [ICC.2:2019] 9.2.71 directionalBToD3Tag
    public static let directionalBToD3: ICCSignature = "dBD3"
    
    /// [ICC.2:2019] 9.2.72 directionalDToB0Tag
    public static let directionalDToB0: ICCSignature = "dDB0"
    
    /// [ICC.2:2019] 9.2.73 directionalDToB1Tag
    public static let directionalDToB1: ICCSignature = "dDB1"
    
    /// [ICC.2:2019] 9.2.74 directionalDToB2Tag
    public static let directionalDToB2: ICCSignature = "dDB2"
    
    /// [ICC.2:2019] 9.2.75 directionalDToB3Tag
    public static let directionalDToB3: ICCSignature = "dDB3"
    
    /// [ICC.2:2019] 9.2.80 gamutBoundaryDescription0Tag
    public static let gamutBoundaryDescription0: ICCSignature = "gbd0"
    
    /// [ICC.2:2019] 9.2.81 gamutBoundaryDescription1Tag
    public static let gamutBoundaryDescription1: ICCSignature = "gbd1"
    
    /// [ICC.2:2019] 9.2.82 gamutBoundaryDescription2Tag
    public static let gamutBoundaryDescription2: ICCSignature = "gbd2"
    
    /// [ICC.2:2019] 9.2.83 gamutBoundaryDescription3Tag
    public static let gamutBoundaryDescription3: ICCSignature = "gbd3"
    
    /// [ICC.2:2019] 9.2.84 multiplexDefaultValuesTag
    public static let multiplexDefaultValues: ICCSignature = "mdv "
    
    /// [ICC.2:2019] 9.2.85 multiplexTypeArrayTag
    public static let multiplexTypeArray: ICCSignature = "mcta"
    
    /// [ICC.2:2019] 9.2.86 measurementInfoTag
    public static let measurementInfo: ICCSignature = "minf"
    
    /// [ICC.2:2019] 9.2.87 measurementInputInfoTag
    public static let measurementInputInfo: ICCSignature = "miin"
    
    /// [ICC.2:2019]
    public static let metadata: ICCSignature = "meta"
    
    /// [ICC.2:2019] 9.2.90 MToA0Tag
    public static let mToA0: ICCSignature = "M2A0"
    
    /// [ICC.2:2019] 9.2.91 MToB0Tag
    public static let mToB0: ICCSignature = "M2B0"
    
    /// [ICC.2:2019] 9.2.92 MToB1Tag
    public static let mToB1: ICCSignature = "M2B1"
    
    /// [ICC.2:2019] 9.2.93 MToB2Tag
    public static let mToB2: ICCSignature = "M2B2"
    
    /// [ICC.2:2019] 9.2.94 MToB3Tag
    public static let mToB3: ICCSignature = "M2B3"
    
    /// [ICC.2:2019] 9.2.95 MToS0Tag
    public static let mToS0: ICCSignature = "M2S0"
    
    /// [ICC.2:2019] 9.2.96 MToS1Tag
    public static let mToS1: ICCSignature = "M2S1"
    
    /// [ICC.2:2019] 9.2.97 MToS2Tag
    public static let mToS2: ICCSignature = "M2S2"
    
    /// [ICC.2:2019] 9.2.98 MToS3Tag
    public static let mToS3: ICCSignature = "M2S3"
    
    /// [ICC.2:2019] 9.2.99 namedColorTag
    public static let namedColorTagNew: ICCSignature = "nmcl"
    
    /// [ICC.2:2019] 9.2.102 profileSequenceInformationTag
    public static let profileSequenceInformation: ICCSignature = "psin"
    
    /// [ICC.2:2019] 9.2.103 referenceNameTag
    public static let referenceName: ICCSignature = "rfnm"
    
    /// [ICC.2:2019] 9.2.105 spectralViewingConditionsTag
    public static let spectralViewingConditions: ICCSignature = "svcn"
    
    /// [ICC.2:2019] 9.2.106 spectralWhitePointTag
    public static let spectralWhitePoint: ICCSignature = "swpt"
    
    /// [ICC.2:2019] 9.2.107 standardToCustomPccTag
    public static let standardToCustomPcc: ICCSignature = "s2cp"
    
    /// [ICC.2:2019] 9.2.108 surfaceMapTag
    public static let surfaceMap: ICCSignature = "smap"

    /* private */
    /// Apple Computer 61616267 ‘aabg’ 2008-08-28 Tag
    public static let aabg: ICCSignature = "aabg"
    
    /// Apple Computer 61616767 ‘aagg’ 2008-08-28 Tag
    public static let aagg: ICCSignature = "aagg"
    
    /// Apple Computer 61617267 ‘aarg’ 2008-08-28 Tag
    public static let aarg: ICCSignature = "aarg"
    
    /// Graham Gill 61727473 ‘arts’ 2014-09-17 Tag
    public static let arts: ICCSignature = "arts"
    
    /// GretagMacbeth 43494544 ‘CIED’ 2002-10-11 Tag
    public static let cied: ICCSignature = "CIED"
    
    /// GretagMacbeth 44657644 ‘DevD’ 2002-10-11 Tag
    public static let devd: ICCSignature = "DevD"
    
    /// Apple Computer 6473636d ‘dscm’ 2004-05-28 Tag
    public static let dscm: ICCSignature = "dscm"
    
    /// GretagMacbeth 676d7073 ‘gmps’ 2003-08-29 Tag
    public static let gmps: ICCSignature = "gmps"

    /// Apple Computer 6d6d6f64 ‘mmod’ 2004-05-28 Tag
    public static let displayMakeAndModel: ICCSignature = "mmod"
    
    /// GretagMacbeth 506d7472 ‘Pmtr’ 2002-10-11 Tag
    public static let pmtr: ICCSignature = "Pmtr"
    
    /// Apple Computer 76636774 'vcgt' Tag
    public static let videoCardGammaTable: ICCSignature = "vcgt"
}
