//
//  videoCardGammaTableType.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// https://github.com/akavel/plan9/blob/master/sys/src/cmd/gs/icclib/icc.h#L706-L738
/// https://github.com/OpenICC/xcalib/blob/master/xcalib.c
public struct videoCardGammaTableType {
    public let sig: TagTypeSignature
    public let reserved: uInt32Number
    public let gammaType: GammaType
    public let data: GammaData
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position
        
        guard size >= 18 else {
            throw ICCReadError.corrupted
        }
        
        /// 0 to 3 4 ‘vcgt’ (76636774h) type signature
        self.sig = try TagTypeSignature(dataStream: &dataStream)
        guard self.sig ==  .videoCardGammaTableType else {
            throw ICCReadError.corrupted
        }
        
        /// 4 to 7 4 Reserved, shall be set to 0
        self.reserved = try dataStream.read(endianess: .bigEndian)
        
        /// 8 to 11 GammaType
        let gammaTypeRaw: UInt32 = try dataStream.read(endianess: .bigEndian)
        guard let gammaType = GammaType(rawValue: gammaTypeRaw) else {
            throw ICCReadError.corrupted
        }
        
        self.gammaType = gammaType
        
        /// Data - depends on type.
        switch gammaType {
        case .table:
            self.data = .table(try GammaTable(dataStream: &dataStream, size: size))
        case .formula:
            self.data = .formula(try GammaFormula(dataStream: &dataStream, size: size))
        }
        
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
    
    /// 8 to 11 GammaType
    public enum GammaType: UInt32 {
        case table = 0
        case formula = 1
    }

    public enum GammaData {
        case table(_: GammaTable)
        case formula(_: GammaFormula)
    }
    
    public struct GammaTable {
        public let channels: UInt16
        public let entryCount: UInt16
        public let entrySize: UInt16
        public let data: Data
        
        public init(dataStream: inout DataStream, size: UInt32) throws {
            guard size >= 18 else {
                throw ICCReadError.corrupted
            }
            
            /// unsigned short   channels;        /* # of gamma channels (1 or 3) */
            let channels: UInt16 = try dataStream.read(endianess: .bigEndian)
            guard channels == 1 || channels == 3 else {
                throw ICCReadError.corrupted
            }
            
            self.channels = channels
            
            /// unsigned short   entryCount;     /* 1-based number of entries per channel */
            self.entryCount = try dataStream.read(endianess: .bigEndian)
            
            /// unsigned short   entrySize;        /* size in bytes of each entry */
            let entrySize: UInt16 = try dataStream.read(endianess: .bigEndian)
            guard entrySize == 1 || entrySize == 2 else {
                throw ICCReadError.corrupted
            }
            
            let dataLength = Int(self.channels) * Int(self.entryCount)
            guard 18 + dataLength * Int(entrySize) <= size else {
                throw ICCReadError.corrupted
            }
            
            self.entrySize = entrySize
            
            /// void            *data;            /* variable size data */
            if entrySize == 1 {
                self.data = .uint8(try dataStream.readBytes(count: dataLength))
            } else {
                var data: [UInt16] = []
                data.reserveCapacity(dataLength)
                for _ in 0..<dataLength {
                    data.append(try dataStream.read(endianess: .bigEndian))
                }
                
                self.data = .uint16(data)
            }
        }
        
        public enum Data {
            case uint8(_: [UInt8])
            case uint16(_: [UInt16])
        }
    }
    
    public struct GammaFormula {
        public let redGamma: s15Fixed16Number
        public let redMin: s15Fixed16Number
        public let redMax: s15Fixed16Number
        public let greenGamma: s15Fixed16Number
        public let greenMin: s15Fixed16Number
        public let greenMax: s15Fixed16Number
        public let blueGamma: s15Fixed16Number
        public let blueMin: s15Fixed16Number
        public let blueMax: s15Fixed16Number
        
        public init(dataStream: inout DataStream, size: UInt32) throws {
            guard size == 48 else {
                throw ICCReadError.corrupted
            }
            
            /// double           redGamma;        /* must be > 0.0 */
            self.redGamma = try s15Fixed16Number(dataStream: &dataStream) 
            
            /// double           redMin;        /* must be > 0.0 and < 1.0 */
            self.redMin = try s15Fixed16Number(dataStream: &dataStream)
            
            /// double           redMax;        /* must be > 0.0 and < 1.0 */
            self.redMax = try s15Fixed16Number(dataStream: &dataStream)
            
            /// double           greenGamma;       /* must be > 0.0 */
            self.greenGamma = try s15Fixed16Number(dataStream: &dataStream)
            
            /// double           greenMin;        /* must be > 0.0 and < 1.0 */
            self.greenMin = try s15Fixed16Number(dataStream: &dataStream)
            
            /// double           greenMax;        /* must be > 0.0 and < 1.0 */
            self.greenMax = try s15Fixed16Number(dataStream: &dataStream)
            
            /// double           blueGamma;        /* must be > 0.0 */
            self.blueGamma = try s15Fixed16Number(dataStream: &dataStream)
            
            /// double           blueMin;        /* must be > 0.0 and < 1.0 */
            self.blueMin = try s15Fixed16Number(dataStream: &dataStream)
            
            /// double           blueMax;        /* must be > 0.0 and < 1.0 */
            self.blueMax = try s15Fixed16Number(dataStream: &dataStream)
        }
    }
}
