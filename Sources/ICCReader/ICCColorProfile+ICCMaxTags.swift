//
//  ICCColorProfile+ICCMaxTags.swift
//
//
//  Created by Hugh Bellamy on 08/02/2021.
//

public extension ICCColorProfile {
    /// [ICC.2:2019] 9.2.4 AToB3Tag
    /// Tag signature: ‘A2B3’ (41324233h).
    /// Permitted tag types: lutAToBType or multiProcessElementsType.
    /// This tag describes the colour transform from Device or Colour Encoding to colorimetric-based PCS using lookup
    /// table tag element structures. For most profile classes, it defines the transform to achieve absolute colorimetric
    /// rendering (see Table 25). The processing mechanisms are described in lutAToBType or multiProcessElementsType
    /// (see 10.2.12 and 10.2.16).
    /// If this tag is not present then absolute colorimetric processing shall be performed by using the relative colorimetric
    /// AToB1Tag and then adjusting the colorimetric PCS values by the media white point.
    var aToB3: lutType? {
        guard let tag = getTag(signature: ICCTagSignature.aToB3) else {
            return nil
        }

        if case let .lutAToB(value) = tag.data {
            return .lutAToB(value)
        } else if case let .multiProcessElements(value) = tag.data {
            return .multiProcessElements(value)
        }
        
        return nil
    }

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
    var aToM0: multiProcessElementsType? {
        guard let tag = getTag(signature: ICCTagSignature.aToM0) else {
            return nil
        }

        if case let .multiProcessElements(value) = tag.data {
            return value
        }
        
        return nil
    }

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
    var brdfColorimetricParameter0: tagStructType? {
        guard let tag = getTag(signature: ICCTagSignature.brdfColorimetricParameter0) else {
            return nil
        }

        if case let .tagStruct(value) = tag.data {
            return value
        }
        
        return nil
    }

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
    var brdfColorimetricParameter1: tagStructType? {
        guard let tag = getTag(signature: ICCTagSignature.brdfColorimetricParameter1) else {
            return nil
        }

        if case let .tagStruct(value) = tag.data {
            return value
        }
        
        return nil
    }

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
    var brdfColorimetricParameter2: tagStructType? {
        guard let tag = getTag(signature: ICCTagSignature.brdfColorimetricParameter2) else {
            return nil
        }

        if case let .tagStruct(value) = tag.data {
            return value
        }
        
        return nil
    }

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
    var brdfColorimetricParameter3: tagStructType? {
        guard let tag = getTag(signature: ICCTagSignature.brdfColorimetricParameter3) else {
            return nil
        }

        if case let .tagStruct(value) = tag.data {
            return value
        }
        
        return nil
    }

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
    var brdfSpectralParameter0: tagStructType? {
        guard let tag = getTag(signature: ICCTagSignature.brdfSpectralParameter0) else {
            return nil
        }

        if case let .tagStruct(value) = tag.data {
            return value
        }
        
        return nil
    }

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
    var brdfSpectralParameter1: tagStructType? {
        guard let tag = getTag(signature: ICCTagSignature.brdfSpectralParameter1) else {
            return nil
        }

        if case let .tagStruct(value) = tag.data {
            return value
        }
        
        return nil
    }

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
    var brdfSpectralParameter2: tagStructType? {
        guard let tag = getTag(signature: ICCTagSignature.brdfSpectralParameter2) else {
            return nil
        }

        if case let .tagStruct(value) = tag.data {
            return value
        }
        
        return nil
    }

