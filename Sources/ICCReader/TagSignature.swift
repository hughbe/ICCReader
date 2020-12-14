//
//  TagSignature.swift
//  
//
//  Created by Hugh Bellamy on 11/12/2020.
//

/// [ICC.1:2010] 9.2 Tag listing
public enum TagSignature: String {
    /// [ICC.1:2010] 9.2.1 AToB0Tag
    case aToB0Tag = "A2B0"
    
    /// [ICC.1:2010] 9.2.2 AToB1Tag
    case aToB1Tag = "A2B1"
    
    /// [ICC.1:2010] 9.2.3 AToB2Tag
    case aToB2Tag = "A2B2"
    
    /// [ICC.1:2010] 9.2.4 blueMatrixColumnTag
    /// [ICC.1:2001-04] 6.4.4 blueColorantTag
    case blueMatrixColumn = "bXYZ"
    
    /// [ICC.1:2010] 6.4.4 blueColorantTag
    case blueTRCTag = "bTRC"
    
    /// [ICC.1:2010] 9.2.6 BToA0Tag
    case bToA0Tag = "B2A0"
    
    /// [ICC.1:2010] 9.2.7 BToA1Tag
    case bToA1Tag = "B2A1"
    
    /// [ICC.1:2010] 9.2.8 BToA2Tag
    case bToA2Tag = "B2A2"
    
    /// [ICC.1:2010] 9.2.9 BToD0Tag
    case bToD0Tag = "B2D0"
    
    /// [ICC.1:2010] 9.2.10 BToD1Tag
    case bToD1Tag = "B2D1"
    
    /// [ICC.1:2010] 9.2.11 BToD2Tag
    case bToD2Tag = "B2D2"
    
    /// [ICC.1:2010] 9.2.12 BToD3Tag
    case bToD3Tag = "B2D3"

    /// [ICC.1:2010] 9.2.13 calibrationDateTimeTag 
    case calibrationDateTimeTag = "calt"
    
    /// [ICC.1:2010] 9.2.14 charTargetTag
    case charTargetTag = "targ"
    
    /// [ICC.1:2010] 9.2.15 chromaticAdaptationTag
    case chromaticAdaptationTag = "chad"
    
    /// [ICC.1:2010] 9.2.16 chromaticityTag
    case chromacityTag = "chrm"
    
    /// [ICC.1:2010] 9.2.17 colorantOrderTag
    case colorantOrderTag = "clro"
    
    /// [ICC.1:2010] 9.2.18 colorantTableTag
    case colorantTableTag = "clrt"
    
    /// [ICC.1:2010] 9.2.19 colorantTableOutTag
    case colorantTableOutTag = "clot"
    
    /// [ICC.1:2010] 9.2.20 colorimetricIntentImageStateTag
    case colorimetricIntentImageStateTag = "ciis"
    
    /// [ICC.1:2010] 9.2.21 copyrightTag
    case copyrightTag = "cprt"
    
    /// [ICC.1:2010] 9.2.22 deviceMfgDescTag
    case deviceMfgDescTag = "dmnd"
    
    /// [ICC.1:2010] 9.2.23 deviceModelDescTag
    case deviceModelDescTag = "dmdd"
    
    /// [ICC.1:2010] 9.2.24 DToB0Tag
    case dToB0Tag = "D2B0"
    
    /// [ICC.1:2010] 9.2.25 DToB1Tag
    case dToB1Tag = "D2B1"
    
    /// [ICC.1:2010] 9.2.26 DToB2Tag
    case dToB2Tag = "D2B2"
    
    /// [ICC.1:2010] 9.2.27 DToB3Tag
    case dToB3Tag = "D2B3"
    
    /// [ICC.1:2010] 9.2.28 gamutTag
    case gamutTag = "gamt"
    
    /// [ICC.1:2010] 9.2.29 grayTRCTag
    case grayTRCTag = "kTRC"
    
    /// [ICC.1:2010] 9.2.30 greenMatrixColumnTag
    /// [ICC.1:2001-04] 6.4.20 greenColorantTag
    case greenMatrixColumnTag = "gXYZ"
    
