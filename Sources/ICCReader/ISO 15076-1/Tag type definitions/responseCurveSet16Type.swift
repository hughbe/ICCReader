//
//  responseCurveSet16Type.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// [ICC.1:2010] 10.19 responseCurveSet16Type
/// ICC profiles for display and output devices will produce the desired colour only while the device has a particular relationship between
/// normalized device codes and physical colorant amount (the reference response). If the response of the device changes (the current
/// response), the profile will no longer produce the correct result. In many cases it is impractical to produce a new profile for the current
/// response, but the change can be compensated for by modifying the single channel device codes.
/// The purpose of this tag type is to provide a mechanism to relate physical colorant amounts with the normalized device codes produced
/// by lut8Type, lut16Type, lutAToBType, lutBToAType or multiProcessElementsType tags so that corrections can be made for variation in
/// the device without having to produce a new profile. The mechanism can be used by applications to allow users with relatively
/// inexpensive and readily available instrumentation to apply corrections to individual output colour channels in order to achieve
/// consistent results.
/// Two pieces of information are necessary for this compensation, the reference response and the current response. This tag type
/// provides a mechanism that allows applications that create profiles to specify the reference response. The way in which applications
/// determine and make use of the current response is not specified at this time.
/// The measurements are of the standard variety used in the photographic, graphic arts, and television industries for process control.
/// The measurements are intended to represent colorant amounts and so different measurement techniques are appropriate for different
/// device types.
/// It is the job of the profile creator to provide reference response data in as many measurement units as practical and appropriate so
/// that applications may select the same units that are measured by the user’s instrument. Since it is not possible in general to translate
/// between measurement units, and since most instruments only measure in one unit, providing a wide range of measurement units is
/// vital. The profile originator shall decide which measurement units are appropriate for the device.
/// Here are some examples of suitable measurement units.
/// ⎯ For process colours, density should be reported.
/// ⎯ Red-filter density should be reported for the cyan channel.
/// ⎯ Green-filter should be reported for the magenta channel.
/// ⎯ Blue-filter should be reported for the yellow channel.
/// ⎯ Visual should be reported for the black channel.
/// ⎯ For other colorants, such as spot colours or Hi-Fi colours, it is the responsibility of the profile creator to select the appropriate units
/// of measure for the system being profiled. Several different density standards are used around the world, so it is important that profile
/// creators report in as many different density units as possible (See Table 72). Examples of suitable density measurements are:
/// ⎯ Status T,
/// ⎯ Status E,
/// ⎯ Status I, and
/// ⎯ DIN.
/// Normalized device codes resulting from a lut8Type tag should first be multiplied by 257 (101h). Normalized device codes in the
/// 0 to 1 range that are related to lutAToBType and lutBToAType tags should be encoded in a responseCurveSet16Type as
/// 16-bit values converted to the range of 0 to 65,535 (FFFFh). Normalized device codes clipped to the 0 to 1 range that are related
/// to multiProcessElementsType tags should be encoded in a responseCurveSet16Type as 16-bit values converted to the range of 0
/// to 65,535 (FFFFh).
/// For those fields that have been structured in arrays of channel data, the channels are ordered as specified for the appropriate data
/// colour space in Table 38.
/// When used the byte assignment and structure shall be as given in Table 70.
public struct responseCurveSet16Type {
    public let sig: ICCSignature
    public let reserved: uInt32Number
    public let numberOfChannels: uInt16Number
    public let numberOfMeasurementTypes: uInt16Number
    public let offsets: [uInt32Number]
    public let curves: [ResponseCurve]
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position
        
        guard size >= 12 else {
            throw ICCReadError.corrupted
        }
        
        /// 0 to 3 4 ‘rcs2’ (72637332h) [response curve set with 2-byte precision] type signature
        self.sig = try ICCSignature(dataStream: &dataStream)
        guard self.sig ==  ICCTagTypeSignature.responseCurveSet16 else {
            throw ICCReadError.corrupted
        }
        
        /// 4 to 7 4 Reserved, shall be set to 0
        self.reserved = try dataStream.read(endianess: .bigEndian)
        
        /// 8 to 9 2 Number of channels (n) uInt16Number
        self.numberOfChannels = try dataStream.read(endianess: .bigEndian)
        
        /// 10 to 11 2 Count of measurement types (m) uInt16Number
        self.numberOfMeasurementTypes = try dataStream.read(endianess: .bigEndian)
        guard 12 + self.numberOfMeasurementTypes * 4 + self.numberOfMeasurementTypes * (4 + self.numberOfChannels * 4 + self.numberOfChannels * 12) <= size else {
            throw ICCReadError.corrupted
        }
        
        /// 12 to (11 + 4m) 4m m offsets, each relative to byte 0 of this structure, with one entry for each measurement type. Each
        /// offset shall point to the start of the response curve structure for the measurement type. uInt32Number [m]
        var offsets: [uInt32Number] = []
        offsets.reserveCapacity(Int(self.numberOfMeasurementTypes))
        for _ in 0..<self.numberOfMeasurementTypes {
            offsets.append(try dataStream.read(endianess: .bigEndian))
        }
        
