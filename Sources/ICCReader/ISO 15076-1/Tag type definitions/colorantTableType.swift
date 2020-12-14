//
//  colorantTableType.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// [ICC.1:2010] 10.4 colorantTableType
/// The purpose of this tag is to identify the colorants used in the profile by a unique name and set of PCSXYZ or PCSLAB values to give
/// the colorant an unambiguous value. The first colorant listed is the colorant of the first device channel of a LUT tag. The second
/// colorant listed is the colorant of the second device channel of a LUT tag, and so on. When used the byte assignment shall be as
/// given in Table 33.
/// The PCS values are provided only for convenience and, for many profile classes, should be populated by processing the individual
/// colorants through the AToB1Tag of the profile if this tag exists. Otherwise the user shall supply the values, if this tag is to be used.
/// An individual colorant has the maximum device value in the channel corresponding to that colorant and the minimum device value
/// in all other channels.
/// EXAMPLE Using a 3CLR profile, the colorant values for the first channel would be (1, 0, 0) where 1 is the maximum device value and
/// 0 is the minimum device value. This would be achieved by dividing all the encoded values by the maximum value for that channel
/// (e.g. dividing the 8-bit values 255, 0, 0 by 255). Processing this colour through the AToB1Tag would produce the PCS values listed
/// in bytes 44 to 49.
/// When this tag is used, the “count of colorants” shall be in agreement with the data colour space signature of 7.2.6.
/// NOTE The PCSXYZ or PCSLAB values can also be used to derive the visual density of the colorant, which trapping algorithms can
/// then use to determine overlay values.
public struct colorantTableType {
    public let sig: TagTypeSignature
    public let reserved: uInt32Number
    public let numberOfColorants: uInt32Number
    public let values: [Colorant]
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position
        
        guard size >= 12 && (size - 12) % 38 == 0 else {
            throw ICCReadError.corrupted
        }
        
        /// 0 to 3 4 ‘clrt’ (636c7274h) type signature
        self.sig = try TagTypeSignature(dataStream: &dataStream)
        guard self.sig ==  .colorantTableType else {
            throw ICCReadError.corrupted
        }
        
        /// 4 to 7 4 Reserved, shall be set to 0
        self.reserved = try dataStream.read(endianess: .bigEndian)
        
        /// 8 to 11 4 Count of colorants (n) uInt32Number
        let numberOfColorants: UInt32 = try dataStream.read(endianess: .bigEndian)
        guard numberOfColorants > 0 &&
                12 + numberOfColorants * 38 == size else {
            throw ICCReadError.corrupted
        }
        
        self.numberOfColorants = numberOfColorants
        
        /// 12 to 43 32 First colorant name (32-byte field, null terminated, unused bytes shall be set to zero) 7-bit ASCII
        /// 44 to 49 6 PCS values of the first colorant in the colour space of the profile as described in 7.2.7 (the PCS Signature in the
        /// header). PCS values shall be relative colorimetric 16-bit integer uInt16Number [3]
        /// 50 to 49+38(n−1) 38(n−1) The remaining colorants, if n > 1, described using the format of bytes 12 to 49 of the first colorant
        /// (7-bit ASCII followed by 16-bit integer uInt16Number [3]) [...]
        var values: [Colorant] = []
        values.reserveCapacity(Int(self.numberOfColorants))
        for _ in 0..<self.numberOfColorants {
            values.append(try Colorant(dataStream: &dataStream))
        }
        
        self.values = values
        
        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }
    
    public struct Colorant {
        public let name: String
        public let pcsValues: [UInt16]
        
        public init(dataStream: inout DataStream) throws {
            /// 12 to 43 32 First colorant name (32-byte field, null terminated, unused bytes shall be set to zero) 7-bit ASCII
            self.name = try dataStream.readString(count: 32, encoding: .ascii)!.trimmingCharacters(in: ["\0"])
            
            /// 44 to 49 6 PCS values of the first colorant in the colour space of the profile as described in 7.2.7 (the PCS Signature in the
            /// header). PCS values shall be relative colorimetric 16-bit integer uInt16Number [3]
            self.pcsValues = [
                try dataStream.read(endianess: .bigEndian),
                try dataStream.read(endianess: .bigEndian),
                try dataStream.read(endianess: .bigEndian)
            ]
        }
    }
}
