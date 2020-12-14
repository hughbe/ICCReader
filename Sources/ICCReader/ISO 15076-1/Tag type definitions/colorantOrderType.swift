//
//  colorantOrderType.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// [ICC.1:2010] 10.3 colorantOrderType
/// This is an optional tag which specifies the laydown order in which colorants will be printed on an n-colorant device. The laydown
/// order may be the same as the channel generation order listed in the colorantTableTag or the channel order of a colour encoding
/// type such as CMYK, in which case this tag is not needed. When this is not the case (for example, ink-towers sometimes use the
/// order KCMY), this tag may be used to specify the laydown order of the colorants. When used the byte assignments shall be as
/// given in Table 32.
/// The size of the array is the same as the number of colorants. The first position in the array contains the number of the first colorant
/// to be laid down, the second position contains the number of the second colorant to be laid down, and so on, until all colorants are listed.
/// When this tag is used, the “count of colorants” shall be in agreement with the data colour space signature of 7.2.6.
public struct colorantOrderType {
    public let sig: TagTypeSignature
    public let reserved: uInt32Number
    public let count: uInt32Number
    public let values: [uInt8Number]
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position
        
        guard size >= 12 else {
            throw ICCReadError.corrupted
        }
        
        /// 0 to 3 4 ‘clro’ (636c726fh) type signature
        self.sig = try TagTypeSignature(dataStream: &dataStream)
        guard self.sig ==  .colorantOrderType else {
            throw ICCReadError.corrupted
        }
        
        /// 4 to 7 4 Reserved, shall be set to 0
        self.reserved = try dataStream.read(endianess: .bigEndian)
        
        /// 8 to 11 4 Count of colorants (n) uInt32Number
        self.count = try dataStream.read(endianess: .bigEndian)
        guard 12 + self.count == size else {
            throw ICCReadError.corrupted
        }
        
        /// 12 1 Number of the colorant to be printed first. uInt8Number 13 to
        /// (11+n) n−1 The remaining n−1 colorants are described in a manner consistent with the first colorant uInt8Number
        self.values = try dataStream.readBytes(count: Int(self.count))
        
        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }
}
