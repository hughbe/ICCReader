//
//  float16Number.swift
//  
//
//  Created by Hugh Bellamy on 14/12/2020.
//

/// [ICC.2:2019] 4.2.2 float16Number
/// A float16Number shall be a half-precision 16-bit floating-point number as specified in IEEE 754, excluding infinities and “not a
/// number” (NaN) values.
/// NOTE 1 A 16-bit IEEE 754 floating-point number has a 5-bit exponent and a 10-bit mantissa
/// NOTE 2 Although infinities and NaN values are not stored in the ICC profile, such values can occur as a result of CMM computations.
public typealias float16Number = UInt16
