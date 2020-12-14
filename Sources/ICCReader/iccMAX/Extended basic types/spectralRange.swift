//
//  spectralRange.swift
//  
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// 4.2.7 spectralRange
/// The spectralRange data type shall be used to specify spectral ranges. This data type shall be made up of two float16Number values
/// and a uInt16Number value that define the starting wavelength, ending wavelength and total number of steps in the range. The encoding
/// of a spectralRange data type is shown in Table 6.
public struct spectralRange {
    public let startWavelength: UInt16
    public let endWavelength: UInt16
    public let steps: UInt16
    
    public init(dataStream: inout DataStream) throws {
        /// 0 to 1 2 Start wavelength float16Number
        self.startWavelength = try dataStream.read(endianess: .bigEndian)
        
        /// 2 to 3 2 End wavelength float16Number
        self.endWavelength = try dataStream.read(endianess: .bigEndian)
        
        /// 4 to 5 2 Steps in wavelength range uInt16Number
        self.steps = try dataStream.read(endianess: .bigEndian)
    }
}
