//
//  ICCColorProfile+ICCTags.swift
//  
//
//  Created by Hugh Bellamy on 08/02/2021.
//

public extension ICCColorProfile {
    /// [ICC.1:2010] 9.2.1 AToB0Tag
    /// Tag signature: ‘A2B0’ (41324230h)
    /// Permitted tag types: lut8Type or lut16Type or lutAToBType
    /// This tag defines a colour transform from Device, Colour Encoding or PCS, to PCS, or a colour transform from
    /// Device 1 to Device 2, using lookup table tag element structures. For most profile classes it defines the transform
    /// to achieve perceptual rendering (see Table 25). The processing mechanisms are described in lut8Type or lut16Type
    /// or lutAToBType (see 10.8, 10.9 and 10.10).
    /// [ICCC.2:2019] 9.2.2 AToB1Tag
    /// Tag signature: ‘A2B1’ (41324231h).
    /// Permitted tag types: lutAToBType or multiProcessElementsType.
    /// This tag describes the colour transform from Device or Colour Encoding to colorimetric-based PCS using lookup
    /// table tag element structures. For most profile classes, it defines the transform to achieve colorimetric rendering
    /// (see Table 25). The processing mechanisms are described in lutAToBType or multiProcessElementsType
    /// (see 10.2.12 and 10.2.16).
    /// If this tag is not present then relative colorimetric processing shall be performed by using the absolute colorimetric
    /// AToB3Tag and then adjusting the colorimetric PCS values by the media white point.
    var aToB0: lutType? {
        guard let tag = getTag(signature: ICCTagSignature.aToB0) else {
            return nil
        }

        if case let .lut8(value) = tag.data {
            return .lut8(value)
        } else if case let .lut16(value) = tag.data {
            return .lut16(value)
        } else if case let .lutAToB(value) = tag.data {
            return .lutAToB(value)
        } else if case let .multiProcessElements(value) = tag.data {
            return .multiProcessElements(value)
        }
        
        return nil
    }

    /// [ICC.1:2010] 9.2.2 AToB1Tag
    /// Tag signature: ‘A2B1’ (41324231h)
    /// Permitted tag types: lut8Type or lut16Type or lutAToBType
    /// This tag describes the colour transform from Device or Colour Encoding to PCS using lookup table tag element
    /// structures. For most profile classes, it defines the transform to achieve colorimetric rendering (see Table 25).
    /// The processing mechanisms are described in lut8Type or lut16Type or lutAToBType (see 10.8, 10.9 and 10.10).
    /// [ICCC.2:2019] 9.2.3 AToB2Tag
    /// Tag signature: ‘A2B2’ (41324232h).
    /// Permitted tag types: lutAToBType or multiProcessElementsType.
    /// This tag describes the colour transform from Device or Colour Encoding to colorimetric-based PCS using lookup
    /// table tag element structures. For most profile classes, it defines the transform to achieve saturation rendering
    /// (see Table 25). The processing mechanisms are described in lutAToBType or multiProcessElementsType (see
    /// 10.13 and 10.17).
    var aToB1: lutType? {
        guard let tag = getTag(signature: ICCTagSignature.aToB1) else {
            return nil
        }

        if case let .lut8(value) = tag.data {
            return .lut8(value)
        } else if case let .lut16(value) = tag.data {
            return .lut16(value)
        } else if case let .lutAToB(value) = tag.data {
            return .lutAToB(value)
        } else if case let .multiProcessElements(value) = tag.data {
            return .multiProcessElements(value)
        }
        
        return nil
    }

    /// [ICC.1:2010] 9.2.3 AToB2Tag
    /// Tag signature: ‘A2B2’ (41324232h)
    /// Permitted tag types: lut8Type or lut16Type or lutAToBType
    /// This tag describes the colour transform from Device or Colour Encoding to PCS using lookup table tag element
    /// structures. For most profile classes it defines the transform to achieve saturation rendering (see Table 25). The
    ///  processing mechanisms are described in lut8Type or lut16Type or lutAToBType (see 10.8, 10.9 and 10.10).
    /// [ICCC.2:2019] 9.2.4 AToB3Tag
    /// Tag signature: ‘A2B3’ (41324233h).
    /// Permitted tag types: lutAToBType or multiProcessElementsType.
    /// This tag describes the colour transform from Device or Colour Encoding to colorimetric-based PCS using lookup
    /// table tag element structures. For most profile classes, it defines the transform to achieve absolute colorimetric
    /// rendering (see Table 25). The processing mechanisms are described in lutAToBType or multiProcessElementsType
    /// (see 10.2.12 and 10.2.16).
    /// If this tag is not present then absolute colorimetric processing shall be performed by using the relative colorimetric
    /// AToB1Tag and then adjusting the colorimetric PCS values by the media white point.
    var aToB2: lutType? {
        guard let tag = getTag(signature: ICCTagSignature.aToB2) else {
            return nil
        }

        if case let .lut8(value) = tag.data {
            return .lut8(value)
        } else if case let .lut16(value) = tag.data {
            return .lut16(value)
        } else if case let .lutAToB(value) = tag.data {
            return .lutAToB(value)
        } else if case let .multiProcessElements(value) = tag.data {
            return .multiProcessElements(value)
        }
        
        return nil
    }

    /// [ICC.1:2010] 9.2.4 blueMatrixColumnTag
    /// Tag signature: ‘bXYZ’ (6258595Ah)
    /// Permitted tag type: XYZType
    /// This tag contains the third column in the matrix used in matrix/TRC transforms.
    var blueMatrixColumn: [XYZNumber]? {
        guard let tag = getTag(signature: ICCTagSignature.blueMatrixColumn) else {
            return nil
        }

        if case let .xyz(value) = tag.data {
            return value
        }
        
        return nil
    }

    /// [ICC.1:2010] 9.2.5 blueTRCTag
    /// Tag signature: ‘bTRC’ (62545243h)
    /// Permitted tag types: curveType or parametricCurveType
    /// This tag contains the blue channel tone reproduction curve. The first element represents no colorant (white) or
    /// phosphor (black) and the last element represents 100 % colorant (blue) or 100 % phosphor (blue).
    var blueTRC: curveOrParametricCurveType? {
        guard let tag = getTag(signature: ICCTagSignature.blueTRC) else {
            return nil
        }

        if case let .curve(value) = tag.data {
            return .curve(value)
        } else if case let .parametricCurve(value) = tag.data {
            return .parametricCurve(value)
        }
        
        return nil
    }

