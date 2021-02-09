//
//  spectralViewingConditionsType.swift
//  
//
//  Created by Hugh Bellamy on 13/12/2020.
//

import DataStream

/// [ICC.2:2019] 10.2.21 spectralViewingConditionsType
/// Spectral data are always coded equidistantly defined by a start wavelength, interval step wavelength and end wavelength such that
/// the difference between the end wavelength and start wavelength is an integer number of interval steps.
/// A profile may encode both standard and custom settings for the colorimetric observer. In both cases, the observer’s CMFs are stored
/// in a 3XN matrix with N the spectral dimension defined by the fields “start wavelength colorimetric observer”, “interval wavelength
/// colorimetric observer” and “end wavelength colorimetric observer”. The 3XN matrix is stored row by row, in the “Matrix colorimetric
/// observer” field.
/// For object colours, both custom and standard illuminants are supported. The illuminant is specified both by its illuminant type as
/// well as its power distribution function. When the illuminant type value is either “Black body defined by CCT” (00000009h) or
/// “Daylight defined by CCT” (0000000Ah) the (correlated) colour temperature field is also used to define the illuminant. If the illuminant
/// type is not one of these values then the (correlated) colour temperature field is merely informative and may be set to zero.
/// The power distribution of the illuminant is represented by an M-dimensional vector with M defined by the fields “start wavelength
/// illuminant”, “interval wavelength illuminant” and “end wavelength illuminant”.
/// To remain compatible with the viewingConditions tag, the unnormalized XYZ values for the illuminant and surround are also
/// provided, both defined in cd/m2.
/// For luminous colours no illuminant is specified. In this case, the fields “start wavelength illuminant”, “interval wavelength illuminant”,
/// “end wavelength illuminant” and “Vector illuminant” are replaced by the corresponding values for the white emission spectrum.
/// And as a result the “un-normalized CIEXYZ values for illuminant” field is filled with the un-normalized CIEXYZ values for the reference
/// white emission spectrum.
/// When used, the spectralViewingConditions Type byte assignment and encoding shall be as given in Table 69. Encodings for the
/// standard observer field are provide in Table 70, and the Encodings for the standard illuminants are provided in Table 71.
/// Having the ability to use custom reference viewing conditions introduces the need for additional processing by the CMM when
/// connecting profiles that use a colorimetric-based PCS. The CMM needs to both determine the compatibility of the implied PCS for
/// each of the profiles and then insert the proper PCS transforms that are needed.
/// For both the source and destination profile, the reference observer and reference illuminant are determined in the following manner:
/// If the profile version is less than V5, then the CIE 1931 standard observer and a D50 illuminant is assumed. Else if no reference
/// spectral viewing condition tag exists and the illuminant field in the profile header matches the CIE 1931 standard observer and a
/// D50 illuminant, then the CIE 1931 standard observer and D50 illuminant are assumed. Else if a reference spectral viewing condition
/// tag exists, then the observer and illuminant are defined by the observer and illuminant fields in the reference spectral viewing
/// condition tag.
/// Note that the illuminant field in the profile header should always be in agreement with the reference spectral viewing conditions tag
/// if available.
/// Once the reference observer and reference illuminant for both source and destination are determined, then the decision about what
/// (if any) transformations are needed to connect the profiles can be made.
/// If both the reference observer and reference illuminant match between the two profiles then no additional transformations are needed.
/// Otherwise:
/// If the reference observer of the source profile is not the CIE 1931 standard observer or the reference illuminant of the source profile
/// is not a D50 illuminant, then the transform from the source profile’s customToStandardPccTag is first used, unless the CMM provides
/// its own transform. If this tag is not present and the CMM does not provide an alternative, then the source profile cannot be connected.
/// If the reference observer of the destination profile is not the CIE 1931 standard observer or the reference illuminant of the destination
/// profile is not a D50 illuminant, then the transform from the destination profile’s standardToCustomPccTag profile is then used, unless
/// the CMM provides its own transform. If this tag is not present and the CMM does not provide an alternative, then the profile cannot
/// be connected.
public struct spectralViewingConditionsType {
    public let sig: ICCSignature
    public let reserved: uInt32Number
    public let colorimetricObserverType: StandardObserverEncoding
    public let range: spectralRange
    public let reserved2: UInt16
    public let matrix: [(Float, Float, Float)]
    public let illuminant: Illuminant
    public let colorTemperature: Float
    public let illuminantSpectralRange: spectralRange
    public let reserved3: UInt16
    public let vectorIlluminant: [Float]
    public let unNormalizedCIEXYZIlluminant: XYZNumber
    public let unNormalizedCIEXYZSurround: XYZNumber
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position

        guard size >= 60 else {
            throw ICCReadError.corrupted
        }
        
        /// 0 .. 3 4 ‘svcn’ (7376636eh ) type signature
        self.sig = try ICCSignature(dataStream: &dataStream)
        guard self.sig ==  ICCTagTypeSignature.spectralViewingConditions else {
            throw ICCReadError.corrupted
        }
        
        /// 4..7 4 Reserved, shall be 0
        self.reserved = try dataStream.read(endianess: .bigEndian)
        
        /// 8 .. 11 4 Colorimetric observer type See Table 70
        self.colorimetricObserverType = try StandardObserverEncoding(dataStream: &dataStream)

