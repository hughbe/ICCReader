//
//  File.swift
//  
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// ICC.1:2001-04: 6.5.17 textDescriptionType
/// The textDescriptionType is a complex structure that contains three types of text description structures: 7-bit ASCII, Unicode and
/// ScriptCode. Since no single standard method for specifying localizable character sets exists across the major platform vendors,
/// including all three provides access for the major operating systems. The 7-bit ASCII description is to be an invariant, nonlocalizable
/// name for consistent reference.
/// It is preferred that both the Unicode and ScriptCode structures be properly localized.
/// Some applications look for special strings of text in the descriptions. These strings are delimited by << and >> tokens, and need
/// to remain constant. Therefore, avoid translating or otherwise modifying text of the form "<<text>>" when localizing a profile.
/// The localized Macintosh profile description contains 67 bytes of data, of which at most count bytes contain a ScriptCode string,
/// including a null terminator. The count cannot be greater than 67.
/// The count field for each types are defined as follows:
/// ASCII: The count is the length of the string in bytes including the null terminator.
/// Unicode: The count is the number of characters including a Unicode null where a character is always two bytes.
/// ScriptCode: The count is the length of the string in bytes including the terminating null.
/// If both Unicode and ScriptCode structures cannot be localized then the following guidelines should be used:
/// If Unicode is not native on the platform, then the Unicode language code and Unicode count should be filled in as 0, with no data
/// placed in the Unicode localizable profile description area.
/// If Scriptcode is not native on the platform, then the ScriptCode code and ScriptCode count should be filled in as 0. The 67-byte
/// localizable Macintosh profile description should be filled with 0’s.
/// Note: It has been found that textDescriptionType can contain misaligned data (see 4.1 for the definition of “aligned”). Because the
/// Unicode language code and Unicode count immediately follow the ASCII description, their alignment is not correct when the ASCII
/// count is not a multiple of four. The ScriptCode code is misaligned when the ASCII count is odd. Profile reading and writing software
/// must be written carefully in order to handle these alignment problems.
public struct textDescriptionType {
    public let sig: TagTypeSignature
    public let reserved: uInt32Number
    public let count: UInt32
    public let desc: String
    public let ucLangCode: UInt32
    public let ucCount: UInt32
    public let ucDesc: String
    public let scCode: UInt16
    public let scCount: UInt8
    public let scDesc: String
    
    public init(dataStream: inout DataStream, size: UInt32?) throws {
        let startPosition = dataStream.position

        /// Note: seen some files that don't include the scode
        if let size = size {
            guard size >= 23 else {
                throw ICCReadError.corrupted
            }
        }
        
        /// 0..3 ‘desc’ (64657363h) type signature
        self.sig = try TagTypeSignature(dataStream: &dataStream)
        guard self.sig ==  .textDescriptionType else {
            throw ICCReadError.corrupted
        }
        
        /// 4..7 reserved, must be set to 0
        self.reserved = try dataStream.read(endianess: .bigEndian)
        
        /// 8..11 ASCII invariant description count, including terminating null (description length) uInt32Number
        self.count = try dataStream.read(endianess: .bigEndian)
        if let size = size {
            guard 23 + Int(self.count) <= size else {
                throw ICCReadError.corrupted
            }
        }
        
        /// 12..n-1 ASCII invariant description 7-bit ASCII
        if self.count > 0 {
            self.desc = try dataStream.readAsciiString()!
        } else {
            self.desc = ""
        }
        
        /// n..n+3 Unicode language code uInt32Number
        self.ucLangCode = try dataStream.read(endianess: .bigEndian)
        
        /// n+4..n+7 Unicode localizable description count (description length) uInt32Number
        self.ucCount = try dataStream.read(endianess: .bigEndian)
        if let size = size {
            guard 23 + Int(self.count) + Int(self.ucCount) * 2 <= size else {
                // Seen invalid data.
                let remainingCount = Int(size) - (dataStream.position - startPosition)
                if remainingCount > 0 {
                    guard dataStream.position + remainingCount <= dataStream.count else {
                        throw ICCReadError.corrupted
                    }
                    
                    dataStream.position += remainingCount
                }
                

                self.ucDesc = "";
                self.scCode = 0;
                self.scCount = 0;
                self.scDesc = "";
                return;
            }
        }

        /// n+8..m-1 Unicode localizable description
        if self.ucCount > 0 {
            self.ucDesc = try dataStream.readString(count: Int(self.ucCount) * 2, encoding: .utf16BigEndian)!
                .trimmingCharacters(in: ["\0"])
        } else {
            self.ucDesc = ""
        }
        
        /// m..m+1 ScriptCode code uInt16Number
        self.scCode = try dataStream.read(endianess: .bigEndian)
        
        /// m+2 Localizable Macintosh description count (description length) uInt8Number
        self.scCount = try dataStream.read()
        guard self.scCount <= 67 else {
            throw ICCReadError.corrupted
        }
        if let size = size {
            guard 23 + Int(self.count) + Int(self.ucCount) * 2 + Int(self.scCount) * 1 <= size else {
                throw ICCReadError.corrupted
            }
        }
        
        /// m+3..m+69 Localizable Macintosh description
        if self.scCount > 0 {
            self.scDesc = try dataStream.readString(count: Int(self.scCount), encoding: .ascii)!
                .trimmingCharacters(in: ["\0"])
        } else {
            self.scDesc = ""
        }
        
        /// Seen some profiles that don't contain the scode field fully.
        let remainingScData = 67 - Int(self.scCount)
        let remainingCount: Int
        if let size = size {
            remainingCount = Int(size) - (dataStream.position - startPosition)
        } else {
            remainingCount = remainingScData
        }

        let dataToRead = min(remainingScData, remainingCount)
        guard dataStream.position + dataToRead <= dataStream.count else {
            throw ICCReadError.corrupted
        }
        
        dataStream.position += dataToRead
        
        if let size = size {
            /// Seen padding.
            let remainingCount = Int(size) - (dataStream.position - startPosition)
            if remainingCount > 0 {
                guard dataStream.position + remainingCount <= dataStream.count else {
                    throw ICCReadError.corrupted
                }
                
                dataStream.position += remainingCount
            }
            
            guard dataStream.position - startPosition == size else {
                throw ICCReadError.corrupted
            }
        }
    }
}
