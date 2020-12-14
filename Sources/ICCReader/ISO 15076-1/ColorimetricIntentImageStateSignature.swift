//
//  ColorimetricIntentImageStateSignature.swift
//  
//
//  Created by Hugh Bellamy on 12/12/2020.
//

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
public enum ColorimetricIntentImageStateSignature: String {
    /// Scene colorimetry estimates 'scoe' 73636F65h
    case sceneColorimetryEstimates = "scoe"
    
    /// Scene appearance estimates 'sape' 73617065h
    case sceneAppearanceEstimates = "sape"
    
    /// Focal plane colorimetry estimates 'fpce' 66706365h
    case focalPlaneColorimetryEstimates = "fpce"
    
    /// Reflection hardcopy original colorimetry ‘rhoc’ 72686F63h
    case reflectionHardcopyOriginalColorimetry = "rhoc"
    
    /// Reflection print output colorimetry ‘rpoc’ 72706F63h
    case reflectionPrintOutputColorimetry = "rpoc"
}