    /// [ICC.1:2010] 9.2.6 BToA0Tag
    /// Tag signature: ‘B2A0’ (42324130h)
    /// Permitted tag types: lut8Type or lut16Type or lutBToAType
    /// This tag defines a colour transform from PCS to Device or Colour Encoding using the lookup table tag element
    /// structures. For most profile classes, it defines the transform to achieve perceptual rendering (see Table 25).
    /// The processing mechanisms are described in lut8Type or lut16Type or lutBToAType (see 10.8, 10.9 and 10.11).
    var bToA0: lutType? {
        guard let tag = getTag(signature: ICCTagSignature.bToA0) else {
            return nil
        }

        if case let .lut8(value) = tag.data {
            return .lut8(value)
        } else if case let .lut16(value) = tag.data {
            return .lut16(value)
        } else if case let .lutBToA(value) = tag.data {
            return .lutBToA(value)
        }
        
        return nil
    }

    /// [ICC.1:2010] 9.2.7 BToA1Tag
    /// Tag signature: ‘B2A1’ (42324131h)
    /// Permitted tag types: lut8Type or lut16Type or lutBToAType
    /// This tag defines a colour transform from PCS to Device or Colour Encoding using the lookup table tag element
    /// structures. For most profile classes it defines the transform to achieve colorimetric rendering (see Table 25). The
    /// processing mechanisms are described in lut8Type or lut16Type or lutBToAType (see 10.8, 10.9 and 10.11).
    var bToA1: lutType? {
        guard let tag = getTag(signature: ICCTagSignature.bToA1) else {
            return nil
        }

        if case let .lut8(value) = tag.data {
            return .lut8(value)
        } else if case let .lut16(value) = tag.data {
            return .lut16(value)
        } else if case let .lutBToA(value) = tag.data {
            return .lutBToA(value)
        }
        
        return nil
    }

    /// [ICC.1:2010] 9.2.8 BToA2Tag
    /// Tag signature: ‘B2A2’ (42324132h)
    /// Permitted tag types: lut8Type or lut16Type or lutBToAType
    /// This tag defines a colour transform from PCS to Device or Colour Encoding using the lookup table tag element
    /// structures. For most profile classes it defines the transform to achieve saturation rendering (see Table 25). The
    /// processing mechanisms are described in lut8Type or lut16Type or lutBToAType (see 10.8, 10.9 and 10.11).
    var bToA2: lutType? {
        guard let tag = getTag(signature: ICCTagSignature.bToA2) else {
            return nil
        }

        if case let .lut8(value) = tag.data {
            return .lut8(value)
        } else if case let .lut16(value) = tag.data {
            return .lut16(value)
        } else if case let .lutBToA(value) = tag.data {
            return .lutBToA(value)
        }
        
        return nil
    }

    /// [ICC.1:2010] 9.2.9 BToD0Tag
    /// Tag signature ‘B2D0’ (42324430h)
    /// Allowed tag types: multiProcessElementsType
    /// This tag defines a colour transform from PCS to Device. It supports float32Number-encoded input range, output
    /// range and transform, and provides a means to override the BToA0Tag. As with the BToA0Tag, it defines a transform
    /// to achieve a perceptual rendering. The processing mechanism is described in multiProcessElementsType (see 10.14).
    var bToD0: multiProcessElementsType? {
        guard let tag = getTag(signature: ICCTagSignature.bToD0) else {
            return nil
        }

        if case let .multiProcessElements(value) = tag.data {
            return value
        }
        
        return nil
    }

    /// [ICC.1:2010] 9.2.10 BToD1Tag
    /// Tag signature ‘B2D1’ (42324431h)
    /// Allowed tag types: multiProcessElementsType
    /// This tag defines a colour transform from PCS to Device. It supports float32Number-encoded input range, output
    /// range and transform, and provides a means to override the BToA1Tag. As with the BToA1Tag, it defines a transform
    /// to achieve a media-relative colorimetric rendering. The processing mechanism is described in
    /// multiProcessElementsType (see 10.14).
    var bToD1: multiProcessElementsType? {
        guard let tag = getTag(signature: ICCTagSignature.bToD1) else {
            return nil
        }

        if case let .multiProcessElements(value) = tag.data {
            return value
        }
        
        return nil
    }

    /// [ICC.1:2010] 9.2.11 BToD2Tag
    /// Tag signature ‘B2D2’ (42324432h)
    /// Allowed tag types: multiProcessElementsType
    /// This tag defines a colour transform from PCS to Device. It supports float32Number-encoded input range, output
    /// range and transform, and provides a means to override the BToA2Tag. As with the BToA2Tag, it defines a transform
    /// to achieve a saturation rendering. The processing mechanism is described in multiProcessElementsType (see 10.14).
    var bToD2: multiProcessElementsType? {
        guard let tag = getTag(signature: ICCTagSignature.bToD2) else {
            return nil
        }

        if case let .multiProcessElements(value) = tag.data {
            return value
        }
        
        return nil
    }

    /// [ICC.1:2010] 9.2.12 BToD3Tag
    /// Tag signature ‘B2D3’ (42324433h)
    /// Allowed tag types: multiProcessElementsType
    /// This tag defines a colour transform from PCS to Device. It supports float32Number-encoded input range, output
    /// range and transform, and provides a means to override the BToA1Tag and associated ICC-absolute colorimetric
    /// rendering intent processing. As with the BToA1Tag and associated ICC-absolute colorimetric rendering intent
    /// processing, it defines a transform to achieve an ICC-absolute colorimetric rendering. The processing mechanism
    /// is described in multiProcessElementsType (see 10.14).
    var bToD3: multiProcessElementsType? {
        guard let tag = getTag(signature: ICCTagSignature.bToD3) else {
            return nil
        }

        if case let .multiProcessElements(value) = tag.data {
            return value
        }
        
        return nil
    }

    /// [ICC.1:2010] 9.2.13 calibrationDateTimeTag
    /// Tag signature: ‘calt’ (63616C74h)
    /// Permitted tag type: dateTimeType
    /// This tag contains the profile calibration date and time. This allows applications and utilities to verify if this profile
    /// matches a vendor’s profile and how recently calibration has been performed.
    var calibrationDateTime: dateTimeNumber? {
        guard let tag = getTag(signature: ICCTagSignature.calibrationDateTime) else {
            return nil
        }

        if case let .dateTime(value) = tag.data {
            return value
        }
        
        return nil
    }

