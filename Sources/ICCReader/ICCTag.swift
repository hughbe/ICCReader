//
//  DataStream.swift
//  
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

public struct ICCTag {
    public let signature: ICCSignature
    public let type: ICCSignature
    public let data: ICCTagData
    
    public init(signature: ICCSignature, dataStream: inout DataStream, size: UInt32, header: ICCColorProfileHeader) throws {
        guard size >= 8 else {
            throw ICCReadError.corrupted
        }

        self.signature = signature
        
        let position = dataStream.position
        self.type = try ICCSignature(dataStream: &dataStream)
        dataStream.position = position
        self.data = try ICCTagData(dataStream: &dataStream, size: size, header: header)
    }
}