    /// [ICC.1:2010] 9.2.31 greenTRCTag
    case greenTRCTag = "gTRC"
    
    /// [ICC.1:2010] 9.2.32 luminanceTag
    case luminanceTag = "lumi"
    
    /// [ICC.1:2010] 9.2.33 measurementTag
    case measurementTag = "meas"
    
    /// [ICC.1:2010] 9.2.34 mediaWhitePointTag
    case mediaWhitePointTag = "wtpt"
    
    /// [ICC.1:2010] 9.2.35 namedColor2Tag
    case namedColor2Tag = "ncl2"
    
    /// [ICC.1:2010] 9.2.36 outputResponseTag
    case outputResponseTag = "resp"
    
    /// [ICC.1:2010] 9.2.37 perceptualRenderingIntentGamutTag
    case perceptualRenderingIntentGamutTag = "rig0"
    
    /// [ICC.1:2010] 9.2.38 preview0Tag
    case preview0Tag = "pre0"
    
    /// [ICC.1:2010] 9.2.39 preview1Tag
    case preview1Tag = "pre1"
    
    /// [ICC.1:2010] 9.2.40 preview2Tag
    case preview2Tag = "pre2"
    
    /// [ICC.1:2010] 9.2.41 profileDescriptionTag
    case profileDescriptionTag = "desc"
    
    /// [ICC.1:2010] 9.2.42 profileSequenceDescTag
    case profileSequenceDescTag = "pseq"
    
    /// [ICC.1:2010] 9.2.43 profileSequenceIdentifierTag
    case profileSequenceIdentifierTag = "psid"
    
    /// [ICC.1:2010] 9.2.44 redMatrixColumnTag
    /// [ICC.1:2010] 6.4.40 redColorantTag
    case redMatrixColumnTag = "rXYZ"
    
    /// [ICC.1:2010] 9.2.45 redTRCTag
    case redTRCTag = "rTRC"
    
    /// [ICC.1:2010] 9.2.46 saturationRenderingIntentGamutTag
    case saturationRenderingIntentGamutTag = "rig2"
    
    /// [ICC.1:2010] 9.2.47 technologyTag
    case technologyTag = "tech"
    
    /// [ICC.1:2010]
    case ucrBgTag = "bfd "
    
    /// [ICC.1:2010]
    case viewingCondDescTag = "vued"
    
    /// [ICC.1:2010]
    case viewingConditionsTag = "view"
    
    /* Removed */
    /// [ICC.1:2001-04] 6.4.14 crdInfoTag
    case crdInfoTag = "crdi"
    
    /// [ICC.1:2001-04] 6.4.17 deviceSettingsTag
    case deviceSettingsTag = "devs"
    
    /// [ICC.1:2001-04] 6.4.24 mediaBlackPointTag
    case mediaBlackPointTag = "bkpt"
    
    /// [ICC.1:2001-40] 6.4.26 namedColorTag
    case namedColorTag = "ncol"
    
    /// [ICC.1:2001-04] 6.4.34 ps2CRD0Tag
    case ps2CRD0Tag = "psd0"
    
    /// [ICC.1:2001-4] 6.4.35 ps2CRD1Tag
    case ps2CRD1Tag = "psd1"
    
    /// [ICC.1:2001-4] 6.4.36 ps2CRD2Tag
    case ps2CRD2Tag = "psd2"
    
    /// [ICC.1:2001-4] 6.4.37 ps2CRD3Tag
    case ps2CRD3Tag = "psd3"
    
    /// [ICC.1:2001-4] 6.4.38 ps2CSATag
    case ps2CSATag = "ps2s"
    
    /// [ICC.1:2001-4] 6.4.39 ps2RenderingIntentTag
    case ps2RenderingIntentTag = "ps2i"
    
    /// [ICC.1:2001-4] 6.4.42 screeningDescTag
    case screeningDescTag = "scrd"
    
    /// [ICC.1:2001-4] 6.4.43 screeningTag
    case screeningTag = "scrn"
    