    /// [ICC.2:2019] 9.2.13 brdfSpectralParameter3Tag
    /// Tag signature: ‘bsp3’ (62737033h).
    /// Permitted tag types: tagStructType of type brdfTransformStructure.
    /// For the transform subtag of this structure, the number of input channels shall be the same as the number of
    /// channels implied by the colorSpace signature in the profile header.
    /// The number of output channels of the subtag transform depends on the type of BRDF model. For monochrome type
    /// models the output of the transform subtag shall be the number of parameters defined by the BRDF model type.
    /// For chromatic type models the number of output values shall be the number of parameters defined by the BRDF
    /// model type multiplied by the number of channels implied by the spectral PCS signature in the profile header.
    var brdfSpectralParameter3: tagStructType? {
        guard let tag = getTag(signature: ICCTagSignature.brdfSpectralParameter3) else {
            return nil
        }

        if case let .tagStruct(value) = tag.data {
            return value
        }
        
        return nil
    }

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
    var brdfAToB0: multiProcessElementsType? {
        guard let tag = getTag(signature: ICCTagSignature.brdfAToB0) else {
            return nil
        }

        if case let .multiProcessElements(value) = tag.data {
            return value
        }
        
        return nil
    }

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
    var brdfAToB1: multiProcessElementsType? {
        guard let tag = getTag(signature: ICCTagSignature.brdfAToB1) else {
            return nil
        }

        if case let .multiProcessElements(value) = tag.data {
            return value
        }
        
        return nil
    }

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
    var brdfAToB2: multiProcessElementsType? {
        guard let tag = getTag(signature: ICCTagSignature.brdfAToB2) else {
            return nil
        }

        if case let .multiProcessElements(value) = tag.data {
            return value
        }
        
        return nil
    }

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
    var brdfAToB3: multiProcessElementsType? {
        guard let tag = getTag(signature: ICCTagSignature.brdfAToB3) else {
            return nil
        }

        if case let .multiProcessElements(value) = tag.data {
            return value
        }
        
        return nil
    }

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
    var brdfBToA0: multiProcessElementsType? {
        guard let tag = getTag(signature: ICCTagSignature.brdfBToA0) else {
            return nil
        }

        if case let .multiProcessElements(value) = tag.data {
            return value
        }
        
        return nil
    }

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
    var brdfBToA1: multiProcessElementsType? {
        guard let tag = getTag(signature: ICCTagSignature.brdfBToA1) else {
            return nil
        }

        if case let .multiProcessElements(value) = tag.data {
            return value
        }
        
        return nil
    }

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
    var brdfBToA2: multiProcessElementsType? {
        guard let tag = getTag(signature: ICCTagSignature.brdfBToA2) else {
            return nil
        }

        if case let .multiProcessElements(value) = tag.data {
            return value
        }
        
        return nil
    }

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
    var brdfBToA3: multiProcessElementsType? {
        guard let tag = getTag(signature: ICCTagSignature.brdfBToA3) else {
            return nil
        }

        if case let .multiProcessElements(value) = tag.data {
            return value
        }
        
        return nil
    }

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
    var brdfBToD0: multiProcessElementsType? {
        guard let tag = getTag(signature: ICCTagSignature.brdfBToD0) else {
            return nil
        }

        if case let .multiProcessElements(value) = tag.data {
            return value
        }
        
        return nil
    }

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
    var brdfBToD1: multiProcessElementsType? {
        guard let tag = getTag(signature: ICCTagSignature.brdfBToD1) else {
            return nil
        }

        if case let .multiProcessElements(value) = tag.data {
            return value
        }
        
        return nil
    }

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
    var brdfBToD2: multiProcessElementsType? {
        guard let tag = getTag(signature: ICCTagSignature.brdfBToD2) else {
            return nil
        }

        if case let .multiProcessElements(value) = tag.data {
            return value
        }
        
        return nil
    }

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
    var brdfBToD3: multiProcessElementsType? {
        guard let tag = getTag(signature: ICCTagSignature.brdfBToD3) else {
            return nil
        }

        if case let .multiProcessElements(value) = tag.data {
            return value
        }
        
        return nil
    }

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
    var brdfDToB0: multiProcessElementsType? {
        guard let tag = getTag(signature: ICCTagSignature.brdfDToB0) else {
            return nil
        }

        if case let .multiProcessElements(value) = tag.data {
            return value
        }
        
        return nil
    }

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
    var brdfDToB1: multiProcessElementsType? {
        guard let tag = getTag(signature: ICCTagSignature.brdfDToB1) else {
            return nil
        }

        if case let .multiProcessElements(value) = tag.data {
            return value
        }
        
        return nil
    }

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
    var brdfDToB2: multiProcessElementsType? {
        guard let tag = getTag(signature: ICCTagSignature.brdfDToB2) else {
            return nil
        }

        if case let .multiProcessElements(value) = tag.data {
            return value
        }
        
        return nil
    }

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
    var brdfDToB3: multiProcessElementsType? {
        guard let tag = getTag(signature: ICCTagSignature.brdfDToB3) else {
            return nil
        }

        if case let .multiProcessElements(value) = tag.data {
            return value
        }
        
        return nil
    }

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
    var brdfMToB0: tagStructType? {
        guard let tag = getTag(signature: ICCTagSignature.brdfMToB0) else {
            return nil
        }

        if case let .tagStruct(value) = tag.data {
            return value
        }
        
        return nil
    }

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
    var brdfMToB1: tagStructType? {
        guard let tag = getTag(signature: ICCTagSignature.brdfMToB1) else {
            return nil
        }

        if case let .tagStruct(value) = tag.data {
            return value
        }
        
        return nil
    }

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
    var brdfMToB2: tagStructType? {
        guard let tag = getTag(signature: ICCTagSignature.brdfMToB2) else {
            return nil
        }

        if case let .tagStruct(value) = tag.data {
            return value
        }
        
        return nil
    }

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
    var brdfMToB3: tagStructType? {
        guard let tag = getTag(signature: ICCTagSignature.brdfMToB3) else {
            return nil
        }

        if case let .tagStruct(value) = tag.data {
            return value
        }
        
        return nil
    }

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
    var brdfMToS0: tagStructType? {
        guard let tag = getTag(signature: ICCTagSignature.brdfMToS0) else {
            return nil
        }

        if case let .tagStruct(value) = tag.data {
            return value
        }
        
        return nil
    }

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
    var brdfMToS1: tagStructType? {
        guard let tag = getTag(signature: ICCTagSignature.brdfMToS1) else {
            return nil
        }

        if case let .tagStruct(value) = tag.data {
            return value
        }
        
        return nil
    }

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
    var brdfMToS2: tagStructType? {
        guard let tag = getTag(signature: ICCTagSignature.brdfMToS2) else {
            return nil
        }

        if case let .tagStruct(value) = tag.data {
            return value
        }
        
        return nil
    }

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
    var brdfMToS3: tagStructType? {
        guard let tag = getTag(signature: ICCTagSignature.brdfMToS3) else {
            return nil
        }

        if case let .tagStruct(value) = tag.data {
            return value
        }
        
        return nil
    }

