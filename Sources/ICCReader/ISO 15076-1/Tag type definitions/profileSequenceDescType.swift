//
//  profileSequenceDescType.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// [ICC.1:2010] 10.17 profileSequenceDescType
/// This type is an array of structures, each of which contains information from the header fields and tags from the original profiles which
/// were combined to create the final profile. The order of the structures is the order in which the profiles were combined and includes
/// a structure for the final profile. This provides a description of the profile sequence from source to destination, typically used with
/// the DeviceLink profile.
/// When used the byte assignment and structure shall be as given in Table 66.
/// Each profile description structure has the format shown in Table 67.
/// If the deviceMfgDescTag and/or deviceModelDescTag is not present in a component profile, then a “placeholder” tag should be
/// inserted. This tag should have a 0 in the number of names field in the multiLocalizedUnicodeType structure with no name record
/// or strings.
/// Also note that the entire tag, including the tag type, should be stored.
/// If the technologyTag is not present, bytes 16 to 19 should be 00000000h.
public struct profileSequenceDescType {
    public let sig: ICCSignature
    public let reserved: uInt32Number
    public let count: UInt32
    public let values: [ProfileDescription]
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position
        
        guard size >= 12 else {
            throw ICCReadError.corrupted
        }
        
        /// 0 to 3 4 ‘pseq’ (70736571h) type signature
        self.sig = try ICCSignature(dataStream: &dataStream)
        guard self.sig ==  ICCTagTypeSignature.profileSequenceDesc else {
            throw ICCReadError.corrupted
        }
        
        /// 4 to 7 4 Reserved, shall be set to 0
        self.reserved = try dataStream.read(endianess: .bigEndian)
        
        /// 8 to 11 4 Count value specifying number of description structures in the array
        self.count = try dataStream.read(endianess: .bigEndian)
        guard 12 + self.count * 20 <= size else {
            throw ICCReadError.corrupted
        }
        
        /// 12 to end Variable Count profile description structures, see Table 67
        var values: [ProfileDescription] = []
        values.reserveCapacity(Int(self.count))
        for _ in 0..<self.count {
            values.append(try ProfileDescription(dataStream: &dataStream, startPosition: startPosition, size: size))
        }
        
        self.values = values
        
        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }
    
    public struct ProfileDescription {
        public let manufacturer: UInt32
        public let model: UInt32
        public let attributes: UInt64
        public let technology: UInt32
        public let manufacturerDescription: textDescriptionOrMultiLocalizedUnicodeTextType?
        public let modelDescription: textDescriptionOrMultiLocalizedUnicodeTextType?
        
        public init(dataStream: inout DataStream, startPosition: Int, size: UInt32) throws {
            /// 0 to 3 4 Device manufacturer Signature (from corresponding profile’s header)
            self.manufacturer = try dataStream.read(endianess: .bigEndian)
            
            /// 4 to 7 4 Device model Signature (from corresponding profile’s header)
            self.model = try dataStream.read(endianess: .bigEndian)
            
            /// 8 to 15 8 Device attributes (from corresponding profile’s header)
            self.attributes = try dataStream.read(endianess: .bigEndian)
            
            /// 16 to 19 4 Device technology information such as CRT, dye sublimation, etc. (corresponding to profile’s technology
            /// Signature)
            self.technology = try dataStream.read(endianess: .bigEndian)
            
            if dataStream.position - startPosition == size {
                self.manufacturerDescription = nil
                self.modelDescription = nil
                return
            }
            
            /// 20 to m Variable Displayable description of device manufacturer (profile’s deviceMfgDescTag)
            self.manufacturerDescription = try textDescriptionOrMultiLocalizedUnicodeTextType(dataStream: &dataStream, size: nil)
            
            if dataStream.position - startPosition == size {
                self.modelDescription = nil
                return
            }
            
            /// m+1 to n Variable Displayable description of device model (profile’s deviceModelDescTag)
            self.modelDescription = try textDescriptionOrMultiLocalizedUnicodeTextType(dataStream: &dataStream, size: nil)
        }
    }
}
