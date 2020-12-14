//
//  curveType.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// [ICC.1:2010] 10.16 parametricCurveType
/// The parametricCurveType describes a one-dimensional curve by specifying one of a predefined set of functions using the parameters.
/// When used the byte assignment and encoding shall be as given in Table 64.
/// The order of the parameters in the tag data, Table 64, follows the left-to-right order of the parameters in Table 65.
/// Table 65 — parametricCurveType function type encoding
/// Field length bytes Function type Encoded value Parameters Note
/// 4 g Y X = 0000h g
/// 12 ( ) g Y aX b = + ( X ba W − / ) Y = 0 ( X ba > − / ) 0001h g a b CIE 122-1996
/// 16 ( ) g Y aX b c = ++ ( X ba W − / ) Y c = ( X ba > − / ) 0002h g a b c IEC 61966-3
/// 20 ( ) g Y aX b = + ( X d W ) Y cX = ( X d > ) 0003h g a b c d IEC 61966-2-1 (sRGB)
/// 28 ( ) g Y aX b c = ++ ( X d W ) Y cX f = + ( ) ( X d > ) 0004h g a b c d e f
///     NOTE More functions can be added as necessary.
/// The domain and range of each function shall be [0,0 1,0]. Any function value outside the range shall be clipped to the range of the
/// function. When unsigned integer data is supplied as input, it shall be converted to the domain by dividing it by a factor of (2N)−1,
/// where N is the number of bits used to represent the input data. When unsigned integer data is required as output, it shall be converted
/// from the range by multiplying it by a factor of (2M)−1, where M is the number of bits used to represent the output data.
/// If the input is PCSXYZ, the PCSXYZ X, Y, or Z value 1+ (32 767/32 768) shall be mapped to the function input value 1,0. If the output
/// is PCSXYZ, the function output value 1,0 shall be mapped to the PCSXYZ X, Y, or Z value 1+(32 767/32 768).
/// NOTE The parameters selected for a parametric curve can result in complex or undefined values for the input range used. This can
/// occur, for example, if d < −b/a. In such cases the behaviour of the curve is undefined.
public struct parametricCurveType {
    public let sig: TagTypeSignature
    public let reserved1: UInt32
    public let functionType: UInt16
    public let reserved2: UInt16
    public let values: [s15Fixed16Number]
    
    public init(dataStream: inout DataStream, size: UInt32?) throws {
        let startPosition = dataStream.position
        
        if let size = size {
            guard size >= 12 && (size - 12) % 4 == 0 else {
                throw ICCReadError.corrupted
            }
        }
        
        /// 0 to 3 4 'para' (70617261h) type signature
        self.sig = try TagTypeSignature(dataStream: &dataStream)
        guard self.sig ==  .parametricCurveType else {
            throw ICCReadError.corrupted
        }
        
        /// 4-7 reserved, must be set to 0
        self.reserved1 = try dataStream.read(endianess: .bigEndian)
        
        /// 8 to 9 2 Encoded value of the function type uInt16Number (see Table 65)
        self.functionType = try dataStream.read(endianess: .bigEndian)
        
        /// 10 to 11 2 Reserved, shall be set to 0
        self.reserved2 = try dataStream.read(endianess: .bigEndian)
        
        /// 12 to end See Table 65 One or more parameters (see Table 65) s15Fixed16Number [...]
        let count: Int
        switch self.functionType {
        case 0x0000:
            count = 1
        case 0x0001:
            count = 3
        case 0x0002:
            count = 4
        case 0x0003:
            count = 5
        case 0x0004:
            count = 7
        default:
            guard let size = size else {
                throw ICCReadError.corrupted
            }

            // Unknown: just use the rest of the function
            count = (Int(size) - 12) / 4
        }
        
        var values: [s15Fixed16Number] = []
        values.reserveCapacity(Int(count))
        for _ in 0..<count {
            values.append(try s15Fixed16Number(dataStream: &dataStream))
        }
        
        self.values = values
        
        if let size = size {
            guard dataStream.position - startPosition == size else {
                throw ICCReadError.corrupted
            }
        }
    }
}
