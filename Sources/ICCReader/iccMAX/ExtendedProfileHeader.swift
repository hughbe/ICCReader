//
//  ExtendedProfileHeader.swift
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
public struct ExtendedProfileHeader {
    public let size: UInt32
    public let cmmId: Signature
    public let version: ProfileVersion
    public let deviceClass: ProfileClassSignature
    public let colorSpace: KnownSignature<ColorSpaceSignature>
    public let pcs: ColorSpaceSignature
    public let date: dateTimeNumber
    public let magic: Signature
    public let platform: KnownSignature<PlatformSignature>
    public let flags: ProfileFlags
    public let manufacturer: Signature
    public let model: Signature
    public let attributes: DeviceAttributes
    public let renderingIntent: RenderingIntent
    public let illuminant: XYZNumber
    public let creator: Signature
    public let profileID: (UInt64, UInt64)
    public let spectralPcs: SpectralProfileClassSignature
    public let spectralPcsWavelengthRange: spectralRange
    public let biSpectralPcsWavelengthRange: spectralRange
    public let multiplexColorSpace: MultiplexColorSpaceSignature
    public let deviceSubClass: Signature
    public let reserved: [UInt8]
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// 0 to 3 4 Profile size uInt32Number; See 7.2.4
        self.size = try dataStream.read(endianess: .bigEndian)
        
        /// 4 to 7 4 Preferred CMM type 4-byte signature; see 7.2.5
        /// 7.2.5 Preferred CMM type field (bytes 4 to 7)
        /// This field may be used to identify the preferred CMM to be used. If used, it shall match a CMM type signature registered in
        /// the ICC CMM registry. If no preferred CMM is identified, this field shall be zero (00000000h).
        self.cmmId = try Signature(dataStream: &dataStream)
        
        /// 8 to 11 4 Profile version and sub-version number uInt32Number; see 7.2.6
        self.version = try ProfileVersion(dataStream: &dataStream)
        
        /// 12 to 15 4 Profile/device class 4-byte signature; see 7.2.7
        self.deviceClass = try ProfileClassSignature(dataStream: &dataStream)
        
        /// 16 to 19 4 Colour space of data (possibly a derived space) 4-byte signature; see
        self.colorSpace = try KnownSignature(dataStream: &dataStream)
        
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
        /// Colour space type Signature Hexidecimal encoding
        /// nCIEXYZ or PCSXYZa ‘XYZ ’ 58595A20h
        /// CIELAB or PCSLABb ‘Lab ’ 4C616220h
        /// None (spectral PCS defined by spectral PCS header field) 0 00000000h
        /// a The signature 'XYZ ' refers to nCIEXYZ or PCSXYZ, depending upon the context.
        /// b The signature 'Lab' refers to CIELAB or PCSLAB, depending upon the context.
        /// Channel encoding order shall be associated with the order that channel names are identified in the signature.
        self.pcs = try ColorSpaceSignature(dataStream: &dataStream)
        
        /// 24 to 35 12 Date and time this profile was first created dateTimeNumber; see 7.2.10
        /// 7.2.10 Date and time field (bytes 24 to 35)
        /// This header field shall contain the date and time that the profile was first created, encoded as a dateTimeNumber.
        self.date = try dateTimeNumber(dataStream: &dataStream)
        
        /// 36 to 39 4 ‘acsp’ (61637370h) profile file signature 4-byte signature; see 7.2.11
        /// 7.2.11 Profile file signature field (bytes 36 to 39)
        /// The profile file signature field shall contain the value ‘acsp’ (61637379h) as a profile file signature.
        self.magic = try Signature(dataStream: &dataStream)
        guard self.magic == "acsp" else {
            throw ICCReadError.corrupted
        }
        
        /// 40 to 43 4 Primary platform signature 4-byte signature; see 7.2.12
        self.platform = try KnownSignature(dataStream: &dataStream)
        