    /// [ICC.1:2010] 9.2.14 charTargetTag
    /// Tag signature: ‘targ’ (74617267h)
    /// Permitted tag type: textType
    /// This tag contains the name of the registered characterization data set, or it contains the measurement data for a
    /// characterization target. This tag is provided so that distributed utilities can identify the underlying characterization
    /// data, create transforms “on the fly” or check the current performance against the original device performance.
    /// The first seven characters of the text shall identify the nature of the characterization data.
    /// If the first seven characters are “ICCHDAT”, then the remainder of the text shall be a single space followed by the
    /// Reference Name of a characterization data set in the Characterization Data Registry maintained by ICC, and
    /// terminated with a NULL byte (00h). The Reference Name in the text shall match exactly (including case) the
    /// Reference Name in the registry which may be found on the ICC web site (www.color.org).
    /// If the first seven characters match one of the identifiers defined in an ANSI or ISO standard, then the tag embeds
    /// the exact data file format defined in that standard. Each of these file formats contains an identifying character string
    /// as the first seven characters of the format, allowing an external parser to determine which data file format is being
    /// used. This provides the facilities to include a wide range of targets using a variety of measurement specifications in
    /// a standard manner.
    var charTarget: String? {
        guard let tag = getTag(signature: ICCTagSignature.charTarget) else {
            return nil
        }

        if case let .text(value) = tag.data {
            return value
        }
        
        return nil
    }

    /// [ICC.1:2010] 9.2.15 chromaticAdaptationTag
    /// Tag signature: 'chad' (63686164h)
    /// Permitted tag type: s15Fixed16ArrayType
    /// This tag contains a matrix, which shall be invertible, and which converts an nCIEXYZ colour, measured using the actual
    /// illumination conditions and relative to the actual adopted white, to an nCIEXYZ colour relative to the PCS adopted
    /// white, with complete adaptation from the actual adopted white chromaticity to the PCS adopted white chromaticity.
    /// The tag reflects a survey of the currently used methods of conversion, all of which can be formulated as a matrix
    /// transformation. The Bradford transform (see Annex E) is recommended for ICC profiles.
    /// Such a 3 × 3 chromatic adaptation matrix is organized as a 9-element array of s15Fixed16Number numbers
    /// (s15Fixed16ArrayType tag). Similarly as in the other occurrences of a 3 × 3 matrix in the ICC tags, the dimension
    /// corresponding to the matrix rows varies least rapidly while the one corresponding to the matrix columns varies most
    /// rapidly.
    /// array = (10) 0123 45 678
    /// ⎡Xpcs ⎤  ⎡a0 a1 a2 ⎤  ⎡Xsrc ⎤
    /// ⎢Ypcs ⎥=⎢a3 a4 a5 ⎥o⎢Ysrc ⎥
    /// ⎣ Zpcs⎦  ⎣a6 a7 a8 ⎦  ⎣ Zsrc⎦
    /// where (XYZ)SRC represents the measured nCIEXYZ value in the actual device viewing condition and (XYZ)PCS
    /// represents the chromatically adapted nCIEXYZ value.
    /// The chromatic adaptation matrix is a combination of three separate conversions as defined in Annex E.
    var chromaticAdaptation: [Float]? {
        guard let tag = getTag(signature: ICCTagSignature.chromaticAdaptation) else {
            return nil
        }

        if case let .s15Fixed16Array(value) = tag.data {
            return value
        }
        
        return nil
    }

    /// [ICC.1:2010] 9.2.16 chromaticityTag
    /// Tag signature: ‘chrm’ (6368726Dh)
    /// Permitted tag type: chromaticityType
    /// This tag contains the type and the data of the phosphor/colorant chromaticity set used.
    var chromacity: chromacityType? {
        guard let tag = getTag(signature: ICCTagSignature.chromacity) else {
            return nil
        }

        if case let .chromacity(value) = tag.data {
            return value
        }
        
        return nil
    }

    var colorantOrder: [UInt8]? {
        guard let tag = getTag(signature: ICCTagSignature.colorantOrder) else {
            return nil
        }

        /// [ICC.1:2010] 9.2.17 colorantOrderTag
        /// Tag signature: ’clro’ (636C726Fh)
        /// Permitted tag type: colorantOrderType
        /// This tag specifies the laydown order of colorants.
        if case let .colorantOrder(value) = tag.data {
            return value
        }
        
        return nil
    }

    /// [ICC.1:2010] 9.2.18 colorantTableTag
    /// Tag signature: ’clrt’ (636C7274h)
    /// Permitted tag type: colorantTableType
    /// This tag identifies the colorants used in the profile by a unique name and set of PCSXYZ or PCSLAB values.
    /// When used in DeviceLink profiles only the PCSLAB values shall be permitted.
    var colorantTable: [colorantTableType.Colorant]? {
        guard let tag = getTag(signature: ICCTagSignature.colorantTable) else {
            return nil
        }

        if case let .colorantTable(value) = tag.data {
            return value
        }
        
        return nil
    }

    /// [ICC.1:2010] 9.2.19 colorantTableOutTag
    /// Tag signature: ‘clot’ (636C6F74h)
    /// Permitted tag type: colorantTableType
    /// This tag identifies the colorants used in the profile by a unique name and set of PCSLAB values. This tag is used
    /// for DeviceLink profiles only.
    var colorantTableOut: [colorantTableType.Colorant]? {
        guard let tag = getTag(signature: ICCTagSignature.colorantTableOut) else {
            return nil
        }

        if case let .colorantTable(value) = tag.data {
            return value
        }
        
        return nil
    }

