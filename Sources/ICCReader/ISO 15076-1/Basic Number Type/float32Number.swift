//
//  float32Number.swift
//  
//
//  Created by Hugh Bellamy on 14/12/2020.
//

/// [ICC.1:2010] 4.3 float32Number
/// A float32Number shall be single-precision 32-bit floating-point number as specified in IEEE 754, excluding un-normalized numbers,
/// infinities, and “not a number” (NaN) values.
/// NOTE 1 A 32-bit IEEE 754 floating-point number has an 8-bit exponent and a 23-bit mantissa.
/// NOTE 2 Although un-normalized numbers, infinities and NaN values are not stored in the ICC Profile, such values can occur as a
/// result of CMM computations.
public typealias float32Number = Float