        /// 44 to 47 4 Profile flags to indicate various options for the CMM such as distributed processing and caching options
        /// uInt32Number; see 7.2.13
        self.flags = try ProfileFlags(dataStream: &dataStream)
        
        /// 48 to 51 4 Device manufacturer of the device for which this profile is created 4-byte signature; see 7.2.14
        /// 7.2.14 Device manufacturer field (bytes 48 to 51)
        /// This field may be used to identify a device manufacturer. If used, the signature shall match the signature contained in the
        /// appropriate section of the ICC signature registry at http://www.color.org (see Clause 5).
        /// If not used, this field shall be zero (00000000h).
        self.manufacturer = try Signature(dataStream: &dataStream)
        
        /// 52 to 55 4 Device model of the device for which this profile is created 4-byte signature; see 7.2.15
        /// 7.2.15 Device model field (bytes 52 to 55)
        /// This field may be used to identify a device model. If used, the signature shall match the signature contained in the
        /// appropriate section of the ICC signature registry at http://www.color.org (see Clause 5).
        /// If not used, this field shall be zero (00000000h).
        self.model = try Signature(dataStream: &dataStream)
        
        /// 56 to 63 8 Device attributes unique to the particular device setup such as media type uInt64Number see 7.2.16
        self.attributes = try DeviceAttributes(dataStream: &dataStream)
        
        /// 64 to 67 4 Rendering Intent uInt32Number; see 7.2.17
        self.renderingIntent = try RenderingIntent(dataStream: &dataStream)
        
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
        self.illuminant = try XYZNumber(dataStream: &dataStream)
        
        /// 80 to 83 4 Profile creator signature 4-byte signature; see 7.2.19
        /// 7.2.19 Profile creator field (bytes 80 to 83)
        /// This field may be used to identify the creator of the profile. If used, the signature should match the signature contained in
        /// the device manufacturer section of the ICC signature registry at http://www.color.org. If not used, this field shall
        /// be zero (00000000h).
        self.creator = try Signature(dataStream: &dataStream)
        
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
        /// This field shall specify the spectral range used for a spectrally-based PCS when the spectralPCS signature field in the
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
        /// signature field in the profile header indicates the use of Bi-spectral reflectance. Otherwise this field shall be zero.
        /// Bi-spectral reflectance characterizes of the interaction of light with a diffuse surface using a Donaldson matrix.
        /// The multiplication of such a matrix by a vector representing the illumination results in a vector representing the light
        /// reflected off the surface. Columns of a Donaldson matrix correspond to incident wavelengths of light and rows of a
        /// Donaldson matrix correspond to reflected wavelengths of light. Diagonal entries (where incident and reflected wavelengths
        /// are the same) correspond to spectral reflectance. Off diagonal entries (below the diagonal) represent the contribution of
        /// a change in the reflected light’s wavelength (typically due to fluorescence). Fluorescence occurs when light is absorbed
        /// and then re-emitted at a longer wavelength. Using Donaldson matrices to represent colours in an ICC profile allows for
        /// a more complete description of colour to be encoded than using only spectral reflectance or simple colorimetry.
        self.biSpectralPcsWavelengthRange = try spectralRange(dataStream: &dataStream)
        
        /// 116 to 119 4 MCS signature uInt32Number; see 7.2.24
        self.multiplexColorSpace = try MultiplexColorSpaceSignature(dataStream: &dataStream)
        
        /// 120 to 123 4 Profile/device sub-class 4-byte signature; see 7.2.25
        /// 7.2.25 Profile/device sub-class (bytes 124 to 127)
        /// This field allows for a profile/device subclass signature associated with the profile class. This field’s purpose is to provide
        /// a connection with ICS documents that provide specifications for specific colour management workflows. If this field is zero
        /// then no profile/device subclass shall be associated with the profile type. When this field is set then the profile sub-version
        /// field shall also identify the version associated with the profile/device sub-class that can be referenced with an ICS document.
        self.deviceSubClass = try Signature(dataStream: &dataStream)
        
