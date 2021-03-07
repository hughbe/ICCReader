//
//  deviceSettingsType.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// [ICC.1:2001-04] 6.5.6 deviceSettingsType
/// This type is an array of structures each of which contains platform-specific information about the settings of the device for which
/// this profile is valid.
public struct deviceSettingsType {
    public let sig: ICCSignature
    public let reserved: uInt32Number
    public let count: uInt32Number
    public let entries: [PlatformEntry]
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position
        
        guard size >= 12 else {
            throw ICCReadError.corrupted
        }
        
        /// 0..3 ‘devs’ (64657673h) type signature
        self.sig = try ICCSignature(dataStream: &dataStream)
        guard self.sig ==  ICCTagTypeSignature.deviceSettings else {
            throw ICCReadError.corrupted
        }
        
        /// 4..7 reserved, must be set to 0
        self.reserved = try dataStream.read(endianess: .bigEndian)
        
        /// 8..11 count value specifying number of platform entry structures uInt32Number
        self.count = try dataStream.read(endianess: .bigEndian)
        guard 12 + self.count * 12 <= size else {
            throw ICCReadError.corrupted
        }
        
        /// 12..end count platform entry structures see below
        var entries: [PlatformEntry] = []
        entries.reserveCapacity(Int(self.count))
        for _ in 0..<self.count {
            entries.append(try PlatformEntry(dataStream: &dataStream))
        }
        
