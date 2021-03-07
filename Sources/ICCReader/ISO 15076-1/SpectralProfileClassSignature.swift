//
//  SpectralProfileClassSignature.swift
//  
//
//  Created by Hugh Bellamy on 07/03/2021.
//

import DataStream

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
/// NOTE Spectral colour space signatures use the same 32-bit binary encoding mechanism as N colour device data Signatures
/// (see 6.2.1), with each having a six-character Signature representation.
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
    
    case unknown(Signature: String, numberOfChannels: UInt16)
    
    public init(dataStream: inout DataStream) throws {
        let Signature = try dataStream.readString(count: 2, encoding: .ascii)!
        
        switch Signature {
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
            self = .unknown(Signature: Signature, numberOfChannels: try dataStream.read(endianess: .bigEndian))
        }
    }
}
