//
//  sparseMatrixEncoding.swift
//  
//
//  Created by Hugh Bellamy on 14/12/2020.
//

import DataStream

/// [ICC:2.2019] 4.2.5 Sparse matrix encodings
/// [ICC:2.2019] 4.2.5.1 General
/// Sparse matrices shall be encoded using compressed row order, which facilitates efficient multiplication of column vectors as well as
/// the interpolation between sparse matrices. A sparse matrix shall be encoded as a variable structure with internal padding within a
/// fixed size data block. The use of a fixed data block size allows for the efficient indexing of arrays of sparse matrices.
/// In addition to encoding the number of rows, number of columns and number of matrix data entries, the compressed row order
/// encoding shall include three sub-arrays: a padded array of matrix entry data values, a padded array of matrix entry column identifiers,
/// and an array of offsets to successive rows stored in the matrix data and column index arrays.
/// Successive offset values in the row start offset array shall be greater than or equal to preceding values.
/// The number of matrix data entries associated with a row can therefore be found by subtracting the offset of the row by the offset of
/// the succeeding row.
/// Successive matrix entry column index values associated with any single row shall be monotonically increasing.
/// Information about operations with sparse matrices can be found in Annex E.
/// Multiple sparse matrix encodings are permitted, but shall differ in the encoding of the matrix entry data values as follows:
/// — The sparseMatrixUInt8 encoding shall use uInt8Numbers to encode matrix data values (Table 1). The internal representation of the
/// values 0 to 255 shall represent matrix values 0,0 to 1,0.
/// — The sparseMatrixUInt16 encoding shall use uInt16Numbers to encode matrix data values (Table 2). The internal representation of
/// the values 0 to 65 535 shall represent matrix values 0,0 to 1,0.
/// — The sparseMatrixFloat16 encoding shall use float16Numbers to encode matrix values (Table 3).
/// — The sparseMatrixFloat32 encoding shall use float32Numbers to encode matrix values (Table 4).
public enum sparseMatrixEncoding {
    case uInt8(_: sparseMatrixUInt8)
    case uInt16(_: sparseMatrixUInt16)
    case float16(_: sparseMatrixFloat16)
    case float32(_: sparseMatrixFloat32)
    
    public init(dataStream: inout DataStream, type: sparseMatrixEncodingType) throws {
        switch type {
        case .uInt8:
            self = .uInt8(try sparseMatrixUInt8(dataStream: &dataStream))
        case .uInt16:
            self = .uInt16(try sparseMatrixUInt16(dataStream: &dataStream))
        case .float16:
            self = .float16(try sparseMatrixFloat16(dataStream: &dataStream))
        case .float32:
            self = .float32(try sparseMatrixFloat32(dataStream: &dataStream))
        }
    }
    
    public struct sparseMatrixUInt8 {
        public let rows: uInt16Number
        public let columns: uInt16Number
        public let rowStartOffsets: [uInt16Number]
        public let numberOfMatrixEntries: uInt16Number
        public let matrixEntryColumnIndices: [uInt16Number]
        public let data: [UInt8]
        
        public init(dataStream: inout DataStream) throws {
            let startPosition = dataStream.position

            /// 0…1 2 Rows (R) uInt16Number
            self.rows = try dataStream.read(endianess: .bigEndian)
            
            /// 2…3 2 Columns (C) uInt16Number
            self.columns = try dataStream.read(endianess: .bigEndian)
            
            /// 4…3+R*2 R*2 Row start offset array uInt16Number[R]
            var rowStartOffsets: [uInt16Number] = []
            rowStartOffsets.reserveCapacity(Int(self.rows))
            for _ in 0..<self.rows {
                rowStartOffsets.append(try dataStream.read(endianess: .bigEndian))
            }
            
            self.rowStartOffsets = rowStartOffsets
            
            /// 4+R*2…5+R*2 2 Number of matrix entries (N) uInt16Number
            self.numberOfMatrixEntries = try dataStream.read(endianess: .bigEndian)
            
            /// 6+R*2…5+R*2 + N*2 N*2 Matrix entry column index array uInt16Number[N]
            var matrixEntryColumnIndices: [uInt16Number] = []
            matrixEntryColumnIndices.reserveCapacity(Int(self.rows))
            for _ in 0..<self.rows {
                matrixEntryColumnIndices.append(try dataStream.read(endianess: .bigEndian))
            }
            
            self.matrixEntryColumnIndices = matrixEntryColumnIndices
            
            /// 6+R*2+N*2…O-1 Index padding, shall be 0
            try dataStream.readFourByteAlignmentPadding(startPosition: startPosition)
            
            /// O…O+N-1 N Matrix entry data array uInt8Number[N]
            self.data = try dataStream.readBytes(count: Int(self.numberOfMatrixEntries))
        
            /// O+N…end Data padding, shall be 0
            try dataStream.readFourByteAlignmentPadding(startPosition: startPosition)
        }
    }
    
    public struct sparseMatrixUInt16 {
        public let rows: uInt16Number
        public let columns: uInt16Number
        public let rowStartOffsets: [uInt16Number]
        public let numberOfMatrixEntries: uInt16Number
        public let matrixEntryColumnIndices: [uInt16Number]