    /// [ICC.1:2010] 9.2.20 colorimetricIntentImageStateTag
    /// Tag signature: ‘ciis’ (63696973h)
    /// Permitted tag type: signatureType
    /// This tag indicates the image state of PCS colorimetry produced using the colorimetric intent transforms. If present,
    /// the colorimetricIntentImageStateTag shall specify one of the ICC-defined image states shown in Table 26 and
    /// described herein. Other image state specifications are reserved for future ICC use.
    /// NOTE 1 When the state of the image colorimetry represented in the PCS is different from that of the image data in the
    /// file, the colorimetric intent image state includes the word “estimates”. This will be the case when transformation of the
    /// image file data to colorimetry is not fully deterministic.
    /// EXAMPLE If the spectral sensitivities of a digital camera sensor (or photographic film) are not a linear transform of the
    /// CIE XYZ colour matching functions, there will not be a single “correct” transform to focal plane colorimetry.
    /// The tag value 'scoe' (scene colorimetry estimates) shall indicate that colorimetry in the PCS represents
    /// estimates of the colorimetry of the scene, as viewed from the capture point, chromatically adapted from the
    /// scene adopted white chromaticity to the PCS D50 adopted white chromaticity. With the media-relative
    /// colorimetric intent, the colorimetry is relative to the scene encoding maximum white (after chromatic
    /// adaptation). With the ICC-absolute colorimetric intent, the colorimetry is relative to the scene adopted white
    /// (after chromatic adaptation). The scene colorimetry can result from a real scene, a synthetically generated
    /// scene, an edited scene, or some combination of these, but shall be interpreted as actual scene colorimetry for
    /// subsequent processing. When this image state is specified, the actual scene viewing conditions, including the
    /// adopted white, shall be specified in the viewing conditions tag.
    /// For scene colorimetry estimates, the mediaWhitePointTag is populated with the XYZ tristimulus values of the
    /// scene encoding maximum white, normalized to be relative to the scene adopted white (perfect diffuser), and
    /// then converted to the corresponding tristimulus values for the D50 PCS white point using the
    /// chromaticAdaptationTag matrix (if required). The scene adopted white Y value is normalized to 1,0; the
    /// mediaWhitePointTag Y value is relative to the scene adopted white Y value and can be larger than 1,0.
    /// NOTE 2 The un-normalized adopted white values are stored in the illuminant field in the viewing conditions tag.
    /// NOTE 3 Since the media white point Y value can be larger than 1,0, brighter than diffuse white colours (e.g. specular
    /// highlights) can be represented.
    /// The tag value 'sape' (scene appearance estimates) shall indicate that colorimetry in the PCS represents
    /// estimates of the appearance of the scene, as viewed from the capture point, fully adapted to the ISO 3664 P2
    /// viewing conditions. With the media relative colorimetric intent, the corresponding colorimetry is relative to the
    /// scene encoding maximum white (after adaptation). With the ICC-absolute colorimetric intent, the
    /// corresponding colorimetry is relative to the scene adopted white (after adaptation). The scene appearance
    /// estimates may result from a real scene, a synthetically generated scene, an edited scene, or some
    /// combination of these, but shall be interpreted as scene appearance estimates for an actual scene in
    /// subsequent processing. When this image state is specified, the ISO 3664 P2 viewing conditions shall be
    /// specified in the viewing conditions tag.
    /// For scene appearance estimates, the mediaWhitePointTag is populated with the XYZ tristimulus values of the
    /// scene encoding maximum white, normalized to be relative to the scene adopted white (perfect diffuser), and
    /// then converted to the corresponding tristimulus values for the D50 PCS white point using the
    /// chromaticAdaptationTag matrix (if required). The scene adopted white Y value is normalized to 1,0; the
    /// mediaWhitePointTag Y value is relative to the scene adopted white Y value and can be larger than 1,0.
    /// NOTE 4 Since the media white point Y value can be larger than 1,0, brighter than diffuse white colours can be
    /// represented (e.g. specular highlights).
    /// The tag value 'fpce' (focal plane colorimetry estimates) shall indicate that colorimetry in the PCS represents
    /// estimates of the colorimetry of the light present at the focal plane of a camera (digital or film), chromatically
    /// adapted from the focal plane adopted white chromaticity to the PCS D50 adopted white chromaticity. With the
    /// media relative colorimetric intent, the colorimetry is relative to the focal-plane encoding maximum white (after
    /// chromatic adaptation). With the ICC-absolute colorimetric intent, the colorimetry is relative to the focal plane
    /// adopted white (after chromatic adaptation). The focal plane colorimetry may result from a real scene, a
    /// synthetically generated scene, an edited scene, or some combination of these, but shall be interpreted as focal
    /// plane colorimetry for subsequent processing. When this colorimetric intent image state is specified, the
    /// actual focal plane viewing conditions, including the adopted white, shall be specified in the viewing conditions tag.
    /// For focal plane colorimetry estimates, the mediaWhitePointTag is populated with the XYZ tristimulus values of
    /// the focal plane encoding maximum white, normalized to be relative to the focal plane adopted white (perfect
    /// diffuser), and then converted to the corresponding tristimulus values for the D50 PCS white point using the
    /// chromaticAdaptationTag matrix (if required). The focal plane adopted white Y value is normalized to 1,0; the
    /// mediaWhitePointTag Y value is relative to the focal plane adopted white Y value and can be larger than 1,0.
    /// NOTE 5 The effects of any optics in or attached to the camera are included in the focal plane colorimetry estimates;
    /// this includes lens flare, filters, etc.
    /// NOTE 6 The un-normalized adopted white values are stored in the illuminant field in the viewing conditions tag.
    /// NOTE 7 Since the media white point Y value can be larger than 1,0, brighter than diffuse white colours can be
    /// represented (e.g. specular highlights).
    /// The tag value 'rhoc' (reflection hardcopy original colorimetry) shall indicate that colorimetry in the PCS
    /// represents the colorimetry of a reflection hardcopy original that has been digitally scanned, and chromatically
    /// adapted from the scanner adopted white chromaticity to the PCS D50 adopted white chromaticity. With the
    /// media relative colorimetric intent, the colorimetry is normalized relative to the scan condition encoding
    /// maximum white after chromatic adaptation to D50. With the ICC-absolute colorimetric intent, the colorimetry is
    /// relative to the perfect reflecting diffuser after chromatic adaptation to D50. When this colorimetric intent image
    /// state is specified, the scan illumination conditions, including the adopted white, shall be specified in the
    /// viewing conditions tag and the chromatic adaptation shall be specified in the chromaticAdaptationTag.
    /// NOTE 8 The un-normalized adopted white values are stored in the illuminant field in the viewing conditions tag.
    /// The tag value 'rpoc' (reflection print output colorimetry) shall indicate that colorimetry in the PCS represents
    /// the colorimetry of reflection print output, after chromatic adaptation from the print viewing condition adopted
    /// white chromaticity to the PCS D50 adopted white chromaticity. With the media relative colorimetric intent, the
    /// colorimetry is normalized relative to the print medium white point, measured under the actual print viewing
    /// conditions. With the ICC-absolute colorimetric intent, the colorimetry is relative to the perfect reflecting diffuser
    /// after chromatic adaptation to D50. When this colorimetric intent image state is specified, the print viewing
    /// conditions, including the adopted white, shall be specified in the viewing conditions tag, and the chromatic
    /// adaptation shall be specified in the chromaticAdaptationTag.
    /// NOTE 9 The un-normalized adopted white values are stored in the illuminant field in the viewing conditions tag.
    var colorimetricIntentImageState: ICCSignature? {
        guard let tag = getTag(signature: ICCTagSignature.colorimetricIntentImageState) else {
            return nil
        }

        if case let .signature(signature) = tag.data {
            return signature
        }
        
        return nil
    }

    /// [ICC.1:2001-04] 6.4.13 copyrightTag
    /// Tag Type: textType
    /// Tag signature: ‘cprt’ (63707274h)
    /// This tag contains the 7-bit ASCII text copyright information for the profile
    /// [ICC.1:2010] 9.2.21 copyrightTag
    /// Tag signature: ‘cprt’ (63707274h)
    /// Permitted tag type: multiLocalizedUnicodeType
    /// This tag contains the text copyright information for the profile.
    var copyright: textOrMultiLocalizedUnicodeTextType? {
        guard let tag = getTag(signature: ICCTagSignature.copyright) else {
            return nil
        }

        if case let .text(value) = tag.data {
            return .text(value)
        } else if case let .multiLocalizedUnicode(value) = tag.data {
            return .multiLocalizedUnicode(value)
        }
        
        return nil
    }

