//
//  float64Number.swift
//
//
//  Created by Hugh Bellamy on 14/12/2020.
//

/// [ICC.2:2019] 4.2.3 float64Number
/// A float64Number shall be a double-precision 64-bit floating-point number as specified in IEEE 754, excluding infinities, and
/// “not a number” (NaN) values.
/// NOTE 1 A 64-bit IEEE 754 floating-point number has an 11-bit exponent and a 52-bit mantissa.
/// NOTE 2 Although infinities and NaN values are not stored in the ICC profile, such values can occur as a result of CMM computations.
public typealias float64Number = Double