    /* ICC Max */
    /// [ICC.2:2019] 9.2.4 AToB3Tag
    case aToB3Tag = "A2B3"
    
    /// [ICC.2:2019] 9.2.5 AToM0Tag
    case aToM0Tag = "A2M0"
    
    /// [ICC.2:2019] 9.2.6 brdfColorimetricParameter0Tag
    case brdfColorimetricParameter0Tag = "bcp0"
    
    /// [ICC.2:2019] 9.2.7 brdfColorimetricParameter1Tag
    case brdfColorimetricParameter1Tag = "bcp1"
    
    /// [ICC.2:2019] 9.2.8 brdfColorimetricParameter2Tag
    case brdfColorimetricParameter2Tag = "bcp2"
    
    /// [ICC.2:2019] 9.2.9 brdfColorimetricParameter3Tag
    case brdfColorimetricParameter3Tag = "bcp3"
    
    /// [ICC.2:2019] 9.2.10 brdfSpectralParameter0Tag
    case brdfSpectralParameter0Tag = "bsp0"
    
    /// [ICC.2:2019] 9.2.11 brdfSpectralParameter1Tag
    case brdfSpectralParameter1Tag = "bsp1"
    
    /// [ICC.2:2019] 9.2.12 brdfSpectralParameter2Tag
    case brdfSpectralParameter2Tag = "bsp2"
    
    /// [ICC.2:2019] 9.2.13 brdfSpectralParameter3Tag
    case brdfSpectralParameter3Tag = "bsp3"
    
    /// [ICC.2:2019] 9.2.14 brdfAToB0Tag
    case brdfAToB0Tag = "bAB0"
    
    /// [ICC.2:2019] 9.2.15 brdfAToB1Tag
    case brdfAToB1Tag = "bAB1"
    
    /// [ICC.2:2019] 9.2.16 brdfAToB2Tag
    case brdfAToB2Tag = "bAB2"
    
    /// [ICC.2:2019] 9.2.17 brdfAToB3Tag
    case brdfAToB3Tag = "bAB3"
    
    /// [ICC.2:2019] 9.2.18 brdfBToA0Tag
    case brdfBToA0Tag = "bBA0"
    
    /// [ICC.2:2019] 9.2.19 brdfBToA1Tag
    case brdfBToA1Tag = "bBA1"
    
    /// [ICC.2:2019] 9.2.20 brdfBToA2Tag
    case brdfBToA2Tag = "bBA2"
    
    /// [ICC.2:2019] 9.2.21 brdfBToA3Tag
    case brdfBToA3Tag = "bBA3"
    
    /// [ICC.2:2019] 9.2.22 brdfBToD0Tag
    case brdfBToD0Tag = "bBD0"
    
    /// [ICC.2:2019] 9.2.23 brdfBToD1Tag
    case brdfBToD1Tag = "bBD1"
    
    /// [ICC.2:2019] 9.2.24 brdfBToD2Tag
    case brdfBToD2Tag = "bBD2"
    
    /// [ICC.2:2019] 9.2.25 brdfBToD3Tag
    case brdfBToD3Tag = "bBD3"
    
    /// [ICC.2:2019] 9.2.26 brdfDToB0Tag
    case brdfDToB0Tag = "bDB0"
    
    /// [ICC.2:2019] 9.2.27 brdfDToB1Tag
    case brdfDToB1Tag = "bDB1"
    
    /// [ICC.2:2019] 9.2.28 brdfDToB2Tag
    case brdfDToB2Tag = "bDB2"
    
    /// [ICC.2:2019] 9.2.29 brdfDToB3Tag
    case brdfDToB3Tag = "bDB3"
    
    /// [ICC.2:2019] 9.2.30 brdfMToB0Tag
    case brdfMToB0Tag = "bMB0"
    
    /// [ICC.2:2019] 9.2.31 brdfMToB1Tag
    case brdfMToB1Tag = "bMB1"
    
    /// [ICC.2:2019] 9.2.32 brdfMToB2Tag
    case brdfMToB2Tag = "bMB2"
    
    /// [ICC.2:2019] 9.2.33 brdfMToB3Tag
    case brdfMToB3Tag = "bMB3"
    
