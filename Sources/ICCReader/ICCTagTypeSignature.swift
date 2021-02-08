//
//  ICCTagTypeSignature.swift
//  
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

public enum ICCTagTypeSignature {
    /// [ICC.1:2010] 10.2 chromaticityType
    public static let chromacity: ICCSignature = "chrm"
    
    /// [ICC.1:2010] 10.3 colorantOrderType
    public static let colorantOrder: ICCSignature = "clro"
    
    /// [ICC.1:2010] 10.4 colorantTableType
    public static let colorantTable: ICCSignature = "clrt"

    /// [ICC.1:2010] 10.5 curveType
    public static let curve: ICCSignature = "curv"
    
    /// [ICC.1:2010] 10.6 dataType
    public static let data: ICCSignature = "data"
    
    /// [ICC.1:2010] 10.7 dateTimeType
    public static let dateTime: ICCSignature = "dtim"
    
    /// [ICC.1:2010] 10.8 lut16Type
    public static let lut16: ICCSignature = "mft2"
    
    /// [ICC.1:2010] 10.9 lut8Type
    public static let lut8: ICCSignature = "mft1"
    
    /// [ICC.1:2010] 10.10 lutAToBType
    public static let lutAToB: ICCSignature = "mAB "
    
    /// [ICC.1:2010] 10.11 lutBToAType
    public static let lutBToA: ICCSignature = "mBA "
    
    /// [ICC.1:2010] 10.12 measurementType
    public static let measurement: ICCSignature = "meas"
    
    /// [ICC.1:2010] 10.13 multiLocalizedUnicodeType
    public static let multiLocalizedUnicode: ICCSignature = "mluc"
    
    /// [ICC.1:2010] 10.14 multiProcessElementsType
    public static let multiProcessElements: ICCSignature = "mpet"
    
    /// [ICC.1:2010] 10.15 namedColor2Type
    public static let namedColor2: ICCSignature = "ncl2"
    
    /// [ICC.1:2010] 10.16 parametricCurveType
    public static let parametricCurve: ICCSignature = "para"
    
    /// [ICC.1:2010] 10.17 profileSequenceDescType
    public static let profileSequenceDesc: ICCSignature = "pseq"
    
    /// [ICC.1:2010] 10.18 profileSequenceIdentifierType
    public static let profileSequenceIdentifier: ICCSignature = "psid"
    
    /// [ICC.1:2010] 10.19 responseCurveSet16Type
    public static let responseCurveSet16: ICCSignature = "rcs2"
    
    /// [ICC.1:2010] 10.20 s15Fixed16ArrayType
    public static let s15Fixed16Array: ICCSignature = "sf32"
    
    /// [ICC.1:2010] 10.21 signatureType
    public static let Signature: ICCSignature = "sig "
    
    /// [ICC.1:2010] 10.22 textType
    public static let text: ICCSignature = "text"
    
    /// [ICC.1:2010] 10.23 u16Fixed16ArrayType
    public static let u16Fixed16Array: ICCSignature = "uf32"
    
    /// [ICC.1:2010] 10.24 uInt16ArrayType
    public static let uInt16Array: ICCSignature = "ui16"
    
    /// [ICC.1:2010] 10.25 uInt32ArrayType
    public static let uInt32Array: ICCSignature = "ui32"
    
    /// [ICC.1:2010] 10.26 uInt64ArrayType
    public static let uInt64Array: ICCSignature = "ui64"
    
    /// [ICC.1:2010] 10.27 uInt8ArrayType
    public static let uInt8Array: ICCSignature = "ui08"
    
    /// [ICC.1:2010] 10.28 viewingConditionsType
    public static let viewingConditions: ICCSignature = "view"
    
    /// [ICC.1:2010] 10.29 XYZType
    public static let xyz: ICCSignature = "XYZ "
    
    /* Removed */
    /// [ICC.1:2001-04] 6.5.2 crdInfoType
    public static let crdInfo: ICCSignature = "crdi"
    
    /// [ICC.1:2001-04] 6.5.6 deviceSettingsType
    public static let deviceSettings: ICCSignature = "devs"
    
    /// [ICC.1:2001-04] 6.5.10 namedColorType
    public static let namedColor: ICCSignature = "ncol"
    
    /// [ICC.1:2001-04] 6.5.15 screeningType
    public static let screening: ICCSignature = "scrn"
    
    /// [ICC.1:2001-04] 6.5.17 textDescriptionType
    public static let textDescription: ICCSignature = "desc"
    
    /// [ICC.1:2001-04] 6.5.20 ucrbgType
    public static let ucrBg: ICCSignature = "bfd "
    
    /* ICC Max */
    /// [ICC.2:2019] 10.2.5 dictType
    public static let dict: ICCSignature = "dict"
    
    /// [ICC.2:2019] 10.2.6 embeddedHeightImageType
    public static let embeddedHeightImage: ICCSignature = "ehim"
    
    /// [ICC.2:2019] 10.2.7 embeddedNormalImageType
    public static let embeddedNormalImage: ICCSignature = "enim"
    
    /// [ICC.2:2019] 10.2.8 float16ArrayType
    public static let float16Array: ICCSignature = "fl16"
    
    /// [ICC.2:2019] 10.2.9 float32ArrayType
    public static let float32Array: ICCSignature = "fl32"
    
    /// [ICC.2:2019] 10.2.10 float64ArrayType
    public static let float64Array: ICCSignature = "fl64"
    
    /// [ICC.2:2019] 10.2.11 gamutBoundaryDescriptionType
    public static let gamutBoundaryDescription: ICCSignature = "gbd "
    
    /// [ICC.2:2019] 10.2.20 sparseMatrixArrayType
    public static let sparseMatrixArray: ICCSignature = "smat"
    
    /// [ICC.2:2019] 10.2.21 spectralViewingConditionsType
    public static let spectralViewingConditions: ICCSignature = "svcn"
    
    /// [ICC.2:2019] 10.2.22 tagArrayType
    public static let tagArray: ICCSignature = "tary"
    
    /// [ICC.2:2019] 10.2.23 tagStructType
    public static let tagStruct: ICCSignature = "tstr"
    
    /// [ICC.2:2019] 10.2.29 utf16Type
    public static let utf16: ICCSignature = "ut16"
    
    /// [ICC.2:2019] 10.2.30 utf8Type
    public static let utf8: ICCSignature = "utf8"
    
    /// [ICC.2:2019] 10.2.31 utf8ZipType
    public static let utf8Zip: ICCSignature = "zut8"
    
    /// [ICC.2:2019] 10.2.33 zipXmlType
    public static let zipXml: ICCSignature = "zxml"
    
    /* private */
    public static let ncpi: ICCSignature = "ncpi"
    public static let displayNativeInformation: ICCSignature = "ndin"
    public static let videoCardGammaTable: ICCSignature = "vcgt"
    public static let displayMakeAndModel: ICCSignature = "mmod"
    public static let vcgp: ICCSignature = "vcgp"
    
    /// XRite 5A584d4c ‘ZXML‘ 2013-10-04 Type
    public static let zxml: ICCSignature = "ZXML"
    
    /// https://lists.apple.com/archives/colorsync-users/2009/Aug/msg00063.html
    public static let msbn: ICCSignature = "MSBN"
    
    public static let tcpt: ICCSignature = "TCPt"
    
    public static let sdin: ICCSignature = "sdin"
}