    var bToA3: lutType? {
        guard let tag = getTag(signature: ICCTagSignature.bToA3) else {
            return nil
        }

        /// [ICC.2:2019] 9.2.41 BToA3Tag
        /// Tag signature: ‘B2A3’ (42324133h).
        /// Permitted tag types: lutBToAType or multiProcessElementsType.
        /// This tag defines a colour transform from a colorimetric-based PCS to Device or Colour Encoding using the lookup
        /// table tag element structures or multiProcessElementsType transforms. For most profile classes, it defines the
        /// transform to achieve absolute colorimetric rendering (see Table 29). The processing mechanisms are described in
        /// lutBToAType or multiProcessElementsType (see 10.2.13 and 10.2.16).
        /// If this tag is not present then absolute colorimetric processing shall be performed by adjusting the colorimetric
        /// PCS values by the media white point and then using the relative colorimetric BToA1Tag.
        if case let .lutBToA(value) = tag.data {
            return .lutBToA(value)
        } else if case let .multiProcessElements(value) = tag.data {
            return .multiProcessElements(value)
        }
        
        return nil
    }

    var colorEncodingParams: tagStructType? {
        guard let tag = getTag(signature: ICCTagSignature.colorEncodingParams) else {
            return nil
        }

        /// [ICC.2:2019] 9.2.48 colorEncodingParamsTag
        /// Tag signature: ‘cept’ (63657074h).
        /// Tag Type: tagStructType of type colorEncodingParamsStructure.
        /// The colorEncodingParamsTag is defined using a colorEncodingParamsStructure. Element members in this structure
        /// are assumed to be overrides of parameters assumed by the encoding reference name.
        if case let .tagStruct(value) = tag.data {
            return value
        }
        
        return nil
    }

    var colorSpaceName: String? {
        guard let tag = getTag(signature: ICCTagSignature.colorSpaceName) else {
            return nil
        }

        /// [ICC.2:2019] 9.2.49 colorSpaceNameTag
        /// Tag signature: 'csnm' (63736e6dh).
        /// Tag Type: utf8Type.
        /// This tag defines the reference name for the three component colour encoding when the profile uniquely defines all
        /// the necessary parameters for the encoding. This occurs when the referenceNameTag solely contains the text
        /// “ISO 22028-1” (quotes excluded).
        /// If the referenceNameTag does not solely contain the text “ISO 22028-1” then the colorSpaceNameTag shall contain
        /// the same text as the referenceNameTag (if the profile is present).
        if case let .utf8(value) = tag.data {
            return value
        }
        
        return nil
    }

