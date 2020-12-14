//
//  icSignature.swift
//  
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

public struct Signature: Hashable, RawRepresentable, ExpressibleByStringLiteral {
    public let value: String
    
    public var rawValue: String {
        return value
    }
    
    public init(rawValue: String) {
        guard rawValue.count == 4 else {
            fatalError("Should be 4 characters long")
        }

        self.value = rawValue
    }

    public init(stringLiteral value: String) {
        guard value.count == 4 else {
            fatalError("Should be 4 characters long")
        }

        self.value = value
    }
        
    public init(dataStream: inout DataStream) throws {
        self.value = try dataStream.readString(count: 4, encoding: .ascii)!
    }
}
