//
//  positionNumber.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// [ICC.1:2010] 4.4 positionNumber
/// Positions of some data elements are indicated using a position offset with the data element’s size. This data type allows this
/// information to be stored as a single entity. Table 2 shows the positionNumber encoding.
public struct positionNumber {
    public let offset: uInt32Number
    public let size: uInt32Number
    
    public init(dataStream: inout DataStream) throws {
        /// 0 to 3 4 Offset to data element in bytes uInt32Number
        self.offset = try dataStream.read(endianess: .bigEndian)
        
        /// 4 to 7 4 Size of data element in bytes uInt32Number
        self.size = try dataStream.read(endianess: .bigEndian)
    }
}
