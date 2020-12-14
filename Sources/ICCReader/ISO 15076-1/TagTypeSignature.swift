//
//  TagTypeSignature.swift
//  
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

public enum TagTypeSignature: String {
    /// [ICC.1:2010] 10.2 chromaticityType
    case chromacityType = "chrm"
    
    /// [ICC.1:2010] 10.3 colorantOrderType
    case colorantOrderType = "clro"
    
    /// [ICC.1:2010] 10.4 colorantTableType
    case colorantTableType = "clrt"

    /// [ICC.1:2010] 10.5 curveType
    case curveType = "curv"
    
    /// [ICC.1:2010] 10.6 dataType
    case dataType = "data"
    
    /// [ICC.1:2010] 10.7 dateTimeType
    case dateTimeType = "dtim"
    
    /// [ICC.1:2010] 10.8 lut16Type
    case lut16Type = "mft2"
    
    /// [ICC.1:2010] 10.9 lut8Type
    case lut8Type = "mft1"
    
    /// [ICC.1:2010] 10.10 lutAToBType
    case lutAToBType = "mAB "
    
    /// [ICC.1:2010] 10.11 lutBToAType
    case lutBToAType = "mBA "
    
    /// [ICC.1:2010] 10.12 measurementType
    case measurementType = "meas"
    
    /// [ICC.1:2010] 10.13 multiLocalizedUnicodeType
    case multiLocalizedUnicodeType = "mluc"
    
    /// [ICC.1:2010] 10.14 multiProcessElementsType
    case multiProcessElementsType = "mpet"
    
    /// [ICC.1:2010] 10.15 namedColor2Type
    case namedColor2Type = "ncl2"
    
    /// [ICC.1:2010] 10.16 parametricCurveType
    case parametricCurveType = "para"
    
    /// [ICC.1:2010] 10.17 profileSequenceDescType
    case profileSequenceDescType = "pseq"
    
    /// [ICC.1:2010] 10.18 profileSequenceIdentifierType
    case profileSequenceIdentifierType = "psid"
    
    /// [ICC.1:2010] 10.19 responseCurveSet16Type
    case responseCurveSet16Type = "rcs2"
    
    /// [ICC.1:2010] 10.20 s15Fixed16ArrayType
    case s15Fixed16ArrayType = "sf32"
    
    /// [ICC.1:2010] 10.21 signatureType
    case signatureType = "sig "
    
    /// [ICC.1:2010] 10.22 textType
    case textType = "text"
    
    /// [ICC.1:2010] 10.23 u16Fixed16ArrayType
    case u16Fixed16ArrayType = "uf32"
    
    /// [ICC.1:2010] 10.24 uInt16ArrayType
    case uInt16ArrayType = "ui16"
    
    /// [ICC.1:2010] 10.25 uInt32ArrayType
    case uInt32ArrayType = "ui32"
    
    /// [ICC.1:2010] 10.26 uInt64ArrayType
    case uInt64ArrayType = "ui64"
    
    /// [ICC.1:2010] 10.27 uInt8ArrayType
    case uInt8ArrayType = "ui08"
    
    /// [ICC.1:2010] 10.28 viewingConditionsType
    case viewingConditionsType = "view"
    
    /// [ICC.1:2010] 10.29 XYZType
    case xyzType = "XYZ "
    
    /* Removed */
    /// [ICC.1:2001-04] 6.5.2 crdInfoType
    case crdInfoType = "crdi"
    
    /// [ICC.1:2001-04] 6.5.6 deviceSettingsType
    case deviceSettingsType = "devs"
    
    /// [ICC.1:2001-04] 6.5.10 namedColorType
    case namedColorType = "ncol"
    
    /// [ICC.1:2001-04] 6.5.15 screeningType
    case screeningType = "scrn"
    
    /// [ICC.1:2001-04] 6.5.17 textDescriptionType
    case textDescriptionType = "desc"
    
    /// [ICC.1:2001-04] 6.5.20 ucrbgType
    case ucrBgType = "bfd "
    
    /* ICC Max */
    /// [ICC.2:2019] 10.2.5 dictType
    case dictType = "dict"
    
    /// [ICC.2:2019] 10.2.6 embeddedHeightImageType
    case embeddedHeightImageType = "ehim"
    
    /// [ICC.2:2019] 10.2.7 embeddedNormalImageType
    case embeddedNormalImageType = "enim"
    
    /// [ICC.2:2019] 10.2.8 float16ArrayType
    case float16ArrayType = "fl16"
    
    /// [ICC.2:2019] 10.2.9 float32ArrayType
    case float32ArrayType = "fl32"
    
    /// [ICC.2:2019] 10.2.10 float64ArrayType
    case float64ArrayType = "fl64"
    
    /// [ICC.2:2019] 10.2.11 gamutBoundaryDescriptionType
    case gamutBoundaryDescriptionType = "gbd "
    
    /// [ICC.2:2019] 10.2.20 sparseMatrixArrayType
    case sparseMatrixArrayType = "smat"
    
    /// [ICC.2:2019] 10.2.21 spectralViewingConditionsType
    case spectralViewingConditionsType = "svcn"
    
    /// [ICC.2:2019] 10.2.22 tagArrayType
    case tagArrayType = "tary"
    
    /// [ICC.2:2019] 10.2.23 tagStructType
    case tagStructType = "tstr"
    
    /// [ICC.2:2019] 10.2.29 utf16Type
    case utf16Type = "ut16"
    
    /// [ICC.2:2019] 10.2.30 utf8Type
    case utf8Type = "utf8"
    
    /// [ICC.2:2019] 10.2.31 utf8ZipType
    case utf8ZipType = "zut8"
    
    /// [ICC.2:2019] 10.2.33 zipXmlType
    case zipXmlType = "zxml"
    
    /* private */
    case ncpi = "ncpi"
    case displayNativeInformationType = "ndin"
    case videoCardGammaTableType = "vcgt"
    case displayMakeAndModelType = "mmod"
    case vcgp = "vcgp"
    
    /// XRite 5A584d4c ‘ZXML‘ 2013-10-04 Type
    case zxml = "ZXML"
    
    /// https://lists.apple.com/archives/colorsync-users/2009/Aug/msg00063.html
    case msbn = "MSBN"
    
    case tcpt = "TCPt"
    
    case sdin = "sdin"
    
    public init(dataStream: inout DataStream) throws {
        let rawValue = try dataStream.readString(count: 4, encoding: .ascii)!
        guard let value = Self(rawValue: rawValue) else {
            throw ICCReadError.corrupted
        }
        
        self = value
    }
}
