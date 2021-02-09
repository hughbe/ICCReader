//
//  namedColorType.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// [ICC.1:2001-04] 6.5.10 namedColorType
/// NOTE: This type is obsolete, and should not be used in new profiles. Use namedColor2Type instead.
/// The namedColorType is a count value and array of structures that provide color coordinates for 7-bit ASCII color names. This provides
/// users the ability to create a logo color dictionary between a named color set and a space color specification. The color space is
/// identified by the “color space of data” field of the profile header. In order to maintain maximum portability it is strongly recommended
/// that special characters of the 7-bit ASCII set not be used.
public struct namedColorType {
    public let sig: ICCSignature
    public let reserved: uInt32Number
    public let vendorFlag: UInt32
    public let count: UInt32
    public let prefix: String
    public let suffix: String
    public let values: [NamedColor]
    
    public init(dataStream: inout DataStream, size: UInt32, header: ExtendedProfileHeader) throws {
        let startPosition = dataStream.position
        
        guard size >= 16 else {
            throw ICCReadError.corrupted
        }
        
        /// 0..3 ‘ncol’ (6E636F6Ch) type signature
        self.sig = try ICCSignature(dataStream: &dataStream)
        guard self.sig ==  ICCTagTypeSignature.namedColor else {
            throw ICCReadError.corrupted
        }
        
        /// 4..7 reserved, must be set to 0
        self.reserved = try dataStream.read(endianess: .bigEndian)
        
        /// 8..11 vendor specific flag (least-significant 16 bits reserved for ICC use)
        self.vendorFlag = try dataStream.read(endianess: .bigEndian)
        
        /// 12..15 count of named colors uInt32Number
        self.count = try dataStream.read(endianess: .bigEndian)
        guard 16 + self.count <= size else {
            throw ICCReadError.corrupted
        }
        
        /// 16..t prefix for each color name (maximum of 32 bytes) 7-bit ASCII, null terminated
        self.prefix = try dataStream.readAsciiString()!
        guard self.prefix.count <= 32 else {
            throw ICCReadError.corrupted
        }

        /// t+1..u suffix for each color name (maximum of 32 bytes) 7-bit ASCII, null terminated
        self.suffix = try dataStream.readAsciiString()!
        guard self.suffix.count <= 32 else {
            throw ICCReadError.corrupted
        }

        /// u+1..v first color root name (maximum of 32 bytes) 7-bit ASCII, null terminated
        /// v+1..w first name’s color coordinates. Color space of data
        /// w+1..x second color root name (maximum of 32 bytes) 7-bit ASCII, null terminated
        /// x+1..y second name’s color coordinates. Color space of data
        /// y+1..z the remaining count-2 name structures as described in the first two name structures (assuming count > 2)
        var values: [NamedColor] = []
        values.reserveCapacity(Int(self.count))
        for _ in 0..<self.count {
            values.append(try NamedColor(dataStream: &dataStream, header: header))
        }
        
        self.values = values
        
        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }
    
    public struct NamedColor {
        public let rootName: String
        public let pcsCoords: [UInt16]
        
        public init(dataStream: inout DataStream, header: ExtendedProfileHeader) throws {
            /// u+1..v first color root name (maximum of 32 bytes) 7-bit ASCII, null terminated
            self.rootName = try dataStream.readAsciiString()!
            
            let coordinateCount: Int
            switch header.colorSpace {
            case ExtendedProfileHeader.ColorSpaceSignature.xyz:
                coordinateCount = 3
            case ExtendedProfileHeader.ColorSpaceSignature.lab:
                coordinateCount = 3
            case ExtendedProfileHeader.ColorSpaceSignature.cieluv:
                coordinateCount = 3
            case ExtendedProfileHeader.ColorSpaceSignature.yCbCr:
                coordinateCount = 3
            case ExtendedProfileHeader.ColorSpaceSignature.yxy:
                coordinateCount = 3
            case ExtendedProfileHeader.ColorSpaceSignature.lms:
                coordinateCount = 3
            case ExtendedProfileHeader.ColorSpaceSignature.rgb:
                coordinateCount = 3
            case ExtendedProfileHeader.ColorSpaceSignature.gray:
                coordinateCount = 1
            case ExtendedProfileHeader.ColorSpaceSignature.hsv:
                coordinateCount = 3
            case ExtendedProfileHeader.ColorSpaceSignature.hls:
                coordinateCount = 3
            case ExtendedProfileHeader.ColorSpaceSignature.cmyk:
                coordinateCount = 4
            case ExtendedProfileHeader.ColorSpaceSignature.cmy:
                coordinateCount = 3
            case ExtendedProfileHeader.ColorSpaceSignature.twoColor:
                coordinateCount = 2
            case ExtendedProfileHeader.ColorSpaceSignature.threeColor:
                coordinateCount = 3
            case ExtendedProfileHeader.ColorSpaceSignature.fourColor:
                coordinateCount = 4
            case ExtendedProfileHeader.ColorSpaceSignature.fiveColor:
                coordinateCount = 5
            case ExtendedProfileHeader.ColorSpaceSignature.sixColor:
                coordinateCount = 6
            case ExtendedProfileHeader.ColorSpaceSignature.sevenColor:
                coordinateCount = 7
            case ExtendedProfileHeader.ColorSpaceSignature.eightColor:
                coordinateCount = 8
            case ExtendedProfileHeader.ColorSpaceSignature.nineColor:
                coordinateCount = 9
            case ExtendedProfileHeader.ColorSpaceSignature.tenColor:
                coordinateCount = 10
            case ExtendedProfileHeader.ColorSpaceSignature.elevenColor:
                coordinateCount = 11
            case ExtendedProfileHeader.ColorSpaceSignature.twelveColor:
                coordinateCount = 12
            case ExtendedProfileHeader.ColorSpaceSignature.thirteenColor:
                coordinateCount = 13
            case ExtendedProfileHeader.ColorSpaceSignature.fourteenColor:
                coordinateCount = 14
            case ExtendedProfileHeader.ColorSpaceSignature.fifteenColor:
                coordinateCount = 15
            case ExtendedProfileHeader.ColorSpaceSignature.none:
                coordinateCount = 0
            default:
                throw ICCReadError.corrupted
            }
            
            var pcsCoords: [UInt16] = []
            pcsCoords.reserveCapacity(coordinateCount)
            for _ in 0..<coordinateCount {
                pcsCoords.append(try dataStream.read(endianess: .bigEndian))
            }
            
            self.pcsCoords = pcsCoords
        }
    }
}