        /// 12 .. 17 6 Spectral range for colorimetric observer with (N) steps spectralRange
        self.range = try spectralRange(dataStream: &dataStream)
        guard 60 + self.range.steps * 12 <= size else {
            throw ICCReadError.corrupted
        }
        
        /// 18..19 2 Reserved, shall be 0
        self.reserved2 = try dataStream.read(endianess: .bigEndian)
        
        /// 20.. 20+12*N-1 12N Matrix colorimetric observer (X vector, then Y vector, then Z vector) float32Number[]
        var matrix: [(Float, Float, Float)] = []
        matrix.reserveCapacity(Int(self.range.steps))
        for _ in 0..<self.range.steps {
            matrix.append((try dataStream.readFloat(endianess: .bigEndian),
                           try dataStream.readFloat(endianess: .bigEndian),
                           try dataStream.readFloat(endianess: .bigEndian)))
        }
        
        self.matrix = matrix
        
        /// 20+12*N .. 23+12*N 4 Illuminant type See Table 71
        self.illuminant = try Illuminant(dataStream: &dataStream)
        
        /// 24+12*N .. 27+12*N 4 (Correlated) colour temperature float32Number
        self.colorTemperature = try dataStream.readFloat(endianess: .bigEndian)
        
        /// 28+12*N .. 33+12*N 6 Illuminant spectral range with (M) steps spectralRange
        self.illuminantSpectralRange = try spectralRange(dataStream: &dataStream)
        guard 60 + self.range.steps * 12 + self.illuminantSpectralRange.steps * 4 <= size else {
            throw ICCReadError.corrupted
        }
        
        /// 34+12*N .. 35+12*N 2 Reserved, shall be 0
        self.reserved3 = try dataStream.read(endianess: .bigEndian)
    
        /// 36+12*N. 36+12*N+4*M-1 4M Vector illuminant float32Number[]
        var vectorIlluminant: [Float] = []
        vectorIlluminant.reserveCapacity(Int(self.illuminantSpectralRange.steps))
        for _ in 0..<self.illuminantSpectralRange.steps {
            vectorIlluminant.append(try dataStream.readFloat(endianess: .bigEndian))
        }
        
        self.vectorIlluminant = vectorIlluminant
        
        /// 36+12*N+4*M .. 36+12*N+4*M+11 12 Un-normalized CIEXYZ values for illuminant (with Y in cd/m2) XYZNumber
        self.unNormalizedCIEXYZIlluminant = try XYZNumber(dataStream: &dataStream)
        
        /// 48+12*N+4*M .. 48+12*N+4*M+11 12 Un-normalized CIEXYZ values for surround (with Y in cd/m2) XYZNumber
        self.unNormalizedCIEXYZSurround = try XYZNumber(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }
    
    /// 8 .. 11 4 Colorimetric observer type See Table 70
    public enum StandardObserverEncoding: UInt32 {
        /// Custom colorimetric observer 00000000h
        case custom = 0x00000000
        
        /// CIE 1931 standard colorimetric observer 00000001h
        case cie1931 = 0x00000001
        
        /// CIE 1964 standard colorimetric observer 00000002h
        case cie1964 = 0x00000002
        
        public init(dataStream: inout DataStream) throws {
            let rawValue: UInt32 = try dataStream.read(endianess: .bigEndian)
            guard let value = Self(rawValue: rawValue) else {
                throw ICCReadError.corrupted
            }
            
            self = value
        }
    }
    
    /// 20+12*N .. 23+12*N 4 Illuminant type See Table 71
    public enum Illuminant: UInt32 {
        /// Custom 00000000h
        case custom = 0x00000000
        
        /// D50 00000001h
        case d50 = 0x00000001
        
        /// D65 00000002h
        case d65 = 0x00000002
        
        /// D93 00000003h
        case d93 = 0x00000003
        
        /// F2 00000004h
        case f2 = 0x00000004
        
        /// D55 00000005h
        case d55 = 0x00000005
        
        /// A 00000006h
        case a = 0x00000006
        
        /// Equi-Power (E) 00000007h
        case equiPower = 0x00000007
        
        /// F8 00000008h
        case f8 = 0x00000008
        
        /// Black body defined by CCT 00000009h
        case blackBodyDefinedByCCT = 0x00000009
        
        /// Daylight defined by CCT 0000000Ah
        case daylightDefinedByCCT = 0x0000000A
        
        /// B 0000000Bh
        case b = 0x0000000B
        
        /// C 0000000Ch
        case c = 0x0000000C
        
        /// F1 0000000Dh
        case f1 = 0x0000000D
        
        /// F3 0000000Eh
        case f3 = 0x0000000E
        
        /// F4 0000000Fh
        case f4 = 0x0000000F
        
        /// F5 00000010h
        case f5 = 0x00000010
        
        /// F6 00000011h
        case f6 = 0x00000011
        
        /// F7 00000012h
        case f7 = 0x00000012
        
        /// F9 00000013h
        case f9 = 0x00000013
        
        /// F10 00000014h
        case f10 = 0x00000014
        
        /// F11 00000015h
        case f11 = 0x00000015
        
        /// F12 00000016h
        case f12 = 0x00000016
        
        public init(dataStream: inout DataStream) throws {
            let rawValue: UInt32 = try dataStream.read(endianess: .bigEndian)
            guard let value = Self(rawValue: rawValue) else {
                throw ICCReadError.corrupted
            }
            
            self = value
        }
    }
}
