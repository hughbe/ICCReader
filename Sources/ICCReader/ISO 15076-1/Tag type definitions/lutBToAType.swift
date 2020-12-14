//
//  lutBToAType.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// [ICC.1:2010] 10.10 lutAToBType
/// This structure represents a colour transform. The type contains up to five processing elements which are stored in the BToATag in
/// the following order: a set of one-dimensional curves, a 3 × 3 matrix with offset terms, a set of one-dimensional curves, a
/// multi-dimensional lookup table, and a set of one-dimensional curves. Data are processed using these elements via the following
/// sequence:
/// (“B” curves) ⇒ (matrix) ⇒ (“M” curves) ⇒ (multi-dimensional lookup table, CLUT) ⇒ (“A” curves).
/// It is possible to use any or all of these processing elements. At least one processing element shall be included.
/// Only the following combinations are permitted:
/// ⎯ B;
/// ⎯ B, Matrix, M;
/// ⎯ B, CLUT, A;
/// ⎯ B, Matrix, M, CLUT, A.
/// Other combinations may be achieved by setting processing element values to identity transforms. The domain and range of the A and
/// B curves and CLUT are defined to consist of all real numbers between 0,0 and 1,0 inclusive. The first entry is located at 0,0, the last
/// entry at 1,0, and intermediate entries are uniformly spaced using an increment of 1,0/(m-1). For the A, M and B curves m is the number
/// of entries in the table. For the CLUT m is the number of grid points along each dimension. Since the domain and range of the tables
/// are 0,0 to 1,0 it is necessary to convert all device values and PCSLAB values to this numeric range. It shall be assumed that the
/// maximum value in each case is set to 1,0 and the minimum value to 0,0 and all intermediate values are linearly scaled accordingly.
/// When using this type, it is necessary to assign each data colour space component to an input and output channel. This assignment
/// is specified in Table 38.
/// Each curve and processing element shall start on a 4-byte boundary. To achieve this, each item may be followed by up to three
/// 00h pad bytes as needed.
/// Curve data elements may be shared. For example, the offsets for A, B and M curves may be identical. The offset entries (bytes 12 to 31)
/// point to the various processing elements found in the tag. The offsets indicate the number of bytes from the beginning of the tag to
/// the desired data. If any of the offsets are zero, i.e. an indication that processing element is not present and the operation is not
/// performed.
/// This tag type shall only be used when the PCS field in the header specifies either PCSXYZ or PCSLAB.
public struct lutBToAType {
    public let sig: TagTypeSignature
    public let reserved: uInt32Number
    public let inputChan: UInt8
    public let outputChan: UInt8
    public let pad: UInt16
    public let offsetToFirstBCurve: UInt32
    public let offsetToMatrix: UInt32
    public let offsetToFirstMCurve: UInt32
    public let offsetToCLUT: UInt32
    public let offsetToFirstACurve: UInt32
    public let bCurves: [curveOrParametricCurveType]
    public let matrix: [s15Fixed16Number]
    public let mCurves: [curveOrParametricCurveType]
    public let clut: CLUT?
    public let aCurves: [curveOrParametricCurveType]
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position
        
        guard size >= 32 && size % 4 == 0 else {
            throw ICCReadError.corrupted
        }
        
        /// 0 to 3 4 ‘mBA’ (6D424120h) [multi-function BToA table] type signature
        self.sig = try TagTypeSignature(dataStream: &dataStream)
        guard self.sig ==  .lutBToAType else {
            throw ICCReadError.corrupted
        }
        
        /// 4 to 7 4 Reserved, shall be set to 0
        self.reserved = try dataStream.read(endianess: .bigEndian)
        
        /// 8 1 Number of Input Channels (i) uInt8Number
        let inputChan: UInt8 = try dataStream.read()
        self.inputChan = inputChan
        
        /// 9 1 Number of Output Channels (o) uInt8Number
        let outputChan: UInt8 = try dataStream.read()
        self.outputChan = outputChan
        
