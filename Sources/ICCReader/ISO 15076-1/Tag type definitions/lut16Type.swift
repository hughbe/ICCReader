//
//  lut8Type.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream
import Foundation

/// [ICC.1:2010] 10.8 lut16Type
/// This structure represents a colour transform using tables with 16-bit precision. This type contains four processing elements:
/// a 3 × 3 matrix (which shall be the identity matrix unless the input colour space is PCSXYZ), a set of one-dimensional input tables,
/// a multi-dimensional lookup table, and a set of one-dimensional output tables. Data is processed using these elements via the
/// following sequence:
/// (matrix) ⇒ (1D input tables) ⇒ (multi-dimensional lookup table, CLUT) ⇒ (1D output tables).
/// When used the byte assignment shall be as given in Table 37.
public struct lut16Type {
    public let sig: ICCSignature
    public let reserved: uInt32Number
    public let inputChan: UInt8
    public let outputChan: UInt8
    public let clutPoints: UInt8
    public let pad: UInt8
    public let e1: s15Fixed16Number
    public let e2: s15Fixed16Number
    public let e3: s15Fixed16Number
    public let e4: s15Fixed16Number
    public let e5: s15Fixed16Number
    public let e6: s15Fixed16Number
    public let e7: s15Fixed16Number
    public let e8: s15Fixed16Number
    public let e9: s15Fixed16Number
    public let inputTable: [UInt16]
    public let clutTable: [UInt16]
    public let outputTable: [UInt16]
    public let inputTableEntries: UInt16
    public let outputTableEntries: UInt16
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position
        
        guard size >= 8 else {
            throw ICCReadError.corrupted
        }
        
        /// 0 to 3 4 ‘mft2’ (6D667432h) [multi-function table with 2-byte precision] type signature
        self.sig = try ICCSignature(dataStream: &dataStream)
        guard self.sig ==  ICCTagTypeSignature.lut16 else {
            throw ICCReadError.corrupted
        }
        
        /// 4 to 7 4 Reserved, shall be set to 0
        self.reserved = try dataStream.read(endianess: .bigEndian)
        
        /// 8 1 Number of Input Channels (i) uInt8Number
        self.inputChan = try dataStream.read()
        
        /// 9 1 Number of Output Channels (o) uInt8Number
        self.outputChan = try dataStream.read()
        
        /// 10 1 Number of CLUT grid points (identical for each side) (g)
        self.clutPoints = try dataStream.read()
        
        /// 11 1 Reserved for padding (required to be 00h)
        self.pad = try dataStream.read()
        
        /// 12 to 15 4 Encoded e1 parameter s15Fixed16Number
        self.e1 = try s15Fixed16Number(dataStream: &dataStream)
        
        /// 16 to 19 4 Encoded e2 parameter s15Fixed16Number
        self.e2 = try s15Fixed16Number(dataStream: &dataStream)
        
        /// 20 to 23 4 Encoded e3 parameter s15Fixed16Number
        self.e3 = try s15Fixed16Number(dataStream: &dataStream)
        
        /// 24 to 27 4 Encoded e4 parameter s15Fixed16Number
        self.e4 = try s15Fixed16Number(dataStream: &dataStream)
        
        /// 28 to 31 4 Encoded e5 parameter s15Fixed16Number
        self.e5 = try s15Fixed16Number(dataStream: &dataStream)
        
        /// 32 to 35 4 Encoded e6 parameter s15Fixed16Number
        self.e6 = try s15Fixed16Number(dataStream: &dataStream)
        
        /// 36 to 39 4 Encoded e7 parameter s15Fixed16Number
        self.e7 = try s15Fixed16Number(dataStream: &dataStream)
        
        /// 40 to 43 4 Encoded e8 parameter s15Fixed16Number
        self.e8 = try s15Fixed16Number(dataStream: &dataStream)
        
        /// 44 to 47 4 Encoded e9 parameter s15Fixed16Number
        self.e9 = try s15Fixed16Number(dataStream: &dataStream)
        
        /// 48 to 49 4 Number of input table entries (n) uInt16Number
        self.inputTableEntries = try dataStream.read(endianess: .bigEndian)
        
        /// 50 to 51 4 Number of output table entries (m) uInt16Number
        self.outputTableEntries = try dataStream.read(endianess: .bigEndian)

        let inputCount = Int(self.inputTableEntries) * Int(self.inputChan)
        let clutCount = Int(pow(Double(self.clutPoints), Double(self.inputChan))) * Int(self.outputChan)
        let outputCount = Int(self.outputTableEntries) * Int(self.outputChan)
        
        guard 52 + inputCount * 2 + clutCount * 2 + outputCount * 2 <= size else {
            throw ICCReadError.corrupted
        }
        
        /// 52 to 51+(2ni) 2ni Input tables uInt16Number [...]
        var inputTable: [UInt16] = []
        inputTable.reserveCapacity(inputCount)
        for _ in 0..<inputCount {
            inputTable.append(try dataStream.read(endianess: .bigEndian))
        }
        
        self.inputTable = inputTable
        
        /// 52+( 2ni) to 51+(2ni) + (2g^i o) 2g^i o CLUT values uInt16Number [...]
        var clutTable: [UInt16] = []
        clutTable.reserveCapacity(clutCount)
        for _ in 0..<clutCount {
            clutTable.append(try dataStream.read(endianess: .bigEndian))
        }
        
        self.clutTable = clutTable
        
        /// 52+(2ni) + (2g^i o) to end 2mo Output tables uInt16Number [...]
        var outputTable: [UInt16] = []
        outputTable.reserveCapacity(outputCount)
        for _ in 0..<outputCount {
            outputTable.append(try dataStream.read(endianess: .bigEndian))
        }
        
        self.outputTable = outputTable
        
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
