//
//  ICCColorProfile+RemovedTags.swift
//  
//
//  Created by Hugh Bellamy on 08/02/2021.
//

public extension ICCColorProfile {
    var crdInfo: crdInfoType? {
        guard let tag = getTag(signature: ICCTagSignature.crdInfo) else {
            return nil
        }

        /// [ICC.1:2001-04] 6.4.14 crdInfoTag
        /// Tag Type: crdInfoType
        /// Tag signature: ‘crdi’ (63726469h)
        /// This tag contains the PostScript product name to which this profile corresponds and the names of the companion
        /// CRDs. Recall that a single profile can generate multiple CRDs.
        /// See C.1 for information about using this tag.
        if case let .crdInfo(value) = tag.data {
            return value
        }
        
        return nil
    }

    var deviceSettings: [deviceSettingsType.PlatformEntry]? {
        guard let tag = getTag(signature: ICCTagSignature.deviceSettings) else {
            return nil
        }

        /// [ICC.1:2001-04] 6.4.17 deviceSettingsTag
        /// Tag Type: deviceSettingsType
        /// Tag signature: ‘devs’ (64657673h)
        /// This tag specifies the device settings for which the profile is valid.
        /// These settings are usually specific to a platform, so they are specified for each platform separately. The profile creator
        /// decides which platforms need to be supported.
        /// The profile may be valid only for certain combination of settings like a specific media type with a specific resolution
        /// with a specific halftone. Therefore, for each platform there are groupings or combinations of settings.
        /// Under each grouping, multiple values can be specified for each setting. For example, if the profile is valid for
        /// resolutions a and b with media type c and halftone style d, then “resolution” will have two values, while the other
        /// two settings have one value each in the combination.
        /// The content of this structure is described in 6.5.6.
        if case let .deviceSettings(value) = tag.data {
            return value
        }
        
        return nil
    }

    var mediaBlackPoint: [XYZNumber]? {
        guard let tag = getTag(signature: ICCTagSignature.mediaBlackPoint) else {
            return nil
        }

        /// [ICC.1:2001-04]: 6.4.24 mediaBlackPointTag
        /// Tag Type: XYZType
        /// Tag signature: ‘bkpt’ (626B7074h)
        /// This tag specifies the media black point. It is referenced to the profile connection space so that the media
        /// black point as represented in the PCS is equivalent to this tag value. If this tag is not present, it is assumed
        /// to be (0,0,0).
        if case let .xyz(value) = tag.data {
            return value
        }
        
        return nil
    }

    var namedColor: namedColorType? {
        guard let tag = getTag(signature: ICCTagSignature.namedColor) else {
            return nil
        }

        /// [ICC.1:2010] 6.4.26 namedColorTag
        /// Tag Type: namedColorType
        /// Tag signature: ‘ncol’ (6E636F6Ch)
        /// NOTE: This tag is obsolete, and should not be used in new profiles. Use namedColor2Tag instead.
        /// Named color reference transformation for converting between named color sets and the profile connection space
        /// or device color spaces.
        if case let .namedColor(value) = tag.data {
            return value
        }
        
        return nil
    }

    var ps2CRD0: dataType? {
        guard let tag = getTag(signature: ICCTagSignature.ps2CRD0) else {
            return nil
        }

        /// [ICC.1:2001-04] 6.4.34 ps2CRD0Tag
        /// Tag Type: dataType
        /// Tag signature: ‘psd0’ (70736430h)
        /// PostScript Level 2 Type 1 color rendering dictionary (CRD) for the Perceptual rendering intent. This tag provides the
        /// dictionary operand to the setcolorrendering operator. This tag can be used in conjunction with the setcolorrendering
        /// operator on any PostScript Level 2 device.
        /// See Annex C for the relationship between the ICC profile data and PostScript Tags.
        if case let .data(value) = tag.data {
            return value
        }
        
        return nil
    }

    var ps2CRD1: dataType? {
        guard let tag = getTag(signature: ICCTagSignature.ps2CRD1) else {
            return nil
        }

        /// [ICC.1:2001-04] 6.4.35 ps2CRD1Tag
        /// Tag Type: dataType
        /// Tag signature: ‘psd1’ (70736431h)
        /// PostScript Level 2 Type 1 CRD for the media-relative Colorimetric rendering intent. This tag provides the dictionary
        /// operand to the setcolorrendering operator. This tag can be used in conjunction with the setcolorrendering operator
        /// on any PostScript Level 2 device.
        /// See Annex C for the relationship between the ICC profile data and PostScript Tags.
        if case let .data(value) = tag.data {
            return value
        }
        
        return nil
    }

