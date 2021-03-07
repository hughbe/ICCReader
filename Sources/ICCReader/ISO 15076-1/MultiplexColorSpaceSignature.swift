//
//  MultiplexColorSpaceSignature.swift
//  
//
//  Created by Hugh Bellamy on 07/03/2021.
//

import DataStream

/// 7.2.24 MCS field (bytes 116 to 119)
/// The MCS for AToM0/MToA0/MToB0/MToS0 tags shall always be defined by the MCS field. The field represents the colour
/// space on the M-side of the transform. When this field is non-zero the multiplex channel identification shall be encoded by
/// a multiplexTypeArrayTag (see 9.2.85).
/// For the MultiplexIdentification and MultiplexVisualization profile classes (see Table 14), the MCS encoding shall be one of
/// the signatures as defined in Table 22.
/// NOTE Multiplex colour space signatures use the same 32-bit binary encoding mechanism as N colour device data Signatures
/// (see 6.2.1), with each having a six-character Signature representation.
/// For the input profile class (Table 14) the MCS encoding shall be one of the signatures as defined in Table 23.
/// For all other profile classes (Table 14) the MCS encoding shall be zero.
public enum MultiplexColorSpaceSignature {
    /// None (no MCS is used) 0 0 0 0
    case none
    
    /// Multiplex channel values with N channels ’mc’ (6d63h) 1 … 65 535 (0001h … FFFFh) 6d630001h … 6d63FFFFh “mc0001” … “mcFFFF”
    case multiplex(numberOfChannels: UInt16)
    
    case unknown(signature: String, numberOfChannels: UInt16)
    
    public init(dataStream: inout DataStream) throws {
        let signature = try dataStream.readString(count: 2, encoding: .ascii)!
        
        switch signature {
        case "\0\0":
            let _: UInt16 = try dataStream.read(endianess: .bigEndian)
            self = .none
        case "mc":
            self = .multiplex(numberOfChannels: try dataStream.read(endianess: .bigEndian))
        default:
            self = .unknown(signature: signature, numberOfChannels: try dataStream.read(endianess: .bigEndian))
        }
    }
}