    /// [ICC.2:2019] 9.2.34 brdfMToS0Tag
    case brdfMToS0Tag = "bMS0"
    
    /// [ICC.2:2019] 9.2.35 brdfMToS1Tag
    case brdfMToS1Tag = "bMS1"
    
    /// [ICC.2:2019] 9.2.36 brdfMToS2Tag
    case brdfMToS2Tag = "bMS2"
    
    /// [ICC.2:2019] 9.2.37 brdfMToS3Tag
    case brdfMToS3Tag = "bMS3"
    
    /// [ICC.2:2019] 9.2.41 BToA3Tag
    case bToA3Tag = "B2A3"
    
    /// [ICC.2:2019] 9.2.48 colorEncodingParamsTag
    case colorEncodingParamsTag = "cept"
    
    /// [ICC.2:2019] 9.2.49 colorSpaceNameTag
    case colorSpaceNameTag = "csnm"
    
    /// [ICC.2:2019] 9.2.52 colorantInfoTag
    case colorantInfoTag = "clin"
    
    /// [ICC.2:2019] 9.2.53 colorantInfoOutTag
    case colorantInfoOutTag = "clio"
    
    /// [ICC.2:2019] 9.2.56 customToStandardPccTag
    case customToStandardPccTag = "c2sp"
    
    /// [ICC.2:2019] 9.2.57 cxfTag
    case cxfTag = "CxF "
    
    /// [ICC.2:2019] 9.2.60 directionalAToB0Tag
    case directionalAToB0Tag = "dAB0"
    
    /// [ICC.2:2019] 9.2.61 directionalAToB1Tag
    case directionalAToB1Tag = "dAB1"
    
    /// [ICC.2:2019] 9.2.62 directionalAToB2Tag
    case directionalAToB2Tag = "dAB2"
    
    /// [ICC.2:2019] 9.2.63 directionalAToB3Tag
    case directionalAToB3Tag = "dAB3"
    
    /// [ICC.2:2019] 9.2.64 directionalBToA0Tag
    case directionalBToA0Tag = "dBA0"
    
    /// [ICC.2:2019] 9.2.65 directionalBToA1Tag
    case directionalBToA1Tag = "dBA1"
    
    /// [ICC.2:2019] 9.2.66 directionalBToA2Tag
    case directionalBToA2Tag = "dBA2"
    
    /// [ICC.2:2019] 9.2.67 directionalBToA3Tag
    case directionalBToA3Tag = "dBA3"
    
    /// [ICC.2:2019] 9.2.68 directionalBToD0Tag
    case directionalBToD0Tag = "dBD0"
    
    /// [ICC.2:2019] 9.2.69 directionalBToD1Tag
    case directionalBToD1Tag = "dBD1"
    
    /// [ICC.2:2019] 9.2.70 directionalBToD2Tag
    case directionalBToD2Tag = "dBD2"
    
    /// [ICC.2:2019] 9.2.71 directionalBToD3Tag
    case directionalBToD3Tag = "dBD3"
    
    /// [ICC.2:2019] 9.2.72 directionalDToB0Tag
    case directionalDToB0Tag = "dDB0"
    
    /// [ICC.2:2019] 9.2.73 directionalDToB1Tag
    case directionalDToB1Tag = "dDB1"
    
    /// [ICC.2:2019] 9.2.74 directionalDToB2Tag
    case directionalDToB2Tag = "dDB2"
    
    /// [ICC.2:2019] 9.2.75 directionalDToB3Tag
    case directionalDToB3Tag = "dDB3"
    
    /// [ICC.2:2019] 9.2.80 gamutBoundaryDescription0Tag
    case gamutBoundaryDescription0Tag = "gbd0"
    
    /// [ICC.2:2019] 9.2.81 gamutBoundaryDescription1Tag
    case gamutBoundaryDescription1Tag = "gbd1"
    
    /// [ICC.2:2019] 9.2.82 gamutBoundaryDescription2Tag
    case gamutBoundaryDescription2Tag = "gbd2"
    
