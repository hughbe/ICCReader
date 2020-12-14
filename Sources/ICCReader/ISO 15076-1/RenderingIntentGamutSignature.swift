//
//  RenderingIntentGamutSignature.swift
//  
//
//  Created by Hugh Bellamy on 13/12/2020.
//

/// [ICC.1:2010] 9.2.37 perceptualRenderingIntentGamutTag
/// Tag signature: ‘rig0’ (72696730h)
/// Permitted tag type: signatureType
/// There is only one standard reference medium gamut, as defined in ISO 12640-3. When the signature is present, the specified gamut
/// is defined to be the reference medium gamut for the PCS side of both the A2B0 and B2A0 tags, if they are present. If this tag is not
/// present, the perceptual rendering intent reference gamut is unspecified.
/// The standard PCS reference medium gamut signatures that shall be used are listed in Table 27:
/// Table 27 — Perceptual rendering intent gamut
/// PCS reference medium gamut Signature Hex encoding
/// Perceptual reference medium gamut ‘prmg’ 70726D67h
/// NOTE 1 Because the perceptual intent is the typical default rendering intent, it is most important to use the PRMG for
/// this rendering intent.
/// NOTE 2 It is possible that the ICC will define other signature values in the future.
/// [ICC.1:2010] 9.2.46 saturationRenderingIntentGamutTag
/// Tag signature: ‘rig2’ (72696732h)
/// Permitted tag type: signatureType
/// There is only one standard reference medium gamut, as defined in ISO 12640-3. When the signature is present, the specified gamut
/// is defined to be the reference medium gamut for the PCS side of both the A2B2 and B2A2 tags, if they are present. If this tag is not
/// present, the saturation rendering intent reference gamut is unspecified. The standard PCS reference medium gamut signatures that
/// shall be used are listed in Table 28.
/// NOTE It is possible that the ICC will define other signature values in the future.
public enum RenderingIntentGamutSignature: String {
    /// Perceptual reference medium gamut ‘prmg’ 70726D67h
    case perceputalReferenceMediumGamut = "prmg"
}