    var colorantInfo: tagArrayTypeOrLutType? {
        guard let tag = getTag(signature: ICCTagSignature.colorantInfo) else {
            return nil
        }

        /// [ICC.2:2019] 9.2.52 colorantInfoTag
        /// Tag signature: 'clin' (636c696eh).
        /// Permitted tag type: tagArrayType with an array type identifier of ‘cinf’ (63696e66h).
        /// This tag identifies the colorants associated with the data colour space field header (see 7.2.8) when the data colour
        /// space field is either an xCLR where x is a hexadecimal value from 1 to F, or has a signature representation of
        /// “ncXXXX” where X is a hexadecimal value from 1 to FFFF. The colorant information is provided as an array of
        /// colorantInfoStructure elements. Each colorantInfoStructure entry provides a name for the colorant and optionally
        /// colorimetric or spectral information. See 12.2.2 for a complete description of contents and usage of a
        /// colorantInfoStructure.
        if case let .tagArray(value) = tag.data {
            return .tagArray(value)
        } else if case let .lut8(value) = tag.data {
            return .lut(.lut8(value))
        }
        
        return nil
    }

    var colorantInfoOut: tagArrayTypeOrLutType? {
        guard let tag = getTag(signature: ICCTagSignature.colorantInfoOut) else {
            return nil
        }

        /// [ICC.2:2019] 9.2.53 colorantInfoOutTag
        /// Tag signature: ‘clio’ (636C696fh).
        /// Permitted tag type: tagArrayType with an array type identifier of ‘cinf’ (63696e66h).
        /// This tag identifies the colorants associated with the PCS colour space field header (see 7.2.8) when the PCS colour
        /// space field is either an xCLR where x is a hexadecimal value from 1 to F, or has a signature representation of
        /// “ncXXXX” where X is a hexadecimal value from 1 to FFFF. The colorant information is provided as an array of
        /// colorantInfoStructure elements. Each colorantInfoStructure entry provides a name for the colorant and optionally
        /// colorimetric and/or spectral information. See 12.2.2 for a complete description of contents and usage of a colorantInfoStructure.
        /// This tag is used for DeviceLink profiles only.
        if case let .tagArray(value) = tag.data {
            return .tagArray(value)
        } else if case let .lut8(value) = tag.data {
            return .lut(.lut8(value))
        }
        
        return nil
    }

    var customToStandardPcc: multiProcessElementsType? {
        guard let tag = getTag(signature: ICCTagSignature.customToStandardPcc) else {
            return nil
        }

        /// [ICC.2:2019] 9.2.56 customToStandardPccTag
        /// Tag signature: 'c2sp' (63327370h).
        /// Permitted Tag types: multiProcessElementsType.
        /// This tag provides the transform needed to convert from the colorimetry defined by the observer and illuminant
        /// defined in the spectralViewingConditionsTag to the colorimetry defined by the CIE 1931 Standard Colorimetric
        /// Observer with a D50 illuminant. The multiProcessElementsType structure shall define a sequence of one or more
        /// transforms that performs this conversion.
        /// The number of both the input and output channels of the transform shall be three.
        if case let .multiProcessElements(value) = tag.data {
            return value
        }
        
        return nil
    }

    var cxf: utf8OrUtf8ZipType? {
        guard let tag = getTag(signature: ICCTagSignature.cxf) else {
            return nil
        }

        /// [ICC.2:2019] 9.2.57 cxfTag
        /// Tag signature: ‘CxF ’ (43784620).
        /// Permitted tag type: utf8Type, utf8ZipType.
        /// This tag contains a Color Exchange Format file. The CxF/X file contains the characterization target and corresponding
        /// measurement data. The CxF/X file is an XML document and shall be encoded as specified by ISO 17972-1. The
        /// CxF/X specification requires that UTF-8 be used.
        /// The cxfTag shall contain the characterization set and measurement data used to create the profile. The tag may
        /// contain any other data that conforms to the CxF/X specification.
        if case let .utf8(value) = tag.data {
            return .utf8(value)
        } else if case let .utf8Zip(value) = tag.data {
            return .utf8Zip(value)
        }
        
        return nil
    }