    /// [ICC.1:2001-04] 6.4.15 deviceMfgDescTag
    /// Tag Type: textDescriptionType
    /// Tag signature: ‘dmnd’ (646D6E64h)
    /// Structure containing invariant and localizable versions of the device manufacturer for display. The content of this
    /// structure is described in 6.5.17.
    /// [ICC.1:2010] 9.2.22 deviceMfgDescTag
    /// Tag signature: ‘dmnd’ (646D6E64h)
    /// Permitted tag type: multiLocalizedUnicodeType
    /// This tag describes the structure containing invariant and localizable versions of the device manufacturer for display.
    /// The content of this structure is described in 10.13.
    var deviceMfgDesc: textDescriptionOrMultiLocalizedUnicodeTextType? {
        guard let tag = getTag(signature: ICCTagSignature.deviceMfgDesc) else {
            return nil
        }

        if case let .textDescription(value) = tag.data {
            return .textDescription(value)
        } else if case let .multiLocalizedUnicode(value) = tag.data {
            return .multiLocalizedUnicode(value)
        }
        
        return nil
    }

    /// [ICC.1:2001-04] 6.4.16 deviceModelDescTag
    /// Tag Type: textDescriptionType
    /// Tag signature: ‘dmdd’ (646D6464h)
    /// Structure containing invariant and localizable versions of the device model for display. The content of this structure
    /// is described in 6.5.17.
    /// [ICC.1:2010] 9.2.23 deviceModelDescTag
    /// Tag signature: ‘dmdd’ (646D6464h)
    /// Permitted tag type: multiLocalizedUnicodeType
    /// This tag describes the structure containing invariant and localizable versions of the device model for display.
    /// The content of this structure is described in 10.13.
    var deviceModelDesc: textDescriptionOrMultiLocalizedUnicodeTextType? {
        guard let tag = getTag(signature: ICCTagSignature.deviceModelDesc) else {
            return nil
        }

        if case let .textDescription(value) = tag.data {
            return .textDescription(value)
        } else if case let .multiLocalizedUnicode(value) = tag.data {
            return .multiLocalizedUnicode(value)
        }
        
        return nil
    }

    /// [ICC.1:2010] 9.2.24 DToB0Tag
    /// Tag signature ‘D2B0’ (44324230h)
    /// Allowed tag types: multiProcessElementsType
    /// This tag defines a colour transform from Device to PCS. It supports float32Number-encoded input range, output
    /// range and transform, and provides a means to override the AToB0Tag. As with the AToB0Tag, it defines a transform
    /// to achieve a perceptual rendering. The processing mechanism is described in multiProcessElementsType (see 10.14).
    /// [ICC.2:2019] 9.2.76 DToB0Tag
    /// Tag signature ‘D2B0’ (44324230h).
    /// Permitted tag types: multiProcessElementsType.
    /// This tag has a different behaviour to the DToB0Tag in ISO 15076-1. It defines a colour transform from device to a
    /// spectrally-based PCS (determined by the spectralPCS field in the header). When this tag is present, the spectralPCS
    /// header field shall be non-zero. This tag defines a device to spectrally-based PCS transform with the spectral PCS
    /// defined by the spectralPCS, spectralRange, and biSpectralRange fields in the profile header. It supports
    /// float32Number-encoded input range, output range and transforms. As with the AToB0Tag, it defines a transform to
    /// achieve a perceptual rendering. The processing mechanism is described in multiProcessElementsType (see 10.2.16).
    var dToB0: multiProcessElementsType? {
        guard let tag = getTag(signature: ICCTagSignature.dToB0) else {
            return nil
        }

        if case let .multiProcessElements(value) = tag.data {
            return value
        }
        
        return nil
    }

    /// [ICC.1:2010] 9.2.25 DToB1Tag
    /// Tag signature ‘D2B1’ (44324231h)
    /// Allowed tag types: multiProcessElementsType
    /// This tag defines a colour transform from Device to PCS. It supports float32Number-encoded input range, output
    /// range and transform, and provides a means to override the AToB1Tag. As with the AToB1Tag, it defines a transform
    /// to achieve a media-relative colorimetric rendering. The processing mechanism is described in
    /// multiProcessElementsType (see 10.14).
    /// [ICC.2:2019] 9.2.77 DToB1Tag
    /// Tag signature ‘D2B1’ (44324231h).
    /// Permitted tag types: multiProcessElementsType.
    /// This tag has a different behaviour to the DToB1Tag in ISO 15076-1. It defines a colour transform from device to a
    /// spectrally-based PCS (determined by the spectralPCS field in the header). When this tag is present, the spectralPCS
    /// header field shall be non-zero. This tag defines a device to spectrally-based PCS transform with the spectral PCS
    /// defined by the spectralPCS, spectralRange, and biSpectralRange fields in the profile header. It supports
    /// float32Number-encoded input range, output range and transforms. As with the AToB0Tag, it defines a transform to
    /// achieve a relative rendering. The processing mechanism is described in multiProcessElementsType (see 10.2.16).
    /// If this tag is not present then relative colorimetric processing shall be performed by using the absolute DToB3Tag
    /// and then adjusting the PCS values by the media white point.
    var dToB1: multiProcessElementsType? {
        guard let tag = getTag(signature: ICCTagSignature.dToB1) else {
            return nil
        }

        if case let .multiProcessElements(value) = tag.data {
            return value
        }
        
        return nil
    }

    /// [ICC.1:2010] 9.2.26 DToB2Tag
    /// Tag signature ‘D2B2’ (44324232h)
    /// Allowed tag types: multiProcessElementsType
    /// This tag defines a colour transform from Device to PCS. It supports float32Number-encoded input range, output
    /// range and transform, and provides a means to override the AToB2Tag. As with the AToB2Tag, it defines a transform
    /// to achieve a saturation rendering. The processing mechanism is described in multiProcessElementsType (see 10.14).
    /// [ICC.2:2019] 9.2.78 DToB2Tag
    /// Tag signature ‘D2B2’ (44324232h).
    /// Permitted tag types: multiProcessElementsType.
    /// This tag has a different behaviour to the DToB2Tag in ISO 15076-1. It defines a colour transform from device to a
    /// spectrally-based PCS (determined by the spectralPCS field in the header). When this tag is present, the spectralPCS
    /// header field shall be non-zero. This tag defines a device to spectrally-based PCS transform with the spectral PCS
    /// defined by the spectralPCS, spectralRange, and biSpectralRange fields in the profile header. It supports
    /// float32Number-encoded input range, output range and transforms. As with the AToB0Tag, it defines a transform to
    /// achieve a saturation rendering. The processing mechanism is described in multiProcessElementsType (see 10.2.16).
    var dToB2: multiProcessElementsType? {
        guard let tag = getTag(signature: ICCTagSignature.dToB2) else {
            return nil
        }

        if case let .multiProcessElements(value) = tag.data {
            return value
        }
        
        return nil
    }