        /// 10 to 11 2 Reserved for padding, shall be set to 0
        self.pad = try dataStream.read(endianess: .bigEndian)
        
        /// 12 to 15 4 Offset to first “B” curve uInt32Number
        let offsetToFirstBCurve: UInt32 = try dataStream.read(endianess: .bigEndian)
        guard offsetToFirstBCurve == 0 ||
                (offsetToFirstBCurve >= 32 &&
                    offsetToFirstBCurve + UInt32(inputChan) * 8 <= size) else {
            throw ICCReadError.corrupted
        }
        
        self.offsetToFirstBCurve = offsetToFirstBCurve
        
        /// 16 to 19 4 Offset to matrix uInt32Number
        let offsetToMatrix: UInt32 = try dataStream.read(endianess: .bigEndian)
        guard offsetToMatrix == 0 ||
                (offsetToMatrix >= 32 &&
                    offsetToMatrix + 12 * 4 <= size) else {
            throw ICCReadError.corrupted
        }
        
        self.offsetToMatrix = offsetToMatrix
        
        /// 20 to 23 4 Offset to first “M” curve uInt32Number
        let offsetToFirstMCurve: UInt32 = try dataStream.read(endianess: .bigEndian)
        guard offsetToFirstMCurve == 0 ||
                (offsetToFirstMCurve >= 32 &&
                    offsetToFirstMCurve + UInt32(inputChan) * 12 <= size) else {
            throw ICCReadError.corrupted
        }
        
        self.offsetToFirstMCurve = offsetToFirstMCurve
        
        /// 24 to 27 4 Offset to CLUT uInt32Number
        let offsetToCLUT: UInt32 = try dataStream.read(endianess: .bigEndian)
        guard offsetToCLUT == 0 ||
                (offsetToCLUT >= 32 &&
                    offsetToCLUT + 20 <= size) else {
            throw ICCReadError.corrupted
        }
        
        self.offsetToCLUT = offsetToCLUT
        
        /// 28 to 31 4 Offset to first “A” curve uInt32Number
        let offsetToFirstACurve: UInt32 = try dataStream.read(endianess: .bigEndian)
        guard offsetToFirstACurve == 0 ||
                (offsetToFirstACurve >= 32 &&
                    offsetToFirstACurve + UInt32(outputChan) * 12 <= size) else {
            throw ICCReadError.corrupted
        }
        
        self.offsetToFirstACurve = offsetToFirstACurve
                
        /// 32 to end Variable Data
        /// 10.11.2 “B” curves
        /// There are the same number of “B” curves as there are input channels. The curves are stored sequentially, with 00h
        /// bytes used for padding between them if needed. Each “B” curve is stored as an embedded curveType tag or a
        /// parametricCurveType (see 10.5 or 10.16). The length is as indicated by the convention of the proper curve type. Note
        /// that the entire tag type, including the tag type signature and reserved bytes, is included for each curve.
        if self.offsetToFirstBCurve != 0 {
            let dataStartPosition = startPosition + Int(self.offsetToFirstBCurve)
            dataStream.position = dataStartPosition
            var bCurves: [curveOrParametricCurveType] = []
            bCurves.reserveCapacity(Int(self.inputChan))
            for _ in 0..<self.inputChan {
                bCurves.append(try curveOrParametricCurveType(dataStream: &dataStream, size: nil))
                try dataStream.readFourByteAlignmentPadding(startPosition: dataStartPosition)
            }
            
            self.bCurves = bCurves
        } else {
            self.bCurves = []
        }