    var directionalAToB0: multiProcessElementsType? {
        guard let tag = getTag(signature: ICCTagSignature.directionalAToB0) else {
            return nil
        }

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
        if case let .multiProcessElements(value) = tag.data {
            return value
        }
        
        return nil
    }

    var directionalAToB1: multiProcessElementsType? {
        guard let tag = getTag(signature: ICCTagSignature.directionalAToB1) else {
            return nil
        }

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
        if case let .multiProcessElements(value) = tag.data {
            return value
        }
        
        return nil
    }

    var directionalAToB2: multiProcessElementsType? {
        guard let tag = getTag(signature: ICCTagSignature.directionalAToB2) else {
            return nil
        }

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
        if case let .multiProcessElements(value) = tag.data {
            return value
        }
        
        return nil
    }

    var directionalAToB3: multiProcessElementsType? {
        guard let tag = getTag(signature: ICCTagSignature.directionalAToB3) else {
            return nil
        }

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
        if case let .multiProcessElements(value) = tag.data {
            return value
        }
        
        return nil
    }

    var directionalBToA0: multiProcessElementsType? {
        guard let tag = getTag(signature: ICCTagSignature.directionalBToA0) else {
            return nil
        }

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
        if case let .multiProcessElements(value) = tag.data {
            return value
        }
        
        return nil
    }

    var directionalBToA1: multiProcessElementsType? {
        guard let tag = getTag(signature: ICCTagSignature.directionalBToA1) else {
            return nil
        }

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
        if case let .multiProcessElements(value) = tag.data {
            return value
        }
        
        return nil
    }

    var directionalBToA2: multiProcessElementsType? {
        guard let tag = getTag(signature: ICCTagSignature.directionalBToA2) else {
            return nil
        }

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
        if case let .multiProcessElements(value) = tag.data {
            return value
        }
        
        return nil
    }

    var directionalBToA3: multiProcessElementsType? {
        guard let tag = getTag(signature: ICCTagSignature.directionalBToA3) else {
            return nil
        }

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
        if case let .multiProcessElements(value) = tag.data {
            return value
        }
        
        return nil
    }

    var directionalBToD0: multiProcessElementsType? {
        guard let tag = getTag(signature: ICCTagSignature.directionalBToD0) else {
            return nil
        }

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
        if case let .multiProcessElements(value) = tag.data {
            return value
        }
        
        return nil
    }

    var directionalBToD1: multiProcessElementsType? {
        guard let tag = getTag(signature: ICCTagSignature.directionalBToD1) else {
            return nil
        }

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
        if case let .multiProcessElements(value) = tag.data {
            return value
        }
        
        return nil
    }

    var directionalBToD2: multiProcessElementsType? {
        guard let tag = getTag(signature: ICCTagSignature.directionalBToD2) else {
            return nil
        }

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
        if case let .multiProcessElements(value) = tag.data {
            return value
        }
        
        return nil
    }

    var directionalBToD3: multiProcessElementsType? {
        guard let tag = getTag(signature: ICCTagSignature.directionalBToD3) else {
            return nil
        }

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
        if case let .multiProcessElements(value) = tag.data {
            return value
        }
        
        return nil
    }

    var directionalDToB0: multiProcessElementsType? {
        guard let tag = getTag(signature: ICCTagSignature.directionalDToB0) else {
            return nil
        }

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
        if case let .multiProcessElements(value) = tag.data {
            return value
        }
        
        return nil
    }

    var directionalDToB1: multiProcessElementsType? {
        guard let tag = getTag(signature: ICCTagSignature.directionalDToB1) else {
            return nil
        }

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
        if case let .multiProcessElements(value) = tag.data {
            return value
        }
        
        return nil
    }

    var directionalDToB2: multiProcessElementsType? {
        guard let tag = getTag(signature: ICCTagSignature.directionalDToB2) else {
            return nil
        }

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
        if case let .multiProcessElements(value) = tag.data {
            return value
        }
        
        return nil
    }

