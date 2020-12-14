//
//  screeningType.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// [ICC.1:2001-04] 6.5.15 screeningType
/// The screeningType describes various screening parameters including screen frequency, screening angle, and spot shape.
public struct screeningType {
    public let sig: TagTypeSignature
    public let reserved: uInt32Number
    public let screeningFlag: ScreeningFlag
    public let numberOfChannels: UInt32
    public let channels: [Channel]
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position
        
        guard size >= 16 && (size - 16) % 12 == 0 else {
            throw ICCReadError.corrupted
        }
        
        /// 0..3 ‘scrn’ (7363726Eh) type signature
        self.sig = try TagTypeSignature(dataStream: &dataStream)
        guard self.sig ==  .screeningType else {
            throw ICCReadError.corrupted
        }
        
        /// 4..7 reserved, must be set to 0
        self.reserved = try dataStream.read(endianess: .bigEndian)
        
        /// 8..11 screening flag see below
        self.screeningFlag = try ScreeningFlag(dataStream: &dataStream)

        /// 12..15 number of channels
        self.numberOfChannels = try dataStream.read(endianess: .bigEndian)
        guard 12 + self.numberOfChannels * 12 == size else {
            throw ICCReadError.corrupted
        }
        
        /// 16..19 channel #1 frequency s15Fixed16Number
        /// 20..23 channel #1 screen angle (degrees) s15Fixed16Number
        /// 24..27 channel #1 spot shape see below
        /// 28..end frequency, screen angle, and spot shape for additional channels
        var channels: [Channel] = []
        channels.reserveCapacity(Int(self.numberOfChannels))
        for _ in 0..<self.numberOfChannels {
            channels.append(try Channel(dataStream: &dataStream))
        }
        
        self.channels = channels
        
        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }
    
    /// 8..11 screening flag see below
    /// Screening flag encoding is such that:
    public struct ScreeningFlag {
        public let usePrinterDefaultScreens: Bool
        public let frequencyUnitsInLinesPerInch: Bool
        public let unused: UInt32
        
        public init(dataStream: inout DataStream) throws {
            var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .bigEndian)
            
            /// Use Printer Default Screens (true is 1) 0
            self.usePrinterDefaultScreens = flags.readBit()
            
            /// Frequency units in Lines/Inch (value 1) or Lines/cm (value 0) 1
            self.frequencyUnitsInLinesPerInch = flags.readBit()
            
            self.unused = flags.readRemainingBits()
        }
    }
    
    public struct Channel {
        public let frequency: s15Fixed16Number
        public let screenAngle: s15Fixed16Number
        public let spotShape: SpotFunction
        
        public init(dataStream: inout DataStream) throws {
            /// 16..19 channel #1 frequency s15Fixed16Number
            self.frequency = try s15Fixed16Number(dataStream: &dataStream)
            
            /// 20..23 channel #1 screen angle (degrees) s15Fixed16Number
            self.screenAngle = try s15Fixed16Number(dataStream: &dataStream)
            
            /// 24..27 channel #1 spot shape see below
            self.spotShape = try SpotFunction(dataStream: &dataStream)
        }
        
        /// Spot function encoding is such that:
        public enum SpotFunction: UInt32 {
            /// unknown 0
            case unknown = 0
            
            /// printer default 1
            case printerDefault = 1
            
            /// round 2
            case round = 2
            
            /// diamond 3
            case diamond = 3
            
            /// ellipse 4
            case ellipse = 4
            
            /// line 5
            case line = 5
            
            /// square 6
            case square = 6
            
            /// cross 7
            case cross = 7
            
            public init(dataStream: inout DataStream) throws {
                let rawValue: UInt32 = try dataStream.read(endianess: .bigEndian)
                guard let value = Self(rawValue: rawValue) else {
                    throw ICCReadError.corrupted
                }
                
                self = value
            }
        }
    }
}
