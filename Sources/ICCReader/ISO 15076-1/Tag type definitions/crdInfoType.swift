//
//  crdInfoType.swift
//  
//
//  Created by Hugh Bellamy on 14/12/2020.
//

import DataStream

/// [ICC.1:2001-04] 6.5.2 crdInfoType
/// This type contains the PostScript product name to which this profile corresponds and the names of the companion CRDs.
/// Recall that a single profile can generate multiple CRDs.
/// If a companion CRD is not available for a given profile, then the character count field is zero and there is no string.
/// See C.1 for more information.
/// Note: It has been found that crdInfoType can contain misaligned data (see 4.1 for the definition of “aligned”). Because the CRD
/// character counts immediately follow variable-length ASCII strings, their alignment is not correct when the length of any of the
/// receding strings is not a multiple of four. Profile reading and writing software must be written carefully in order to handle these
/// alignment problems.
public struct crdInfoType {
    public let sig: ICCSignature
    public let reserved: uInt32Number
    public let productNameCount: uInt32Number
    public let productName: String
    public let renderingIntent1Count: uInt32Number
    public let renderingIntent1: String
    public let renderingIntent2Count: uInt32Number
    public let renderingIntent2: String
    public let renderingIntent3Count: uInt32Number
    public let renderingIntent3: String
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position
        
        guard size >= 24 else {
            throw ICCReadError.corrupted
        }
        
        /// 0..3 ‘crdi’ (63726469h) type signature
        self.sig = try ICCSignature(dataStream: &dataStream)
        guard self.sig ==  ICCTagTypeSignature.crdInfo else {
            throw ICCReadError.corrupted
        }
        
        /// 4..7 reserved, must be set to 0
        self.reserved = try dataStream.read(endianess: .bigEndian)
        
        /// 8..11 PostScript product name character count, including terminating null uInt32Number
        self.productNameCount = try dataStream.read(endianess: .bigEndian)
        guard 24 + self.productNameCount <= size else {
            throw ICCReadError.corrupted
        }
        
        /// m+4..n-1 Rendering intent 0 CRD name string 7-bit ASCII
        if self.productNameCount > 0 {
            self.productName = try dataStream.readString(count: Int(self.productNameCount) - 1, encoding: .ascii)!
            let nullTerminator: UInt8 = try dataStream.read()
            guard nullTerminator == 0x00 else {
                throw ICCReadError.corrupted
            }
        } else {
            self.productName = ""
        }
        
        /// n..n+3 Rendering intent 1 CRD character count, including terminating null uInt32Number
        self.renderingIntent1Count = try dataStream.read(endianess: .bigEndian)
        guard 24 + self.productNameCount + self.renderingIntent1Count <= size else {
            throw ICCReadError.corrupted
        }
       
        /// n+4..p-1 Rendering intent 1 CRD name string 7-bit ASCII
        if self.renderingIntent1Count > 0 {
            self.renderingIntent1 = try dataStream.readString(count: Int(self.renderingIntent1Count) - 1, encoding: .ascii)!
            let nullTerminator: UInt8 = try dataStream.read()
            guard nullTerminator == 0x00 else {
                throw ICCReadError.corrupted
            }
        } else {
            self.renderingIntent1 = ""
        }
        
        /// p..p+3 Rendering intent 2 CRD character count, including terminating null uInt32Number
        self.renderingIntent2Count = try dataStream.read(endianess: .bigEndian)
        guard 24 + self.productNameCount + self.renderingIntent1Count + self.renderingIntent2Count <= size else {
            throw ICCReadError.corrupted
        }
        
        /// p+4..q-1 Rendering intent 2 CRD name string 7-bit ASCII
        if self.renderingIntent2Count > 0 {
            self.renderingIntent2 = try dataStream.readString(count: Int(self.renderingIntent2Count) - 1, encoding: .ascii)!
            let nullTerminator: UInt8 = try dataStream.read()
            guard nullTerminator == 0x00 else {
                throw ICCReadError.corrupted
            }
        } else {
            self.renderingIntent2 = ""
        }
        
        /// q..q+3 Rendering intent 3 CRD character count, including terminating null uInt32Number
        self.renderingIntent3Count = try dataStream.read(endianess: .bigEndian)
        guard 24 + self.productNameCount + self.renderingIntent1Count + self.renderingIntent2Count + self.renderingIntent3Count <= size else {
            throw ICCReadError.corrupted
        }

        /// q+4..r Rendering intent 3 CRD name string 7-bit ASCII
        if self.renderingIntent3Count > 0 {
            self.renderingIntent3 = try dataStream.readString(count: Int(self.renderingIntent3Count) - 1, encoding: .ascii)!
            let nullTerminator: UInt8 = try dataStream.read()
            guard nullTerminator == 0x00 else {
                throw ICCReadError.corrupted
            }
        } else {
            self.renderingIntent3 = ""
        }
        
        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }
}