    /// [ICC.1:2010] 9.2.27 DToB3Tag
    /// Tag signature ‘D2B3’ (44324233h)
    /// Allowed tag types: multiProcessElementsType
    /// This tag defines a colour transform from Device to PCS. It supports float32Number-encoded input range, output
    /// range and transform, and provides a means to override the AToB1Tag with associated ICC-absolute colorimetric
    /// rendering intent processing. As with the AToB1Tag and associated ICC-absolute colorimetric rendering intent
    /// processing, it defines a transform to achieve an ICC-absolute colorimetric rendering. The processing mechanism
    /// is described in multiProcessElementsType (see 10.14).
    /// [ICC.2:2019] 9.2.79 DToB3Tag
    /// Tag signature ‘D2B3’ (44324233h).
    /// Permitted tag types: multiProcessElementsType.
    /// This tag has a different behaviour to the DToB3Tag in ISO 15076-1. It defines a colour transform from device to a
    /// spectrally-based PCS (determined by the spectralPCS field in the header). When this tag is present, the spectralPCS
    /// header field shall be non-zero. This tag defines a device to spectrally-based PCS transform with the spectral PCS
    /// defined by the spectralPCS, spectralRange, and biSpectralRange fields in the profile header. It supports
    /// float32Number-encoded input range, output range and transforms. As with the AToB0Tag, it defines a transform to
    /// achieve an absolute rendering. The processing mechanism is described in multiProcessElementsType (see 10.2.16).
    /// If this tag is not present then absolute colorimetric processing shall be performed by using the relative DToB1Tag
    /// and then adjusting the PCS values by the media white point.
    var dToB3: multiProcessElementsType? {
        guard let tag = getTag(signature: ICCTagSignature.dToB3) else {
            return nil
        }

        if case let .multiProcessElements(value) = tag.data {
            return value
        }
        
        return nil
    }

    /// [ICC.1:2010] 9.2.28 gamutTag
    /// Tag signature: ‘gamt’ (67616D74h)
    /// Permitted tag types: lut8Type or lut16Type or lutBToAType
    /// Out of gamut tag. The processing mechanisms are described in lut8Type or lut16Type or lutBToAType.
    /// This tag provides a table in which PCS values are the input and a single output value for each input value is the
    /// output. If the output value is 0, the PCS colour is in-gamut. If the output is non-zero, the PCS colour is out-of-gamut.
    var gamut: lutType? {
        guard let tag = getTag(signature: ICCTagSignature.gamut) else {
            return nil
        }

        if case let .lut8(value) = tag.data {
            return .lut8(value)
        } else if case let .lut16(value) = tag.data {
            return .lut16(value)
        } else if case let .lutBToA(value) = tag.data {
            return .lutBToA(value)
        }
        
        return nil
    }

    /// [ICC.1:2010] 9.2.29 grayTRCTag
    /// Tag signature: ‘kTRC’ (6B545243h)
    /// Permitted tag types: curveType or parametricCurveType
    /// This tag contains the grey tone reproduction curve. The tone reproduction curve provides the necessary information
    /// to convert between a single device channel and the PCSXYZ or PCSLAB encoding. The first element represents
    /// black and the last element represents white. The computational model supported by the grayTRC tag is defined in F.2.
    var grayTRC: curveOrParametricCurveType? {
        guard let tag = getTag(signature: ICCTagSignature.grayTRC) else {
            return nil
        }

        if case let .curve(value) = tag.data {
            return .curve(value)
        } else if case let .parametricCurve(value) = tag.data {
            return .parametricCurve(value)
        }
        
        return nil
    }

    /// [ICC.1:2010] 9.2.30 greenMatrixColumnTag
    /// Tag signature: ‘gXYZ’ (6758595Ah)
    /// Permitted tag type: XYZType
    /// This tag contains the second column in the matrix, which is used in matrix/TRC transforms.
    var greenMatrixColumn: [XYZNumber]? {
        guard let tag = getTag(signature: ICCTagSignature.greenMatrixColumn) else {
            return nil
        }

        if case let .xyz(value) = tag.data {
            return value
        }
        
        return nil
    }

    /// [ICC.1:2010] 9.2.31 greenTRCTag
    /// Tag signature: ‘gTRC’ (67545243h)
    /// Permitted tag types: curveType or parametricCurveType
    /// This tag contains the green channel tone reproduction curve. The first element represents no colorant (white) or
    /// phosphor (black) and the last element represents 100 % colorant (green) or 100 % phosphor (green).
    var greenTRC: curveOrParametricCurveType? {
        guard let tag = getTag(signature: ICCTagSignature.greenTRC) else {
            return nil
        }

        if case let .curve(value) = tag.data {
            return .curve(value)
        } else if case let .parametricCurve(value) = tag.data {
            return .parametricCurve(value)
        }
        
        return nil
    }

    /// [ICC.1:2010] 9.2.32 luminanceTag
    /// Tag signature: ‘lumi’ (6C756D69h)
    /// Permitted tag type: XYZType
    /// This tag contains the absolute luminance of emissive devices in candelas per square metre as described by the
    /// Y channel.
    /// NOTE The X and Z values are set to zero.
    var luminance: [XYZNumber]? {
        guard let tag = getTag(signature: ICCTagSignature.luminance) else {
            return nil
        }

        if case let .xyz(value) = tag.data {
            return value
        }
        
        return nil
    }

    /// [ICC.1:2010] 9.2.33 measurementTag
    /// Tag signature: ‘meas’ (6D656173h)
    /// Permitted tag type: measurementType
    /// This tag describes the alternative measurement specification, such as a D65 illuminant instead of the default D50.
    var measurement: measurementType? {
        guard let tag = getTag(signature: ICCTagSignature.measurement) else {
            return nil
        }

        if case let .measurement(value) = tag.data {
            return value
        }
        
        return nil
    }

