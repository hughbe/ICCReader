//
//  ICCColorProfileHeader.swift
//  
//
//  Created by Hugh Bellamy on 10/12/2020.
//

import DataStream

/// [ICC.2:2019] 7.2 Profile header
/// [ICC.2:2019] 7.2.1 General
/// ISO 15076-1 defines a single header specification for defining ICC profiles. ISO 20677 extends the use of the ICC header in two
/// ways. For spectral PCS support additional entries have been defined. For ColorEncodingSpace profile device class profiles a
/// minimal subset of header field entries is defined.
/// [ICC.2:2019] 7.2.2 Extended profile header field definitions
/// The encoding of the profile header with spectral PCS support shall be as shown in Table 12.
/// A spectral-only profile shall be defined by setting the PCS header field to zero, setting the spectral PCS field to the desired spectral
/// colour space, and only providing spectral DToBx and BToDx tables in the profile.
/// [ICC.2:2019] 7.2.3 ColourEncodingSpace class profile header field definitions
/// A ColourEncodingSpace class profile shall use only the ICC header fields defined in Table 13 with the other fields either set according
/// to ISO 15076-1 or optionally zero filled.
public struct ICCColorProfileHeader {
    public let size: UInt32
    public let cmm: ICCSignature
    public let version: ICCColorProfileVersion
    public let `class`: ICCSignature
    public let colorSpace: ICCSignature
    public let pcs: ICCSignature
    public let date: dateTimeNumber
    public let magic: ICCSignature
    public let platform: ICCSignature
    public let flags: ICCColorProfileFlags
    public let manufacturer: ICCSignature
    public let model: ICCSignature
    public let attributes: ICCColorProfileDeviceAttributes
    public let renderingIntent: ICCColorProfileRenderingIntent
    public let pcsIlluminant: XYZNumber
    public let creator: ICCSignature
    public let profileID: (UInt64, UInt64)
    public let spectralPcs: SpectralProfileClassSignature
    public let spectralPcsWavelengthRange: spectralRange
    public let biSpectralPcsWavelengthRange: spectralRange
    public let multiplexColorSpace: MultiplexColorSpaceSignature
    public let deviceSubClass: ICCSignature
    public let reserved: [UInt8]
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// 0 to 3 4 Profile size uInt32Number; See 7.2.4
        self.size = try dataStream.read(endianess: .bigEndian)
        
        /// 4 to 7 4 Preferred CMM type 4-byte signature; see 7.2.5
        /// 7.2.5 Preferred CMM type field (bytes 4 to 7)
        /// This field may be used to identify the preferred CMM to be used. If used, it shall match a CMM type signature registered in
        /// the ICC CMM registry. If no preferred CMM is identified, this field shall be zero (00000000h).
        self.cmm = try ICCSignature(dataStream: &dataStream)
        
        /// 8 to 11 4 Profile version and sub-version number uInt32Number; see 7.2.6
        self.version = try ICCColorProfileVersion(dataStream: &dataStream)
        
        /// 12 to 15 4 Profile/device class 4-byte signature; see 7.2.7
        self.`class` = try ICCSignature(dataStream: &dataStream)
        
        /// 16 to 19 4 Colour space of data (possibly a derived space) 4-byte signature; see
        self.colorSpace = try ICCSignature(dataStream: &dataStream)
        
        /// 20 to 23 4 PCS 4-byte signature; see 7.2.9
        /// 7.2.9 PCS field (Bytes 20 to 23)
        /// For all profile classes (see Table 14), other than a DeviceLink or MultiplexLink profile, the PCS encoding shall be one of
        /// the signatures as defined in Table 16. When the profile/device class is a DeviceLink profile or MultiplexLink, the value of
        /// the PCS shall be the appropriate data colour space from Table 15. The field represents the colour space on the B-side
        /// of the transform.
        /// The PCS for AToBx/BToAx tags shall always be defined by the PCS field.
        /// To define the use of a colorimetric-based PCS one of the non-spectral colour space signatures in Table 16 shall be used
        /// to encode the colour space implied by the PCS field of the profile header. These colour space signatures define both the
        /// colour space type and the number of channels associated with the colour space.
        /// Table 16 — Non-spectral PCS colour space signatures
        /// Colour space type signature Hexidecimal encoding
        /// nCIEXYZ or PCSXYZa ‘XYZ ’ 58595A20h
        /// CIELAB or PCSLABb ‘Lab ’ 4C616220h
        /// None (spectral PCS defined by spectral PCS header field) 0 00000000h
        /// a The Signature 'XYZ ' refers to nCIEXYZ or PCSXYZ, depending upon the context.
        /// b The Signature 'Lab' refers to CIELAB or PCSLAB, depending upon the context.
        /// Channel encoding order shall be associated with the order that channel names are identified in the signature.
        self.pcs = try ICCSignature(dataStream: &dataStream)
        
