//
//  curveOrParametricCurveType.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// Tag Type : curveType xor parametricCurveType
public enum curveOrParametricCurveType {
    case curve(_: curveType)
    case parametricCurve(_: parametricCurveType)
    
    public init(dataStream: inout DataStream, size: UInt32?) throws {
        let startPosition = dataStream.position
        
        if let size = size {
            guard size >= 4 else {
                throw ICCReadError.corrupted
            }
        }
        
        /// 0..3 type signature
        let sig = try dataStream.peekString(count: 4, encoding: .ascii)!
        switch sig {
        case TagTypeSignature.curveType.rawValue:
            self = .curve(try curveType(dataStream: &dataStream, size: size))
        case TagTypeSignature.parametricCurveType.rawValue:
            self = .parametricCurve(try parametricCurveType(dataStream: &dataStream, size: size))
        default:
            throw ICCReadError.corrupted
        }
        
        if let size = size {
            guard dataStream.position - startPosition == size else {
                throw ICCReadError.corrupted
            }
        }
    }
}
