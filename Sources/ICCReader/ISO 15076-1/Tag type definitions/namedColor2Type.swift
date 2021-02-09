//
//  namedColor2Type.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// [ICC.1:2010] 10.15 namedColor2Type
/// The namedColor2Type is a count value and array of structures that provide colour coordinates for 7-bit ASCII colour names. For each
/// named colour, a PCS and optional device representation of the colour are given. Both representations are 16-bit values and PCS values
/// shall be relative colorimetric. The device representation corresponds to the header’s “data colour space” field. This representation
/// should be consistent with the “number of device coordinates” field in the namedColor2Type. If this field is 0, device coordinates are not
/// provided. The PCS representation corresponds to the header’s PCS field. The PCS representation is always provided. Colour names are
/// fixed-length, 32-byte fields including null termination. In order to maintain maximum portability, it is strongly recommended that special
/// characters of the 7-bit ASCII set not be used.
/// When used the byte assignment and encoding shall be as given in Table 63.
/// For colour values that are in PCSLAB, this tag uses the legacy 16-bit PCSLAB encoding defined in 10.8 (Tables 39 and 40), not the
/// 16-bit PCSLAB encoding that is defined in 6.3.4.2 (Tables 12 and 13). This encoding is retained for backwards compatibility with
/// profile version 2. The PCSLAB L* values have a different encoding than the PCSLAB a* and PCSLAB b* values. The 16-bit PCSLAB L*
/// encoding shall be as shown in Table 39 and the PCSLAB a* and PCSLAB b* 16-bit encoding shall be as shown in Table 40. Note that
/// though the 16-bit PCSLAB L* encoding can represent values slightly greater than 100,0, these are not valid PCSLAB L* values and
/// they should not be used. The 16-bit PCSLAB a* and PCSLAB b* encoding can represent values slightly greater than 127,0 which are
/// valid PCS values.
/// To convert colour values from this tag's legacy 16-bit PCSLAB encoding to the 16-bit PCSLAB encoding defined in 6.3.4.2 (Tables 12
/// and 13), multiply all values with (65 535/65 280) (i.e. FFFFh/FF00h). Any colour values that are in the value range of legacy 16-bit
/// PCSLAB, but not in the more recent 16-bit PCSLAB encoding, shall be clipped on a per-component basis. To convert colour values
/// from the 16-bit PCSLAB encoding defined in 6.3.4.2 (Tables 12 and 13) to this tag's legacy 16-bit PCSLAB encoding, divide all values
/// by (65 535/65 280).
/// NOTE The parameters selected for a parametric curve can result in complex or undefined values for the input range used. This can
/// occur for example if g ⇐ 0, a ⇐ 0 or d < −b/a In such cases, the behaviour of the curve is undefined.
public struct namedColor2Type {
    public let sig: ICCSignature
    public let reserved: uInt32Number
    public let vendorFlag: UInt32
    public let count: UInt32
    public let nDeviceCoords: UInt32
    public let prefix: String
    public let suffix: String
    public let values: [NamedColor]
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position
        
        guard size >= 84 else {
            throw ICCReadError.corrupted
        }
        
        /// 0 to 3 4 ‘ncl2’ (6E636C32h) type signature 
        self.sig = try ICCSignature(dataStream: &dataStream)
        guard self.sig ==  ICCTagTypeSignature.namedColor2 else {
            throw ICCReadError.corrupted
        }
        
        /// 4 to 7 4 Reserved, shall be set to 0
        self.reserved = try dataStream.read(endianess: .bigEndian)
        
        /// 8 to 11 4 Vendor specific flag (least-significant 16 bits reserved for ICC use)
        self.vendorFlag = try dataStream.read(endianess: .bigEndian)
        
        /// 12 to 15 4 Count of named colours (n) uInt32Number
        self.count = try dataStream.read(endianess: .bigEndian)
        guard 84 + self.count * 38 <= size else {
            throw ICCReadError.corrupted
        }
        
        /// 16 to 19 4 Number of device coordinates (m) for each named colour uInt32Number
        self.nDeviceCoords = try dataStream.read(endianess: .bigEndian)
        guard 84 + self.count * (38 + self.nDeviceCoords * 2) <= size else {
            throw ICCReadError.corrupted
        }

        ///20 to 51 32 Prefix for each colour name (32-byte field including null termination) 7-bit ASCII
        self.prefix = try dataStream.readString(count: 32, encoding: .ascii)!.trimmingCharacters(in: ["\0"])
        
        /// 52 to 83 32 Suffix for each colour name (32-byte field including null termination) 7-bit ASCII
        self.suffix = try dataStream.readString(count: 32, encoding: .ascii)!.trimmingCharacters(in: ["\0"])
        
        /// 84 to 115 32 First colour root name (32-byte field including null termination) 7-bit ASCII
        /// 116 to 121 6 First named colour’s PCS coordinates. The encoding is the same as the encodings for the PCS colour
        /// spaces as described in 6.3.4.2 and 10.8. Only PCSXYZ and legacy 16-bit PCSLAB encodings are permitted. PCS values
        /// shall be relative colorimetric. uInt16Number [3]
        /// 122 to 121+(2m) 2m First named colour’s device coordinates. For each coordinate, 0000h represents the minimum value for
        /// the device coordinate and FFFFh represents the maximum value for the device coordinate. The number of coordinates is
        /// given by the “number of device coordinates” field. If the “number of device coordinates” field is 0, this field is not given.
        /// uInt16Number [...]
        /// 122+(2m) to end (n−1) (38+2m) If n > 1 the remaining n−1 colours are described in a manner consistent with the first
        /// named colour, see byte offsets 84 to 121+(2m).
        var values: [NamedColor] = []
        values.reserveCapacity(Int(self.count))
        for _ in 0..<self.count {
            values.append(try NamedColor(dataStream: &dataStream, nDeviceCoords: self.nDeviceCoords))
        }
        
        self.values = values
        
        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }
    
    public struct NamedColor {
        public let rootName: String
        public let pcsCoords: [UInt16]
        public let deviceCoords: [UInt16]
        
        public init(dataStream: inout DataStream, nDeviceCoords: UInt32) throws {
            /// 84 to 115 32 First colour root name (32-byte field including null termination) 7-bit ASCII
            self.rootName = try dataStream.readString(count: 32, encoding: .ascii)!.trimmingCharacters(in: ["\0"])
            
            /// 116 to 121 6 First named colour’s PCS coordinates. The encoding is the same as the encodings for the PCS colour
            /// spaces as described in 6.3.4.2 and 10.8. Only PCSXYZ and legacy 16-bit PCSLAB encodings are permitted. PCS values
            /// shall be relative colorimetric. uInt16Number [3]
            self.pcsCoords = [
                try dataStream.read(endianess: .bigEndian),
                try dataStream.read(endianess: .bigEndian),
                try dataStream.read(endianess: .bigEndian)
            ]
            
            /// 122 to 121+(2m) 2m First named colour’s device coordinates. For each coordinate, 0000h represents the minimum value for
            /// the device coordinate and FFFFh represents the maximum value for the device coordinate. The number of coordinates is
            /// given by the “number of device coordinates” field. If the “number of device coordinates” field is 0, this field is not given.
            /// uInt16Number [...]
            var deviceCoords: [UInt16] = []
            deviceCoords.reserveCapacity(Int(nDeviceCoords))
            for _ in 0..<nDeviceCoords {
                deviceCoords.append(try dataStream.read(endianess: .bigEndian))
            }
            
            self.deviceCoords = deviceCoords
        }
    }
}