        /// 24 to 35 12 Date and time this profile was first created dateTimeNumber; see 7.2.10
        /// 7.2.10 Date and time field (bytes 24 to 35)
        /// This header field shall contain the date and time that the profile was first created, encoded as a dateTimeNumber.
        self.date = try dateTimeNumber(dataStream: &dataStream)
        
        /// 36 to 39 4 ‘acsp’ (61637370h) profile file Signature 4-byte signature; see 7.2.11
        /// 7.2.11 Profile file Signature field (bytes 36 to 39)
        /// The profile file Signature field shall contain the value ‘acsp’ (61637379h) as a profile file Signature.
        self.magic = try ICCSignature(dataStream: &dataStream)
        guard self.magic == "acsp" else {
            throw ICCReadError.corrupted
        }
        
        /// 40 to 43 4 Primary platform Signature 4-byte signature; see 7.2.12
        self.platform = try ICCSignature(dataStream: &dataStream)
        
        /// 44 to 47 4 Profile flags to indicate various options for the CMM such as distributed processing and caching options
        /// uInt32Number; see 7.2.13
        self.flags = try ICCColorProfileFlags(dataStream: &dataStream)
        
        /// 48 to 51 4 Device manufacturer of the device for which this profile is created 4-byte signature; see 7.2.14
        /// 7.2.14 Device manufacturer field (bytes 48 to 51)
        /// This field may be used to identify a device manufacturer. If used, the signature shall match the signature contained in the
        /// appropriate section of the ICC Signature registry at http://www.color.org (see Clause 5).
        /// If not used, this field shall be zero (00000000h).
        self.manufacturer = try ICCSignature(dataStream: &dataStream)
        
        /// 52 to 55 4 Device model of the device for which this profile is created 4-byte signature; see 7.2.15
        /// 7.2.15 Device model field (bytes 52 to 55)
        /// This field may be used to identify a device model. If used, the signature shall match the signature contained in the
        /// appropriate section of the ICC Signature registry at http://www.color.org (see Clause 5).
        /// If not used, this field shall be zero (00000000h).
        self.model = try ICCSignature(dataStream: &dataStream)
        
        /// 56 to 63 8 Device attributes unique to the particular device setup such as media type uInt64Number see 7.2.16
        self.attributes = try ICCColorProfileDeviceAttributes(dataStream: &dataStream)
        
        /// 64 to 67 4 Rendering Intent uInt32Number; see 7.2.17
        self.renderingIntent = try ICCColorProfileRenderingIntent(dataStream: &dataStream)
        
        /// 68 to 79 12 The nCIEXYZ values of the PCS illuminant, computed with the PCS observer XYZNumber; see 7.2.18
        /// The PCS illuminant field shall contain the nCIEXYZ values of the PCS illuminant. If the PCS illuminant is D50, the values shall
        /// be X = 0,964 2, Y = 1,0 and Z = 0,824 9 encoded as an XYZNumber. If the PCS illuminant is not D50, the values shall
        /// correspond to the colorimetry of the illuminant as computed using the illuminant and observer values specified in the
        /// spectralViewingConditions tag, as described in 9.2.105.
        /// See Annex A for further details.
        /// NOTE These values are the nCIEXYZ values of CIE illuminant D50.
        /// The precise value of the PCS illuminant depends on the precision and method of computation. CIE Publication 15[11]
        /// gives a different value for Z, which corresponds to an nCIEXYZ value of 0,825 1. Such close approximations should be
        /// considered as D50.
        self.pcsIlluminant = try XYZNumber(dataStream: &dataStream)
        
        /// 80 to 83 4 Profile creator Signature 4-byte signature; see 7.2.19
        /// 7.2.19 Profile creator field (bytes 80 to 83)
        /// This field may be used to identify the creator of the profile. If used, the signature should match the signature contained in
        /// the device manufacturer section of the ICC Signature registry at http://www.color.org. If not used, this field shall
        /// be zero (00000000h).
        self.creator = try ICCSignature(dataStream: &dataStream)