    var directionalDToB3: multiProcessElementsType? {
        guard let tag = getTag(signature: ICCTagSignature.directionalDToB3) else {
            return nil
        }

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
        if case let .multiProcessElements(value) = tag.data {
            return value
        }
        
        return nil
    }

    var gamutBoundaryDescription0: gamutBoundaryDescriptionType? {
        guard let tag = getTag(signature: ICCTagSignature.gamutBoundaryDescription0) else {
            return nil
        }

        /// [ICC.2:2019] 9.2.80 gamutBoundaryDescription0Tag
        /// Tag signature: ‘gbd0’ (67626430h).
        /// Permitted tag types: gamutBoundaryDescriptionType.
        /// This tag defines the gamut boundary of the reference medium gamut that was used for the creation of the perceptual
        /// transform.
        if case let .gamutBoundaryDescription(value) = tag.data {
            return value
        }
        
        return nil
    }

    var gamutBoundaryDescription1: gamutBoundaryDescriptionType? {
        guard let tag = getTag(signature: ICCTagSignature.gamutBoundaryDescription1) else {
            return nil
        }

        /// [ICC.2:2019] 9.2.81 gamutBoundaryDescription1Tag
        /// Tag signature: ‘gbd1’ (67626431h).
        /// Permitted tag types: gamutBoundaryDescriptionType.
        /// This tag defines the gamut boundary for the relative colorimetric transform.
        if case let .gamutBoundaryDescription(value) = tag.data {
            return value
        }
        
        return nil
    }

    var gamutBoundaryDescription2: gamutBoundaryDescriptionType? {
        guard let tag = getTag(signature: ICCTagSignature.gamutBoundaryDescription2) else {
            return nil
        }

        /// [ICC.2:2019] 9.2.82 gamutBoundaryDescription2Tag
        /// Tag signature: ‘gbd2’ (67626432h).
        /// Permitted tag types: gamutBoundaryDescriptionType.
        /// This tag defines the gamut boundary for the saturation intent transform.
        if case let .gamutBoundaryDescription(value) = tag.data {
            return value
        }
        
        return nil
    }

    /// [ICC.2:2019] 9.2.83 gamutBoundaryDescription3Tag
    /// Tag signature: ‘gbd3’ (67626433h).
    /// Permitted tag types: gamutBoundaryDescriptionType.
    /// This tag defines the gamut boundary for the absolute colorimetric intent transform. The presence of the DToB3 or
    /// BToD3 tags may require a gamut boundary description that is different from gamutBoundaryDescription1Tag
    var gamutBoundaryDescription3: gamutBoundaryDescriptionType? {
        guard let tag = getTag(signature: ICCTagSignature.gamutBoundaryDescription3) else {
            return nil
        }

        if case let .gamutBoundaryDescription(value) = tag.data {
            return value
        }
        
        return nil
    }

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
    var multiplexDefaultValues: multiplexDefaultValuesType? {
        guard let tag = getTag(signature: ICCTagSignature.multiplexDefaultValues) else {
            return nil
        }

        if case let .uInt8Array(value) = tag.data {
            return .uInt8Array(value)
        } else if case let .uInt16Array(value) = tag.data {
            return .uInt16Array(value)
        } else if case let .float16Array(value) = tag.data {
            return .float16Array(value)
        } else if case let .float32Array(value) = tag.data {
            return .float32Array(value)
        }
        
        return nil
    }

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
    var multiplexTypeArray: tagArrayType? {
        guard let tag = getTag(signature: ICCTagSignature.multiplexTypeArray) else {
            return nil
        }

        if case let .tagArray(value) = tag.data {
            return value
        }
        
        return nil
    }

    /// [ICC.2:2019] 9.2.86 measurementInfoTag
    /// Tag signature: ‘minf’ (6d696e66h).
    /// Permitted tag type: tagStructType of type measurementInfo.
    /// This tag defines measurement conditions for the colorimetric and/or spectral PCS (defined by PCS or spectralPCS
    /// fields of the profile header respectively). If this tag is not present the measurement conditions shall be assumed to
    /// have white backing, zero flare, 0°:45° geometry, using M1 illumination (ISO 13655).
    /// NOTE Unless otherwise specified, this tag is informative only with no CMM processing associated with the contents
    /// of this tag
    var measurementInfo: tagStructType? {
        guard let tag = getTag(signature: ICCTagSignature.measurementInfo) else {
            return nil
        }

        if case let .tagStruct(value) = tag.data {
            return value
        }
        
        return nil
    }