        self.offsets = offsets
        
        /// (12 + 4 m) to end Variable m response curve structures, with one structure for each measurement type See Table 71
        var curves: [ResponseCurve] = []
        curves.reserveCapacity(Int(self.numberOfMeasurementTypes))
        for _ in 0..<self.numberOfMeasurementTypes {
            curves.append(try ResponseCurve(dataStream: &dataStream, numberOfChannels: self.numberOfChannels))
        }
        
        self.curves = curves

        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }
    
    /// Each response curve structure has the format shown in Table 71.
    /// The response arrays shall be ordered with normalized device code elements increasing
    public struct ResponseCurve {
        public let measurementUnitSig: ICCSignature
        public let measurements: [uInt32Number]
        public let values: [XYZNumber]
        public let responseArrays: [[response16Number]]
        
        public init(dataStream: inout DataStream, numberOfChannels: UInt16) throws {
            /// 0 to 3 4 Measurement unit Signature see Table 72
            self.measurementUnitSig = try ICCSignature(dataStream: &dataStream)
            
            /// 4 to (3 + 4 n) 4n n counts of measurements in response arrays, one for each channel i. Each count of measurements,
            /// qi, shall be the count of response16Numbers in the response array for channel i p shall be the sum of the counts qi
            /// for all channels. The counts shall be ordered in the channel order specified in Table 38 for the appropriate data
            /// colour space. uInt32Number [n]
            var measurements: [uInt32Number] = []
            measurements.reserveCapacity(Int(numberOfChannels))
            for _ in 0..<numberOfChannels {
                measurements.append(try dataStream.read(endianess: .bigEndian))
            }
            
            self.measurements = measurements
            
            /// (4 + 4 n) to (3 + 4 n + 12 n) 12n n PCSXYZ values, one for each channel. Each entry shall be a measurement of a
            /// patch with the maximum colorant value for the channel. The PCSXYZ values shall be relative colorimetric. The
            /// PCSXYZ values shall be ordered in the channel order specified in Table 38 for the appropriate data colour space.
            /// XYZNumber [n]
            var values: [XYZNumber] = []
            values.reserveCapacity(Int(numberOfChannels))
            for _ in 0..<numberOfChannels {
                values.append(try XYZNumber(dataStream: &dataStream))
            }
            
            self.values = values
            
            /// (4 + 16 n) to (3 + 16 n+8 p) 8 p n response arrays, one for each channel (i). Each response array shall contain qi
            /// response16Numbers. Each response16Number shall contain a measurement for channel i. The response arrays
            /// shall be ordered in the channel order specified in Table 38 for the appropriate data colour space.
            /// response16Number [p]
            var responseArrays: [[response16Number]] = []
            responseArrays.reserveCapacity(Int(numberOfChannels))
            for measurement in self.measurements {
                var responseArray: [response16Number] = []
                responseArray.reserveCapacity(Int(measurement))
                for _ in 0..<measurement {
                    responseArray.append(try response16Number(dataStream: &dataStream))
                }
                
                responseArrays.append(responseArray)
            }
            
            self.responseArrays = responseArrays
        }
    }
    
    /// 0 to 3 4 Measurement unit Signature see Table 72
    /// The measurement unit shall be encoded as shown in Table 72.
    public enum MeasurementSignature: String {
        /// Status A ISO 5-3 densitometer response. This is the accepted standard for reflection densitometers for measuring
        /// photographic colour prints. ‘StaA’ 53746141h
        case statusA = "StaA"
        
        /// Status E ISO 5-3 densitometer response which is the accepted standard in Europe for colour reflection densitometers.
        /// ‘StaE’ 53746145h
        case statusE = "StaE"
        
        /// Status I ISO 5-3 densitometer response commonly referred to as narrow band or interference-type response. ‘StaI’
        /// 53746149h
        case statusI = "StaI"
        
        /// Status T ISO 5-3 wide band colour reflection densitometer response which is the accepted standard in the United States
        /// for colour reflection densitometers. ‘StaT’ 53746154h
        case statusT = "StaT"
        
        /// Status M ISO 5-3 densitometer response for measuring colour negatives. ‘StaM’ 5374614Dh
        case statusM = "StaM"
        
        /// DIN E DIN 16536-2 densitometer response, with no polarizing filter. ‘DN’ 434E2020h
        case dinE = "DN  "
        
        /// DIN E DIN 16536-2 densitometer response, with polarizing filter. ‘DN P’ 434E2050h
        case dinEWithPolarizingFilter = "DN P"
        
        /// DIN I DIN 16536-2 narrow band densitometer response, with no polarizing filter. ‘DNN ’ 434E4E20h
        case dinI = "DI  "
        
        /// DIN I DIN 16536-2 narrow band densitometer response, with polarizing filter. ‘DNNP’ 434E4E50h
        case dinIWithPolarizingFilter = "DI P"
    }
}
