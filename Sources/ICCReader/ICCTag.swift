//
//  DataStream.swift
//  
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

public enum ICCTag {
    case aToB0(_: lutType)
    case aToB1(_: lutType)
    case aToB2(_: lutType)
    case blueMatrixColumnTag(_: XYZType)
    case blueTRC(_: curveOrParametricCurveType)
    case bToA0(_: lutType)
    case bToA1(_: lutType)
    case bToA2(_: lutType)
    case bToD0(_: multiProcessElementsType)
    case bToD1(_: multiProcessElementsType)
    case bToD2(_: multiProcessElementsType)
    case bToD3(_: multiProcessElementsType)
    case calibrationDateTime(_: dateTimeType)
    case charTarget(_: textType)
    case chromaticAdaptation(_: s15Fixed16ArrayType)
    case chromacity(_: chromacityType)
    case colorantOrder(_: colorantOrderType)
    case colorantTable(_: colorantTableType)
    case colorantTableOut(_: colorantTableType)
    case colorimetricIntentImageState(_: signatureType<ColorimetricIntentImageStateSignature>)
    case copyright(_: textOrMultiLocalizedUnicodeTextType)
    case deviceMfgDesc(_: textDescriptionOrMultiLocalizedUnicodeTextType)
    case deviceModelDesc(_: textDescriptionOrMultiLocalizedUnicodeTextType)
    case dToB0(_: multiProcessElementsType)
    case dToB1(_: multiProcessElementsType)
    case dToB2(_: multiProcessElementsType)
    case dToB3(_: multiProcessElementsType)
    case gamut(_: lutType)
    case grayTRC(_: curveOrParametricCurveType)
    case greenMatrixColumn(_: XYZType)
    case greenTRC(_: curveOrParametricCurveType)
    case luminance(_: XYZType)
    case measurement(_: measurementType)
    case mediaWhitePoint(_: XYZType)
    case namedColor2(_: namedColor2OrTagArrayType)
    case outputResponse(_: responseCurveSet16Type)
    case perceptualRenderingIntentGamut(_: signatureType<RenderingIntentGamutSignature>)
    case preview0(_: lutType)
    case preview1(_: lutType)
    case preview2(_: lutType)
    case profileDescription(_: textDescriptionOrMultiLocalizedUnicodeTextType)
    case profileSequenceDesc(_: profileSequenceDescType)
    case profileSequenceIdentifier(_: profileSequenceIdentifierType)
    case redMatrixColumn(_: XYZType)
    case redTRC(_: curveOrParametricCurveType)
    case saturationRenderingIntentGamut(_: signatureType<RenderingIntentGamutSignature>)
    case technology(_: signatureType<TechnologySignature>)
    case viewingCondDesc(_: textDescriptionOrMultiLocalizedUnicodeTextType)
    case viewingConditions(_: viewingConditionsType)
    
    /* Removed */
    case crdInfo(_: crdInfoType)
    case deviceSettings(_: deviceSettingsType)
    case mediaBlackPoint(_: XYZType)
    case namedColor(_: namedColorType)
    case ps2CRD0(_: dataType)
    case ps2CRD1(_: dataType)
    case ps2CRD2(_: dataType)
    case ps2CRD3(_: dataType)
    case ps2CRDA(_: dataType)
    case ps2RenderingIntent(_: dataType)
    case screeningDesc(_: textDescriptionOrMultiLocalizedUnicodeTextType)
    case screening(_: screeningType)
    case ucrBg(_: ucrBgType)
    
    /* ICC Max */
    case aToB3(_: lutType)
    case aToM0(_: multiProcessElementsType)
    case bToA3(_: lutType)
    case brdfColorimetricParameter0(_: tagStructType)
    case brdfColorimetricParameter1(_: tagStructType)
    case brdfColorimetricParameter2(_: tagStructType)
    case brdfColorimetricParameter3(_: tagStructType)
    case brdfSpectralParameter0(_: tagStructType)
    case brdfSpectralParameter1(_: tagStructType)
    case brdfSpectralParameter2(_: tagStructType)
    case brdfSpectralParameter3(_: tagStructType)
    case brdfAToB0(_: multiProcessElementsType)
    case brdfAToB1(_: multiProcessElementsType)
    case brdfAToB2(_: multiProcessElementsType)
    case brdfAToB3(_: multiProcessElementsType)
    case brdfBToA0(_: multiProcessElementsType)
    case brdfBToA1(_: multiProcessElementsType)
    case brdfBToA2(_: multiProcessElementsType)
    case brdfBToA3(_: multiProcessElementsType)
    case brdfBToD0(_: multiProcessElementsType)
    case brdfBToD1(_: multiProcessElementsType)
    case brdfBToD2(_: multiProcessElementsType)
    case brdfBToD3(_: multiProcessElementsType)
    case brdfDToB0(_: multiProcessElementsType)
    case brdfDToB1(_: multiProcessElementsType)
    case brdfDToB2(_: multiProcessElementsType)
    case brdfDToB3(_: multiProcessElementsType)
    case brdfMToB0(_: tagStructType)
    case brdfMToB1(_: tagStructType)
    case brdfMToB2(_: tagStructType)
    case brdfMToB3(_: tagStructType)
    case brdfMToS0(_: tagStructType)
    case brdfMToS1(_: tagStructType)
    case brdfMToS2(_: tagStructType)
    case brdfMToS3(_: tagStructType)
    case colorEncodingParams(_: tagStructType)
    case colorSpaceName(_: utf8Type)
    case colorantInfo(_: tagArrayTypeOrLutType)
    case colorantInfoOut(_: tagArrayTypeOrLutType)
    case customToStandardPcc(_: multiProcessElementsType)
    case cxf(_: utf8OrUtf8ZipType)
    case directionalAToB0(_: multiProcessElementsType)
    case directionalAToB1(_: multiProcessElementsType)
    case directionalAToB2(_: multiProcessElementsType)
    case directionalAToB3(_: multiProcessElementsType)
    case directionalBToA0(_: multiProcessElementsType)
    case directionalBToA1(_: multiProcessElementsType)
    case directionalBToA2(_: multiProcessElementsType)
    case directionalBToA3(_: multiProcessElementsType)
    case directionalBToD0(_: multiProcessElementsType)
    case directionalBToD1(_: multiProcessElementsType)
    case directionalBToD2(_: multiProcessElementsType)
    case directionalBToD3(_: multiProcessElementsType)
    case directionalDToB0(_: multiProcessElementsType)
    case directionalDToB1(_: multiProcessElementsType)
    case directionalDToB2(_: multiProcessElementsType)
    case directionalDToB3(_: multiProcessElementsType)
    case gamutBoundaryDescription0(_: gamutBoundaryDescriptionType)
    case gamutBoundaryDescription1(_: gamutBoundaryDescriptionType)
    case gamutBoundaryDescription2(_: gamutBoundaryDescriptionType)
    case gamutBoundaryDescription3(_: gamutBoundaryDescriptionType)
    case multiplexDefaultValues(_: multiplexDefaultValuesType)
    case multiplexTypeArray(_: tagArrayType)
    case measurementInfo(_: tagStructType)
    case measurementInputInfo(_: tagStructType)
    case metadata(_: dictType)
    case mToA0(_: multiProcessElementsType)
    case mToB0(_: multiProcessElementsType)
    case mToB1(_: multiProcessElementsType)
    case mToB2(_: multiProcessElementsType)
    case mToB3(_: multiProcessElementsType)
    case mToS0(_: multiProcessElementsType)
    case mToS1(_: multiProcessElementsType)
    case mToS2(_: multiProcessElementsType)
    case mToS3(_: multiProcessElementsType)
    case namedColorTagNew(_: tagStructType)
    case profileSequenceInformation(_: tagArrayType)
    case referenceName(_: utf8Type)
    case spectralViewingConditions(_: spectralViewingConditionsType)
    case spectralWhitePoint(_: spectralWhitePointType)
    case surfaceMap(_: embeddedNormalImageOrEmbeddedHeightImageType)
    case standardToCustomPcc(_: multiProcessElementsType)
    
    /* Private */
    case aabg(_: parametricCurveType)
    case aagg(_: parametricCurveType)
    case aarg(_: parametricCurveType)
    case arts(_: s15Fixed16ArrayType)
    case cied(_: textType)
    case devd(_: textType)
    case dscm(_: multiLocalizedUnicodeType)
    case gmps(_: dataType)
    case displayMakeAndModel(_: displayMakeAndModelType)
    case pmtr(_: textType)
    case swpt(_: float16ArrayType)
    case videoCardGammaTable(_: videoCardGammaTableType)

    case unknown(signature: String, data: TagFactory)
    