        self.entries = entries
        
        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }
    
    /// 12..end count platform entry structures see below
    /// Each platform entry structure has the following format:
    public struct PlatformEntry {
        public let sig: ICCSignature
        public let size: uInt32Number
        public let count: uInt32Number
        public let settingCombinations: [SettingCombination]
        
        public init(dataStream: inout DataStream) throws {
            let startPosition = dataStream.position
            
            /// 0..3 platform ID signature (one of the Primary Platform signatures from Table 15)
            self.sig = try ICCSignature(dataStream: &dataStream)
            
            /// 4..7 size of this structure (including all of its substructures) in bytes uInt32Number
            self.size = try dataStream.read(endianess: .bigEndian)
            guard self.size >= 12 else {
                throw ICCReadError.corrupted
            }
            
            /// 8..11 count value specifying number of setting combinations structures uInt32Number
            self.count = try dataStream.read(endianess: .bigEndian)
            guard 12 + self.count * 8 <= size else {
                throw ICCReadError.corrupted
            }
            
            /// 12..end count setting combinations structures see below
            var settingCombinations: [SettingCombination] = []
            settingCombinations.reserveCapacity(Int(self.count))
            for _ in 0..<self.count {
                settingCombinations.append(try SettingCombination(dataStream: &dataStream, platformSignature: self.sig))
            }
            
            self.settingCombinations = settingCombinations
            
            guard dataStream.position - startPosition == self.size else {
                throw ICCReadError.corrupted
            }
        }
    }
    
    /// 12..end count setting combinations structures see below
    /// Each setting combinations structure has the following format:
    public struct SettingCombination {
        public let size: uInt32Number
        public let count: uInt32Number
        public let settings: [Setting]
        
        public init(dataStream: inout DataStream, platformSignature: ICCSignature) throws {
            let startPosition = dataStream.position
            
            /// 0..3 size of this structure (including all of its substructures) in bytes uInt32Number
            self.size = try dataStream.read(endianess: .bigEndian)
            guard self.size >= 8 else {
                throw ICCReadError.corrupted
            }
            
            /// 4..7 count value specifying number of setting structures uInt32Number
            self.count = try dataStream.read(endianess: .bigEndian)
            guard 8 + self.count * 12 <= size else {
                throw ICCReadError.corrupted
            }
            
            /// 8..n count setting structures see below
            var settings: [Setting] = []
            settings.reserveCapacity(Int(self.count))
            for _ in 0..<self.count {
                let remainingCount = self.size - UInt32(dataStream.position - startPosition)
                settings.append(try Setting(dataStream: &dataStream, platformSignature: platformSignature, availableSize: remainingCount))
            }
            
            self.settings = settings
            
            guard dataStream.position - startPosition == self.size else {
                throw ICCReadError.corrupted
            }
        }
    }
    
    /// Each setting structure has the following format:
    /// 8..n count setting structures see below
    public struct Setting {
        public let signature: ICCSignature
        public let size: uInt32Number
        public let count: uInt32Number
        public let values: [SettingValue]
        
        public init(dataStream: inout DataStream, platformSignature: ICCSignature, availableSize: UInt32) throws {
            let startPosition = dataStream.position
            
            guard availableSize >= 12 else {
                throw ICCReadError.corrupted
            }
            
            /// 0..3 setting ID signature see below
            self.signature = try ICCSignature(dataStream: &dataStream)
            
            /// 4..7 size (in bytes) per setting value uInt32Number
            self.size = try dataStream.read(endianess: .bigEndian)
            
            /// 8..11 count value specifying number of setting values uInt32Number
            self.count = try dataStream.read(endianess: .bigEndian)
            guard 12 + self.count * self.size <= availableSize else {
                throw ICCReadError.corrupted
            }
            
            var values: [SettingValue] = []
            values.reserveCapacity(Int(self.count))
            for _ in 0..<self.count {
                values.append(try SettingValue(dataStream: &dataStream, platformSignature: platformSignature, idSignature: self.signature, size: size))
            }
            
            self.values = values
            
            guard dataStream.position - startPosition <= availableSize else {
                throw ICCReadError.corrupted
            }
        }
    }
    
    public enum SettingValue {
        case unknown(data: [UInt8])
        case msftResolution(_: uInt64Number)
        case msftMediaType(_: MSFTMediaType)
        case msftHalftone(_: MSFTHalftone)
        
        public init(dataStream: inout DataStream, platformSignature: ICCSignature, idSignature: ICCSignature, size: UInt32) throws {
            switch platformSignature {
            case ICCColorProfilePlatformSignature.microsoftCorporation,
                 ICCColorProfilePlatformSignature.microsoftCorporation2:
                switch idSignature.rawValue {
                case MSFTSettingSignature.resolution.rawValue:
                    guard size == 8 else {
                        throw ICCReadError.corrupted
                    }
                    
                    self = .msftResolution(try dataStream.read(endianess: .bigEndian))
                case MSFTSettingSignature.mediaType.rawValue:
                    guard size == 4 else {
                        throw ICCReadError.corrupted
                    }
                    
                    self = .msftMediaType(try MSFTMediaType(dataStream: &dataStream))
                case MSFTSettingSignature.halftone.rawValue:
                    guard size == 4 else {
                        throw ICCReadError.corrupted
                    }
                    
                    self = .msftHalftone(try MSFTHalftone(dataStream: &dataStream))
                default:
                    self = .unknown(data: try dataStream.readBytes(count: Int(size)))
                }
            default:
                self = .unknown(data: try dataStream.readBytes(count: Int(size)))
            }
        }
    }
    
    /// 0..3 setting ID signature see below
    /// Setting ID signatures are specific to the enclosing platform ID. More settings can be added in the future by the ICC.
    /// The currently defined setting ID signatures and values for the ’MSFT’ (Microsoft) platform are encoded as follows:
    public enum MSFTSettingSignature: String {
        /// Resolution: X resolution (dpi) in the least-significant 32 bits, Y resolution (dpi) in the most-significant 32 bits ‘rsln’
        /// 72736C6Eh uInt64Number (8 bytes per value)
        case resolution = "rsln"
        
        /// Media type (see below) ‘mtyp’ 6D747970h uInt32Number (4 bytes per value)
        case mediaType = "mtyp"
        
        /// Halftone (see below) ‘hftn’ 6866746Eh uInt32Number (4 bytes per value)
        case halftone = "hftn"
    }
    
    /// Media type (see below) ‘mtyp’ 6D747970h uInt32Number (4 bytes per value)
    /// Media type values for the ‘MSFT’ (Microsoft) platform are defined as follows:
    public enum MSFTMediaType {
        /// DMMEDIA_STANDARD (Standard paper) 1
        case standard
        
        /// DMMEDIA_TRANSPARENCY (Transparency) 2
        case transparent
        
        /// DMMEDIA_GLOSSY (Glossy paper) 3
        case glossy
        
        /// DMMEDIA_USER (Device-specific media are >= 256) 256
        case userDefined(value: UInt32)
        
        public init(dataStream: inout DataStream) throws {
            let value: UInt32 = try dataStream.read(endianess: .bigEndian)
            switch value {
            case 1:
                self = .standard
            case 2:
                self = .transparent
            case 3:
                self = .glossy
            case let value where value >= 256:
                self = .userDefined(value: value)
            default:
                throw ICCReadError.corrupted
            }
        }
    }
    
    /// Halftone (see below) ‘hftn’ 6866746Eh uInt32Number (4 bytes per value)
    /// Halftone values for the ‘MSFT’ (Microsoft) platform are defined as follows:
    public enum MSFTHalftone {
        /// DMDITHER_NONE (No dithering) 1
        case none
        
        /// DMDITHER_COARSE (Dither with a coarse brush) 2
        case coarse
        
        /// DMDITHER_FINE (Dither with a fine brush) 3
        case fine
        
        /// DMDITHER_LINEART (LineArt dithering) 4
        case lineArt
        
        /// DMDITHER_ERRORDIFFUSION (LineArt dithering) 5
        case errorDiffusion
        
        /// DMDITHER_RESERVED6 (LineArt dithering) 6
        case reserved6
        
        /// DMDITHER_RESERVED7 (LineArt dithering) 7
        case reserved7
        
        /// DMDITHER_RESERVED8 (LineArt dithering) 8
        case reserved8
        
        /// DMDITHER_RESERVED9 (LineArt dithering) 9
        case reserved9
        
        /// DMDITHER_GRAYSCALE (Device does grayscaling) 10
        case grayscale
        
        /// DMDITHER_USER (Device-specific halftones are >= 256) 256
        case userDefined(value: UInt32)
        
        public init(dataStream: inout DataStream) throws {
            let value: UInt32 = try dataStream.read(endianess: .bigEndian)
            switch value {
            case 1:
                self = .none
            case 2:
                self = .coarse
            case 3:
                self = .fine
            case 4:
                self = .lineArt
            case 5:
                self = .errorDiffusion
            case 6:
                self = .reserved6
            case 7:
                self = .reserved7
            case 8:
                self = .reserved8
            case 9:
                self = .reserved9
            case 10:
                self = .grayscale
            case let value where value >= 256:
                self = .userDefined(value: value)
            default:
                throw ICCReadError.corrupted
            }
        }
    }
}
