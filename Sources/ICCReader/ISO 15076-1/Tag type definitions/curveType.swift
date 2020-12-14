//
//  curveType.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// [ICC.1:2010] 10.5 curveType
/// The curveType contains a 4-byte count value and a one-dimensional table of 2-byte values. When used the byte assignment shall be
/// as given in Table 34.
public struct curveType {
    public let sig: TagTypeSignature
    public let reserved: uInt32Number
    public let count: UInt32
    public let data: CurveData
    
    public enum CurveData {
        case identity
        case gamma(_: u8Fixed8Number)
        case values(_: [UInt16])
    }
    
    public init(dataStream: inout DataStream, size: UInt32?) throws {
        let startPosition = dataStream.position
        
        if let size = size {
            guard size >= 12 && (size - 12) % 2 == 0 else {
                throw ICCReadError.corrupted
            }
        }
        
        /// 0 to 3 4 ‘curv’ (63757276h) type signature
        self.sig = try TagTypeSignature(dataStream: &dataStream)
        guard self.sig ==  .curveType else {
            throw ICCReadError.corrupted
        }
        
        /// 4 to 7 4 Reserved, shall be set to 0
        self.reserved = try dataStream.read(endianess: .bigEndian)
        
        /// 8 to 11 4 Count value specifying the number of entries (n) that follow uInt32Number
        self.count = try dataStream.read(endianess: .bigEndian)
        if let size = size {
            guard 12 + self.count * 2 <= size else {
                throw ICCReadError.corrupted
            }
        }
        
        /// 12 to end 2n* Actual curve values starting with the zeroth entry and ending with the entry n −1 uInt16Number [...]
        /// * If n = 1, the field length is 1 and the value is encoded as a u8Fixed8Number
        if self.count == 0 {
            self.data = .identity
        } else if self.count == 1 {
            self.data = .gamma(try u8Fixed8Number(dataStream: &dataStream))
        } else {
            var values: [UInt16] = []
            values.reserveCapacity(Int(self.count))
            for _ in 0..<self.count {
                values.append(try dataStream.read(endianess: .bigEndian))
            }
            
            self.data = .values(values)
        }
        
        if let size = size {
            /// Seen padding
            if dataStream.position - startPosition < size {
                try dataStream.readFourByteAlignmentPadding(startPosition: startPosition)
            }

            guard dataStream.position - startPosition == size else {
                throw ICCReadError.corrupted
            }
        }
    }
}