        /// 84 to 99 16 Profile ID uInt64Number[2]; see 7.2.20
        /// 7.2.20 Profile ID field (bytes 84 to 99)
        /// This field, if not zero (00h), shall hold the profile ID. The profile ID shall be calculated using the MD5 fingerprinting method
        /// as defined in Internet RFC 1321[12]. The entire profile, whose length is given by the size field in the header, with the
        /// profile flags field (bytes 44 to 47, see 7.2.13), rendering intent field (bytes 64 to 67, see 7.2.14), and profile ID field (bytes
        /// 84 to 99) in the profile header temporarily set to zeros (00h), shall be used to calculate the ID. A profile ID field value of
        /// zero (00h) shall indicate that a profile ID has not been calculated.
        /// It is recommended that profile creators compute and record a profile ID.
        self.profileID = (try dataStream.read(endianess: .bigEndian),
                          try dataStream.read(endianess: .bigEndian))
        
        /// 100 to 103 4 Spectral PCS 4-byte signature; see 7.2.21
        self.spectralPcs = try SpectralProfileClassSignature(dataStream: &dataStream)
        
        /// 104 to 109 6 Spectral PCS wavelength range spectralRange; See 7.2.22
        /// 7.2.22 Spectral PCS range field (bytes 104 to 109)
        /// This field shall specify the spectral range used for a spectrally-based PCS when the spectralPCS Signature field in the
        /// profile header is non-zero. If the spectralPCS field is zero then this field shall be zero.
        /// Spectra are normally represented according to their canonical basis, i.e. the spectrum is sampled at equal intervals along
        /// the wavelength axis. The wavelength range is represented by a start wavelength (S), end wavelength (E) and number of
        /// steps (n). The wavelength interval between steps is given by Formula (4).
        /// I = (E − S)/(n − 1) (4)
        /// Unless otherwise specified, spectral data in all tags shall be uniformly sampled, with a given start, end wavelength and
        /// number of steps as defined by this field. The dimensions and range of the spectra in the different tags shall be defined
        /// consistently. For normal spectra, this means that the spectral dimension of object characterization spectra shall be the same.
        self.spectralPcsWavelengthRange = try spectralRange(dataStream: &dataStream)
        
        /// 110 to 115 6 Bi-spectral PCS wavelength range spectralRange; see 7.2.23
        /// 7.2.23 Bi-Spectral PCS range field (bytes 110 to 115)
        /// This field shall specify the spectral range of the incident light used for a spectrally-based PCS when the spectralPCS
        /// Signature field in the profile header indicates the use of Bi-spectral reflectance. Otherwise this field shall be zero.
        /// Bi-spectral reflectance characterizes of the interaction of light with a diffuse surface using a Donaldson matrix.
        /// The multiplication of such a matrix by a vector representing the illumination results in a vector representing the light
        /// reflected off the surface. Columns of a Donaldson matrix correspond to incident wavelengths of light and rows of a
        /// Donaldson matrix correspond to reflected wavelengths of light. Diagonal entries (where incident and reflected wavelengths
        /// are the same) correspond to spectral reflectance. Off diagonal entries (below the diagonal) represent the contribution of
        /// a change in the reflected light’s wavelength (typically due to fluorescence). Fluorescence occurs when light is absorbed
        /// and then re-emitted at a longer wavelength. Using Donaldson matrices to represent colours in an ICC profile allows for
        /// a more complete description of colour to be encoded than using only spectral reflectance or simple colorimetry.
        self.biSpectralPcsWavelengthRange = try spectralRange(dataStream: &dataStream)
        
        /// 116 to 119 4 MCS Signature uInt32Number; see 7.2.24
        self.multiplexColorSpace = try MultiplexColorSpaceSignature(dataStream: &dataStream)
        
        /// 120 to 123 4 Profile/device sub-class 4-byte signature; see 7.2.25
        /// 7.2.25 Profile/device sub-class (bytes 124 to 127)
        /// This field allows for a profile/device subclass Signature associated with the profile class. This field’s purpose is to provide
        /// a connection with ICS documents that provide specifications for specific colour management workflows. If this field is zero
        /// then no profile/device subclass shall be associated with the profile type. When this field is set then the profile sub-version
        /// field shall also identify the version associated with the profile/device sub-class that can be referenced with an ICS document.
        self.deviceSubClass = try ICCSignature(dataStream: &dataStream)
        
        /// 124 to 127 4 Reserved bytes shall be zero (00h) uInt32Number; see 7.2.26
        /// 7.2.26 Reserved field (bytes 124 to 127)
        /// This field of the profile header is reserved for future ICC definition and shall be zero.
        self.reserved = try dataStream.readBytes(count: 4)
        
        guard dataStream.position - startPosition == 128 else {
            throw ICCReadError.corrupted
        }
    }
}