        /// 10.11.3 Matrix
        /// The matrix is organized as a 3 × 4 array. The elements of the matrix appear in the type in order from e1 to e12.
        /// The matrix elements are each s15Fixed16Numbers.
        /// array = [e1 e2 e3 e4 e5 e6 e7 e8 e9 e10 e11 e12 ]
        /// (16)
        /// The matrix is used to convert data to a different colour space, according to the following equation:
        /// ⎡ Y1 ⎤  ⎡e1 e2 e3 ⎤  ⎡ X1 ⎤  ⎡ e10 ⎤
        /// ⎢ Y2 ⎢=⎢e4 e5 e6 ⎢o⎢ X2 ⎢+⎢ e11 ⎢
        /// ⎣ Y3 ⎦  ⎣ e7 e8 e9⎦  ⎣ X3 ⎦  ⎣ e12 ⎦
        /// (17)
        /// The range of input values X1, X2 and X3 is 0,0 to 1,0. The resultant values Y1, Y2 and Y3 shall be clipped to the range
        /// 0,0 to 1,0 and used as inputs to the “M” curves.
        /// The matrix is permitted only if the number of output channels, or “M” curves, is 3.
        if self.offsetToMatrix != 0 {
            dataStream.position = startPosition + Int(self.offsetToMatrix)
            var matrix: [s15Fixed16Number] = []
            matrix.reserveCapacity(12)
            for _ in 0..<12 {
                matrix.append(try s15Fixed16Number(dataStream: &dataStream))
            }
            
            self.matrix = matrix
        } else {
            self.matrix = []
        }
        
        /// 10.11.4 “M” curves
        /// There are the same number of “M” curves as there are input channels. The curves are stored sequentially, with 00h bytes
        /// used for padding between them if needed. Each “M” curve is stored as an embedded curveType or a parametricCurveType
        /// (see 10.5 or 10.16). The length is as indicated by the convention of the proper curve type. Note that the entire tag type,
        /// including the tag type signature and reserved bytes, are included for each curve. The “M” curves may only be used when
        /// the matrix is used.
        if self.offsetToFirstMCurve != 0 {
            let dataStartPosition = startPosition + Int(self.offsetToFirstMCurve)
            dataStream.position = dataStartPosition
            var mCurves: [curveOrParametricCurveType] = []
            mCurves.reserveCapacity(Int(self.inputChan))
            for _ in 0..<self.inputChan {
                mCurves.append(try curveOrParametricCurveType(dataStream: &dataStream, size: nil))
                try dataStream.readFourByteAlignmentPadding(startPosition: dataStartPosition)
            }
            
            self.mCurves = mCurves
        } else {
            self.mCurves = []
        }
        
        /// 10.11.5 CLUT
        /// The CLUT appears as an n-dimensional array, with each dimension having a number of entries corresponding to the
        /// number of grid points.
        /// The CLUT values are arrays of 8-bit or 16-bit unsigned values, normalized to the range of 0 to 255 or 0 to 65 535
        /// The CLUT is organized as an i-dimensional array with a variable number of grid points in each dimension, where i is the
        /// number of input channels in the transform. The dimension corresponding to the first channel varies least rapidly and the
        /// dimension corresponding to the last input channel varies most rapidly.
        /// Each grid point value is an o-integer array, where o is the number of output channels. The first sequential integer of the
        /// entry contains the function value for the first output function, the second sequential integer of the entry contains the
        /// function value for the second output function and so on until all of the output functions have been supplied. The size
        /// of the CLUT in bytes is (nGrid1 × nGrid2 ×…× nGridN) × number of output channels (o) × size of (channel component).
        /// When used the byte assignment and encoding for the CLUT shall be as given in Table 45.
        /// If the number of grid points in a one-dimensional curve, or in a particular dimension of the CLUT, is two, the data for
        /// those points shall be set so that the correct results are obtained when linear interpolation is used to generate intermediate
        /// values.
        /// If the number of input channels does not equal the number of output channels, the CLUT shall be present.
        if self.offsetToCLUT != 0 {
            dataStream.position = startPosition + Int(self.offsetToCLUT)
            self.clut = try CLUT(dataStream: &dataStream, inputChan: self.inputChan, outputChan: self.outputChan)
        } else {
            self.clut = nil
        }
        