    public init(signature: KnownSignature<TagSignature>, dataStream: inout DataStream, size: UInt32, header: ExtendedProfileHeader) throws {
        guard case let .known(sig) = signature else {
            guard case let .unknown(signature) = signature else {
                throw ICCReadError.corrupted
            }
            
#if DEBUG
            if signature == "ncpi" ||
                signature == "ndin" /* Apple display native information */ ||
                signature == "mmod" /* Apple display make and model */ ||
                signature == "vcgp" ||
                signature == "Info" ||
                signature == "hd10" ||
                signature == "DEVD" ||
                signature == "DEVS" ||
                signature == "LPIN" ||
                signature == "debg" ||
                signature == "DDPS" ||
                signature == "TCPt" ||
                signature == "smwp" ||
                signature == "smwi" ||
                signature == "sdin" ||
                signature == "imnK" ||
                signature == "imnM" ||
                signature == "info" ||
                signature == "K031" ||
                signature == "K017" ||
                signature == "K025" ||
                signature == "K016" ||
                signature == "K021" ||
                signature == "K030" ||
                signature == "K007" ||
                signature == "K070" ||
                signature == "K071" {
                self = .unknown(signature: signature, data: try TagFactory(dataStream: &dataStream, size: size, header: header))
                return
            }

            let type = try TagTypeSignature(dataStream: &dataStream)
            fatalError("NYI: \"\(signature)\": \(type)")
#else
            self = .unknown(signature: signature, data: try TagFactory(dataStream: &dataStream, size: size))
            return
#endif
        }
        
        switch sig {
        case .aToB0Tag:
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
            self = .aToB0(try lutType(dataStream: &dataStream, size: size))
        case .aToB1Tag:
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
            self = .aToB1(try lutType(dataStream: &dataStream, size: size))
        case .aToB2Tag:
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
            self = .aToB2(try lutType(dataStream: &dataStream, size: size))
        case .blueMatrixColumn:
            /// [ICC.1:2010] 9.2.4 blueMatrixColumnTag
            /// Tag signature: ‘bXYZ’ (6258595Ah)
            /// Permitted tag type: XYZType
            /// This tag contains the third column in the matrix used in matrix/TRC transforms.
            self = .blueMatrixColumnTag(try XYZType(dataStream: &dataStream, size: size))
        case .blueTRCTag:
            /// [ICC.1:2010] 9.2.5 blueTRCTag
            /// Tag signature: ‘bTRC’ (62545243h)
            /// Permitted tag types: curveType or parametricCurveType
            /// This tag contains the blue channel tone reproduction curve. The first element represents no colorant (white) or
            /// phosphor (black) and the last element represents 100 % colorant (blue) or 100 % phosphor (blue).
            self = .blueTRC(try curveOrParametricCurveType(dataStream: &dataStream, size: size))
        case .bToA0Tag:
            /// [ICC.1:2010] 9.2.6 BToA0Tag
            /// Tag signature: ‘B2A0’ (42324130h)
            /// Permitted tag types: lut8Type or lut16Type or lutBToAType
            /// This tag defines a colour transform from PCS to Device or Colour Encoding using the lookup table tag element
            /// structures. For most profile classes, it defines the transform to achieve perceptual rendering (see Table 25).
            /// The processing mechanisms are described in lut8Type or lut16Type or lutBToAType (see 10.8, 10.9 and 10.11).
            self = .bToA0(try lutType(dataStream: &dataStream, size: size))
        case .bToA1Tag:
            /// [ICC.1:2010] 9.2.7 BToA1Tag
            /// Tag signature: ‘B2A1’ (42324131h)
            /// Permitted tag types: lut8Type or lut16Type or lutBToAType
            /// This tag defines a colour transform from PCS to Device or Colour Encoding using the lookup table tag element
            /// structures. For most profile classes it defines the transform to achieve colorimetric rendering (see Table 25). The
            /// processing mechanisms are described in lut8Type or lut16Type or lutBToAType (see 10.8, 10.9 and 10.11).
            self = .bToA1(try lutType(dataStream: &dataStream, size: size))
        case .bToA2Tag:
            /// [ICC.1:2010] 9.2.8 BToA2Tag
            /// Tag signature: ‘B2A2’ (42324132h)
            /// Permitted tag types: lut8Type or lut16Type or lutBToAType
            /// This tag defines a colour transform from PCS to Device or Colour Encoding using the lookup table tag element
            /// structures. For most profile classes it defines the transform to achieve saturation rendering (see Table 25). The
            /// processing mechanisms are described in lut8Type or lut16Type or lutBToAType (see 10.8, 10.9 and 10.11).
            self = .bToA2(try lutType(dataStream: &dataStream, size: size))
        case .bToD0Tag:
            /// [ICC.1:2010] 9.2.9 BToD0Tag
            /// Tag signature ‘B2D0’ (42324430h)
            /// Allowed tag types: multiProcessElementsType
            /// This tag defines a colour transform from PCS to Device. It supports float32Number-encoded input range, output
            /// range and transform, and provides a means to override the BToA0Tag. As with the BToA0Tag, it defines a transform
            /// to achieve a perceptual rendering. The processing mechanism is described in multiProcessElementsType (see 10.14).
            self = .bToD0(try multiProcessElementsType(dataStream: &dataStream, size: size))
        case .bToD1Tag:
            /// [ICC.1:2010] 9.2.10 BToD1Tag
            /// Tag signature ‘B2D1’ (42324431h)
            /// Allowed tag types: multiProcessElementsType
            /// This tag defines a colour transform from PCS to Device. It supports float32Number-encoded input range, output
            /// range and transform, and provides a means to override the BToA1Tag. As with the BToA1Tag, it defines a transform
            /// to achieve a media-relative colorimetric rendering. The processing mechanism is described in
            /// multiProcessElementsType (see 10.14).
            self = .bToD1(try multiProcessElementsType(dataStream: &dataStream, size: size))
        case .bToD2Tag:
            /// [ICC.1:2010] 9.2.11 BToD2Tag
            /// Tag signature ‘B2D2’ (42324432h)
            /// Allowed tag types: multiProcessElementsType
            /// This tag defines a colour transform from PCS to Device. It supports float32Number-encoded input range, output
            /// range and transform, and provides a means to override the BToA2Tag. As with the BToA2Tag, it defines a transform
            /// to achieve a saturation rendering. The processing mechanism is described in multiProcessElementsType (see 10.14).
            self = .bToD2(try multiProcessElementsType(dataStream: &dataStream, size: size))
        case .bToD3Tag:
            /// [ICC.1:2010] 9.2.12 BToD3Tag
            /// Tag signature ‘B2D3’ (42324433h)
            /// Allowed tag types: multiProcessElementsType
            /// This tag defines a colour transform from PCS to Device. It supports float32Number-encoded input range, output
            /// range and transform, and provides a means to override the BToA1Tag and associated ICC-absolute colorimetric
            /// rendering intent processing. As with the BToA1Tag and associated ICC-absolute colorimetric rendering intent
            /// processing, it defines a transform to achieve an ICC-absolute colorimetric rendering. The processing mechanism
            /// is described in multiProcessElementsType (see 10.14).
            self = .bToD3(try multiProcessElementsType(dataStream: &dataStream, size: size))
        case .calibrationDateTimeTag:
            /// [ICC.1:2010] 9.2.13 calibrationDateTimeTag
            /// Tag signature: ‘calt’ (63616C74h)
            /// Permitted tag type: dateTimeType
            /// This tag contains the profile calibration date and time. This allows applications and utilities to verify if this profile
            /// matches a vendor’s profile and how recently calibration has been performed.
            self = .calibrationDateTime(try dateTimeType(dataStream: &dataStream, size: size))
        case .charTargetTag:
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
            self = .charTarget(try textType(dataStream: &dataStream, size: size))
        case .chromaticAdaptationTag:
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
            self = .chromaticAdaptation(try s15Fixed16ArrayType(dataStream: &dataStream, size: size))
        case .chromacityTag:
                /// [ICC.1:2010] 9.2.16 chromaticityTag
                /// Tag signature: ‘chrm’ (6368726Dh)
                /// Permitted tag type: chromaticityType
                /// This tag contains the type and the data of the phosphor/colorant chromaticity set used.
                self = .chromacity(try chromacityType(dataStream: &dataStream, size: size))
        case .colorantOrderTag:
            /// [ICC.1:2010] 9.2.17 colorantOrderTag
            /// Tag signature: ’clro’ (636C726Fh)
            /// Permitted tag type: colorantOrderType
            /// This tag specifies the laydown order of colorants.
            self = .colorantOrder(try colorantOrderType(dataStream: &dataStream, size: size))
        case .colorantTableTag:
            /// [ICC.1:2010] 9.2.18 colorantTableTag
            /// Tag signature: ’clrt’ (636C7274h)
            /// Permitted tag type: colorantTableType
            /// This tag identifies the colorants used in the profile by a unique name and set of PCSXYZ or PCSLAB values.
            /// When used in DeviceLink profiles only the PCSLAB values shall be permitted.
            self = .colorantTable(try colorantTableType(dataStream: &dataStream, size: size))
        case .colorantTableOutTag:
            /// [ICC.1:2010] 9.2.19 colorantTableOutTag
            /// Tag signature: ‘clot’ (636C6F74h)
            /// Permitted tag type: colorantTableType
            /// This tag identifies the colorants used in the profile by a unique name and set of PCSLAB values. This tag is used
            /// for DeviceLink profiles only.
            self = .colorantTableOut(try colorantTableType(dataStream: &dataStream, size: size))
        case .colorimetricIntentImageStateTag:
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
            self = .colorimetricIntentImageState(try signatureType(dataStream: &dataStream, size: size))
        case .copyrightTag:
            /// [ICC.1:2001-04] 6.4.13 copyrightTag
            /// Tag Type: textType
            /// Tag Signature: ‘cprt’ (63707274h)
            /// This tag contains the 7-bit ASCII text copyright information for the profile
            /// [ICC.1:2010] 9.2.21 copyrightTag
            /// Tag signature: ‘cprt’ (63707274h)
            /// Permitted tag type: multiLocalizedUnicodeType
            /// This tag contains the text copyright information for the profile.
            self = .copyright(try textOrMultiLocalizedUnicodeTextType(dataStream: &dataStream, size: size))
        case .deviceMfgDescTag:
            /// [ICC.1:2001-04] 6.4.15 deviceMfgDescTag
            /// Tag Type: textDescriptionType
            /// Tag Signature: ‘dmnd’ (646D6E64h)
            /// Structure containing invariant and localizable versions of the device manufacturer for display. The content of this
            /// structure is described in 6.5.17.
            /// [ICC.1:2010] 9.2.22 deviceMfgDescTag
            /// Tag signature: ‘dmnd’ (646D6E64h)
            /// Permitted tag type: multiLocalizedUnicodeType
            /// This tag describes the structure containing invariant and localizable versions of the device manufacturer for display.
            /// The content of this structure is described in 10.13.
            self = .deviceMfgDesc(try textDescriptionOrMultiLocalizedUnicodeTextType(dataStream: &dataStream, size: size))
        case .deviceModelDescTag:
            /// [ICC.1:2001-04] 6.4.16 deviceModelDescTag
            /// Tag Type: textDescriptionType
            /// Tag Signature: ‘dmdd’ (646D6464h)
            /// Structure containing invariant and localizable versions of the device model for display. The content of this structure
            /// is described in 6.5.17.
            /// [ICC.1:2010] 9.2.23 deviceModelDescTag
            /// Tag signature: ‘dmdd’ (646D6464h)
            /// Permitted tag type: multiLocalizedUnicodeType
            /// This tag describes the structure containing invariant and localizable versions of the device model for display.
            /// The content of this structure is described in 10.13.
            self = .deviceModelDesc(try textDescriptionOrMultiLocalizedUnicodeTextType(dataStream: &dataStream, size: size))
        case .dToB0Tag:
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
                self = .dToB0(try multiProcessElementsType(dataStream: &dataStream, size: size))
            case .dToB1Tag:
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
                self = .dToB1(try multiProcessElementsType(dataStream: &dataStream, size: size))
            case .dToB2Tag:
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
                self = .dToB2(try multiProcessElementsType(dataStream: &dataStream, size: size))
            case .dToB3Tag:
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
                self = .dToB3(try multiProcessElementsType(dataStream: &dataStream, size: size))
                
        case .gamutTag:
            /// [ICC.1:2010] 9.2.28 gamutTag
            /// Tag signature: ‘gamt’ (67616D74h)
            /// Permitted tag types: lut8Type or lut16Type or lutBToAType
            /// Out of gamut tag. The processing mechanisms are described in lut8Type or lut16Type or lutBToAType.
            /// This tag provides a table in which PCS values are the input and a single output value for each input value is the
            /// output. If the output value is 0, the PCS colour is in-gamut. If the output is non-zero, the PCS colour is out-of-gamut.
            self = .gamut(try lutType(dataStream: &dataStream, size: size))
        case .grayTRCTag:
            /// [ICC.1:2010] 9.2.29 grayTRCTag
            /// Tag signature: ‘kTRC’ (6B545243h)
            /// Permitted tag types: curveType or parametricCurveType
            /// This tag contains the grey tone reproduction curve. The tone reproduction curve provides the necessary information
            /// to convert between a single device channel and the PCSXYZ or PCSLAB encoding. The first element represents
            /// black and the last element represents white. The computational model supported by the grayTRC tag is defined in F.2.
            self = .grayTRC(try curveOrParametricCurveType(dataStream: &dataStream, size: size))
        case .greenMatrixColumnTag:
            /// [ICC.1:2010] 9.2.30 greenMatrixColumnTag
            /// Tag signature: ‘gXYZ’ (6758595Ah)
            /// Permitted tag type: XYZType
            /// This tag contains the second column in the matrix, which is used in matrix/TRC transforms.
            self = .greenMatrixColumn(try XYZType(dataStream: &dataStream, size: size))
        case .greenTRCTag:
            /// [ICC.1:2010] 9.2.31 greenTRCTag
            /// Tag signature: ‘gTRC’ (67545243h)
            /// Permitted tag types: curveType or parametricCurveType
            /// This tag contains the green channel tone reproduction curve. The first element represents no colorant (white) or
            /// phosphor (black) and the last element represents 100 % colorant (green) or 100 % phosphor (green).
            self = .greenTRC(try curveOrParametricCurveType(dataStream: &dataStream, size: size))
        case .luminanceTag:
            /// [ICC.1:2010] 9.2.32 luminanceTag
            /// Tag signature: ‘lumi’ (6C756D69h)
            /// Permitted tag type: XYZType
            /// This tag contains the absolute luminance of emissive devices in candelas per square metre as described by the
            /// Y channel.
            /// NOTE The X and Z values are set to zero.
            self = .luminance(try XYZType(dataStream: &dataStream, size: size))
        case .measurementTag:
            /// [ICC.1:2010] 9.2.33 measurementTag
            /// Tag signature: ‘meas’ (6D656173h)
            /// Permitted tag type: measurementType
            /// This tag describes the alternative measurement specification, such as a D65 illuminant instead of the default D50.
            self = .measurement(try measurementType(dataStream: &dataStream, size: size))
        case .mediaWhitePointTag:
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
            self = .mediaWhitePoint(try XYZType(dataStream: &dataStream, size: size))
        case .namedColor2Tag:
            /// [ICC.1:2010] 9.2.35 namedColor2Tag
            /// Tag signature: ‘ncl2’ (6E636C32h)
            /// Permitted tag type: namedColor2Type
            /// This tag contains the named colour information providing a PCS and optional device representation for a list of named
            /// colours.
            /// Seen also tagArrayType in some ICM files
            self = .namedColor2(try namedColor2OrTagArrayType(dataStream: &dataStream, size: size))
        case .outputResponseTag:
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
            self = .outputResponse(try responseCurveSet16Type(dataStream: &dataStream, size: size))
        case .perceptualRenderingIntentGamutTag:
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
            self = .perceptualRenderingIntentGamut(try signatureType(dataStream: &dataStream, size: size))
        case .preview0Tag:
            /// [ICC.1:2010] 9.2.38 preview0Tag
            /// Tag signature: ‘pre0’ (70726530h)
            /// Permitted tag types: lut8Type or lut16Type or lutAToBType or lutBToAType
            /// This tag contains the preview transformation from PCS to device space and back to the PCS. This tag contains the
            /// combination of tag B2A0 and tag A2B1, or equivalent transforms. The processing mechanisms are described in
            /// lut8Type or lut16Type or lutAToBType or lutBToAType (see 10.8, 10.9, 10.10 and 10.11).
            self = .preview0(try lutType(dataStream: &dataStream, size: size))
        case .preview1Tag:
            /// [ICC.1:2010] 9.2.39 preview1Tag
            /// Tag signature: ‘pre1’ (70726531h)
            /// Permitted tag types: lut8Type or lut16Type or lutBToAType
            /// This tag defines the preview transformation from PCS to device space and back to the PCS. This tag contains the
            /// combination of tag B2A1 and tag A2B1, or equivalent transforms. The processing mechanisms are described in
            /// lut8Type or lut16Type or lutAToBType or lutBToAType (see 10.8, 10.9, 10.10 and 10.11).
            self = .preview1(try lutType(dataStream: &dataStream, size: size))
        case .preview2Tag:
            /// [ICC.1:2010] 9.2.40 preview2Tag
            /// Tag signature: ‘pre2’ (70726532h)
            /// Permitted tag types: lut8Type or lut16Type or lutBToAType
            /// This tag contains the preview transformation from PCS to device space and back to the PCS. This tag contains the
            /// combination of tag B2A2 and tag A2B1, or equivalent transforms. The processing mechanisms are described in
            /// lut8Type or lut16Type or lutAToBType or lutBToAType (see 10.8, 10.9, 10.10 and 10.11).
            self = .preview2(try lutType(dataStream: &dataStream, size: size))
        case .profileDescriptionTag:
            /// [ICC.1:2001-04] 6.4.27 profileDescriptionTag
            /// Tag Type : textDescriptionType
            /// Tag Signature : ‘desc’ 64657363h
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
            self = .profileDescription(try textDescriptionOrMultiLocalizedUnicodeTextType(dataStream: &dataStream, size: size))
        case .profileSequenceDescTag:
            /// [ICC.1:2010] 9.2.42 profileSequenceDescTag
            /// Tag signature: ‘pseq’ (70736571h)
            /// Permitted tag type: profileSequenceDescType
            /// This tag describes the structure containing a description of the profile sequence from source to destination, typically
            /// used with the DeviceLink profile. The content of this structure is described in 10.17.
            self = .profileSequenceDesc(try profileSequenceDescType(dataStream: &dataStream, size: size))
        case .profileSequenceIdentifierTag:
            /// [ICC.1:2010] 9.2.43 profileSequenceIdentifierTag
            /// Tag signature: ‘psid’ (70736964h)
            /// Permitted tag type: profileSequenceIdentifierType
            /// This tag describes the structure containing information for identification of the profiles used in a sequence.
            /// This tag is typically used in DeviceLink profiles to identify the original profiles that were combined to create the
            /// final profile.
            self = .profileSequenceIdentifier(try profileSequenceIdentifierType(dataStream: &dataStream, size: size))
        case .redMatrixColumnTag:
            /// [ICC.1:2010] 9.2.44 redMatrixColumnTag
            /// Tag signature: ‘rXYZ’ (7258595Ah)
            /// Permitted tag type: XYZType
            /// This tag contains the first column in the matrix, which is used in matrix/TRC transforms.
            self = .redMatrixColumn(try XYZType(dataStream: &dataStream, size: size))
        case .redTRCTag:
            /// [ICC.1:2010] 9.2.45 redTRCTag
            /// Tag signature: ‘rTRC’ (72545243h)
            /// Permitted tag types: curveType or parametricCurveType
            /// This tag contains the red channel tone reproduction curve. The first element represents no colorant (white) or
            /// phosphor (black) and the last element represents 100 % colorant (red) or 100 % phosphor (red).
            self = .redTRC(try curveOrParametricCurveType(dataStream: &dataStream, size: size))
        case .saturationRenderingIntentGamutTag:
            /// [ICC.1:2010] 9.2.46 saturationRenderingIntentGamutTag
            /// Tag signature: ‘rig2’ (72696732h)
            /// Permitted tag type: signatureType
            /// There is only one standard reference medium gamut, as defined in ISO 12640-3. When the signature is present, the
            /// specified gamut is defined to be the reference medium gamut for the PCS side of both the A2B2 and B2A2 tags, if
            /// they are present. If this tag is not present, the saturation rendering intent reference gamut is unspecified. The standard
            /// PCS reference medium gamut signatures that shall be used are listed in Table 28.
            self = .saturationRenderingIntentGamut(try signatureType(dataStream: &dataStream, size: size))
        case .technologyTag:
            /// [ICC.1:2010] 9.2.47 technologyTag
            /// Tag signature: ‘tech’ (74656368h)
            /// Permitted tag type: signatureType
            /// The device technology signatures that shall be used are listed in Table 29.
            self = .technology(try signatureType(dataStream: &dataStream, size: size))
        case .viewingCondDescTag:
            /// [ICC.1:2001-04] 6.4.46 viewingCondDescTag
            /// Tag Type: textDescriptionType
            /// Tag Signature: ‘vued’ (76756564h)
            /// Structure containing invariant and localizable versions of the viewing conditions. The content of this structure is described in 6.5.17.
            /// [ICC.1:2010] 9.2.48 viewingCondDescTag
            /// Tag signature: ‘vued’ (76756564h)
            /// Permitted tag type: multiLocalizedUnicodeType
            /// This tag describes the structure containing invariant and localizable versions of the viewing conditions. The content
            /// of this structure is described in 10.13.
            self = .viewingCondDesc(try textDescriptionOrMultiLocalizedUnicodeTextType(dataStream: &dataStream, size: size))
        case .viewingConditionsTag:
            /// [ICC.1:2010] 9.2.49 viewingConditionsTag
            /// Tag signature: ‘view’ (76696577h)
            /// Permitted tag type: viewingConditionsType
            /// This tag defines the viewing conditions parameters. The content of this structure is described in 10.28.
            self = .viewingConditions(try viewingConditionsType(dataStream: &dataStream, size: size))
        
        /* Removed */
        case .crdInfoTag:
            /// [ICC.1:2001-04] 6.4.14 crdInfoTag
            /// Tag Type: crdInfoType
            /// Tag Signature: ‘crdi’ (63726469h)
            /// This tag contains the PostScript product name to which this profile corresponds and the names of the companion
            /// CRDs. Recall that a single profile can generate multiple CRDs.
            /// See C.1 for information about using this tag.
            self = .crdInfo(try crdInfoType(dataStream: &dataStream, size: size))
        case .deviceSettingsTag:
            /// [ICC.1:2001-04] 6.4.17 deviceSettingsTag
            /// Tag Type: deviceSettingsType
            /// Tag Signature: ‘devs’ (64657673h)
            /// This tag specifies the device settings for which the profile is valid.
            /// These settings are usually specific to a platform, so they are specified for each platform separately. The profile creator
            /// decides which platforms need to be supported.
            /// The profile may be valid only for certain combination of settings like a specific media type with a specific resolution
            /// with a specific halftone. Therefore, for each platform there are groupings or combinations of settings.
            /// Under each grouping, multiple values can be specified for each setting. For example, if the profile is valid for
            /// resolutions a and b with media type c and halftone style d, then “resolution” will have two values, while the other
            /// two settings have one value each in the combination.
            /// The content of this structure is described in 6.5.6.
            self = .deviceSettings(try deviceSettingsType(dataStream: &dataStream, size: size))
        case .mediaBlackPointTag:
            /// [ICC.1:2001-04]: 6.4.24 mediaBlackPointTag
            /// Tag Type: XYZType
            /// Tag Signature: ‘bkpt’ (626B7074h)
            /// This tag specifies the media black point. It is referenced to the profile connection space so that the media
            /// black point as represented in the PCS is equivalent to this tag value. If this tag is not present, it is assumed
            /// to be (0,0,0).
            self = .mediaBlackPoint(try XYZType(dataStream: &dataStream, size: size))
        case .namedColorTag:
            /// [ICC.1:2010] 6.4.26 namedColorTag
            /// Tag Type: namedColorType
            /// Tag Signature: ‘ncol’ (6E636F6Ch)
            /// NOTE: This tag is obsolete, and should not be used in new profiles. Use namedColor2Tag instead.
            /// Named color reference transformation for converting between named color sets and the profile connection space
            /// or device color spaces.
            self = .namedColor(try namedColorType(dataStream: &dataStream, size: size, header: header))
        case .ps2CRD0Tag:
            /// [ICC.1:2001-04] 6.4.34 ps2CRD0Tag
            /// Tag Type: dataType
            /// Tag Signature: ‘psd0’ (70736430h)
            /// PostScript Level 2 Type 1 color rendering dictionary (CRD) for the Perceptual rendering intent. This tag provides the
            /// dictionary operand to the setcolorrendering operator. This tag can be used in conjunction with the setcolorrendering
            /// operator on any PostScript Level 2 device.
            /// See Annex C for the relationship between the ICC profile data and PostScript Tags.
            self = .ps2CRD0(try dataType(dataStream: &dataStream, size: size))
        case .ps2CRD1Tag:
            /// [ICC.1:2001-04] 6.4.35 ps2CRD1Tag
            /// Tag Type: dataType
            /// Tag Signature: ‘psd1’ (70736431h)
            /// PostScript Level 2 Type 1 CRD for the media-relative Colorimetric rendering intent. This tag provides the dictionary
            /// operand to the setcolorrendering operator. This tag can be used in conjunction with the setcolorrendering operator
            /// on any PostScript Level 2 device.
            /// See Annex C for the relationship between the ICC profile data and PostScript Tags.
            self = .ps2CRD1(try dataType(dataStream: &dataStream, size: size))
        case .ps2CRD2Tag:
            /// [ICC.1:2001-04] 6.4.36 ps2CRD2Tag
            /// Tag Type: dataType
            /// Tag Signature: ‘psd2’ (70736432h)
            /// PostScript Level 2 Type 1 CRD for the Saturation rendering intent. This tag provides the dictionary operand to the
            /// setcolorrendering operator. This tag can be used in conjunction with the setcolorrendering operator on any
            /// PostScript Level 2 device.
            /// See Annex C for the relationship between the ICC profile data and PostScript Tags.
            self = .ps2CRD2(try dataType(dataStream: &dataStream, size: size))
        case .ps2CRD3Tag:
            /// [ICC.1:2001-04] 6.4.37 ps2CRD3Tag
            /// Tag Type: dataType
            /// Tag Signature: ‘psd3’ (70736433h)
            /// PostScript Level 2 Type 1 CRD for the ICC-Absolute Colorimetric rendering intent. This tag provides the dictionary
            /// operand to the setcolorrendering operator. This tag can be used in conjunction with the setcolorrendering operator
            /// on any PostScript Level 2 device.
            /// See Annex C for the relationship between the ICC profile data and PostScript Tags.
            self = .ps2CRD3(try dataType(dataStream: &dataStream, size: size))
        case .ps2CSATag:
            /// [ICC.1:2001-04] 6.4.38 ps2CSATag
            /// Tag Type: dataType
            /// Tag Signature: ‘ps2s’ (70733273h)
            /// PostScript Level 2 color space array. This tag provides the array operand to the setcolorspace operator. For color
            /// spaces that fit within the original PostScript Level 2 device independent color model no operator verification need
            /// be performed. For color spaces that fit only within extensions to this model, operator verification is first required.
            /// An example of this would be for Calibrated CMYK input color spaces which are supported via an extension. In such
            /// cases where the necessary PostScript Level 2 support is not available, PostScript Level 1 color spaces, such as
            /// DeviceCMYK, can be used, or the colors can be converted on the host using a CMS. In the latter case, the
            /// PostScript Level 1 color operators are used to specify the device dependent (pre-converted) colors. The PostScript
            /// contained in this tag expects the associated color values instantiated either through setcolor or image to be in the
            /// range [0, 1].
            /// See Annex C for the relationship between the ICC profile data and PostScript Tags.
            self = .ps2CRDA(try dataType(dataStream: &dataStream, size: size))
        case .ps2RenderingIntentTag:
            /// [ICC.1:2001-04] 6.4.39 ps2RenderingIntentTag
            /// Tag Type: dataType
            /// Tag Signature: ‘ps2i’ (70733269h)
            /// PostScript Level 2 rendering intent. This tag provides the operand to the findcolorrendering operator. findcolorrendering
            /// is not necessarily supported on all PostScript Level 2 devices, hence its existence must first be established. Standard
            /// values for ps2RenderingIntentTag are media-relative colorimetric, ICC-abso-ute colorimetric, perceptual, and
            /// saturation. These intents are meant to correspond to the rendering intents of the profile’s header.
            /// See Annex C for the relationship between the ICC profile data and PostScript Tags.
            self = .ps2RenderingIntent(try dataType(dataStream: &dataStream, size: size))
        case .screeningDescTag:
            /// [ICC.1:2010] 6.4.42 screeningDescTag
            /// Tag Type: textDescriptionType
            /// Tag Signature: ‘scrd’ (73637264h)
            /// Structure containing invariant and localizable versions of the screening conditions. The content of this structure is
            /// described in 6.5.17.
            self = .screeningDesc(try textDescriptionOrMultiLocalizedUnicodeTextType(dataStream: &dataStream, size: size))
        case .screeningTag:
            /// [ICC.1:2001-04] 6.4.43 screeningTag
            /// Tag Type: screeningType
            /// Tag Signature: ‘scrn’ (7363726Eh)
            /// This tag contains screening information for a variable number of channels.
            self = .screening(try screeningType(dataStream: &dataStream, size: size))
        case .ucrBgTag:
            /// [ICC.1:2010] 6.4.45 ucrbgTag
            /// Tag Type: ucrbgType
            /// Tag Signature: ‘bfd ’ (62666420h)
            /// Under color removal and black generation specification. This tag contains curve information for both under color
            /// removal and black generation in addition to a general description. The content of this structure is described in 6.5.20.
            /// This tag provides descriptive information only and is not involved in the processing model.
            self = .ucrBg(try ucrBgType(dataStream: &dataStream, size: size))
            
        /* ICC Max */
        case .aToB3Tag:
            /// [ICC.2:2019] 9.2.4 AToB3Tag
            /// Tag signature: ‘A2B3’ (41324233h).
            /// Permitted tag types: lutAToBType or multiProcessElementsType.
            /// This tag describes the colour transform from Device or Colour Encoding to colorimetric-based PCS using lookup
            /// table tag element structures. For most profile classes, it defines the transform to achieve absolute colorimetric
            /// rendering (see Table 25). The processing mechanisms are described in lutAToBType or multiProcessElementsType
            /// (see 10.2.12 and 10.2.16).
            /// If this tag is not present then absolute colorimetric processing shall be performed by using the relative colorimetric
            /// AToB1Tag and then adjusting the colorimetric PCS values by the media white point.
            self = .aToB3(try lutType(dataStream: &dataStream, size: size))
        case .aToM0Tag:
            /// [ICC.2:2019] 9.2.5 AToM0Tag
            /// Tag signature: ‘A2M0’ (41324d30h).
            /// Permitted tag type: multiProcessElementsType.
            /// This tag provides a transformation using a multiProcessElementsType (see Clause 11) tag that converts from device
            /// channel values to multiplex channel values.
            /// The number of data channels provided to the transform shall match the number of channels defined by the
            /// deviceColor field in the Profile header.
            /// The number of data channels resulting from the transform shall match the number of channels associated with the
            /// MCS field in the Profile header. MCS connection shall result in multiplex channel values for channels with matching
            /// multiplex channel identifications (see 9.2.85) being passed to the appropriate MCS transform in the connecting profile.
            /// Channels in an AToM0Tag that have no match in the connecting profile MCS shall be ignored.
            self = .aToM0(try multiProcessElementsType(dataStream: &dataStream, size: size))
        case .brdfColorimetricParameter0Tag:
            /// [ICC.2:2019] 9.2.6 brdfColorimetricParameter0Tag
            /// Tag signature: ‘bcp0’ (62637030h).
            /// Permitted tag types: tagStructType of type brdfTransformStructure.
            /// This tag defines a BRDF model and its parameters for perceptual rendering. Specifically, it describes a BRDF model
            /// that transforms viewing angle, lighting angle, and Device or Colour Encoding to the colorimetric-based PCS specified
            /// by the PCS field in the profile header.
            /// For the transform subtag of this structure, the number of input channels shall be the same as the number of channels
            /// implied by the colorSpace signature in the profile header.
            /// The number of output channels of the transform subtag depends on the type of BRDF model. For monochrome type
            /// models the output of the transform subtag shall be the number of parameters defined by the BRDF model type. For
            /// chromatic type models the number of output values shall be the number of parameters defined by the BRDF model
            /// type multiplied by the number of channels implied by the PCS signature in the profile header.
            self = .brdfColorimetricParameter0(_: try tagStructType(dataStream: &dataStream, size: size, header: header))
        case .brdfColorimetricParameter1Tag:
            /// [ICC.2:2019] 9.2.7 brdfColorimetricParameter1Tag
            /// Tag signature: ‘bcp1’ (62637031h).
            /// Permitted tag types: tagStructType of type brdfTransformStructure.
            /// This tag defines a BRDF model and its parameters for media-relative colorimetric intent rendering. Specifically, it
            /// describes a BRDF model that transforms viewing angle, lighting angle, and Device or Colour
            /// Encoding to the colorimetric-based PCS specified by the PCS field in the profile header.
            /// For the transform subtag of this structure, the number of input channels shall be the same as the number of channels
            /// implied by the colorSpace signature in the profile header.
            /// The number of output channels of the transform subtag depends on the type of BRDF model. For monochrome type
            /// models the output of the transform subtag shall be the number of parameters defined by the BRDF model type. For
            /// chromatic type models the number of output values shall be the number of parameters defined by the BRDF model
            /// type multiplied by the number of channels implied by the PCS signature in the profile header.
            self = .brdfColorimetricParameter1(_: try tagStructType(dataStream: &dataStream, size: size, header: header))
        case .brdfColorimetricParameter2Tag:
            /// [ICC.2:2019] 9.2.8 brdfColorimetricParameter2Tag
            /// Tag signature: ‘bcp2’ (62637032h).
            /// Permitted tag types: tagStructType of type brdfTransformStructure.
            /// This tag defines a BRDF model and its parameters for colorimetric saturation intent rendering. Specifically, it describes
            /// a BRDF model that transforms viewing angle, lighting angle, and Device or Colour Encoding to the
            /// colorimetric-based PCS specified by the PCS field in the profile header.
            /// For the transform subtag of this structure, the number of input channels shall be the same as the number of channels
            /// implied by the colorSpace signature in the profile header.
            /// The number of output channels of the transform subtag depends on the type of BRDF model. For monochrome type
            /// models the output of the transform subtag shall be the number of parameters defined by the BRDF model type. For
            /// chromatic type models the number of output values shall be the number of parameters defined by the BRDF model
            /// type multiplied by the number of channels implied by the PCS signature in the profile header.
            self = .brdfColorimetricParameter2(_: try tagStructType(dataStream: &dataStream, size: size, header: header))
        case .brdfColorimetricParameter3Tag:
            /// [ICC.2:2019] 9.2.9 brdfColorimetricParameter3Tag
            /// Tag signature: ‘bcp3’ (62637033h).
            /// Permitted tag types: tagStructType of type brdfTransformStructure.
            /// This tag defines a BRDF model and its parameters for absolute intent rendering. Specifically, it describes a BRDF
            /// model that transforms viewing angle, lighting angle, and Device or Colour Encoding to the colorimetric-based
            /// PCS specified by the PCS field in the profile header.
            /// For the transform subtag of this structure, the number of input channels shall be the same as the number of channels
            /// implied by the colorSpace signature in the profile header.
            /// The number of output channels of the transform subtag depends on the type of BRDF model. For monochrome type
            /// models the output of the transform subtag shall be the number of parameters defined by the BRDF model type. For
            /// chromatic type models the number of output values shall be the number of parameters defined by the BRDF model
            /// type multiplied by the number of channels implied by the PCS signature in the profile header.
            self = .brdfColorimetricParameter3(_: try tagStructType(dataStream: &dataStream, size: size, header: header))
        case .brdfSpectralParameter0Tag:
            /// [ICC.2:2019] 9.2.10 brdfSpectralParameter0Tag
            /// Tag signature: ‘bsp0’ (62737030h).
            /// Permitted tag types: tagStructType of type brdfTransformStructure.
            /// This tag defines a BRDF model and its parameters for perceptual rendering. Specifically, it describes a BRDF model
            /// that transforms viewing angle, lighting angle, and Device or Colour Encoding to the spectralbased PCS specified by
            /// the PCS field in the profile header.
            /// For the transform subtag of this structure, the number of input channels shall be the same as the number of channels
            /// implied by the colorSpace signature in the profile header.
            /// The number of output channels of the subtag transform depends on the type of BRDF model. For monochrome type
            /// models the output of the transform subtag shall be the number of parameters defined by the BRDF model type. For
            /// chromatic type models the number of output values shall be the number of parameters defined by the BRDF model
            /// type multiplied by the number of channels implied by the spectral PCS signature in the profile header.
            self = .brdfSpectralParameter0(_: try tagStructType(dataStream: &dataStream, size: size, header: header))
        case .brdfSpectralParameter1Tag:
            /// [ICC.2:2019] 9.2.11 brdfSpectralParameter1Tag
            /// Tag signature: ‘bsp1’ (62737031h).
            /// Permitted tag types: tagStructType of type brdfTransformStructure.
            /// This tag defines a BRDF model and its parameters for media-relative intent rendering. Specifically, it describes a
            /// BRDF model that transforms viewing angle, lighting angle, and Device or Colour Encoding to the spectral-based
            /// PCS specified by the PCS field in the profile header.
            /// For the transform subtag of this structure, the number of input channels shall be the same as the number of
            /// channels implied by the colorSpace signature in the profile header.
            /// The number of output channels of the subtag transform depends on the type of BRDF model. For monochrome type
            /// models the output of the transform subtag shall be the number of parameters defined by the BRDF model type.
            /// For chromatic type models the number of output values shall be the number of parameters defined by the BRDF
            /// model type multiplied by the number of channels implied by the spectral PCS signature in the profile header.
            self = .brdfSpectralParameter1(_: try tagStructType(dataStream: &dataStream, size: size, header: header))
        case .brdfSpectralParameter2Tag:
            /// [ICC.2:2019] 9.2.12 brdfSpectralParameter2Tag
            /// Tag signature: ‘bsp2’ (62737032h).
            /// Permitted tag types: tagStructType of type brdfTransformStructure.
            /// This tag defines a BRDF model and its parameters for saturation intent rendering. Specifically, it describes a BRDF
            /// model that transforms viewing angle, lighting angle, and Device or Colour Encoding to the spectral-based PCS
            /// specified by the PCS field in the profile header.
            /// For the transform subtag of this structure, the number of input channels shall be the same as the number of channels
            /// implied by the colorSpace signature in the profile header.
            /// The number of output channels of the subtag transform depends on the type of BRDF model. For monochrome
            /// type models the output of the transform subtag shall be the number of parameters defined by the BRDF model type.
            /// For chromatic type models the number of output values shall be the number of parameters defined by the BRDF
            /// model type multiplied by the number of channels implied by the spectral PCS signature in the profile header.
            self = .brdfSpectralParameter2(_: try tagStructType(dataStream: &dataStream, size: size, header: header))
        case .brdfSpectralParameter3Tag:
            /// [ICC.2:2019] 9.2.13 brdfSpectralParameter3Tag
            /// Tag signature: ‘bsp3’ (62737033h).
            /// Permitted tag types: tagStructType of type brdfTransformStructure.
            /// For the transform subtag of this structure, the number of input channels shall be the same as the number of
            /// channels implied by the colorSpace signature in the profile header.
            /// The number of output channels of the subtag transform depends on the type of BRDF model. For monochrome type
            /// models the output of the transform subtag shall be the number of parameters defined by the BRDF model type.
            /// For chromatic type models the number of output values shall be the number of parameters defined by the BRDF
            /// model type multiplied by the number of channels implied by the spectral PCS signature in the profile header.
            self = .brdfSpectralParameter3(_: try tagStructType(dataStream: &dataStream, size: size, header: header))
        case .brdfAToB0Tag:
            /// [ICC.2:2019] 9.2.14 brdfAToB0Tag
            /// Tag signature: ‘bAB0’ (62414230 h).
            /// Permitted tag types: multiProcessElementsType.
            /// This tag defines the transform to achieve perceptual intent rendering in relation to viewing and lighting angles.
            /// Specifically, it describes the colour transform from viewing angle, lighting angle, and Device or Colour Encoding
            /// to the colorimetric-based PCS specified by the PCS field in the profile header.
            /// The number of input channels to the multiProcessElementsType-based tag shall be four plus the number of
            /// channels implied by the colorSpace signature in the profile header. The order and encoding of the BRDF and
            /// device channels provided to the multiProcessElementsType are shown in Table 26.
            /// Table 26 — BRDF device channel encoding
            /// Input channel index Channel identification Encoding type
            /// 0 Viewing azimuth angle Φr azimuthNumber
            /// 1 Viewing zenith angle θr zenithNumber
            /// 2 Lighting azimuth angle Φi azimuthNumber
            /// 3 Lighting zenith angle θi zenithNumber
            /// 4 Device channel 0
            /// … …
            /// 4+N Device channel N-1
            /// The output channels are defined by the encoding implied by the PCS field in the profile header.
            self = .brdfAToB0(try multiProcessElementsType(dataStream: &dataStream, size: size))
        case .brdfAToB1Tag:
            /// [ICC.2:2019] 9.2.15 brdfAToB1Tag
            /// Tag signature: ‘bAB1’ (62414231h).
            /// Permitted tag types: multiProcessElementsType.
            /// This tag defines the transform to achieve media-relative colorimetric intent rendering in relation to viewing and
            /// lighting angles. Specifically, it describes the colour transform from viewing angle, lighting angle, and Device or
            /// Colour Encoding to the colorimetric-based PCS specified by the PCS field in the profile header.
            /// The number of input channels to the multiProcessElementsType-based tag shall be four plus the number of
            /// channels implied by the colorSpace signature in the profile header. The order and encoding of the BRDF and
            /// device channels provided to the multiProcessElementsType are shown in Table 26.
            /// The output channels are defined by the encoding implied by the PCS field in the profile header
            /// If this tag is not present then relative BRDF-based colorimetric processing shall be performed by using the absolute
            /// colorimetric brdfAToB3Tag and then adjusting the colorimetric PCS values by the media white point.
            self = .brdfAToB1(try multiProcessElementsType(dataStream: &dataStream, size: size))
        case .brdfAToB2Tag:
            /// [ICC.2:2019] 9.2.16 brdfAToB2Tag
            /// Tag signature: ‘bAB2’ (62414232h).
            /// Permitted tag types: multiProcessElementsType.
            /// This tag defines the transform to achieve saturation intent rendering in relation to viewing and lighting angles.
            /// Specifically, it describes the colour transform from viewing angle, lighting angle, and Device or Colour Encoding
            /// to the colorimetric-based PCS specified by the PCS field in the profile header.
            /// The number of input channels to the multiProcessElementsType-based tag shall be four plus the number of
            /// channels implied by the colorSpace signature in the profile header. The order and encoding of the BRDF and
            /// device channels provided to the multiProcessElementsType are shown in Table 26.
            /// The output channels are defined by the encoding implied by the PCS field in the profile header.
            self = .brdfAToB2(try multiProcessElementsType(dataStream: &dataStream, size: size))
        case .brdfAToB3Tag:
            /// [ICC.2:2019] 9.2.17 brdfAToB3Tag
            /// Tag signature: ‘bAB3’ (62414233h).
            /// Permitted tag types: multiProcessElementsType.
            /// This tag defines the transform to achieve absolute intent rendering in relation to viewing and lighting angles.
            /// Specifically, it describes the colour transform from viewing angle, lighting angle, and Device or Colour Encoding to
            /// the colorimetric-based PCS specified by the PCS field in the profile header.
            /// The number of input channels to this multiProcessElementsType-based tag shall be four plus the number of
            /// channels implied by the colorSpace signature in the profile header. The order and encoding of the BRDF and
            /// device channels provided to the multiProcessElementsType are shown in Table 26.
            /// The output channels are defined by the encoding implied by the PCS field in the profile header.
            /// If this tag is not present then relative BRDF-based colorimetric processing shall be performed by using the relative
            /// colorimetric brdfAToB1Tag and then adjusting the colorimetric PCS values by the media white point.
            self = .brdfAToB3(try multiProcessElementsType(dataStream: &dataStream, size: size))
        case .brdfBToA0Tag:
            /// [ICC.2:2019] 9.2.18 brdfBToA0Tag
            /// Tag signature: ‘bBA0’ (62424130 h).
            /// Permitted tag types: multiProcessElementsType.
            /// This tag defines the transform to achieve perceptual intent rendering in relation to viewing and lighting angles.
            /// Specifically, it describes the colour transform from viewing angle, lighting angle, and colorimetricbased PCS specified
            /// by the PCS field in the profile header to Device or Colour Encoding.
            /// This use of this tag is not defined when the PCS field in the profile header is set to zero.
            /// The number of input channels to the multiProcessElementsType-based tag shall be four plus the number of channels
            /// defined by the encoding implied by the PCS field in the profile header. The order and encoding of the BRDF and
            /// device channels provided to the multiProcessElementsType are shown in Table 27.
            /// Table 27 — BRDF colorimetric encoding
            /// Input channel index Channel identification Encoding type
            /// 0 Viewing azimuth angle Φr azimuthNumber
            /// 1 Viewing zenith angle θr zenithNumber
            /// 2 Lighting azimuth angle Φi azimuthNumber
            /// 3 Lighting zenith angle θi zenithNumber
            /// 4 PCS channel 0
            /// … …
            /// 4+N PCS channel N-1
            /// The number of output channels shall be the number of device channels defined by the colorSpace signature in the
            /// profile header.
            self = .brdfBToA0(try multiProcessElementsType(dataStream: &dataStream, size: size))
        case .brdfBToA1Tag:
            /// [ICC.2:2019] 9.2.19 brdfBToA1Tag
            /// Tag signature: ‘bBA1’ (62424131h).
            /// Permitted tag types: multiProcessElementsType.
            /// This tag defines the transform to achieve media-relative colorimetric intent rendering in relation to viewing and
            /// lighting angles. Specifically, it describes the colour transform from viewing angle, lighting angle, and
            /// colorimetric-based PCS specified by the PCS field in the profile header to Device or Colour Encoding.
            /// This use of this tag is not defined when the PCS field in the profile header is set to zero.
            /// The number of input channels to the multiProcessElementsType-based tag shall be four plus the number of
            /// channels defined by the encoding implied by the PCS field in the profile header. The order and encoding of the
            /// BRDF and device channels provided to the multiProcessElementsType are shown in Table 27.
            /// The output channels shall be the number of device channels defined by the colorSpace signature in the profile
            /// header.
            /// If this tag is not present then relative BRDF-based colorimetric processing shall be performed by first adjusting the
            /// colorimetric PCS values by the media white point and then using the absolute colorimetric brdfBToA3Tag
            self = .brdfBToA1(try multiProcessElementsType(dataStream: &dataStream, size: size))
        case .brdfBToA2Tag:
            /// [ICC.2:2019] 9.2.20 brdfBToA2Tag
            /// Tag signature: ‘bBA2’ (62424132h).
            /// Permitted tag types: multiProcessElementsType.
            /// This tag defines the transform to achieve saturation intent rendering in relation to viewing and lighting angles.
            /// Specifically, it describes the colour transform from viewing angle, lighting angle, and colorimetricbased PCS specified
            /// by the PCS field in the profile header to Device or Colour Encoding.
            /// This use of this tag is not defined when the PCS field in the profile header is set to zero.
            /// The number of input channels to the multiProcessElementsType-based tag shall be four plus the number of channels
            /// defined by the encoding implied by the PCS field in the profile header. The order and encoding of the BRDF and
            /// device channels provided to the multiProcessElementsType are shown in Table 27.
            /// The output channels shall be the number of device channels defined by the colorSpace signature in the profile header.
            self = .brdfBToA2(try multiProcessElementsType(dataStream: &dataStream, size: size))
        case .brdfBToA3Tag:
            /// [ICC.2:2019] 9.2.21 brdfBToA3Tag
            /// Tag signature: ‘bBA3’ (62424133h).
            /// Permitted tag types: multiProcessElementsType.
            /// This tag defines the transform to achieve absolute intent rendering in relation to viewing and lighting angles.
            /// Specifically, it describes the colour transform from viewing angle, lighting angle, and colorimetricbased PCS
            /// specified by the PCS field in the profile header to Device or Colour Encoding.
            /// This use of this tag is not defined when the PCS field in the profile header is set to zero.
            /// The number of input channels to the multiProcessElementsType-based tag shall be four plus the number of channels
            /// defined by the encoding implied by the PCS field in the profile header. The order and encoding of the BRDF and
            /// device channels provided to the multiProcessElementsType are shown in Table 27.
            /// The output channels shall be the number of device channels defined by the colorSpace signature in the profile header.
            /// If this tag is not present then relative BRDF-based colorimetric processing shall be performed by first adjusting the
            /// colorimetric PCS values by the media white point and then using the relative colorimetric brdfAToB1Tag.
            self = .brdfBToA3(try multiProcessElementsType(dataStream: &dataStream, size: size))
        case .brdfBToD0Tag:
            /// [ICC.2:2019] 9.2.22 brdfBToD0Tag
            /// Tag signature: ‘bBD0’ (62424430 h).
            /// Permitted tag types: multiProcessElementsType.
            /// This tag defines the transform to achieve perceptual intent rendering in relation to viewing and lighting angles.
            /// Specifically, it describes the colour transform from viewing angle, lighting angle, and the spectralbased PCS
            /// specified by the spectralPCS field in the profile header to Device or Colour Encoding.
            /// This use of this tag is not defined when the spectralPCS field in the profile header is set to zero.
            /// The number of input channels to the multiProcessElementsType-based tag shall be four plus the number of
            /// channels defined by the encoding implied by the spectralPCS field in the profile header. The order and encoding
            /// of the BRDF and device channels provided to the multiProcessElementsType are shown in Table 28.
            /// Table 28 — BRDF spectral encoding
            /// Input channel index Channel identification Encoding type
            /// 0 Viewing azimuth angle Φr azimuthNumber
            /// 1 Viewing zenith angle θr zenithNumber
            /// 2 Lighting azimuth angle Φi azimuthNumber
            /// 3 Lighting zenith angle θi zenithNumber
            /// 4 Spectral PCS channel 0
            /// … …
            /// 4+N Spectral PCS channel N-1
            /// The output channels shall be the number of channels implied by the colorSpace signature in the profile header.
            self = .brdfBToD0(try multiProcessElementsType(dataStream: &dataStream, size: size))
        case .brdfBToD1Tag:
            /// [ICC.2:2019] 9.2.23 brdfBToD1Tag
            /// Tag signature: ‘bBD1’ (62424431h).
            /// Permitted tag types: multiProcessElementsType.
            /// This tag defines the transform to achieve relative intent rendering in relation to viewing and lighting angles.
            /// Specifically, it describes the colour transform from viewing angle, lighting angle, and the spectralbased PCS specified by the spectralPCS field in the profile header to Device or Colour Encoding.
            /// This use of this tag is not defined when the spectralPCS field in the profile header is set to zero.
            /// The number of input channels to the multiProcessElementsType-based tag shall be four plus the number of channels
            /// defined by the encoding implied by the spectralPCS field in the profile header. The order and encoding of the BRDF
            /// and device channels provided to the multiProcessElementsType are shown in Table 28.
            /// The output channels shall be the number of channels implied by the colorSpace signature in the profile header.
            /// If this tag is not present then relative BRDF-based spectral processing shall be performed by first adjusting the
            /// spectral PCS values by the spectral media white point and then using the absolute brdfDToB3Tag.
            self = .brdfBToD1(try multiProcessElementsType(dataStream: &dataStream, size: size))
        case .brdfBToD2Tag:
            /// [ICC.2:2019] 9.2.24 brdfBToD2Tag
            /// Tag signature: ‘bBD2’ (62424432h).
            /// Permitted tag types: multiProcessElementsType.
            /// This tag defines the transform to achieve saturation intent rendering in relation to viewing and lighting angles.
            /// Specifically, it describes the colour transform from viewing angle, lighting angle, and the spectralbased PCS
            /// specified by the spectralPCS field in the profile header to Device or Colour Encoding.
            /// This use of this tag is not defined when the spectralPCS field in the profile header is set to zero.
            /// The number of input channels to the multiProcessElementsType-based tag shall be four plus the number of channels
            /// defined by the encoding implied by the spectralPCS field in the profile header. The order and encoding of the BRDF
            /// and device channels provided to the multiProcessElementsType are shown in Table 28.
            /// The output channels shall be the number of channels implied by the colorSpace signature in the profile header.
            /// The output channels are defined by the encoding implied by the spectralPCS field in the profile header.
            self = .brdfBToD2(try multiProcessElementsType(dataStream: &dataStream, size: size))
        case .brdfBToD3Tag:
            /// [ICC.2:2019] 9.2.25 brdfBToD3Tag
            /// Tag signature: ‘bBD3’ (62424433h).
            /// Permitted tag types: multiProcessElementsType.
            /// This tag defines the transform to achieve saturation intent rendering in relation to viewing and lighting angles.
            /// Specifically, it describes the colour transform from viewing angle, lighting angle, and the spectralbased PCS specified
            /// by the spectralPCS field in the profile header to Device or Colour Encoding.
            /// This use of this tag is not defined when the spectralPCS field in the profile header is set to zero.
            /// The number of input channels to the multiProcessElementsType-based tag shall be four plus the number of channels
            /// defined by the encoding implied by the spectralPCS field in the profile header. The order and encoding of the BRDF
            /// and device channels provided to the multiProcessElementsType are shown in Table 28.
            /// The output channels shall be the number of channels implied by the colorSpace signature in the profile header.
            /// If this tag is not present then relative BRDF-based spectral processing shall be performed by using the relative
            /// brdfDToB1Tag and then adjusting the spectral PCS values by the spectral media white point.
            self = .brdfBToD3(try multiProcessElementsType(dataStream: &dataStream, size: size))
        case .brdfDToB0Tag:
            /// [ICC.2:2019] 9.2.26 brdfDToB0Tag
            /// Tag signature: ‘bDB0’ (62444230 h).
            /// Permitted tag types: multiProcessElementsType.
            /// This tag defines the transform to achieve perceptual intent rendering in relation to viewing and lighting angles.
            /// Specifically, it describes the colour transform from viewing angle, lighting angle, and Device or Colour Encoding to
            /// the spectral-based PCS specified by the spectralPCS field in the profile.
            /// This use of this tag is not defined when the spectralPCS tag is set to zero.
            /// The number of input channels to the multiProcessElementsType-based tag shall be four plus the number of
            /// channels implied by the colorSpace signature in the profile header. The order and encoding of the BRDF and
            /// device channels provided to the multiProcessElementsType are shown in Table 26.
            /// The output channels are defined by the encoding implied by the spectralPCS field in the profile header.
            self = .brdfDToB0(try multiProcessElementsType(dataStream: &dataStream, size: size))
        case .brdfDToB1Tag:
            /// [ICC.2:2019] 9.2.27 brdfDToB1Tag
            /// Tag signature: ‘bDB1’ (62444231h).
            /// Permitted tag types: multiProcessElementsType.
            /// This tag defines the transform to achieve relative intent rendering in relation to viewing and lighting angles.
            /// Specifically, it describes the colour transform from viewing angle, lighting angle, and Device or Colour Encoding
            /// to the spectral-based PCS specified by the spectralPCS field in the profile.
            /// This use of this tag is not defined when the spectralPCS tag is set to zero.
            /// The number of input channels to the multiProcessElementsType-based tag shall be four plus the number of channels
            /// implied by the colorSpace signature in the profile header. The order and encoding of the BRDF and device channels
            /// provided to the multiProcessElementsType are shown in Table 26.
            /// The output channels are defined by the encoding implied by the spectralPCS field in the profile header.
            /// If this tag is not present then relative BRDF-based spectral processing shall be performed by using the absolute
            /// brdfDToB3Tag and then adjusting the spectral PCS values by the spectral media white point.
            self = .brdfDToB1(try multiProcessElementsType(dataStream: &dataStream, size: size))
        case .brdfDToB2Tag:
            /// [ICC.2:2019] 9.2.28 brdfDToB2Tag
            /// Tag signature: ‘bDB2’ (62444232h).
            /// Permitted tag types: multiProcessElementsType.
            /// This tag defines the transform to achieve saturation intent rendering in relation to viewing and lighting angles.
            /// Specifically, it describes the colour transform from viewing angle, lighting angle, and Device or Colour Encoding
            /// to the spectral-based PCS specified by the spectralPCS field in the profile.
            /// This use of this tag is not defined when the spectralPCS tag is set to zero.
            /// The number of input channels to the multiProcessElementsType-based tag shall be four plus the number of
            /// channels implied by the colorSpace signature in the profile header. The order and encoding of the BRDF and
            /// device channels provided to the multiProcessElementsType are shown in Table 26.
            /// The output channels are defined by the encoding implied by the spectralPCS field in the profile header.
            self = .brdfDToB2(try multiProcessElementsType(dataStream: &dataStream, size: size))
        case .brdfDToB3Tag:
            /// [ICC.2:2019] 9.2.29 brdfDToB3Tag
            /// Tag signature: ‘bDB3’ (62444233h).
            /// Permitted tag types: multiProcessElementsType.
            /// This tag defines the transform to achieve saturation intent rendering in relation to viewing and lighting angles.
            /// Specifically, it describes the colour transform from viewing angle, lighting angle, and Device or Colour Encoding to
            /// the spectral-based PCS specified by the spectralPCS field in the profile.
            /// This use of this tag is not defined when the spectralPCS tag is set to zero.
            /// The number of input channels to the multiProcessElementsType-based tag shall be four plus the number of
            /// channels implied by the colorSpace signature in the profile header. The order and encoding of the BRDF and
            /// device channels provided to the multiProcessElementsType are shown in Table 26.
            /// The output channels are defined by the encoding implied by the spectralPCS field in the profile header.
            /// If this tag is not present then relative BRDF-based spectral processing shall be performed by using the relative
            /// brdfDToB1Tag and then adjusting the spectral PCS values by the spectral media white point.
            self = .brdfDToB3(try multiProcessElementsType(dataStream: &dataStream, size: size))
        case .brdfMToB0Tag:
            /// [ICC.2:2019] 9.2.30 brdfMToB0Tag
            /// Tag signature: ‘bMB0’ (624d4230h).
            /// Permitted tag types: tagStructType of type brdfTransformStructure.
            /// This tag defines a BRDF model and its parameters for perceptual intent rendering using multiplex channels as input.
            /// Specifically, it describes a BRDF model that transforms viewing angle, lighting angle, and Device or Colour Encoding
            /// to the colorimetric-based PCS specified by the PCS field in the profile header.
            /// For the transform subtag of this structure, the number of input channels shall be the same as the number of
            /// channels implied by the MCS signature in the profile header.
            /// The number of output channels of the transform subtag depends on the type of BRDF model. For monochrome type
            /// models the output of the transform subtag shall be the number of parameters defined by the BRDF model type.
            /// For chromatic type models the number of output values shall be the number of parameters defined by the BRDF
            /// model type multiplied by the number of channels implied by the PCS signature in the profile header.
            self = .brdfMToB0(try tagStructType(dataStream: &dataStream, size: size, header: header))
        case .brdfMToB1Tag:
            /// [ICC.2:2019] 9.2.31 brdfMToB1Tag
            /// Tag signature: ‘bMB1’ (624d4231h).
            /// Permitted tag types: tagStructType of type brdfTransformStructure.
            /// This tag defines a BRDF model and its parameters for media-relative rendering using multiplex channels as input.
            /// Specifically, it describes a BRDF model that transforms viewing angle, lighting angle, and Device or Colour
            /// Encoding to the colorimetric-based PCS specified by the PCS field in the profile header.
            /// For the transform subtag of this structure, the number of input channels shall be the same as the number of
            /// channels implied by the MCS signature in the profile header.
            /// The number of output channels of the transform subtag depends on the type of BRDF model. For monochrome type
            /// models the output of the transform subtag shall be the number of parameters defined by the BRDF model type.
            /// For chromatic type models the number of output values shall be the number of parameters defined by the BRDF
            /// model type multiplied by the number of channels implied by the PCS signature in the profile header.
            self = .brdfMToB1(try tagStructType(dataStream: &dataStream, size: size, header: header))
        case .brdfMToB2Tag:
            /// [ICC.2:2019] 9.2.32 brdfMToB2Tag
            /// Tag signature: ‘bMB2’ (624d4232h).
            /// Permitted tag types: tagStructType of type brdfTransformStructure.
            /// This tag defines a BRDF model and its parameters for saturation intent rendering using multiplex
            /// channels as input. Specifically, it describes a BRDF model that transforms viewing angle, lighting angle, and Device
            /// or Colour Encoding to the colorimetric-based PCS specified by the PCS field in the profile header.
            /// For the transform subtag of this structure, the number of input channels shall be the same as the number of channels
            /// implied by the MCS signature in the profile header.
            /// The number of output channels of the transform subtag depends on the type of BRDF model. For monochrome type
            /// models the output of the transform subtag shall be the number of parameters defined by the BRDF model type.
            /// For chromatic type models the number of output values shall be the number of parameters defined by the BRDF
            /// model type multiplied by the number of channels implied by the PCS signature in the profile header.
            self = .brdfMToB2(try tagStructType(dataStream: &dataStream, size: size, header: header))
        case .brdfMToB3Tag:
            /// [ICC.2:2019] 9.2.33 brdfMToB3Tag
            /// Tag signature: ‘bMB3’ (624d4233h).
            /// Permitted tag types: tagStructType of type brdfTransformStructure.
            /// This tag defines a BRDF model and its parameters for absolute-colorimetric rendering using multiplex channels as
            /// input. Specifically, it describes a BRDF model that transforms viewing angle, lighting angle, and Device or Colour
            /// Encoding to the colorimetric-based PCS specified by the PCS field in the profile header.
            /// For the transform subtag of this structure, the number of input channels shall be the same as the number of
            /// channels implied by the MCS signature in the profile header.
            /// The number of output channels of the transform subtag depends on the type of BRDF model. For monochrome
            /// type models the output of the transform subtag shall be the number of parameters defined by the BRDF model
            /// type. For chromatic type models the number of output values shall be the number of parameters defined by the
            /// BRDF model type multiplied by the number of channels implied by the PCS signature in the profile header.
            self = .brdfMToB3(try tagStructType(dataStream: &dataStream, size: size, header: header))
        case .brdfMToS0Tag:
            /// [ICC.2:2019] 9.2.34 brdfMToS0Tag
            /// Tag signature: ‘bMS0’ (624d5330h).
            /// Permitted tag types: tagStructType of type brdfTransformStructure.
            /// This tag defines a BRDF model and its parameters for perceptual intent rendering using multiplex channels as input.
            /// Specifically, it describes a BRDF model that transforms viewing angle, lighting angle, and Device or Colour Encoding
            /// to the spectral-based PCS specified by the spectralPCS field in the profile header.
            /// This use of this tag is not defined when the spectralPCS tag is set to zero.
            /// For the transform subtag of this structure, the number of input channels shall be the same as the number of channels
            /// implied by the MCS signature in the profile header.
            /// The number of output channels of the transform subtag depends on the type of BRDF model. For monochrome type
            /// models the output of the transform subtag shall be the number of parameters defined by the BRDF model type.
            /// For chromatic type models the number of output values shall be the number of parameters defined by the BRDF
            /// model type multiplied by the number of channels implied by the PCS signature in the profile header.
            self = .brdfMToS0(try tagStructType(dataStream: &dataStream, size: size, header: header))
        case .brdfMToS1Tag:
            /// [ICC.2:2019] 9.2.35 brdfMToS1Tag
            /// Tag signature: ‘bMS1’ (624d5331h).
            /// Permitted tag types: tagStructType of type brdfTransformStructure.
            /// This tag defines a BRDF model and its parameters for media-relative rendering using multiplex channels as input.
            /// Specifically, it describes a BRDF model that transforms viewing angle, lighting angle, and Device or Colour Encoding
            /// to the spectral-based PCS specified by the spectralPCS field in the profile header.
            /// This use of this tag is not defined when the spectralPCS tag is set to zero.
            /// For the transform subtag of this structure, the number of input channels shall be the same as the number of channels
            /// implied by the MCS signature in the profile header.
            /// The number of output channels of the transform subtag depends on the type of BRDF model. For monochrome type
            /// models the output of the transform subtag shall be the number of parameters defined by the BRDF model type.
            /// For chromatic type models the number of output values shall be the number of parameters defined by the BRDF
            /// model type multiplied by the number of channels implied by the PCS signature in the profile header.
            self = .brdfMToS1(try tagStructType(dataStream: &dataStream, size: size, header: header))
        case .brdfMToS2Tag:
            /// [ICC.2:2019] 9.2.36 brdfMToS2Tag
            /// Tag signature: ‘bMS2’ (624d5332h).
            /// Permitted tag types: tagStructType of type brdfTransformStructure.
            /// This tag defines a BRDF model and its parameters for saturation intent rendering using multiplex channels as input.
            /// Specifically, it describes a BRDF model that transforms viewing angle, lighting angle, and Device or Colour Encoding
            /// to the spectral-based PCS specified by the spectralPCS field in the profile header.
            /// This use of this tag is not defined when the spectralPCS tag is set to zero.
            /// For the transform subtag of this structure, the number of input channels shall be the same as the number of
            /// channels implied by the MCS signature in the profile header.
            /// The number of output channels of the transform subtag depends on the type of BRDF model. For monochrome type
            /// models the output of the transform subtag shall be the number of parameters defined by the BRDF model type.
            /// For chromatic type models the number of output values shall be the number of parameters defined by the BRDF
            /// model type multiplied by the number of channels implied by the PCS signature in the profile header.
            self = .brdfMToS2(try tagStructType(dataStream: &dataStream, size: size, header: header))
        case .brdfMToS3Tag:
            /// [ICC.2:2019] 9.2.37 brdfMToS3Tag
            /// Tag signature: ‘bMS3’ (624d5333h).
            /// Permitted tag types: tagStructType of type brdfTransformStructure.
            /// This tag defines a BRDF model and its parameters for perceptual rendering using multiplex channels as input.
            /// Specifically, it describes a BRDF model that transforms viewing angle, lighting angle, and Device or Colour Encoding
            /// to the spectral-based PCS specified by the spectralPCS field in the profile header.
            /// This use of this tag is not defined when the spectralPCS tag is set to zero.
            /// For the transform subtag of this structure, the number of input channels shall be the same as the number of channels
            /// implied by the MCS signature in the profile header.
            /// The number of output channels of the transform subtag depends on the type of BRDF model. For monochrome type
            /// models the output of the transform subtag shall be the number of parameters defined by the BRDF model type.
            /// For chromatic type models the number of output values shall be the number of parameters defined by the BRDF
            /// model type multiplied by the number of channels implied by the PCS signature in the profile header.
            self = .brdfMToS3(try tagStructType(dataStream: &dataStream, size: size, header: header))
        case .bToA3Tag:
            /// [ICC.2:2019] 9.2.41 BToA3Tag
            /// Tag signature: ‘B2A3’ (42324133h).
            /// Permitted tag types: lutBToAType or multiProcessElementsType.
            /// This tag defines a colour transform from a colorimetric-based PCS to Device or Colour Encoding using the lookup
            /// table tag element structures or multiProcessElementsType transforms. For most profile classes, it defines the
            /// transform to achieve absolute colorimetric rendering (see Table 29). The processing mechanisms are described in
            /// lutBToAType or multiProcessElementsType (see 10.2.13 and 10.2.16).
            /// If this tag is not present then absolute colorimetric processing shall be performed by adjusting the colorimetric
            /// PCS values by the media white point and then using the relative colorimetric BToA1Tag.
            self = .bToA3(try lutType(dataStream: &dataStream, size: size))
        case .colorEncodingParamsTag:
            /// [ICC.2:2019] 9.2.48 colorEncodingParamsTag
            /// Tag Signature: ‘cept’ (63657074h).
            /// Tag Type: tagStructType of type colorEncodingParamsStructure.
            /// The colorEncodingParamsTag is defined using a colorEncodingParamsStructure. Element members in this structure
            /// are assumed to be overrides of parameters assumed by the encoding reference name.
            self = .colorEncodingParams(try tagStructType(dataStream: &dataStream, size: size, header: header))
        case .colorSpaceNameTag:
            /// [ICC.2:2019] 9.2.49 colorSpaceNameTag
            /// Tag Signature: 'csnm' (63736e6dh).
            /// Tag Type: utf8Type.
            /// This tag defines the reference name for the three component colour encoding when the profile uniquely defines all
            /// the necessary parameters for the encoding. This occurs when the referenceNameTag solely contains the text
            /// “ISO 22028-1” (quotes excluded).
            /// If the referenceNameTag does not solely contain the text “ISO 22028-1” then the colorSpaceNameTag shall contain
            /// the same text as the referenceNameTag (if the profile is present).
            self = .colorSpaceName(try utf8Type(dataStream: &dataStream, size: size))
        case .colorantInfoTag:
            /// [ICC.2:2019] 9.2.52 colorantInfoTag
            /// Tag signature: 'clin' (636c696eh).
            /// Permitted tag type: tagArrayType with an array type identifier of ‘cinf’ (63696e66h).
            /// This tag identifies the colorants associated with the data colour space field header (see 7.2.8) when the data colour
            /// space field is either an xCLR where x is a hexadecimal value from 1 to F, or has a signature representation of
            /// “ncXXXX” where X is a hexadecimal value from 1 to FFFF. The colorant information is provided as an array of
            /// colorantInfoStructure elements. Each colorantInfoStructure entry provides a name for the colorant and optionally
            /// colorimetric or spectral information. See 12.2.2 for a complete description of contents and usage of a
            /// colorantInfoStructure.
            self = .colorantInfo(try tagArrayTypeOrLutType(dataStream: &dataStream, size: size))
        case .colorantInfoOutTag:
            /// [ICC.2:2019] 9.2.53 colorantInfoOutTag
            /// Tag signature: ‘clio’ (636C696fh).
            /// Permitted tag type: tagArrayType with an array type identifier of ‘cinf’ (63696e66h).
            /// This tag identifies the colorants associated with the PCS colour space field header (see 7.2.8) when the PCS colour
            /// space field is either an xCLR where x is a hexadecimal value from 1 to F, or has a signature representation of
            /// “ncXXXX” where X is a hexadecimal value from 1 to FFFF. The colorant information is provided as an array of
            /// colorantInfoStructure elements. Each colorantInfoStructure entry provides a name for the colorant and optionally
            /// colorimetric and/or spectral information. See 12.2.2 for a complete description of contents and usage of a colorantInfoStructure.
            /// This tag is used for DeviceLink profiles only.
            self = .colorantInfo(try tagArrayTypeOrLutType(dataStream: &dataStream, size: size))
        case .customToStandardPccTag:
            /// [ICC.2:2019] 9.2.56 customToStandardPccTag
            /// Tag signature: 'c2sp' (63327370h).
            /// Permitted Tag types: multiProcessElementsType.
            /// This tag provides the transform needed to convert from the colorimetry defined by the observer and illuminant
            /// defined in the spectralViewingConditionsTag to the colorimetry defined by the CIE 1931 Standard Colorimetric
            /// Observer with a D50 illuminant. The multiProcessElementsType structure shall define a sequence of one or more
            /// transforms that performs this conversion.
            /// The number of both the input and output channels of the transform shall be three.
            self = .customToStandardPcc(try multiProcessElementsType(dataStream: &dataStream, size: size))
        case .cxfTag:
            /// [ICC.2:2019] 9.2.57 cxfTag
            /// Tag signature: ‘CxF ’ (43784620).
            /// Permitted tag type: utf8Type, utf8ZipType.
            /// This tag contains a Color Exchange Format file. The CxF/X file contains the characterization target and corresponding
            /// measurement data. The CxF/X file is an XML document and shall be encoded as specified by ISO 17972-1. The
            /// CxF/X specification requires that UTF-8 be used.
            /// The cxfTag shall contain the characterization set and measurement data used to create the profile. The tag may
            /// contain any other data that conforms to the CxF/X specification.
            self = .cxf(try utf8OrUtf8ZipType(dataStream: &dataStream, size: size))
        case .directionalAToB0Tag:
            /// [ICC.2:2019] 9.2.60 directionalAToB0Tag
            /// Tag signature: ‘dAB0’ (64414230 h).
            /// Permitted tag types: multiProcessElementType.
            /// This tag defines the transform to achieve perceptual intent rendering in relation to viewing angles and relative
            /// position of a viewing area. Specifically, it describes the colour transform from viewing angle and relative position
            /// of the viewing area, and Device or Colour Encoding to the colorimetric-based PCS specified by the PCS field in
            /// the profile header.
            /// This use of this tag is not defined when the PCS field in the profile header is set to zero.
            /// The number of input channels to the multiProcessElementsType-based tag shall be four plus the number of channels
            /// implied by the colorSpace signature in the profile header. The order and encoding of the directional information and
            /// device channels provided to the multiProcessElementType are shown in Table 32.
            /// Input channel index Channel identification Encoding type
            /// 0 Viewing azimuth angle Φr azimuthNumber
            /// 1 Viewing zenith angle θr zenithNumber
            /// 2 Relative Horizontal Position rx horizontalType
            /// 3 Relative Vertical Position ry verticalType
            /// 4 Device channel 0
            /// … …
            /// 4+N Device channel N−1
            /// The output channels are defined by the encoding implied by the PCS field in the profile header.
            self = .directionalAToB0(try multiProcessElementsType(dataStream: &dataStream, size: size))
        case .directionalAToB1Tag:
            /// [ICC.2:2019] 9.2.61 directionalAToB1Tag
            /// Tag signature: ‘dAB1’ (64414231h).
            /// Permitted tag types: multiProcessElementType.
            /// This tag defines the transform to achieve media-relative colorimetric intent rendering in relation to viewing angles
            /// and relative position of a viewing area. Specifically, it describes the colour transform from viewing angle and relative
            /// position of the viewing area, and Device or Colour Encoding to the colorimetric-based PCS specified by the PCS
            /// field in the profile header.
            /// This use of this tag is not defined when the PCS field in the profile header is set to zero.
            /// The number of input channels to the multiProcessElementsType-based tag shall be four plus the number of
            /// channels implied by the colorSpace signature in the profile header. The order and encoding of the directional
            /// information and device channels provided to the multiProcessElementType are shown in Table 32.
            /// The output channels are defined by the encoding implied by the PCS field in the profile header.
            /// If this tag is not present then relative directional-based colorimetric processing shall be performed by using the
            /// absolute colorimetric directionalAToB3Tag and then adjusting the colorimetric PCS values by the media white point.
            self = .directionalAToB1(try multiProcessElementsType(dataStream: &dataStream, size: size))
        case .directionalAToB2Tag:
            /// [ICC.2:2019] 9.2.62 directionalfAToB2Tag
            /// Tag signature: ‘dAB2’ (64414232h).
            /// Permitted tag types: multiProcessElementType.
            /// This tag defines the transform to achieve saturation intent rendering in relation to viewing angles and relative position
            /// of a viewing area. Specifically, it describes the colour transform from viewing angle and relative position of the
            /// viewing area, and Device or Colour Encoding to the colorimetric-based PCS specified by the PCS field in the profile header.
            /// This use of this tag is not defined when the PCS field in the profile header is set to zero.
            /// The number of input channels to the multiProcessElementsType-based tag shall be four plus the number of
            /// channels implied by the colorSpace signature in the profile header. The order and encoding of the directional
            /// information and device channels provided to the multiProcessElementType are shown in Table 32.
            /// The output channels are defined by the encoding implied by the PCS field in the profile header.
            self = .directionalAToB2(try multiProcessElementsType(dataStream: &dataStream, size: size))
        case .directionalAToB3Tag:
            /// [ICC.2:2019] 9.2.63 directionalAToB3Tag
            /// Tag signature: ‘dAB3’ (64414233h).
            /// Permitted tag types: multiProcessElementType.
            /// This tag defines the transform to achieve absolute intent rendering in relation to viewing angles and relative position
            /// of a viewing area. Specifically, it describes the colour transform from viewing angle and relative position of the
            /// viewing area, and Device or Colour Encoding to the colorimetric-based PCS specified by the PCS field in the profile
            /// header.
            /// This use of this tag is not defined when the PCS field in the profile header is set to zero.
            /// The number of input channels to the multiProcessElementsType-based tag shall be four plus the number of channels
            /// implied by the colorSpace signature in the profile header. The order and encoding of the directional information and
            /// device channels provided to the multiProcessElementType are shown in Table 32.
            /// The output channels are defined by the encoding implied by the PCS field in the profile header.
            /// If this tag is not present then relative directional-based colorimetric processing shall be performed by using the
            /// relative colorimetric directionalAToB1Tag and then adjusting the colorimetric PCS values by the media white point.
            self = .directionalAToB3(try multiProcessElementsType(dataStream: &dataStream, size: size))
        case .directionalBToA0Tag:
            /// [ICC.2:2019] 9.2.64 directionalBToA0Tag
            /// Tag signature: ‘dBA0’ (64424130 h).
            /// Permitted tag types: multiProcessElementType.
            /// This tag defines the transform to achieve perceptual intent rendering in relation to viewing angles and relative
            /// position of a viewing area. Specifically, it describes the colour transform from viewing angle and relative position
            /// of the viewing area, and colorimetric-based PCS specified by the PCS field in the profile header to Device or
            /// Colour Encoding.
            /// This use of this tag is not defined when the PCS field in the profile header is set to zero.
            /// The number of input channels to the multiProcessElementsType-based tag shall be four plus the number of channels
            /// defined by the encoding implied by the PCS field in the profile header. The order and encoding of the directional
            /// information and device channels provided to the multiProcessElementType are shown in Table 33.
            /// Table 33 — Directional colorimetric encoding
            /// Input channel index
            /// Channel identification Encoding type
            /// 0 Viewing azimuth angle Φr azimuthNumber
            /// 1 Viewing zenith angle θr zenithNumber
            /// 2 Relative Horizontal Position rx horizontalNumber
            /// 3 Relative Vertical Position ry verticalNumber
            /// 4 PCS channel 0
            /// … …
            /// 4+N PCS channel N−1
            /// The output channels shall be the number of device channels defined by the colorSpace signature in the profile header.
            self = .directionalBToA0(try multiProcessElementsType(dataStream: &dataStream, size: size))
        case .directionalBToA1Tag:
            /// [ICC.2:2019] 9.2.65 directionalBToA1Tag
            /// Tag signature: ‘dBA1’ (64424131h).
            /// Permitted tag types: multiProcessElementType.
            /// This tag defines the transform to achieve media-relative colorimetric intent rendering in relation to viewing angles
            /// and relative position of a viewing area. Specifically, it describes the colour transform from viewing angle and relative
            /// position of the viewing area, and colorimetric-based PCS specified by the PCS field in the profile header to Device
            /// or Colour Encoding.
            /// This use of this tag is not defined when the PCS field in the profile header is set to zero.
            /// The number of input channels to the multiProcessElementsType-based tag shall be four plus the number of
            /// channels defined by the encoding implied by the PCS field in the profile header. The order and encoding of the
            /// directional information and device channels provided to the multiProcessElementType are shown in Table 33.
            /// The number of output channels shall be the number of device channels defined by the colorSpace signature in the
            /// profile header.
            /// If this tag is not present then relative directional-based colorimetric processing shall be performed by first adjusting
            /// the colorimetric PCS values by the media white point and then using the absolute colorimetric directionalBToA3Tag.
            self = .directionalBToA1(try multiProcessElementsType(dataStream: &dataStream, size: size))
        case .directionalBToA2Tag:
            /// [ICC.2:2019] 9.2.66 directionalBToA2Tag
            /// Tag signature: ‘dBA2’ (64424132h).
            /// Permitted tag types: multiProcessElementType.
            /// This tag defines the transform to achieve saturation intent rendering in relation to viewing angles and relative position
            /// of a viewing area. Specifically, it describes the colour transform from viewing angle and relative position of the
            /// viewing area, and colorimetric-based PCS specified by the PCS field in the profile header to Device or Colour Encoding.
            /// This use of this tag is not defined when the PCS field in the profile header is set to zero.
            /// The number of input channels to the multiProcessElementsType-based tag shall be four plus the number of channels
            /// defined by the encoding implied by the PCS field in the profile header. The order and encoding of the directional
            /// information and device channels provided to the multiProcessElementType are shown in Table 33.
            /// The number of output channels shall be the number of device channels defined by the colorSpace signature in the
            /// profile header.
            self = .directionalBToA2(try multiProcessElementsType(dataStream: &dataStream, size: size))
        case .directionalBToA3Tag:
            /// [ICC.2:2019] 9.2.67 directionalBToA3Tag
            /// Tag signature: ‘dBA3’ (64424133h).
            /// Permitted tag types: multiProcessElementType.
            /// This tag defines the transform to achieve absolute intent rendering in relation to viewing angles and relative position
            /// of a viewing area. Specifically, it describes the colour transform from viewing angle and relative position of the
            /// viewing area, and colorimetric-based PCS specified by the PCS field in the profile header to Device or Colour
            /// Encoding.
            /// This use of this tag is not defined when the PCS field in the profile header is set to zero.
            /// The number of input channels to the multiProcessElementsType-based tag shall be four plus the number of channels
            /// defined by the encoding implied by the PCS field in the profile header. The order and encoding of the directional
            /// information and device channels provided to the multiProcessElementType are shown in Table 33.
            /// The number of output channels shall be the number of device channels defined by the colorSpace signature in the
            /// profile header.
            /// If this tag is not present then relative BRDF-based colorimetric processing shall be performed by first adjusting the
            /// colorimetric PCS values by the media white point and then using the relative colorimetric brdfAToB1Tag.
            self = .directionalBToA3(try multiProcessElementsType(dataStream: &dataStream, size: size))
        case .directionalBToD0Tag:
            /// [ICC.2:2019] 9.2.68 directionalBToD0Tag
            /// Tag signature: ‘dBD0’ (64424430 h).
            /// Permitted tag types: multiProcessElementType.
            /// This tag defines the transform to achieve perceptual intent rendering in relation to viewing angles and relative position
            /// of a viewing area. Specifically, it describes the colour transform from viewing angle and relative position of the viewing
            /// area, and the spectral-based PCS specified by the spectralPCS field in the profile header to Device or Colour Encoding.
            /// This use of this tag is not defined when the spectralPCS field in the profile header is set to zero.
            /// The number of input channels to the multiProcessElementsType-based tag shall be four plus the number of channels
            /// defined by the encoding implied by the spectralPCS field in the profile header. The order and encoding of the
            /// directional information and device channels provided to the multiProcessElementType are shown in Table 34.
            /// Table 34 — Directional spectral encoding
            /// Input channel index Channel identification Encoding type
            /// 0 Viewing azimuth angle Φr azimuthNumber
            /// 1 Viewing zenith angle θr zenithNumber
            /// 2 Relative Horizontal Position rx horizontalNumber
            /// 3 Relative Vertical Position ry verticalNumber
            /// 4 Spectral PCS channel 0
            /// … …
            /// 4+N Spectral PCS channel N−1
            /// The number of output channels shall be the number of channels implied by the colorSpace signature in the profile
            /// header.
            self = .directionalBToD0(try multiProcessElementsType(dataStream: &dataStream, size: size))
        case .directionalBToD1Tag:
            /// [ICC.2:2019] 9.2.69 directionalBToD1Tag
            /// Tag signature: ‘dBD1’ (64424431h).
            /// Permitted tag types: multiProcessElementType.
            /// This tag defines the transform to achieve relative intent rendering in relation to viewing angles and relative position
            /// of a viewing area. Specifically, it describes the colour transform from viewing angle and relative position of the
            /// viewing area, and the spectral-based PCS specified by the spectralPCS field in the profile header to Device or
            /// Colour Encoding.
            /// This use of this tag is not defined when the spectralPCS field in the profile header is set to zero.
            /// The number of input channels to the multiProcessElementsType-based tag shall be four plus the number of channels
            /// defined by the encoding implied by the spectralPCS field in the profile header. The order and encoding of the
            /// directional information and device channels provided to the multiProcessElementType are shown in Table 34.
            /// The number of output channels shall be the number of channels implied by the colorSpace signature in the profile
            /// header.
            /// If this tag is not present then relative BRDF-based spectral processing shall be performed by first adjusting the
            /// spectral PCS values by the spectral media white point, and then using the absolute brdfDToB3Tag.
            self = .directionalBToD1(try multiProcessElementsType(dataStream: &dataStream, size: size))
        case .directionalBToD2Tag:
            /// [ICC.2:2019] 9.2.70 directionalBToD2Tag
            /// Tag signature: ‘bBD2’ (64424432h).
            /// Permitted tag types: multiProcessElementType.
            /// This tag defines the transform to achieve saturation intent rendering in relation to viewing angles and relative position
            /// of a viewing area. Specifically, it describes the colour transform from viewing angle and relative position of the
            /// viewing area, and the spectral-based PCS specified by the spectralPCS field in the profile header to Device or Colour
            /// Encoding.
            /// This use of this tag is not defined when the spectralPCS field in the profile header is set to zero.
            /// The number of input channels to the multiProcessElementsType-based tag shall be four plus the number of channels
            /// defined by the encoding implied by the spectralPCS field in the profile header. The order and encoding of the
            /// directional information and device channels provided to the multiProcessElementType are shown in Table 34. The
            /// number of output channels shall be the number of channels implied by the colorSpace signature in the profile header.
            /// The output channels are defined by the encoding implied by the spectralPCS field in the profile header.
            self = .directionalBToD2(try multiProcessElementsType(dataStream: &dataStream, size: size))
        case .directionalBToD3Tag:
            /// [ICC.2:2019] 9.2.71 directionalBToD3Tag
            /// Tag signature: ‘dBD3’ (64424433h).
            /// Permitted tag types: multiProcessElementType.
            /// This tag defines the transform to achieve saturation intent rendering in relation to viewing angles and relative position
            /// of a viewing area. Specifically, it describes the colour transform from viewing angle and relative position of the
            /// viewing area, and the spectral-based PCS specified by the spectralPCS field in the profile header to Device or Colour
            /// Encoding.
            /// This use of this tag is not defined when the spectralPCS field in the profile header is set to zero.
            /// The number of input channels to the multiProcessElementsType-based tag shall be four plus the number of channels
            /// defined by the encoding implied by the spectralPCS field in the profile header. The order and encoding of the
            /// directional information and device channels provided to the multiProcessElementType are shown in Table 34.
            /// The number of output channels shall be the number of channels implied by the colorSpace signature in the profile
            /// header.
            /// If this tag is not present then relative BRDF-based spectral processing shall be performed by using the relative
            /// brdfDToB1Tag and then adjusting the spectral PCS values by the spectral media white point.
            self = .directionalBToD3(try multiProcessElementsType(dataStream: &dataStream, size: size))
        case .directionalDToB0Tag:
            /// [ICC.2:2019] 9.2.72 directionalDToB0Tag
            /// Tag signature: ‘dDB0’ (64444230 h).
            /// Permitted tag types: multiProcessElementType.
            /// This tag defines the transform to achieve perceptual intent rendering in relation to viewing angles and relative
            /// position of a viewing area. Specifically, it describes the colour transform from viewing angle and relative position of
            /// the viewing area, and Device or Colour Encoding to the spectral-based PCS specified by the spectralPCS field in
            /// the profile header.
            /// This use of this tag is not defined when the spectralPCS tag is set to zero.
            /// The number of input channels to the multiProcessElementsType-based tag shall be four plus the number of
            /// channels implied by the colorSpace signature in the profile header. The order and encoding of the directional
            /// information and device channels provided to the multiProcessElementType are shown in Table 32.
            /// The output channels are defined by the encoding implied by the spectralPCS field in the profile header
            self = .directionalDToB0(try multiProcessElementsType(dataStream: &dataStream, size: size))
        case .directionalDToB1Tag:
            /// [ICC.2:2019] 9.2.73 directionalDToB1Tag
            /// Tag signature: ‘dDB1’ (64444231h).
            /// Permitted tag types: multiProcessElementType.
            /// This tag defines the transform to achieve relative intent rendering in relationship viewing angles and relative position
            /// of a viewing area. Specifically, it describes the colour transform from viewing angle and relative position of the
            /// viewing area, and Device or Colour Encoding to the spectral-based PCS specified by the spectralPCS field in the
            /// profile header.
            /// This use of this tag is not defined when the spectralPCS tag is set to zero.
            /// The number of input channels to the multiProcessElementsType-based tag shall be four plus the number of channels
            /// implied by the colorSpace signature in the profile header. The order and encoding of the directional information and
            /// device channels provided to the multiProcessElementType are shown in Table 32.
            /// The output channels are defined by the encoding implied by the spectralPCS field in the profile header.
            /// If this tag is not present then relative directional-based spectral processing shall be performed by using the
            /// absolute directionalDToB3Tag and then adjusting the spectral PCS values by the spectral media white point.
            self = .directionalDToB1(try multiProcessElementsType(dataStream: &dataStream, size: size))
        case .directionalDToB2Tag:
            /// [ICC.2:2019] 9.2.74 directionalDToB2Tag
            /// Tag signature: ‘dDB2’ (64444232h).
            /// Permitted tag types: multiProcessElementType.
            /// This tag defines the transform to achieve saturation intent rendering in relation to viewing angles and relative position
            /// of a viewing area. Specifically, it describes the colour transform from viewing angle and relative position of the viewing
            /// area, and Device or Colour Encoding to the spectral-based PCS specified by the spectralPCS field in the profile header.
            /// This use of this tag is not defined when the spectralPCS tag is set to zero.
            /// The number of input channels to the multiProcessElementsType-based tag shall be four plus the number of channels
            /// implied by the colorSpace signature in the profile header. The order and encoding of the directional information and
            /// device channels provided to the multiProcessElementType are shown in Table 32.
            /// The output channels are defined by the encoding implied by the spectralPCS field in the profile header.
            self = .directionalDToB2(try multiProcessElementsType(dataStream: &dataStream, size: size))
        case .directionalDToB3Tag:
            /// [ICC.2:2019] 9.2.75 directionalDToB3Tag
            /// Tag signature: ‘dDB3’ (64444233h).
            /// Permitted tag types: multiProcessElementType.
            /// This tag defines the transform to achieve saturation intent rendering in relation to viewing angles and relative position
            /// of a viewing area. Specifically, it describes the colour transform from viewing angle and relative position of the
            /// viewing area, and Device or Colour Encoding to the spectral-based PCS specified by the spectralPCS field in the
            /// profile header.
            /// This use of this tag is not defined when the spectralPCS tag is set to zero.
            /// The number of input channels to the multiProcessElementsType-based tag shall be four plus the number of channels
            /// implied by the colorSpace signature in the profile header. The order and encoding of the directional information and
            /// device channels provided to the multiProcessElementType are shown in Table 32.
            /// The output channels are defined by the encoding implied by the spectralPCS field in the profile header.
            /// If this tag is not present then relative directional-based spectral processing shall be performed by using the relative
            /// directionalDToB1Tag and then adjusting the spectral PCS values by the spectral media white point.
            self = .directionalDToB3(try multiProcessElementsType(dataStream: &dataStream, size: size))
        case .gamutBoundaryDescription0Tag:
            /// [ICC.2:2019] 9.2.80 gamutBoundaryDescription0Tag
            /// Tag signature: ‘gbd0’ (67626430h).
            /// Permitted tag types: gamutBoundaryDescriptionType.
            /// This tag defines the gamut boundary of the reference medium gamut that was used for the creation of the perceptual
            /// transform.
            self = .gamutBoundaryDescription0(try gamutBoundaryDescriptionType(dataStream: &dataStream, size: size))
        case .gamutBoundaryDescription1Tag:
            /// [ICC.2:2019] 9.2.81 gamutBoundaryDescription1Tag
            /// Tag signature: ‘gbd1’ (67626431h).
            /// Permitted tag types: gamutBoundaryDescriptionType.
            /// This tag defines the gamut boundary for the relative colorimetric transform.
            self = .gamutBoundaryDescription1(try gamutBoundaryDescriptionType(dataStream: &dataStream, size: size))
        case .gamutBoundaryDescription2Tag:
            /// [ICC.2:2019] 9.2.82 gamutBoundaryDescription2Tag
            /// Tag signature: ‘gbd2’ (67626432h).
            /// Permitted tag types: gamutBoundaryDescriptionType.
            /// This tag defines the gamut boundary for the saturation intent transform.
            self = .gamutBoundaryDescription2(try gamutBoundaryDescriptionType(dataStream: &dataStream, size: size))
        case .gamutBoundaryDescription3Tag:
            /// [ICC.2:2019] 9.2.83 gamutBoundaryDescription3Tag
            /// Tag signature: ‘gbd3’ (67626433h).
            /// Permitted tag types: gamutBoundaryDescriptionType.
            /// This tag defines the gamut boundary for the absolute colorimetric intent transform. The presence of the DToB3 or
            /// BToD3 tags may require a gamut boundary description that is different from gamutBoundaryDescription1Tag
            self = .gamutBoundaryDescription3(try gamutBoundaryDescriptionType(dataStream: &dataStream, size: size))
        case .multiplexDefaultValuesTag:
            /// [ICC.2:2019] 9.2.84 multiplexDefaultValuesTag
            /// Tag signature: ‘mdv ’ (6d647620h).
            /// Permitted tag types: uInt8NumberArray, uInt16NumberArray, float16NumberArray float32NumberArray.
            /// The multiplexDefaultValuesTag defines a default multiplex channel value for each multiplex channel identified in the
            /// multiplexTypeArrayTag. The default values shall be used for processing by the destination profile when the source
            /// profile does contain the multiplex channel identifier in its multiplexTypeArrayTag.
            /// The encoding of integer based values shall be interpreted as a logical 0,0 to 1,0 when processed by the MToA0Tag,
            /// MToB0Tag, MToB1Tag, MToB2Tag, MToB3Tag, MToS0Tag, MToS1Tag, MToS2Tag, or MToS3Tag. Floating point
            /// values shall be directly used by the MToA0Tag, MToB0Tag, MToB1Tag, MToB2Tag, MToB3Tag, MToS0Tag, MToS1Tag,
            /// MToS2Tag, or MToS3Tag.
            /// The multiplexDefaultValuesTag is optional, and if not present then a default value of 0,0 shall be used for processing
            /// when source multiplex channel data are not available.
            /// The number of array entries in a multiplexDefaultValuesTag shall be the same as the number of multiplex colour
            /// channels indicated by the signature used in the MCS profile header field.
            self = .multiplexDefaultValues(try multiplexDefaultValuesType(dataStream: &dataStream, size: size))
        case .multiplexTypeArrayTag:
            /// [ICC.2:2019] 9.2.85 multiplexTypeArrayTag
            /// Tag signature: ‘mcta’ (6d637461h).
            /// Permitted tag type: tagArray of utf8Type.
            /// tagArray type signature: ‘mcta’ (6d637461h).
            /// The multiplexTypeArrayTag defines a multiplex channel type name for each channel in the MCS for the purpose of
            /// profile connection.
            /// MCS connection between profiles is performed by passing multiplex channel values between channels that have
            /// identical multiplex channel type identifications. Channels with a multiplex channel type in the source profile that are
            /// not in the destination profile are ignored. Channels with multiplex channel types in the destination profile that are
            /// not in the source profile are processed with a multiplex channel value of zero.
            /// NOTE The order of multiplex channel identification of connected profiles does not need to be the same.
            /// Each multiplex channel type name shall be unique within a multiplexTypeArrayTag.
            /// Matching of multiplex channel type names shall be case sensitive.
            /// The number of sub-tag entries in a multiplexTypeArrayTag shall be the same as the number of multiplex colour
            /// channels indicated by the signature used in the MCS profile header field.
            self = .multiplexTypeArray(try tagArrayType(dataStream: &dataStream, size: size))
        case .measurementInfoTag:
            /// [ICC.2:2019] 9.2.86 measurementInfoTag
            /// Tag signature: ‘minf’ (6d696e66h).
            /// Permitted tag type: tagStructType of type measurementInfo.
            /// This tag defines measurement conditions for the colorimetric and/or spectral PCS (defined by PCS or spectralPCS
            /// fields of the profile header respectively). If this tag is not present the measurement conditions shall be assumed to
            /// have white backing, zero flare, 0°:45° geometry, using M1 illumination (ISO 13655).
            /// NOTE Unless otherwise specified, this tag is informative only with no CMM processing associated with the contents
            /// of this tag
            self = .measurementInfo(try tagStructType(dataStream: &dataStream, size: size, header: header))
        case .measurementInputInfoTag:
            /// [ICC.2:2019] 9.2.87 measurementInputInfoTag
            /// Tag signature: ‘miin’ (6d69696eh).
            /// Permitted tag type: tagStructType of type measurementInfo.
            /// This tag defines measurement information for measurements related to values on input side of abstract profiles
            /// (defined by device field of the profile header). This tag may therefore only be present if the profile is an abstract profile.
            /// If this tag is not present the measurement conditions shall be assumed to have white backing, zero flare, 0°:45°
            /// geometry, using M1 illumination (ISO 13655).
            /// NOTE Unless otherwise specified, this tag is informative only with no CMM processing associated with the contents
            /// of this tag
            self = .measurementInputInfo(try tagStructType(dataStream: &dataStream, size: size, header: header))
        case .metadataTag:
            /// [ICC.2:2019] 9.2.89 metadataTag
            /// Tag signature: ‘meta’ (6d657461h).
            /// Permitted tag type: dictType.
            /// This tag contains a set of metadata items for the profile.
            /// The names and values in the set shall be taken from the ICC metadata registry, available on the ICC website
            /// (http://www.color.org). Display elements should be taken from the metadata registry, as this provides
            /// common localizations.
            self = .metadata(try dictType(dataStream: &dataStream, size: size))
        case .mToA0Tag:
            /// [ICC.2:2019] 9.2.90 MToA0Tag
            /// Tag signature: ‘M2A0’ (4d324130h).
            /// Permitted tag type: multiProcessElementsType.
            /// This tag provides a transformation using a multiProcessElementsType (see 10.2.16) tag that converts from multiplex
            /// channel values to device channel values.
            /// The number of data channels provided to the transform shall match the number of channels associated with the
            /// MCS field in the Profile header. MCS connection shall result in multiplex channel values for channels with matching
            /// multiplex type identifications (see 9.2.85). Channels that have no multiplex type identification match with the source
            /// MCS shall be processed so the output has the same value as the input from the associated channel in the
            /// multiplexDefaultValuesTag (see 9.2.84) or a value of zero multiplex channel value if this tag is not present.
            /// The number of data channels resulting from the transform shall match the number of channels defined by the
            /// deviceColor field in the Profile header.
            self = .mToA0(try multiProcessElementsType(dataStream: &dataStream, size: size))
        case .mToB0Tag:
            /// [ICC.2:2019] 9.2.91 MToB0Tag
            /// Tag signature: ‘M2B0’ (4d324230h).
            /// Permitted tag type: multiProcessElementsType.
            /// This tag provides a transformation using a multiProcessElementsType (see 10.2.16) tag that converts from multiplex
            /// channel values to colorimetric PCS values for the perceptual rendering intent.
            /// The number of data channels provided to the transform shall match the number of channels associated with the
            /// MCS field in the Profile header. MCS connection shall result in multiplex channel values for channels with matching
            /// multiplex type identifications (see 9.2.85). Channels that have no multiplex type identification match with the source
            /// MCS shall be processed with the value as input from the associated channel in the multiplexDefaultValuesTag
            /// (see 9.2.84) or a zero multiplex channel value if this tag is not present.
            /// The number of data channels resulting from the transform shall match the number of channels defined by the PCS
            /// field in the Profile header.
            self = .mToB0(try multiProcessElementsType(dataStream: &dataStream, size: size))
        case .mToB1Tag:
            /// [ICC.2:2019] 9.2.92 MToB1Tag
            /// Tag signature: ‘M2B1’ (4d324231h).
            /// Permitted tag type: multiProcessElementsType.
            /// This tag provides a transformation using a multiProcessElementsType (see 10.2.16) tag that converts from multiplex
            /// channel values to colorimetric PCS values for the media-relative rendering intent.
            /// The number of data channels provided to the transform shall match the number of channels associated with the MCS
            /// field in the Profile header. MCS connection shall result in multiplex channel values for channels with matching multiplex
            /// type identifications (see 9.2.85). Channels that have no multiplex type identification match with the source MCS shall
            /// be processed with the value as input from the associated channel in the multiplexDefaultValuesTag (see 9.2.84) or a
            /// zero multiplex channel value if this tag is not present.
            /// The number of data channels resulting from the transform shall match the number of channels defined by the PCS
            /// field in the Profile header.
            /// If this tag is not present then relative colorimetric processing shall be performed by using the absolute MToB3Tag
            /// and then adjusting the PCS values by the media white point.
            self = .mToB1(try multiProcessElementsType(dataStream: &dataStream, size: size))
        case .mToB2Tag:
            /// [ICC.2:2019] 9.2.93 MToB2Tag
            /// Tag signature: ‘M2B2’ (4d324232h).
            /// Permitted tag type: multiProcessElementsType.
            /// This tag provides a transformation using a multiProcessElementsType (see 10.2.16) tag that converts from multiplex
            /// channel values to colorimetric PCS values for the saturation rendering intent.
            /// The number of data channels provided to the transform shall match the number of channels associated with the
            /// MCS field in the Profile header. MCS connection shall result in multiplex channel values for channels with matching
            /// multiplex type identifications (see 9.2.85). Channels that have no multiplex type identification match with the source
            /// MCS shall be processed with the value as input from the associated channel in the multiplexDefaultValuesTag
            /// (see 9.2.84) or a zero multiplex channel value if this tag is not present.
            /// The number of data channels resulting from the transform shall match the number of channels defined by the PCS
            /// field in the Profile header.
            self = .mToB2(try multiProcessElementsType(dataStream: &dataStream, size: size))
        case .mToB3Tag:
            /// [ICC.2:2019] 9.2.94 MToB3Tag
            /// Tag signature: ‘M2B3’ (4d324233h).
            /// Permitted tag type: multiProcessElementsType.
            /// This tag provides a transformation using a multiProcessElementsType (see 10.2.16) tag that converts from multiplex
            /// channel values to colorimetric PCS values for the absolute rendering intent.
            /// The number of data channels provided to the transform shall match the number of channels associated with the
            /// MCS field in the Profile header. MCS connection shall result in multiplex channel values for channels with matching
            /// multiplex type identifications (see 9.2.85). Channels that have no multiplex type identification match with the source
            /// MCS shall be processed with the value as input from the associated channel in the multiplexDefaultValuesTag
            /// (see 9.2.84) or a zero multiplex channel value if this tag is not present.
            /// The number of data channels resulting from the transform shall match the number of channels defined by the PCS
            /// field in the Profile header.
            /// If this tag is not present then absolute colorimetric processing shall be performed by using the relative MToB1Tag
            /// and then adjusting the PCS values by the spectral media white point.
            self = .mToB3(try multiProcessElementsType(dataStream: &dataStream, size: size))
        case .mToS0Tag:
            /// [ICC.2:2019] 9.2.95 MToS0Tag
            /// Tag signature: ‘M2S0’ (4d325330h).
            /// Permitted tag type: multiProcessElementsType.
            /// This tag provides a transformation using a multiProcessElementsType (see 10.2.16) tag that converts from multiplex
            /// channel values to spectral PCS values for the perceptual rendering intent.
            /// The number of data channels provided to the transform shall match the number of channels associated with the
            /// MCS field in the Profile header. MCS connection shall result in multiplex channel values for channels with matching
            /// multiplex type identifications (see 9.2.85). Channels that have no multiplex type identification match with the source
            /// MCS shall be processed with the value as input from the associated channel in the multiplexDefaultValuesTag
            /// (see 9.2.84) or a zero multiplex channel value if this tag is not present.
            /// The number of data channels resulting from the transform shall match the number of channels defined by the
            /// spectralPCS field in the Profile header.
            self = .mToS0(try multiProcessElementsType(dataStream: &dataStream, size: size))
        case .mToS1Tag:
            /// [ICC.2:2019] 9.2.96 MToS1Tag
            /// Tag signature: ‘M2S1’ (4d325331h).
            /// Permitted tag type: multiProcessElementsType.
            /// This tag provides a transformation using a multiProcessElementsType (see 10.2.16) tag that converts from multiplex
            /// channel values to spectral PCS values for the media-relative rendering intent.
            /// The number of data channels provided to the transform shall match the number of channels associated with the
            /// MCS field in the Profile header. MCS connection shall result in multiplex channel values for channels with matching
            /// multiplex type identifications (see 9.2.85). Channels that have no multiplex type identification match with the source
            /// MCS shall be processed with the value as input from the associated channel in the multiplexDefaultValuesTag
            /// (see 9.2.84) or a zero multiplex channel value if this tag is not present.
            /// The number of data channels resulting from the transform shall match the number of channels defined by the
            /// spectralPCS field in the Profile header.
            /// If this tag is not present then relative spectral processing shall be performed by using the absolute MToS3Tag and
            /// then adjusting the PCS values by the spectral media white point.
            self = .mToS1(try multiProcessElementsType(dataStream: &dataStream, size: size))
        case .mToS2Tag:
            /// [ICC.2:2019] 9.2.97 MToS2Tag
            /// Tag signature: ‘M2S2’ (4d325332h).
            /// Permitted tag type: multiProcessElementsType.
            /// This tag provides a transformation using a multiProcessElementsType (see 10.2.16) tag that converts from multiplex
            /// channel values to spectral PCS values for the saturation rendering intent.
            /// The number of data channels provided to the transform shall match the number of channels associated with the
            /// MCS field in the Profile header. MCS connection shall result in multiplex channel values for channels with matching
            /// multiplex type identifications (see 9.2.85). Channels that have no multiplex type identification match with the source
            /// MCS shall be processed with the value as input from the associated channel in the multiplexDefaultValuesTag
            /// (see 9.2.84) or a zero multiplex channel value if this tag is not present.
            /// The number of data channels resulting from the transform shall match the number of channels defined by the
            /// spectralPCS field in the Profile header.
            self = .mToS2(try multiProcessElementsType(dataStream: &dataStream, size: size))
        case .mToS3Tag:
            /// [ICC.2:2019] 9.2.98 MToS3Tag
            /// Tag signature: ‘M2S3’ (4d325333h).
            /// Permitted tag type: multiProcessElementsType.
            /// This tag provides a transformation using a multiProcessElementsType (see 10.2.16) tag that converts from multiplex
            /// channel values to spectral PCS values for the absolute rendering intent.
            /// The number of data channels provided to the transform shall match the number of channels associated with the
            /// MCS field in the Profile header. MCS connection shall result in multiplex channel values for channels with matching
            /// multiplex type identifications (see 9.2.85). Channels that have no multiplex type identification match with the source
            /// MCS shall be processed with the value as input from the associated channel in the multiplexDefaultValuesTag
            /// (see 9.2.84) or a zero multiplex channel value if this tag is not present.
            /// The number of data channels resulting from the transform shall match the number of channels defined by the
            /// spectralPCS field in the Profile header.
            /// If this tag is not present then absolute spectral processing shall be performed by using the relative MToB1Tag and
            /// then adjusting the PCS values by the media white point.
            self = .mToS3(try multiProcessElementsType(dataStream: &dataStream, size: size))
        case .namedColorTagNew:
            /// [ICC.2:2019] 9.2.99 namedColorTag
            /// Tag signature: ‘nmcl’ (6e6d636ch).
            /// Permitted tag type: tagArrayType as a namedColorArray.
            /// Named colour information is provided as a namedColorArray (see 13.2.1) defined as a tagArrayType of
            /// tintZeroStructure and namedColorStructure elements. Information related to a named colour can include PCS and
            /// as optional device representation for a list of named colours. The first element in the array shall be a tintZeroStructure
            /// which corresponds to colour values when a zero tint of any named colour is used.
            /// See 12.2.7 for a complete description of contents and usage of a tintZeroStructure. Succeeding elements shall be
            /// defined as a namedColorStructure. See 12.2.5 for a complete description of contents and usage of a
            /// namedColorStructure.
            self = .namedColorTagNew(try tagStructType(dataStream: &dataStream, size: size, header: header))
        case .profileSequenceInformationTag:
            /// [ICC.2:2019] 9.2.102 profileSequenceInformationTag
            /// Tag signature: ‘psin’ (7073696eh).
            /// Permitted tag type: tagArrayType with an array type identifier of 'pinf' (70696e66h).
            /// The profileSequenceInformationTag shall contain a profileInfoArray (see 13.2.2) which contains an array of
            /// profileInfoStructure structures that each contain information about a profile. The successive elements of the array
            /// provide a description of the successive profiles in a sequence from source to destination. The
            /// profileSequenceInformation tag is typically used with the DeviceLink profile. See 12.2.6 for a complete description
            /// of contents and usage of a profileInfoStructure.
            self = .profileSequenceInformation(try tagArrayType(dataStream: &dataStream, size: size))
        case .referenceNameTag:
            /// [ICC.2:2019] 9.2.103 referenceNameTag
            /// Tag Signature: ‘rfnm’ (72666e6dh).
            /// Tag Type: utf8Type.
            /// This text shall contain the Reference name for the three component encoding. This may correspond to the Reference
            /// Name field in the 3-component colour encoding registry on the ICC website (http://www.color.org).
            self = .referenceName(try utf8Type(dataStream: &dataStream, size: size))
        case .spectralViewingConditionsTag:
            /// [ICC.2:2019] 9.2.105 spectralViewingConditionsTag
            /// Tag signature: ‘svcn’ (7376636eh).
            /// Permitted Tag types: spectralViewingConditionsType.
            /// The reference colorimetric observer and the reference illuminant are defined in this tag. When this tag is present it
            /// describes the viewing conditions associated with both the colorimetric and spectral PCS. The content of this
            /// structure is described in 10.2.21.
            /// The colorimetric observer type and illuminant type fields of this structure provide information that shall be used for
            /// the purposes of matching viewing conditions of profiles and determining the PCS conversion transforms to use for
            /// PCS processing. The correlated colour temperature field is also used for the purposes of matching viewing conditions
            /// when the illuminant type value is “Black body defined by CCT “ (00000009h) or “Daylight defined by CCT “ (0000000Ah).
            self = .spectralViewingConditions(try spectralViewingConditionsType(dataStream: &dataStream, size: size))
        case .spectralWhitePointTag:
            /// [ICC.2:2019] 9.2.106 spectralWhitePointTag
            /// Tag signature: ‘swpt’ (73777074h).
            /// Permitted tag type: float16ArrayType, float32ArrayType, uInt16ArrayType.
            /// This tag is required when the spectral PCS is non-zero to define the PCS for the white point associated with the
            /// data in the profile. The number of entries in the array shall match the number of entries implied by the spectral
            /// PCS that is being used.
            /// This tag is used when converting absolute spectral measurement data to relative spectral measurement data or
            /// relative spectral measurement data to absolute spectral measurement data.
            self = .spectralWhitePoint(try spectralWhitePointType(dataStream: &dataStream, size: size))
        case .standardToCustomPccTag:
            /// [ICC.2:2019] 9.2.107 standardToCustomPccTag
            /// Tag signature: 's2cp' (73326370h).
            /// Permitted Tag types: multiProcessElementsType.
            /// This tag provides the transform needed to convert from the colorimetry defined by the1931 standard colorimetric
            /// observer with a D50 illuminant to the colorimetry defined by the observer and illuminant defined in the
            /// spectralViewingConditionsTag. The multiProcessElementsType structure shall define a sequence of one or more
            /// transforms that performs this conversion.
            /// The number of both the input and output channels of the transform shall be three.
            self = .standardToCustomPcc(try multiProcessElementsType(dataStream: &dataStream, size: size))
        case .surfaceMapTag:
            /// [ICC.2:2019] 9.2.108 surfaceMapTag
            /// Tag signature: ‘smap’ (736d6170h).
            /// Permitted tag type: embeddedNormalImageType or embeddedHeightImageType.
            /// This tag allows a normal map or height map to be associated with surface characteristics of all colours specified
            /// by the encapsulating profile.
            self = .surfaceMap(try embeddedNormalImageOrEmbeddedHeightImageType(dataStream: &dataStream, size: size))

        /* Private */
        case .aabg:
            /// Apple Computer 61616267 ‘aabg’ 2008-08-28 Tag
            self = .aabg(try parametricCurveType(dataStream: &dataStream, size: size))
        case .aagg:
            /// Apple Computer 61616767 ‘aagg’ 2008-08-28 Tag
            self = .aagg(try parametricCurveType(dataStream: &dataStream, size: size))
        case .aarg:
            /// Apple Computer 61617267 ‘aarg’ 2008-08-28 Tag
            self = .aarg(try parametricCurveType(dataStream: &dataStream, size: size))
        case .arts:
            /// Graham Gill 61727473 ‘arts’ 2014-09-17 Tag
            self = .arts(try s15Fixed16ArrayType(dataStream: &dataStream, size: size))
        case .cied:
            /// GretagMacbeth 43494544 ‘CIED’ 2002-10-11 Tag
            self = .cied(try textType(dataStream: &dataStream, size: size))
        case .devd:
            /// Monaco Systems Inc. 44455644 ‘DEVD’ 2003-09-17 Tag
            self = .devd(try textType(dataStream: &dataStream, size: size))
        case .dscm:
            /// Apple Computer 6473636d ‘dscm’ 2004-05-28 Tag
            self = .dscm(try multiLocalizedUnicodeType(dataStream: &dataStream, size: size))
        case .displayMakeAndModelTag:
            /// Apple Computer 6d6d6f64 ‘mmod’ 2004-05-28 Tag
            self = .displayMakeAndModel(try displayMakeAndModelType(dataStream: &dataStream, size: size))
        case .gmps:
            /// GretagMacbeth 676d7073 ‘gmps’ 2003-08-29 Tag
            self = .gmps(try dataType(dataStream: &dataStream, size: size))
        case .pmtr:
            /// GretagMacbeth 506d7472 ‘Pmtr’ 2002-10-11 Tag
            self = .pmtr(try textType(dataStream: &dataStream, size: size))
        case .videoCardGammaTableTag:
            /// Apple Computer 76636774 'vcgt' Tag
            self = .videoCardGammaTable(try videoCardGammaTableType(dataStream: &dataStream, size: size))
        }
    }
}