    var ps2CRD2: dataType? {
        guard let tag = getTag(signature: ICCTagSignature.ps2CRD2) else {
            return nil
        }

        /// [ICC.1:2001-04] 6.4.36 ps2CRD2Tag
        /// Tag Type: dataType
        /// Tag signature: ‘psd2’ (70736432h)
        /// PostScript Level 2 Type 1 CRD for the Saturation rendering intent. This tag provides the dictionary operand to the
        /// setcolorrendering operator. This tag can be used in conjunction with the setcolorrendering operator on any
        /// PostScript Level 2 device.
        /// See Annex C for the relationship between the ICC profile data and PostScript Tags.
        if case let .data(value) = tag.data {
            return value
        }
        
        return nil
    }

    var ps2CRD3: dataType? {
        guard let tag = getTag(signature: ICCTagSignature.ps2CRD3) else {
            return nil
        }

        /// [ICC.1:2001-04] 6.4.37 ps2CRD3Tag
        /// Tag Type: dataType
        /// Tag signature: ‘psd3’ (70736433h)
        /// PostScript Level 2 Type 1 CRD for the ICC-Absolute Colorimetric rendering intent. This tag provides the dictionary
        /// operand to the setcolorrendering operator. This tag can be used in conjunction with the setcolorrendering operator
        /// on any PostScript Level 2 device.
        /// See Annex C for the relationship between the ICC profile data and PostScript Tags.
        if case let .data(value) = tag.data {
            return value
        }
        
        return nil
    }

    var ps2CSA: dataType? {
        guard let tag = getTag(signature: ICCTagSignature.ps2CSA) else {
            return nil
        }

        /// [ICC.1:2001-04] 6.4.38 ps2CSATag
        /// Tag Type: dataType
        /// Tag signature: ‘ps2s’ (70733273h)
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
        if case let .data(value) = tag.data {
            return value
        }
        
        return nil
    }

    var ps2RenderingIntent: dataType? {
        guard let tag = getTag(signature: ICCTagSignature.ps2RenderingIntent) else {
            return nil
        }

        /// [ICC.1:2001-04] 6.4.39 ps2RenderingIntentTag
        /// Tag Type: dataType
        /// Tag signature: ‘ps2i’ (70733269h)
        /// PostScript Level 2 rendering intent. This tag provides the operand to the findcolorrendering operator. findcolorrendering
        /// is not necessarily supported on all PostScript Level 2 devices, hence its existence must first be established. Standard
        /// values for ps2RenderingIntentTag are media-relative colorimetric, ICC-abso-ute colorimetric, perceptual, and
        /// saturation. These intents are meant to correspond to the rendering intents of the profile’s header.
        /// See Annex C for the relationship between the ICC profile data and PostScript Tags.
        if case let .data(value) = tag.data {
            return value
        }
        
        return nil
    }

    var screeningDesc: textDescriptionOrMultiLocalizedUnicodeTextType? {
        guard let tag = getTag(signature: ICCTagSignature.screeningDesc) else {
            return nil
        }

        /// [ICC.1:2010] 6.4.42 screeningDescTag
        /// Tag Type: textDescriptionType
        /// Tag signature: ‘scrd’ (73637264h)
        /// Structure containing invariant and localizable versions of the screening conditions. The content of this structure is
        /// described in 6.5.17.
        if case let .textDescription(value) = tag.data {
            return .textDescription(value)
        } else if case let .multiLocalizedUnicode(value) = tag.data {
            return .multiLocalizedUnicode(value)
        }
        
        return nil
    }

    var screening: screeningType? {
        guard let tag = getTag(signature: ICCTagSignature.screening) else {
            return nil
        }

        /// [ICC.1:2001-04] 6.4.43 screeningTag
        /// Tag Type: screeningType
        /// Tag signature: ‘scrn’ (7363726Eh)
        /// This tag contains screening information for a variable number of channels.
        if case let .screening(value) = tag.data {
            return value
        }
        
        return nil
    }

    var ucrBg: ucrBgType? {
        guard let tag = getTag(signature: ICCTagSignature.ucrBg) else {
            return nil
        }

        /// [ICC.1:2010] 6.4.45 ucrbgTag
        /// Tag Type: ucrbgType
        /// Tag signature: ‘bfd ’ (62666420h)
        /// Under color removal and black generation specification. This tag contains curve information for both under color
        /// removal and black generation in addition to a general description. The content of this structure is described in 6.5.20.
        /// This tag provides descriptive information only and is not involved in the processing model.
        if case let .ucrBg(value) = tag.data {
            return value
        }
        
        return nil
    }
}
