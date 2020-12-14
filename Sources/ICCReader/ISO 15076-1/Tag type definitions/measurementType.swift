//
//  measurementType.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// [ICC.1:2010] 10.12 measurementType
/// The measurementType information refers only to the internal profile data and is meant to provide profile makers an alternative to the
/// default measurement specifications. When used the byte assignment and encoding shall be as given in Table 46.
public struct measurementType {
    public let sig: TagTypeSignature
    public let reserved: uInt32Number
    public let standardObserver: StandardObserver
    public let backing: XYZNumber
    public let geometry: MeasurementGeometry
    public let flare: u16Fixed16Number
    public let illuminant: Illuminant
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position
        
        guard size == 36 else {
            throw ICCReadError.corrupted
        }
        
        /// 0 to 3 4 ‘meas’ (6D656173h) type signature
        self.sig = try TagTypeSignature(dataStream: &dataStream)
        guard self.sig ==  .measurementType else {
            throw ICCReadError.corrupted
        }
        
        /// 4 to 7 4 Reserved, shall be set to 0
        self.reserved = try dataStream.read(endianess: .bigEndian)
        
        /// 8 to 11 4 Encoded value for standard observer see Table 47
        guard let standardObserver = StandardObserver(rawValue: try dataStream.read(endianess: .bigEndian)) else {
            throw ICCReadError.corrupted
        }
        
        self.standardObserver = standardObserver
        
        /// 12 to 23 12 nCIEXYZ tristimulus values for measurement backing XYZNumber
        self.backing = try XYZNumber(dataStream: &dataStream)
        
        /// 24 to 27 4 Encoded value for measurement geometry see Table 48
        guard let geometry = MeasurementGeometry(rawValue: try dataStream.read(endianess: .bigEndian)) else {
            throw ICCReadError.corrupted
        }
        
        self.geometry = geometry
        
        /// 28 to 31 4 Encoded value for measurement flare see Table 49
        /// The encoding for the measurement flare value is shown in Table 49, and is equivalent to the basic numeric type
        /// u16Fixed16Number in 4.7.
        /// Table 49 — Measurement flare encodings
        /// Flare Hex encoding
        /// 0 (0 %) 00000000h
        /// 1,0 (or 100 %) 00010000h
        self.flare = try u16Fixed16Number(dataStream: &dataStream)
        
        /// 32 to 35 4 Encoded value for standard illuminant see Table 50
        guard let illuminant = Illuminant(rawValue: try dataStream.read(endianess: .bigEndian)) else {
            throw ICCReadError.corrupted
        }
        
        self.illuminant = illuminant
        
        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }
    
    /// 8 to 11 4 Encoded value for standard observer see Table 47
    /// The encoding for the standard observer field is shown in Table 47.
    public enum StandardObserver: UInt32 {
        /// Unknown 00000000h
        case unknown = 0x00000000
        
        /// CIE 1931 standard colorimetric observer 00000001h
        case cie1931TwoDegrees = 0x00000001
        
        /// CIE 1964 standard colorimetric observer 00000002h
        case cie1964TenDegrees = 0x00000002
    }

    /// 24 to 27 4 Encoded value for measurement geometry see Table 48
    /// The encoding for the measurement geometry field is shown in Table 48.
    public enum MeasurementGeometry: UInt32 {
        /// Unknown 00000000h
        case unknown = 0x00000000
        
        /// 0°:45° or 45°:0° 00000001h
        case zeroFourtyFiveOrFourtyFiveZero = 0x00000001
        
        /// 0°:d or d:0° 00000002h
        case zeroDOrD0 = 0x00000002
    }
    
    /// 32 to 35 4 Encoded value for standard illuminant see Table 50
    /// The encoding for the standard illuminant field is shown in Table 50.
    public enum Illuminant: UInt32 {
        /// Unknown 00000000h
        case unknown = 0x00000000
        
        /// D50 00000001h
        case d50 = 0x00000001
        
        /// D65 00000002h
        case d65 = 0x00000002
        
        /// D93 00000003h
        case d93 = 0x00000003
        
        /// F2 00000004h
        case f2 = 0x00000004
        
        /// D55 00000005h
        case d55 = 0x0000005
        
        /// A 00000006h
        case a = 0x00000006
        
        /// Equi-Power (E) 00000007h
        case equiPowerE = 0x00000007
        
        /// F8 00000008h
        case f8 = 0x00000008
    }
}