    /// [ICC.1:2010] 9.2.34 mediaWhitePointTag
    /// Tag signature: ‘wtpt’ (77747074h)
    /// Permitted tag type: XYZType
    /// This tag, which is used for generating the ICC-absolute colorimetric intent, specifies the chromatically adapted
    /// nCIEXYZ tristimulus values of the media white point. When the measurement data used to create the profile
    /// were specified relative to an adopted white with a chromaticity different from that of the PCS adopted white,
    /// the media white point nCIEXYZ values shall be adapted to be relative to the PCS adopted white chromaticity
    /// using the chromaticAdaptationTag matrix, before recording in the tag. For capture devices, the media white
    /// point is the encoding maximum white for the capture encoding. For displays, the values specified shall be
    /// those of the PCS illuminant as defined in 7.2.16.
    /// See Clause 6 and Annex A for a more complete description of the use of the media white point.
    var mediaWhitePoint: [XYZNumber]? {
        guard let tag = getTag(signature: ICCTagSignature.mediaWhitePoint) else {
            return nil
        }

        if case let .xyz(value) = tag.data {
            return value
        }
        
        return nil
    }

    /// [ICC.1:2010] 9.2.35 namedColor2Tag
    /// Tag signature: ‘ncl2’ (6E636C32h)
    /// Permitted tag type: namedColor2Type
    /// This tag contains the named colour information providing a PCS and optional device representation for a list of named
    /// colours.
    /// Seen also tagArrayType in some ICM files
    var namedColor2: namedColor2OrTagArrayType? {
        guard let tag = getTag(signature: ICCTagSignature.namedColor2) else {
            return nil
        }

        if case let .namedColor2(value) = tag.data {
            return .namedColor2(value)
        } else if case let .tagArray(value) = tag.data {
            return .tagArray(value)
        }
        
        return nil
    }

    /// [ICC.1:2010] 9.2.36 outputResponseTag
    /// Tag signature: ‘resp’ (72657370h)
    /// Permitted tag type: responseCurveSet16Type
    /// This tag describes the structure containing a description of the device response for which the profile is intended.
    /// The content of this structure is described in 10.19.
    /// NOTE The user’s attention is called to the possibility that the use of this tag for device calibration can require use of
    /// an invention covered by patent rights. By publication of this , no position is taken with respect to the validity of this
    /// claim or of any patent rights in connection therewith. The patent holder has, however, filed a statement of willingness
    /// to grant a license under these rights on reasonable and non-discriminatory terms and conditions to applicants
    /// desiring to obtain such a license. Details can be obtained from the International Color Consortium (1899 Preston White
    /// Drive, Reston, Virginia 20191-4367, USA). See Introduction.
    var outputResponse: responseCurveSet16Type? {
        guard let tag = getTag(signature: ICCTagSignature.outputResponse) else {
            return nil
        }

        if case let .responseCurveSet16(value) = tag.data {
            return value
        }
        
        return nil
    }

    /// [ICC.1:2010] 9.2.37 perceptualRenderingIntentGamutTag
    /// Tag signature: ‘rig0’ (72696730h)
    /// Permitted tag type: signatureType
    /// There is only one standard reference medium gamut, as defined in ISO 12640-3. When the signature is present,
    /// the specified gamut is defined to be the reference medium gamut for the PCS side of both the A2B0 and B2A0
    /// tags, if they are present. If this tag is not present, the perceptual rendering intent reference gamut is unspecified.
    /// The standard PCS reference medium gamut signatures that shall be used are listed in Table 27:
    /// Table 27 — Perceptual rendering intent gamut
    /// PCS reference medium gamut Signature Hex encoding
    /// Perceptual reference medium gamut ‘prmg’ 70726D67h
    /// NOTE 1 Because the perceptual intent is the typical default rendering intent, it is most important to use the PRMG for
    /// this rendering intent.
    /// NOTE 2 It is possible that the ICC will define other signature values in the future.
    var perceptualRenderingIntentGamut: ICCSignature? {
        guard let tag = getTag(signature: ICCTagSignature.perceptualRenderingIntentGamut) else {
            return nil
        }

        if case let .signature(signature) = tag.data {
            return signature
        }
        
        return nil
    }

    /// [ICC.1:2010] 9.2.38 preview0Tag
    /// Tag signature: ‘pre0’ (70726530h)
    /// Permitted tag types: lut8Type or lut16Type or lutAToBType or lutBToAType
    /// This tag contains the preview transformation from PCS to device space and back to the PCS. This tag contains the
    /// combination of tag B2A0 and tag A2B1, or equivalent transforms. The processing mechanisms are described in
    /// lut8Type or lut16Type or lutAToBType or lutBToAType (see 10.8, 10.9, 10.10 and 10.11).
    var preview0: lutType? {
        guard let tag = getTag(signature: ICCTagSignature.preview0) else {
            return nil
        }

        if case let .lut8(value) = tag.data {
            return .lut8(value)
        } else if case let .lut16(value) = tag.data {
            return .lut16(value)
        } else if case let .lutAToB(value) = tag.data {
            return .lutAToB(value)
        } else if case let .lutBToA(value) = tag.data {
            return .lutBToA(value)
        }
        
        return nil
    }

    /// [ICC.1:2010] 9.2.39 preview1Tag
    /// Tag signature: ‘pre1’ (70726531h)
    /// Permitted tag types: lut8Type or lut16Type or lutBToAType
    /// This tag defines the preview transformation from PCS to device space and back to the PCS. This tag contains the
    /// combination of tag B2A1 and tag A2B1, or equivalent transforms. The processing mechanisms are described in
    /// lut8Type or lut16Type or lutAToBType or lutBToAType (see 10.8, 10.9, 10.10 and 10.11).
    var preview1: lutType? {
        guard let tag = getTag(signature: ICCTagSignature.preview1) else {
            return nil
        }

        if case let .lut8(value) = tag.data {
            return .lut8(value)
        } else if case let .lut16(value) = tag.data {
            return .lut16(value)
        } else if case let .lutBToA(value) = tag.data {
            return .lutBToA(value)
        }
        
        return nil
    }

    /// [ICC.1:2010] 9.2.40 preview2Tag
    /// Tag signature: ‘pre2’ (70726532h)
    /// Permitted tag types: lut8Type or lut16Type or lutBToAType
    /// This tag contains the preview transformation from PCS to device space and back to the PCS. This tag contains the
    /// combination of tag B2A2 and tag A2B1, or equivalent transforms. The processing mechanisms are described in
    /// lut8Type or lut16Type or lutAToBType or lutBToAType (see 10.8, 10.9, 10.10 and 10.11).
    var preview2: lutType? {
        guard let tag = getTag(signature: ICCTagSignature.preview2) else {
            return nil
        }

        if case let .lut8(value) = tag.data {
            return .lut8(value)
        } else if case let .lut16(value) = tag.data {
            return .lut16(value)
        } else if case let .lutBToA(value) = tag.data {
            return .lutBToA(value)
        }
        
        return nil
    }

