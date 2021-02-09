//
//  ucrBgType.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// [ICC.1:2001-04] 6.5.20 ucrbgType
/// This type contains curves representing the under color removal and black generation and a text string which is a general description
/// of the method used for the UCR and BG.
/// Note: It has been found that ucrbgType can contain misaligned data (see 4.1 for the definition of “aligned”). Because the BG count
/// immediately follows the UCR curve values, its alignment is not correct when the UCR count is odd. Profile reading and writing
/// software must be written carefully in order to handle this alignment problem.
public struct ucrBgType {
    public let sig: ICCSignature
    public let reserved: uInt32Number
    public let ucrCount: UInt32
    public let ucrCurve: [UInt16]
    public let bgCount: UInt32
    public let bgCurve: [UInt16]
    public let string: String
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position
        
        guard size >= 16 else {
            throw ICCReadError.corrupted
        }
        
        /// 0..3 ‘bfd ’ (62666420h) type signature
        self.sig = try ICCSignature(dataStream: &dataStream)
        guard self.sig ==  ICCTagTypeSignature.ucrBg else {
            throw ICCReadError.corrupted
        }
        
        /// 4..7 reserved, must be set to 0
        self.reserved = try dataStream.read(endianess: .bigEndian)
        
        /// 8..11 count value specifying number of entries in the UCR curve uInt32Number
        self.ucrCount = try dataStream.read(endianess: .bigEndian)
        guard 16 + self.ucrCount * 2 <= size else {
            throw ICCReadError.corrupted
        }
        
        /// 12..m actual UCR curve values starting with the zeroth entry and ending with the entry count-1. If the count is 1, the
        /// value is a percent. uInt16Number[]
        var ucrCurve: [UInt16] = []
        ucrCurve.reserveCapacity(Int(self.ucrCount))
        for _ in 0..<self.ucrCount {
            ucrCurve.append(try dataStream.read(endianess: .bigEndian))
        }
        
        self.ucrCurve = ucrCurve
        
        /// m+1..m+4 count value specifying number of entries in the BG curve uInt32Number
        self.bgCount = try dataStream.read(endianess: .bigEndian)
        guard 16 + self.ucrCount * 2 + self.bgCount * 2 == size else {
            throw ICCReadError.corrupted
        }
        
        /// m+5..n actual BG curve values starting with the zeroth entry and ending with the entry count-1. If the count is 1, the
        /// value is a percent. uInt16Number[]
        var bgCurve: [UInt16] = []
        bgCurve.reserveCapacity(Int(self.bgCount))
        for _ in 0..<self.bgCount {
            bgCurve.append(try dataStream.read(endianess: .bigEndian))
        }
        
        self.bgCurve = bgCurve
        
        /// n+1..p a string of ASCII characters, with a null terminator. 7-bit ASCII
        self.string = try dataStream.readAsciiString()!
        
        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }
}