    /// [ICC.2:2019] 9.2.83 gamutBoundaryDescription3Tag
    case gamutBoundaryDescription3Tag = "gbd3"
    
    /// [ICC.2:2019] 9.2.84 multiplexDefaultValuesTag
    case multiplexDefaultValuesTag = "mdv "
    
    /// [ICC.2:2019] 9.2.85 multiplexTypeArrayTag
    case multiplexTypeArrayTag = "mcta"
    
    /// [ICC.2:2019] 9.2.86 measurementInfoTag
    case measurementInfoTag = "minf"
    
    /// [ICC.2:2019] 9.2.87 measurementInputInfoTag
    case measurementInputInfoTag = "miin"
    
    /// [ICC.2:2019]
    case metadataTag = "meta"
    
    /// [ICC.2:2019] 9.2.90 MToA0Tag
    case mToA0Tag = "M2A0"
    
    /// [ICC.2:2019] 9.2.91 MToB0Tag
    case mToB0Tag = "M2B0"
    
    /// [ICC.2:2019] 9.2.92 MToB1Tag
    case mToB1Tag = "M2B1"
    
    /// [ICC.2:2019] 9.2.93 MToB2Tag
    case mToB2Tag = "M2B2"
    
    /// [ICC.2:2019] 9.2.94 MToB3Tag
    case mToB3Tag = "M2B3"
    
    /// [ICC.2:2019] 9.2.95 MToS0Tag
    case mToS0Tag = "M2S0"
    
    /// [ICC.2:2019] 9.2.96 MToS1Tag
    case mToS1Tag = "M2S1"
    
    /// [ICC.2:2019] 9.2.97 MToS2Tag
    case mToS2Tag = "M2S2"
    
    /// [ICC.2:2019] 9.2.98 MToS3Tag
    case mToS3Tag = "M2S3"
    
    /// [ICC.2:2019] 9.2.99 namedColorTag
    case namedColorTagNew = "nmcl"
    
    /// [ICC.2:2019] 9.2.102 profileSequenceInformationTag
    case profileSequenceInformationTag = "psin"
    
    /// [ICC.2:2019] 9.2.103 referenceNameTag
    case referenceNameTag = "rfnm"
    
    /// [ICC.2:2019] 9.2.105 spectralViewingConditionsTag
    case spectralViewingConditionsTag = "svcn"
    
    /// [ICC.2:2019] 9.2.106 spectralWhitePointTag
    case spectralWhitePointTag = "swpt"
    
    /// [ICC.2:2019] 9.2.107 standardToCustomPccTag
    case standardToCustomPccTag = "s2cp"
    
    /// [ICC.2:2019] 9.2.108 surfaceMapTag
    case surfaceMapTag = "smap"

    /* private */
    /// Apple Computer 61616267 ‘aabg’ 2008-08-28 Tag 
    case aabg = "aabg"
    
    /// Apple Computer 61616767 ‘aagg’ 2008-08-28 Tag
    case aagg = "aagg"
    
    /// Apple Computer 61617267 ‘aarg’ 2008-08-28 Tag
    case aarg = "aarg"
    
    /// Graham Gill 61727473 ‘arts’ 2014-09-17 Tag
    case arts = "arts"
    
    /// GretagMacbeth 43494544 ‘CIED’ 2002-10-11 Tag
    case cied = "CIED"
    
    /// GretagMacbeth 44657644 ‘DevD’ 2002-10-11 Tag
    case devd = "DevD"
    
    /// Apple Computer 6473636d ‘dscm’ 2004-05-28 Tag
    case dscm = "dscm"
    
    /// GretagMacbeth 676d7073 ‘gmps’ 2003-08-29 Tag
    case gmps = "gmps"

    /// Apple Computer 6d6d6f64 ‘mmod’ 2004-05-28 Tag
    case displayMakeAndModelTag = "mmod"
    
    /// GretagMacbeth 506d7472 ‘Pmtr’ 2002-10-11 Tag
    case pmtr = "Pmtr"
    
    /// Apple Computer 76636774 'vcgt' Tag
    case videoCardGammaTableTag = "vcgt"
}