        /// 124 to 127 4 Reserved bytes shall be zero (00h) uInt32Number; see 7.2.26
        /// 7.2.26 Reserved field (bytes 124 to 127)
        /// This field of the profile header is reserved for future ICC definition and shall be zero.
        self.reserved = try dataStream.readBytes(count: 4)
        
        guard dataStream.position - startPosition == 128 else {
            throw ICCReadError.corrupted
        }
    }

    /// 7.2.6 Profile version and sub-version field (bytes 8 to 11)
    /// The profile version with which the profile conforms shall be encoded as binary-coded decimal in the profile version field.
    /// The first byte (byte 8) shall identify the major version and byte 9 shall identify the minor version and bug fix version in each
    /// 4-bit half of the byte. Bytes 10 and 11 shall be used to identify the profile sub-class version where byte 10 shall be used to
    /// identify the sub-class major version and byte 11 shall be used to identify the sub-class minor version. When a sub-class is
    /// not associated with a profile (when the Pprofile/device sub-class field is zero) then bytes 10 and 11 shall be zero. The major
    /// and minor versions are set by the International Color Consortium (ICC). Profile sub-class versions shall be established by
    /// profile sub-class specification documents. The profile version and sub-version number consistent with this specification is
    /// "5.0.0.0" (encoded as 05000000h).
    /// NOTE A major version number change occurs only when changes made to this document require that both CMMs and profile
    /// generating software be upgraded in order to correctly produce or use profiles conforming to the revised specification. A minor
    /// version number change occurs when profiles conforming to the revised specification can be processed by existing CMMs.
    /// For example, adding a new required tag would necessitate a major revision to the specification, whereas adding an optional
    /// tag would only require a minor revision.
    public struct ProfileVersion {
        public let majorVersion: UInt8
        public let minorVersion: UInt8
        public let reserved1: UInt8
        public let reserved2: UInt8
        
        public init(dataStream: inout DataStream) throws {
            /// 0 Major Revision in BCD
            self.majorVersion = try dataStream.read()
            
            /// 1 Minor Revision & Bug Fix Revision in each nibble in BCD
            self.minorVersion = try dataStream.read()
            
            /// 2 reserved, must be set to 0
            self.reserved1 = try dataStream.read()
            
            /// 3 reserved, must be set to 0
            self.reserved2 = try dataStream.read()
        }
    }

    /// 7.2.7 Profile/device class field (bytes 12 to15)
    /// This field shall contain one of the profile class signatures shown in Table 14.
    /// There are three basic classes of device profiles: Input, Display and Output profiles. In addition to the three basic device profile
    /// classes, eight additional colour processing profiles are defined. These profiles provide a standard implementation for use by
    /// the CMM in general colour processing, or for the convenience of CMMs which may use these types to store calculated transforms.
    /// These eight additional profile classes are DeviceLink, ColorSpace, ColorEncodingSpace, Abstract, NamedColor,
    /// MultiplexIdentification, MultiplexLink and MultiplexVisualization.
    public enum ProfileClassSignature: String {
        /// Input Device profile ‘scnr’ 73636E72h
        case inputDevices = "scnr"
        
        /// Display Device profile ‘mntr’ 6D6E7472h
        case displayDevices = "mntr"
        
        /// Output Device profile ‘prtr’ 70727472h
        case outputDevices = "prtr"
        
        /// DeviceLink profile ‘link’ 6C696E6Bh
        case deviceLink = "link"
        
        /// ColorSpace profile ‘spac’ 73706163h
        case colorSpace = "spac"
        
        /// Abstract profile ‘abst’ 61627374h
        case abstract = "abst"
        
        /// NamedColor profile ‘nmcl’ 6E6D636Ch
        case namedColor = "nmcl"
        
        /// ColorEncodingSpace profile ‘cenc‘ 63656E63h
        case colorEncodingSpace = "cenc"
        
        /// MultiplexIdentification profile ‘mid ’ 6D696420h
        case multiplexIdentification = "mid "
        
        /// MultiplexLink profile ‘mlnk’ 6d6c6e6bh
        case multiplexLink = "mlnk"
        
        /// MultiplexVisualization profile ‘mvis’ 6d766973h
        case multiplexVisualizationor = "mvis"
        
        public init(dataStream: inout DataStream) throws {
            let rawValue = try dataStream.readString(count: 4, encoding: .ascii)!
            guard let value = Self(rawValue: rawValue) else {
                throw ICCReadError.corrupted
            }
            
            self = value
        }
    }
    
    /// 7.2.8 Data colour space field (Bytes 16 to 20)
    /// This field shall contain the signature of the data colour space expected on the A side of the profile transforms.
    /// The names and signatures of the permitted data colour spaces shall be as shown in Table 15.
    /// Channel encoding order shall be associated with the order that channel names are identified in the signature (for example given
    /// signature ‘RGB’ the channel order shall be channel 1 – R, channel 2 – G, channel 3 – B) with the following exceptions: for the
    /// signature ‘GRAY’ there is only 1 channel; for the signature ‘YCbr’ the channel order shall be channel 1 – Y, channel 2 – Cb,
    /// channel 3 – Cr; for xCLR and N channel data the order shall be the same as the incoming device channel order.
    /// For abstract profiles the data colour space signature shall one of the signatures in Table 15. If set to zero the spectral PCS
    /// signature and spectral range fields shall be used to define the A side of the transform.
    /// For MultiplexLink and MultiplexVisualization profiles the data colour space signature shall be zero.
    public enum ColorSpaceSignature: String {
        /// nCIEXYZ or PCSXYZa ‘XYZ ’ 58595A20h
        /// a The signature 'XYZ ' refers to nCIEXYZ or PCSXYZ, depending upon the context.
        case xyz = "XYZ "
        
        /// CIELAB or PCSLABb ‘Lab ’ 4C616220h
        /// b The signature 'Lab' refers to CIELAB or PCSLAB, depending upon the context.
        case lab = "Lab "
        
        /// CIELUV ‘Luv ’ 4C757620h
        case cieluv = "Luv "

        /// YCbCr ‘YCbr’ 59436272h
        case yCbCr = "YCbr"
        
        /// CIEYxy ‘Yxy ’ 59787920h
        case yxy = "Yxy "
        
        /// LMS ‘LMS ‘ 4C4D5320h
        case lms = "LMS "
        
        /// RGB ‘RGB ’ 52474220h
        case rgb = "RGB "
        
        /// Gray ‘GRAY’ 47524159h
        case gray = "GRAY"
        
        /// HSV ‘HSV ’ 48535620h
        case hsv = "HSV "
        
        /// HLS ‘HLS ’ 484C5320h
        case hls = "HLS "
        
        /// CMYK ‘CMYK’ 434D594Bh
        case cmyk = "CMYK"
        
        /// CMY ‘CMY ’ 434D5920h
        case cmy = "CMY "
        
        /// 2 colour ‘2CLR’ 32434C52h
        case twoColor = "2CLR"
        
        /// 3 colour (other than those listed above) ‘3CLR’ 33434C52h
        case threeColor = "3CLR"
        
        /// 4 colour (other than CMYK) ‘4CLR’ 34434C52h
        case fourColor = "4CLR"
        
        /// 5 colour ‘5CLR’ 35434C52h
        case fiveColor = "5CLR"
        
        /// 6 colour ‘6CLR’ 36434C52h
        case sixColor = "6CLR"
        
        /// 7 colour ‘7CLR’ 37434C52h
        case sevenColor = "7CLR"
        
        /// 8 colour ‘8CLR’ 38434C52h
        case eightColor = "8CLR"
        
        /// 9 colour ‘9CLR’ 39434C52h
        case nineColor = "9CLR"
        
        /// 10 colour ‘ACLR’ 41434C52h
        case tenColor = "10CLR"
        
        /// 11 colour ‘BCLR’ 42434C52h
        case elevenColor = "BCLR"
        
        /// 12 colour ‘CCLR’ 43434C52h
        case twelveColor = "CCLR"
        
        /// 13 colour ‘DCLR’ 44434C52h
        case thirteenColor = "DCLR"
        
        /// 14 colour ‘ECLR’ 45434C52h
        case fourteenColor = "ECLR"
        
        /// 15 colour ‘FCLR’ 46434C52h
        case fifteenColor = "FCLR"
        
        /// None 0 00000000h
        case none = "\0\0\0\0"
        
        public init(dataStream: inout DataStream) throws {
            /// Note: does not implement
            /// N channel device data Represented as “nc0001” – “ncFFFF” 6e630001h – 6e63FFFFh
            /// NOTE Extended “N channel device data” signatures use a 32-bit binary encoding (see 6.2.1) with a six-character
            /// signature representation.
            let rawValue = try dataStream.readString(count: 4, encoding: .ascii)!
            guard let value = Self(rawValue: rawValue) else {
                throw ICCReadError.corrupted
            }
            
            self = value
        }
    }
    
    /// 7.2.12 Primary platform field (bytes 40 to 43)
    /// This field may be used to identify the primary platform/operating system framework for which the profile was created.
    /// The primary platforms that have been identified and the signatures that shall be used are shown in Table 17.
    /// If no primary platform is identified, this field shall be zero (00000000h).
    public enum PlatformSignature: String {
        /// Apple Computer, Inc. ‘APPL’ 4150504Ch
        case appleComputer = "APPL"
        
        /// Microsoft Corporation ‘MSFT’ 4D534654h
        case microsoftCorporation = "MSFT"
        
        /// Silicon Graphics, Inc. ‘SGI ’ 53474920h
        case siliconGraphics = "SGI "
        
        /// Sun Microsystems, Inc. ‘SUNW’ 53554E57h
        case sunMicrosystems = "SUNW"
        
        /// [Removed] Taligent, Inc. ‘TGNT ‘ 54474E54h
        case taligent = "TGNT"
        
        /// [Unknown]
        case unix = "*nix"
        
        case none = "\0\0\0\0"
        
        public init(dataStream: inout DataStream) throws {
            let rawValue = try dataStream.readString(count: 4, encoding: .ascii)!
            guard let value = Self(rawValue: rawValue) else {
                throw ICCReadError.corrupted
            }
            
            self = value
        }
    }

    /// 7.2.13 Profile flags field (bytes 44 to 47)
    /// The profile flags field shall contain flags to indicate various hints for the CMM such as distributed processing and caching options.
    /// The least-significant 16 bits are reserved for the ICC. Flags in bit positions 0, 1 and 2 shall be used as indicated in Table 18.
    /// Bit 2 shall define MCS subset requirements for connecting profiles. When bit 2 is set the CMM shall be instructed to fail the
    /// linking of the profile containing this bit (containing profile) to another profile (second profile) using an MCS based connection if
    /// the second profile does not contain all the channels in its MCS (defined in second profile’s multiplexTypeArrayTag, see 9.2.85)
    /// that the containing profile has in its MCS (defined in the containing profile’s multiplexTypeArrayTag, see 9.2.85).
    public struct ProfileFlags {
        public let reserved: UInt16
        public let embedded: Bool
        public let cannotBeUsedIndependentlyFromEmbeddedColorData: Bool
        public let mcsChannelsSubsetOfMcsChannelsInProfile: Bool
        public let unused: UInt16
        
        public init(dataStream: inout DataStream) throws {
            self.reserved = try dataStream.read(endianess: .bigEndian)

            var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .bigEndian)
            
            /// 0 1 Embedded profile (0 if not embedded, 1 if embedded in file)
            self.embedded = flags.readBit()
            
            /// 1 1 Profile cannot be used independently of the embedded colour data (set to 1 if true, 0 if false)
            self.cannotBeUsedIndependentlyFromEmbeddedColorData = flags.readBit()
            
            /// 2 1 MCS channels in this profile shall be a subset of the MCS channels in the profile it is connected to
            /// (set to 1 if true, 0 if false)
            self.mcsChannelsSubsetOfMcsChannelsInProfile = flags.readBit()
            
            self.unused = flags.readRemainingBits()
        }
    }

    /// 7.2.16 Device attributes field (bytes 56 to 63)
    /// The device attributes field shall contain flags used to identify attributes unique to the particular device setup for which the
    /// profile is applicable. The least-significant 32 bits of this 64-bit value are defined by the ICC. Bit usage shall be used as shown
    /// in Table 19.
    public struct DeviceAttributes {
        public let transparent: Bool
        public let matte: Bool
        public let negativeMediaPolarity: Bool
        public let blackAndWhite: Bool
        public let nonPaperBased: Bool
        public let textured: Bool
        public let nonIsotropic: Bool
        public let selfLuminous: Bool
        public let reserved: uInt32Number
        public let vendorSpecific: UInt32
        
        public init(dataStream: inout DataStream) throws {
            var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .bigEndian)
            
            /// 0 1 Reflective (0) or transparency (1)
            self.transparent = flags.readBit()
            
            /// 1 1 Glossy (0) or matte (1)
            self.matte = flags.readBit()
            
            /// 2 1 Media polarity, positive (0) or negative (1)
            self.negativeMediaPolarity = flags.readBit()
            
            /// 3 1 Colour media (0), black and white media (1)
            self.blackAndWhite = flags.readBit()
            
            /// 4 1 Paper/paperboard (0), non-paper-based (1)
            self.nonPaperBased = flags.readBit()
            
            /// 5 1 Non-textured (0), textured (1)
            self.textured = flags.readBit()
            
            /// 6 1 Isotropic (0), non-isotropic (1)
            self.nonIsotropic = flags.readBit()
            
            /// 7 1 Non self-luminous (0) or self-luminous (1)
            self.selfLuminous = flags.readBit()
            
            /// 8 to 31 24 Reserved (set to binary zero)
            self.reserved = flags.readRemainingBits()
            
            /// 32 to 63 32 Use not defined by ICC (vendor specific)
            self.vendorSpecific = try dataStream.read(endianess: .bigEndian)
        }
    }

    /// 7.2.17 Rendering intent field (bytes 64 to 67)
    /// The rendering intent field shall specify the rendering intent that should be used (or, in the case of a DeviceLink profile, was used)
    /// when this profile is (was) combined with another profile. In a sequence of more than two profiles, it applies to the combination of
    /// this profile and the next profile in the sequence and not to the entire sequence. Typically, the user or application selects the
    /// rendering intent dynamically at runtime or embedding time. Therefore, this flag may not have any meaning until the profile is used
    /// in some context, for example in a DeviceLink or an embedded source profile.
    /// The field is a uInt32Number in which the least-significant 16 bits shall be used to encode the rendering intent. The most significant
    /// 16 bits shall be zero (0000h).
    /// The defined rendering intents are perceptual, media-relative colorimetric, saturation and ICC-absolute colorimetric. These shall
    /// be identified using the values shown in Table 20.
    public enum RenderingIntent: UInt32 {
        /// Perceptual 0
        case perceptual = 0
        
        /// Media-relative colorimetric 1
        case mediaRelativeColorimetric = 1
        
        /// Saturation 2
        case saturation = 2
        
        /// ICC-absolute colorimetric 3
        case iccAbsoluteColorimetric = 3
        
        case unknown = 0xFF
        
        public init(dataStream: inout DataStream) throws {
            let rawValue: UInt32 = try dataStream.read(endianess: .bigEndian)
            guard let value = RenderingIntent(rawValue: rawValue) else {
                self = .unknown
                return
            }
            
            self = value
        }
    }
    
    /// 7.2.21 Spectral PCS field (bytes 100 to 103)
    /// This field, when non-zero, defines the meaning of spectrally-based PCS data in a profile.
    /// If DToBx/BToDx or brdfDToBx/brdfBToDx or directionalDToBx/directionalBToDx tags are present and this field is non-zero,
    /// then the use of a spectrally-based PCS shall be defined for DToBx/BToDx or brdfDToBx/brdfBToDx or
    /// directionalDToBx/directionalBToDx tags. If this field is zero then the use of DToBx/BToDx or brdfDToBx/brdfBToDx or
    /// directionalDToBx/directionalBToDx is not defined.
    /// Spectral data shall be assumed to be sampled at equal intervals, with a given start, end wavelength and number of steps.
    /// Unless otherwise specified, the type, dimensions and range of the spectra in the different tags shall be defined by the
    /// spectral PCS field in addition to the spectral PCS range and bi-spectral PCS range fields.
    /// For normal spectra (i.e. spectra containing no fluorescent emission component), this implies that the spectral dimension
    /// of object characterization spectra shall be the same. If the object characterization spectra are defined by the Donaldson
    /// matrix, the Donaldson matrix shall be an nXm matrix with m defined internally in the corresponding colour table.
    /// A distinction is made between self-emitting colours and reflective colours, here referred to as luminous colours and
    /// object colours. Luminous colours are characterized by their emission spectra, whereas for object colours reflectance
    /// or transmission spectra are used. These three types of spectra are referred to as object characterization spectra.
    /// Reflectance spectra are specified in relation to the perfect reflector whereas transmission spectra are related to a perfect
    /// transmitter. Therefore, both types of spectra can be seen as relative data. For emission spectra, luminance values are used,
    /// hence these are regarded as absolute data.
    /// To define the use of a spectrally-based PCS, one of the spectral colour space signatures in Table 21 shall be used to
    /// encode the colour space implied by the spectralPCS field of the profile header. These colour space signatures define both
    /// the colour space type and the number of channels associated with the colour space. Therefore, the number of channels
    /// implied by the spectralPCS colour space signature shall match the number of channels indicated by the steps field(s) of
    /// the corresponding spectralRange structures (7.2.22 and 7.2.23) in the profile header.
    /// NOTE Spectral colour space signatures use the same 32-bit binary encoding mechanism as N colour device data signatures
    /// (see 6.2.1), with each having a six-character signature representation.
    /// Different types of spectral data can be defined. In most circumstances, only reflectance, transmission or emission spectra are
    /// used, but in other circumstances additional data shall be provided according to the processing to be carried out. The range of
    /// normal spectra shall be indicated by the spectral PCS range field in the header (7.2.22). To represent bi-spectral data, a form of
    /// Donaldson matrix is used and the incident wavelengths corresponding to the columns of the matrix shall be specified by the
    /// bi-spectral PCS range field in the header (7.2.23).
    public enum SpectralProfileClassSignature {
        /// None (PCS defined by PCS header field) 0 0 00000000h 0
        case none
        
        /// Reflectance spectra with N channels ’rs’ (7273h) 1 … 65 535 (0001h … FFFFh) 72730001h … 7273FFFFh “rs0001” … “rsFFFF”
        case reflectanceSpectra(numberOfChannels: UInt16)

        /// Transmission spectra with N channels ’ts’ (7473h) 1 … 65 535 (0001h to FFFFh) 74730001h … 7473FFFFh “ts0001” … “tsFFFF
        case transmissionSpectra(numberOfChannels: UInt16)
        
        /// Radiant (emission) spectra with N channels ’es’ (6573h) 1 … 65 535 (0001h … FFFFh) 65730001h … 6573FFFFh “es0001” … “esFFFF”
        case radiantEmissionSpectra(numberOfChannels: UInt16)
        
        /// Bi-spectral reflectance spectra with N total channels ‘bs’ (6273h) 1 to 65 535 (0001h … FFFFh) 62730001h … 6273FFFFh “bs0001” … “bsFFFF”
        case biSpectralReflectance(numberOfChannels: UInt16)
        
        /// Bi-spectral reflectance using sparse matrix with N equivalent output channels ’sm’ (736d) 1 to 65 535 (0001h … FFFFh) 736D0001h … 736DFFFFh “sm0001” … “smFFFF”
        case biSpectralReflectanceUsingSparseMatrix(numberOfChannels: UInt16)
        
        case unknown(signature: String, numberOfChannels: UInt16)
        
        public init(dataStream: inout DataStream) throws {
            let signature = try dataStream.readString(count: 2, encoding: .ascii)!
            
            switch signature {
            case "\0\0":
                let _: UInt16 = try dataStream.read(endianess: .bigEndian)
                self = .none
            case "rs":
                self = .reflectanceSpectra(numberOfChannels: try dataStream.read(endianess: .bigEndian))
            case "ts":
                self = .transmissionSpectra(numberOfChannels: try dataStream.read(endianess: .bigEndian))
            case "es":
                self = .radiantEmissionSpectra(numberOfChannels: try dataStream.read(endianess: .bigEndian))
            case "bs":
                self = .biSpectralReflectance(numberOfChannels: try dataStream.read(endianess: .bigEndian))
            case "sm":
                self = .biSpectralReflectanceUsingSparseMatrix(numberOfChannels: try dataStream.read(endianess: .bigEndian))
            default:
                self = .unknown(signature: signature, numberOfChannels: try dataStream.read(endianess: .bigEndian))
            }
        }
    }
    
    /// 7.2.24 MCS field (bytes 116 to 119)
    /// The MCS for AToM0/MToA0/MToB0/MToS0 tags shall always be defined by the MCS field. The field represents the colour
    /// space on the M-side of the transform. When this field is non-zero the multiplex channel identification shall be encoded by
    /// a multiplexTypeArrayTag (see 9.2.85).
    /// For the MultiplexIdentification and MultiplexVisualization profile classes (see Table 14), the MCS encoding shall be one of
    /// the signatures as defined in Table 22.
    /// NOTE Multiplex colour space signatures use the same 32-bit binary encoding mechanism as N colour device data signatures
    /// (see 6.2.1), with each having a six-character signature representation.
    /// For the input profile class (Table 14) the MCS encoding shall be one of the signatures as defined in Table 23.
    /// For all other profile classes (Table 14) the MCS encoding shall be zero.
    public enum MultiplexColorSpaceSignature {
        /// None (no MCS is used) 0 0 0 0
        case none
        
        /// Multiplex channel values with N channels ’mc’ (6d63h) 1 … 65 535 (0001h … FFFFh) 6d630001h … 6d63FFFFh “mc0001” … “mcFFFF”
        case multiplex(numberOfChannels: UInt16)
        
        case unknown(signature: String, numberOfChannels: UInt16)
        
        public init(dataStream: inout DataStream) throws {
            let signature = try dataStream.readString(count: 2, encoding: .ascii)!
            
            switch signature {
            case "\0\0":
                let _: UInt16 = try dataStream.read(endianess: .bigEndian)
                self = .none
            case "mc":
                self = .multiplex(numberOfChannels: try dataStream.read(endianess: .bigEndian))
            default:
                self = .unknown(signature: signature, numberOfChannels: try dataStream.read(endianess: .bigEndian))
            }
        }
    }
}