    /// [ICC.2:2019] 9.2.87 measurementInputInfoTag
    /// Tag signature: ‘miin’ (6d69696eh).
    /// Permitted tag type: tagStructType of type measurementInfo.
    /// This tag defines measurement information for measurements related to values on input side of abstract profiles
    /// (defined by device field of the profile header). This tag may therefore only be present if the profile is an abstract profile.
    /// If this tag is not present the measurement conditions shall be assumed to have white backing, zero flare, 0°:45°
    /// geometry, using M1 illumination (ISO 13655).
    /// NOTE Unless otherwise specified, this tag is informative only with no CMM processing associated with the contents
    /// of this tag
    var measurementInputInfo: tagStructType? {
        guard let tag = getTag(signature: ICCTagSignature.measurementInputInfo) else {
            return nil
        }

        if case let .tagStruct(value) = tag.data {
            return value
        }
        
        return nil
    }

    /// [ICC.2:2019] 9.2.89 metadataTag
    /// Tag signature: ‘meta’ (6d657461h).
    /// Permitted tag type: dictType.
    /// This tag contains a set of metadata items for the profile.
    /// The names and values in the set shall be taken from the ICC metadata registry, available on the ICC website
    /// (http://www.color.org). Display elements should be taken from the metadata registry, as this provides
    /// common localizations.
    var metadata: dictType? {
        guard let tag = getTag(signature: ICCTagSignature.metadata) else {
            return nil
        }

        if case let .dict(value) = tag.data {
            return value
        }
        
        return nil
    }

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
    var mToA0: multiProcessElementsType? {
        guard let tag = getTag(signature: ICCTagSignature.mToA0) else {
            return nil
        }

        if case let .multiProcessElements(value) = tag.data {
            return value
        }
        
        return nil
    }
    
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
    var mToB0: multiProcessElementsType? {
        guard let tag = getTag(signature: ICCTagSignature.mToB0) else {
            return nil
        }

        if case let .multiProcessElements(value) = tag.data {
            return value
        }
        
        return nil
    }

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
    var mToB1: multiProcessElementsType? {
        guard let tag = getTag(signature: ICCTagSignature.mToB1) else {
            return nil
        }

        if case let .multiProcessElements(value) = tag.data {
            return value
        }
        
        return nil
    }

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
    var mToB2: multiProcessElementsType? {
        guard let tag = getTag(signature: ICCTagSignature.mToB2) else {
            return nil
        }

        if case let .multiProcessElements(value) = tag.data {
            return value
        }
        
        return nil
    }

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
    var mToB3: multiProcessElementsType? {
        guard let tag = getTag(signature: ICCTagSignature.mToB3) else {
            return nil
        }

        if case let .multiProcessElements(value) = tag.data {
            return value
        }
        
        return nil
    }

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
    var mToS0: multiProcessElementsType? {
        guard let tag = getTag(signature: ICCTagSignature.mToS0) else {
            return nil
        }

        if case let .multiProcessElements(value) = tag.data {
            return value
        }
        
        return nil
    }

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
    var mToS1: multiProcessElementsType? {
        guard let tag = getTag(signature: ICCTagSignature.mToS1) else {
            return nil
        }

        if case let .multiProcessElements(value) = tag.data {
            return value
        }
        
        return nil
    }

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
    var mToS2: multiProcessElementsType? {
        guard let tag = getTag(signature: ICCTagSignature.mToS2) else {
            return nil
        }

        if case let .multiProcessElements(value) = tag.data {
            return value
        }
        
        return nil
    }

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
    var mToS3: multiProcessElementsType? {
        guard let tag = getTag(signature: ICCTagSignature.mToS3) else {
            return nil
        }

        if case let .multiProcessElements(value) = tag.data {
            return value
        }
        
        return nil
    }

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
    var namedColorTagNew: tagArrayType? {
        guard let tag = getTag(signature: ICCTagSignature.namedColorTagNew) else {
            return nil
        }

        if case let .tagArray(value) = tag.data {
            return value
        }
        
        return nil
    }