    /// [ICC.1:2001-04] 6.4.27 profileDescriptionTag
    /// Tag Type : textDescriptionType
    /// Tag signature : ‘desc’ 64657363h
    /// Structure containing invariant and localizable versions of the profile description for display.
    /// This content of this structure is described in clause 6.5.13 'textDescriptionType'. This invariant description has no
    /// fixed relationship to the actual profile disk file name.
    /// [ICC.1:2010] 9.2.41 profileDescriptionTag
    /// Tag signature: ‘desc’ (64657363h)
    /// Permitted tag type: multiLocalizedUnicodeType
    /// This tag describes the structure containing invariant and localizable versions of the profile description for display.
    /// The content of this structure is described in 10.13. This invariant description has no fixed relationship to the actual
    /// profile disk file name.
    /// NOTE It is helpful if an identification of the characterization data that was used in the creation of the profile is
    /// included in the profileDescriptionTag (e.g. “based on CGATS TR 001”)[10]. See also 8.2.11.
    var profileDescription: textDescriptionOrMultiLocalizedUnicodeTextType? {
        guard let tag = getTag(signature: ICCTagSignature.profileDescription) else {
            return nil
        }

        if case let .textDescription(value) = tag.data {
            return .textDescription(value)
        } else if case let .multiLocalizedUnicode(value) = tag.data {
            return .multiLocalizedUnicode(value)
        }
        
        return nil
    }

    /// [ICC.1:2010] 9.2.42 profileSequenceDescTag
    /// Tag signature: ‘pseq’ (70736571h)
    /// Permitted tag type: profileSequenceDescType
    /// This tag describes the structure containing a description of the profile sequence from source to destination, typically
    /// used with the DeviceLink profile. The content of this structure is described in 10.17.
    var profileSequenceDesc: [profileSequenceDescType.ProfileDescription]? {
        guard let tag = getTag(signature: ICCTagSignature.profileSequenceDesc) else {
            return nil
        }

        if case let .profileSequenceDesc(value) = tag.data {
            return value
        }
        
        return nil
    }

    /// [ICC.1:2010] 9.2.43 profileSequenceIdentifierTag
    /// Tag signature: ‘psid’ (70736964h)
    /// Permitted tag type: profileSequenceIdentifierType
    /// This tag describes the structure containing information for identification of the profiles used in a sequence.
    /// This tag is typically used in DeviceLink profiles to identify the original profiles that were combined to create the final profile.
    var profileSequenceIdentifier: [profileSequenceIdentifierType.ProfileIdentifier]? {
        guard let tag = getTag(signature: ICCTagSignature.profileSequenceIdentifier) else {
            return nil
        }

        if case let .profileSequenceIdentifier(value) = tag.data {
            return value
        }
        
        return nil
    }

    /// [ICC.1:2010] 9.2.44 redMatrixColumnTag
    /// Tag signature: ‘rXYZ’ (7258595Ah)
    /// Permitted tag type: XYZType
    /// This tag contains the first column in the matrix, which is used in matrix/TRC transforms.
    var redMatrixColumn: [XYZNumber]? {
        guard let tag = getTag(signature: ICCTagSignature.redMatrixColumn) else {
            return nil
        }

        if case let .xyz(value) = tag.data {
            return value
        }
        
        return nil
    }

    /// [ICC.1:2010] 9.2.45 redTRCTag
    /// Tag signature: ‘rTRC’ (72545243h)
    /// Permitted tag types: curveType or parametricCurveType
    /// This tag contains the red channel tone reproduction curve. The first element represents no colorant (white) or
    /// phosphor (black) and the last element represents 100 % colorant (red) or 100 % phosphor (red).
    var redTRC: curveOrParametricCurveType? {
        guard let tag = getTag(signature: ICCTagSignature.redTRC) else {
            return nil
        }

        if case let .curve(value) = tag.data {
            return .curve(value)
        } else if case let .parametricCurve(value) = tag.data {
            return .parametricCurve(value)
        }
        
        return nil
    }

    /// [ICC.1:2010] 9.2.46 saturationRenderingIntentGamutTag
    /// Tag signature: ‘rig2’ (72696732h)
    /// Permitted tag type: signatureType
    /// There is only one standard reference medium gamut, as defined in ISO 12640-3. When the signature is present, the
    /// specified gamut is defined to be the reference medium gamut for the PCS side of both the A2B2 and B2A2 tags, if
    /// they are present. If this tag is not present, the saturation rendering intent reference gamut is unspecified. The standard
    /// PCS reference medium gamut signatures that shall be used are listed in Table 28.
    var saturationRenderingIntentGamut: ICCSignature? {
        guard let tag = getTag(signature: ICCTagSignature.saturationRenderingIntentGamut) else {
            return nil
        }

        if case let .signature(signature) = tag.data {
            return signature
        }
        
        return nil
    }

    /// [ICC.1:2010] 9.2.47 technologyTag
    /// Tag signature: ‘tech’ (74656368h)
    /// Permitted tag type: signatureType
    /// The device technology signatures that shall be used are listed in Table 29.
    var technology: ICCSignature? {
        guard let tag = getTag(signature: ICCTagSignature.technology) else {
            return nil
        }

        if case let .signature(signature) = tag.data {
            return signature
        }
        
        return nil
    }

    /// [ICC.1:2001-04] 6.4.46 viewingCondDescTag
    /// Tag Type: textDescriptionType
    /// Tag signature: ‘vued’ (76756564h)
    /// Structure containing invariant and localizable versions of the viewing conditions. The content of this structure is described in 6.5.17.
    /// [ICC.1:2010] 9.2.48 viewingCondDescTag
    /// Tag signature: ‘vued’ (76756564h)
    /// Permitted tag type: multiLocalizedUnicodeType
    /// This tag describes the structure containing invariant and localizable versions of the viewing conditions. The content
    /// of this structure is described in 10.13.
    var viewingCondDesc: textDescriptionOrMultiLocalizedUnicodeTextType? {
        guard let tag = getTag(signature: ICCTagSignature.viewingCondDesc) else {
            return nil
        }

        if case let .textDescription(value) = tag.data {
            return .textDescription(value)
        } else if case let .multiLocalizedUnicode(value) = tag.data {
            return .multiLocalizedUnicode(value)
        }
        
        return nil
    }

    /// [ICC.1:2010] 9.2.49 viewingConditionsTag
    /// Tag signature: ‘view’ (76696577h)
    /// Permitted tag type: viewingConditionsType
    /// This tag defines the viewing conditions parameters. The content of this structure is described in 10.28.
    var viewingConditions: viewingConditionsType? {
        guard let tag = getTag(signature: ICCTagSignature.viewingConditions) else {
            return nil
        }

        if case let .viewingConditions(value) = tag.data {
            return value
        }
        
        return nil
    }
}