        public init(dataStream: inout DataStream) throws {
            /// 0…1 2 Rows (R) uInt16Number
            self.rows = try dataStream.read(endianess: .bigEndian)
            
            /// 2…3 2 Columns(C) uInt16Number
            self.columns = try dataStream.read(endianess: .bigEndian)
            
            /// 4…3+R*2 R*2 Row start offset array uInt16Number[R]
            var rowStartOffsets: [uInt16Number] = []
            rowStartOffsets.reserveCapacity(Int(self.rows))
            for _ in 0..<self.rows {
                rowStartOffsets.append(try dataStream.read(endianess: .bigEndian))
            }
            
            self.rowStartOffsets = rowStartOffsets
            
            /// 4+R*2…5+R*2 2 Number matrix entries (N) uInt16Number
            self.numberOfMatrixEntries = try dataStream.read(endianess: .bigEndian)
            
            /// 6+R*2…5+R*2 + N*2 N*2 Matrix entry column indices uInt16Number[N]
            var matrixEntryColumnIndices: [uInt16Number] = []
            matrixEntryColumnIndices.reserveCapacity(Int(self.rows))
            for _ in 0..<self.rows {
                matrixEntryColumnIndices.append(try dataStream.read(endianess: .bigEndian))
            }
            
            self.matrixEntryColumnIndices = matrixEntryColumnIndices
            
            /// 6+R*2+N*2…O-1 Index padding, shall be 0
            
            /// O…O+N*2-1 N*2 Matrix entry data values uInt16Number[N]
            
            /// O+N*2…end Data padding, shall be 0
            
        }
    }
    
    public struct sparseMatrixFloat16 {
        public let rows: uInt16Number
        public let columns: uInt16Number
        public let rowStartOffsets: [uInt16Number]
        public let numberOfMatrixEntries: uInt16Number
        public let matrixEntryColumnIndices: [uInt16Number]

        public init(dataStream: inout DataStream) throws {
            /// 0…1 2 Rows (R) uInt16Number
            self.rows = try dataStream.read(endianess: .bigEndian)
            
            /// 2…3 2 Columns (C) uInt16Number
            self.columns = try dataStream.read(endianess: .bigEndian)
            
            /// 4…3+R*2 R*2 Row start offset array uInt16Number[R]
            var rowStartOffsets: [uInt16Number] = []
            rowStartOffsets.reserveCapacity(Int(self.rows))
            for _ in 0..<self.rows {
                rowStartOffsets.append(try dataStream.read(endianess: .bigEndian))
            }
            
            self.rowStartOffsets = rowStartOffsets
            
            /// 4+R*2…5+R*2 2 Number matrix entries (N) uInt16Number
            self.numberOfMatrixEntries = try dataStream.read(endianess: .bigEndian)
            
            /// 6+R*2…5+R*2 + N*2 N*2 Matrix entry column indices uInt16Number[N]
            var matrixEntryColumnIndices: [uInt16Number] = []
            matrixEntryColumnIndices.reserveCapacity(Int(self.rows))
            for _ in 0..<self.rows {
                matrixEntryColumnIndices.append(try dataStream.read(endianess: .bigEndian))
            }
            
            self.matrixEntryColumnIndices = matrixEntryColumnIndices
            
            /// 6+R*2+N*2…O-1 Index padding, shall be 0
            
            /// O…O+N*2-1 N*2 Matrix entry data values float16Number[N]
            
            /// O+N*2…end Data padding, shall be 0
            
        }
    }
    
    public struct sparseMatrixFloat32 {
        public let rows: uInt16Number
        public let columns: uInt16Number
        public let rowStartOffsets: [uInt16Number]
        public let numberOfMatrixEntries: uInt16Number
        public let matrixEntryColumnIndices: [uInt16Number]

        public init(dataStream: inout DataStream) throws {
            /// 0…1 2 Rows (R) uInt16Number
            self.rows = try dataStream.read(endianess: .bigEndian)
            
            /// 2…3 2 Columns (C) uInt16Number
            self.columns = try dataStream.read(endianess: .bigEndian)
            
            /// 4…3+R*2 R*2 Row start offset array uInt16Number[R]
            var rowStartOffsets: [uInt16Number] = []
            rowStartOffsets.reserveCapacity(Int(self.rows))
            for _ in 0..<self.rows {
                rowStartOffsets.append(try dataStream.read(endianess: .bigEndian))
            }
            
            self.rowStartOffsets = rowStartOffsets
            
            /// 4+R*2…5+R*2 2 Number matrix entries (N) uInt16Number
            self.numberOfMatrixEntries = try dataStream.read(endianess: .bigEndian)
            
            /// 6+R*2…5+R*2 + N*2 N*2 Matrix entry column indices uInt16Number[N]
            var matrixEntryColumnIndices: [uInt16Number] = []
            matrixEntryColumnIndices.reserveCapacity(Int(self.rows))
            for _ in 0..<self.rows {
                matrixEntryColumnIndices.append(try dataStream.read(endianess: .bigEndian))
            }
            
            self.matrixEntryColumnIndices = matrixEntryColumnIndices
            
            /// 6+R*2+N*2…O-1 Index padding, shall be 0
            
            /// O…O+N*4-1 N*4 Matrix entry data values float32Number[N]
            
            /// O+N*4…end Data padding, shall be 0
            
        }
    }
}