    /// [ICC.2:2019] 9.2.102 profileSequenceInformationTag
    /// Tag signature: ‘psin’ (7073696eh).
    /// Permitted tag type: tagArrayType with an array type identifier of 'pinf' (70696e66h).
    /// The profileSequenceInformationTag shall contain a profileInfoArray (see 13.2.2) which contains an array of
    /// profileInfoStructure structures that each contain information about a profile. The successive elements of the array
    /// provide a description of the successive profiles in a sequence from source to destination. The
    /// profileSequenceInformation tag is typically used with the DeviceLink profile. See 12.2.6 for a complete description
    /// of contents and usage of a profileInfoStructure.
    var profileSequenceInformation: tagArrayType? {
        guard let tag = getTag(signature: ICCTagSignature.profileSequenceInformation) else {
            return nil
        }

        if case let .tagArray(value) = tag.data {
            return value
        }
        
        return nil
    }

    /// [ICC.2:2019] 9.2.103 referenceNameTag
    /// Tag signature: ‘rfnm’ (72666e6dh).
    /// Tag Type: utf8Type.
    /// This text shall contain the Reference name for the three component encoding. This may correspond to the Reference
    /// Name field in the 3-component colour encoding registry on the ICC website (http://www.color.org).
    var referenceName: String? {
        guard let tag = getTag(signature: ICCTagSignature.referenceName) else {
            return nil
        }

        if case let .utf8(value) = tag.data {
            return value
        }
        
        return nil
    }

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
    var spectralViewingConditions: spectralViewingConditionsType? {
        guard let tag = getTag(signature: ICCTagSignature.spectralViewingConditions) else {
            return nil
        }

        if case let .spectralViewingConditions(value) = tag.data {
            return value
        }
        
        return nil
    }

    /// [ICC.2:2019] 9.2.106 spectralWhitePointTag
    /// Tag signature: ‘swpt’ (73777074h).
    /// Permitted tag type: float16ArrayType, float32ArrayType, uInt16ArrayType.
    /// This tag is required when the spectral PCS is non-zero to define the PCS for the white point associated with the
    /// data in the profile. The number of entries in the array shall match the number of entries implied by the spectral
    /// PCS that is being used.
    /// This tag is used when converting absolute spectral measurement data to relative spectral measurement data or
    /// relative spectral measurement data to absolute spectral measurement data.
    var spectralWhitePoint: spectralWhitePointType? {
        guard let tag = getTag(signature: ICCTagSignature.spectralWhitePoint) else {
            return nil
        }

        if case let .float16Array(value) = tag.data {
            return .float16Array(value)
        } else if case let .float16Array(value) = tag.data {
            return .float16Array(value)
        } else if case let .uInt16Array(value) = tag.data {
            return .uInt16Array(value)
        }
        
        return nil
    }
    
    /// [ICC.2:2019] 9.2.107 standardToCustomPccTag
    /// Tag signature: 's2cp' (73326370h).
    /// Permitted Tag types: multiProcessElementsType.
    /// This tag provides the transform needed to convert from the colorimetry defined by the1931 standard colorimetric
    /// observer with a D50 illuminant to the colorimetry defined by the observer and illuminant defined in the
    /// spectralViewingConditionsTag. The multiProcessElementsType structure shall define a sequence of one or more
    /// transforms that performs this conversion.
    /// The number of both the input and output channels of the transform shall be three.
    var standardToCustomPcc: multiProcessElementsType? {
        guard let tag = getTag(signature: ICCTagSignature.standardToCustomPcc) else {
            return nil
        }

        if case let .multiProcessElements(value) = tag.data {
            return value
        }
        
        return nil
    }
    
    /// [ICC.2:2019] 9.2.108 surfaceMapTag
    /// Tag signature: ‘smap’ (736d6170h).
    /// Permitted tag type: embeddedNormalImageType or embeddedHeightImageType.
    /// This tag allows a normal map or height map to be associated with surface characteristics of all colours specified
    /// by the encapsulating profile.
    var surfaceMap: embeddedNormalImageOrEmbeddedHeightImageType? {
        guard let tag = getTag(signature: ICCTagSignature.surfaceMap) else {
            return nil
        }

        if case let .embeddedNormalImage(value) = tag.data {
            return .embeddedNormalImage(value)
        } else if case let .embeddedHeightImage(value) = tag.data {
            return .embeddedHeightImage(value)
        }
        
        return nil
    }
}
