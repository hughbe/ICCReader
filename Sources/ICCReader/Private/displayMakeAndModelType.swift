//
//  displayMakeAndModelType.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

public struct displayMakeAndModelType {
    public let sig: ICCSignature
    public let reserved: uInt32Number
    public let manufacturer: UInt32
    public let model: UInt32
    public let serialNumber: UInt32
    public let manufactureDate: UInt32
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position
        
        guard size == 40 else {
            throw ICCReadError.corrupted
        }
        
        /// 0 to 3 4 ‘mmod’ (6d6d6f64h) type signature
        self.sig = try ICCSignature(dataStream: &dataStream)
        guard self.sig ==  ICCTagTypeSignature.displayMakeAndModel else {
            throw ICCReadError.corrupted
        }
        
        /// 4 to 7 4 Reserved, shall be set to 0
        self.reserved = try dataStream.read(endianess: .bigEndian)
        
        /// 8 to 11 Manufacturer
        self.manufacturer = try dataStream.read(endianess: .bigEndian)
        
        /// 12 to 15 Model
        self.model = try dataStream.read(endianess: .bigEndian)
        
        /// 16 to 19 Serial Number
        self.serialNumber = try dataStream.read(endianess: .bigEndian)
        
        /// 20 to 23 Manufacture Date
        self.manufactureDate = try dataStream.read(endianess: .bigEndian)
        
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
