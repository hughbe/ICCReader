//
//  sparseMatrixArrayType.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// [ICC.2:2019] 10.2.20 sparseMatrixArrayType
/// The sparseMatrixArrayType defines a tag type for encoding an array of sparse matrices. When used, the byte assignment and
/// encoding shall be as given in Table 68.
/// The sparse matrices encoded in the list shall all be encoded according to the value in the Sparse Matrix LUT Encoding type element.
/// The sparse matrices encoded in the list of sparse matrices shall use compact padding resulting in the Matrix Entry Data Values and
/// end of each sparse matrix being aligned on a 4 byte boundary.
/// All sparse matrices in the sparseMatrixArrayType shall have the same number of rows and columns.
public struct sparseMatrixArrayType {
    public let sig: TagTypeSignature
    public let reserved: uInt32Number
    public let numberOfChannels: uInt16Number
    public let matrixType: sparseMatrixEncodingType
    public let numberOfMatrices: uInt32Number
    public let matrices: [sparseMatrixEncoding]
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position
        
        guard size >= 8 && (size - 8) % 2 == 0 else {
            throw ICCReadError.corrupted
        }
        
        /// 0…3 4 'smat' (736d6174h) type signature
        self.sig = try TagTypeSignature(dataStream: &dataStream)
        guard self.sig ==  .sparseMatrixArrayType else {
            throw ICCReadError.corrupted
        }
        
        /// 4..7 4 Reserved, shall be 0
        self.reserved = try dataStream.read(endianess: .bigEndian)
        
        /// 8..9 2 Number of equivalent output channels used by sparse matrix encoding (Q) uInt16Number
        self.numberOfChannels = try dataStream.read(endianess: .bigEndian)
        
        /// 10..11 2 Sparse matrix LUT encoding type sparseMatrixEncodingType
        self.matrixType = try sparseMatrixEncodingType(dataStream: &dataStream)
        
        /// 12..15 4 Number of sparse matrices in list uInt32Number
        self.numberOfMatrices = try dataStream.read(endianess: .bigEndian)
        
        /// 12…end N*B List of (N) sparse matrices List of compact sparseMatrixUInt8 or sparseMatrixUInt16 or sparseMatrixFloat16
        /// or sparseMatrixFloat32
        var matrices: [sparseMatrixEncoding] = []
        matrices.reserveCapacity(Int(self.numberOfMatrices))
        for _ in 0..<self.numberOfMatrices {
            matrices.append(try sparseMatrixEncoding(dataStream: &dataStream, type: self.matrixType))
        }
        
        self.matrices = matrices
        
        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }
}