        /// 10.11.6 “A” curves
        /// There are the same number of “A” curves as there are output channels. The “A” curves may only be used when the CLUT
        /// is used. The curves are stored sequentially, with 00h bytes used for padding between them if needed. Each “A” curve is
        /// stored as an embedded curveType or a parametricCurveType (see 10.5 or 10.16). The length is as indicated by the
        /// convention of the proper curve type. Note that the entire tag type, including the tag type signature and reserved bytes, is
        /// included for each curve.
        if self.offsetToFirstACurve != 0 {
            let dataStartPosition = startPosition + Int(self.offsetToFirstACurve)
            dataStream.position = dataStartPosition
            var aCurves: [curveOrParametricCurveType] = []
            aCurves.reserveCapacity(Int(self.outputChan))
            for _ in 0..<self.outputChan {
                aCurves.append(try curveOrParametricCurveType(dataStream: &dataStream, size: nil))
                try dataStream.readFourByteAlignmentPadding(startPosition: dataStartPosition)
            }
            
            self.aCurves = aCurves
        } else {
            self.aCurves = []
        }
        
        /// Skip the data we've already read.
        dataStream.position = startPosition + Int(size)
        
        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }

    /// 10.11.5 CLUT
    /// The CLUT appears as an n-dimensional array, with each dimension having a number of entries corresponding to the
    /// number of grid points.
    /// The CLUT values are arrays of 8-bit or 16-bit unsigned values, normalized to the range of 0 to 255 or 0 to 65 535
    /// The CLUT is organized as an i-dimensional array with a variable number of grid points in each dimension, where i is the
    /// number of input channels in the transform. The dimension corresponding to the first channel varies least rapidly and the
    /// dimension corresponding to the last input channel varies most rapidly.
    /// Each grid point value is an o-integer array, where o is the number of output channels. The first sequential integer of the
    /// entry contains the function value for the first output function, the second sequential integer of the entry contains the
    /// function value for the second output function and so on until all of the output functions have been supplied. The size
    /// of the CLUT in bytes is (nGrid1 × nGrid2 ×…× nGridN) × number of output channels (o) × size of (channel component).
    /// When used the byte assignment and encoding for the CLUT shall be as given in Table 45.
    /// If the number of grid points in a one-dimensional curve, or in a particular dimension of the CLUT, is two, the data for
    /// those points shall be set so that the correct results are obtained when linear interpolation is used to generate intermediate
    /// values.
    public struct CLUT {
        public let numberOfGridPointsInEachDimension: [UInt8]
        public let precision: UInt8
        public let reserved: [UInt8]
        public let data: Data
        
        public enum Data {
            case uint8(_: [UInt8])
            case uint16(_: [UInt16])
        }
        
        public init(dataStream: inout DataStream, inputChan: UInt8, outputChan: UInt8) throws {
            /// 0 to 15 16 Number of grid points in each dimension. Only the first i entries are used, where i is the number of input
            /// channels. Unused entries shall be set to 00h. uInt8Number[16]
            self.numberOfGridPointsInEachDimension = try dataStream.readBytes(count: 16)
            
            /// 16 1 Precision of data elements in bytes. Shall be either 01h or 02h. uInt8Number
            let precision: UInt8 = try dataStream.read()
            guard precision == 0x01 || precision == 0x02 else {
                throw ICCReadError.corrupted
            }
            
            self.precision = precision
            
            /// 17 to 19 3 Reserved for padding, shall be set to 0
            self.reserved = try dataStream.readBytes(count: 3)
        
            /// 20 to end Variable CLUT data points (arranged as described in the text). uInt8Number [...] or uInt16Number [...]
            let gridSize = self.numberOfGridPointsInEachDimension[0..<Int(inputChan)].reduce(1) { Int($0) * Int($1) }
            let clutLength = gridSize * Int(outputChan)
            if self.precision == 0x01 {
                self.data = .uint8(try dataStream.readBytes(count: clutLength))
            } else {
                var data: [UInt16] = []
                data.reserveCapacity(clutLength)
                for _ in 0..<clutLength {
                    data.append(try dataStream.read(endianess: .bigEndian))
                }
                
                self.data = .uint16(data)
            }
        }
    }
}
