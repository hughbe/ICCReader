//
//  KnownSignature.swift
//  
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

public enum KnownSignature<T> where T: RawRepresentable, T.RawValue == String {
    case known(_: T)
    case unknown(_: String)
    
    public init(dataStream: inout DataStream) throws {
        let rawValue = try dataStream.readString(count: 4, encoding: .ascii)!
        if let value = T(rawValue: rawValue) {
            self = .known(value)
        } else {
            self = .unknown(rawValue)
        }
    }
}

extension KnownSignature: Equatable where T: Equatable {
    
}

extension KnownSignature: Hashable where T: Hashable {
    
}
