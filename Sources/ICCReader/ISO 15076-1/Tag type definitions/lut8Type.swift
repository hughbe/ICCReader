//
//  lut8Type.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream
import Foundation

/// [ICC.1:2010] 10.9 lut8Type
/// This structure represents a colour transform using tables of 8-bit precision. This type contains four processing elements:
/// a 3 × 3 matrix (which shall be the identity matrix unless the input colour space is PCSXYZ), a set of one-dimensional input tables,
/// a multi-dimensional lookup table, and a set of one-dimensional output tables.
/// Data is processed using these elements via the following sequence:
/// (matrix) ⇒ (1d input tables) ⇒ (multi-dimensional lookup table, CLUT) ⇒ (1d output tables)
/// When used the byte assignment shall be as given in Table 41.
/// The input and output tables, and CLUT, contained in a lut8Type each embodies a one-dimensional or multidimensional function
/// which maps an input value in the “domain” of the function to an output value in the “range” of the function.
/// The domain of each of these tables is defined to consist of all real numbers between 0,0 and 1,0, inclusive.
/// The first entry is located at 0,0, the last entry at 1,0, and intermediate entries are uniformly spaced using an increment of 1,0/(m−1).
/// For the input and output tables, m is 255. For the CLUT, m is the number of grid points along each dimension. The range of a function
/// used to generate the contents of a table is likewise defined to be all real numbers between 0,0 and 1,0, inclusive. Since the domain
/// and range of the tables are 0 to 1, it is necessary to convert all device values and PCSLAB values to this numeric range. It shall be
/// assumed that the maximum value in each case is set to 1,0 and the minimum value to 0,0, and all intermediate values are linearly
/// scaled accordingly.
/// Because the entries of a table are encoded as uInt8Numbers, it is necessary to round each real value to the nearest 8-bit integer.
/// Because the entries of lut8Type LUTs represent values in the range 0,0 to 1,0, encoded as uInt8Numbers, these entries should be
/// divided by 255,0 for the calculation of the actual output values. See Annex A for additional guidance on this topic.
/// The colour space used on the PCS side of a lut8Type tag (which may be either the input or output space, or both in the case of an
/// Abstract profile) is identified by the PCS field in the profile header (see 7.2.7). This field does not distinguish between 8-bit and 16-bit
/// PCS encodings. For the lut8Type tag, the 'Lab ' signature is defined to specify the 8-bit PCSLAB encoding. Note that this definition
/// only applies to the encoding used as the PCS side of the tag. It does NOT apply when these signatures are used in the data colour
/// space field in the profile header (see 7.2.6), except in the case of an Abstract profile.
/// An 8-bit PCSXYZ encoding has not been defined, so the interpretation of a lut8Type in a profile that uses PCSXYZ is implementation
/// specific. Because of the resulting ambiguity and because an 8-bit linear quantization of PCSXYZ results in poor quality, it is
/// recommended that the lut8Type tag not be used in profiles that employ PCSXYZ.
/// The matrix is organized as a 3 × 3 array. The dimension corresponding to the matrix rows varies least rapidly and the dimension
/// corresponding to the matrix columns varies most rapidly and is shown in matrix form below.
/// ⎡e1 e2 e3⎤
/// ⎢ e4 e5 e6⎥
/// ⎣e7 e8 e9⎦
/// (14)
/// When using the matrix of an Output profile, and the input data is PCSXYZ, then:
/// ⎡ X' ⎤=⎡e1 e2 e3⎤   ⎡ X ⎤
/// ⎢ Y' ⎥=⎢ e4 e5 e6⎥=⎢ Y ⎥
/// ⎣ Z' ⎦=⎣e7 e8 e9⎦   ⎣ Z ⎦
/// (15)
/// Each matrix entry is encoded as an s15Fixed16Number. The domain and range of the matrix is 0,0 to 1,0.
/// The matrix shall be an identity matrix unless the input is in the PCSXYZ colour space.
/// The input tables are arrays of uInt8Number values. Each input table consists of 256 uInt8Number integers. Each input table entry is
/// appropriately normalized to the range 0 to 255. The inputTable is of size (InputChannels × 256) bytes. When stored in this tag, the
/// one-dimensional lookup tables are packed one after another in the order described in Table 41.
/// The CLUT is organized as an i-dimensional array with a given number of grid points in each dimension, where i is the number of input
/// channels (input tables) in the transform. The dimension corresponding to the first input channel varies least rapidly and the dimension
/// corresponding to the last input channel varies most rapidly. Each grid point value is an o-byte array, where o is the number of output
/// channels. The first sequential byte of the entry contains the function value for the first output function, the second sequential byte of
/// the entry contains the function value for the second output function, and so on until all the output functions have been supplied. Each
/// byte in the CLUT is appropriately normalized to the range 0 to 255. The size of the CLUT, in bytes, is
/// GridPointsInputChannels × OutputChannels.
/// The output tables are arrays of uInt8Number values. Each output table consists of 256 uInt8Number integers. Each output table entry
/// is appropriately normalized to the range 0 to 255. The outputTable is of size (OutputChannels × 256) bytes. When stored in this tag,
/// the one-dimensional lookup tables are packed one after another in the order described in Table 41.
/// If the number of data points in a particular dimension of the CLUT, is two, the data for those points shall be set so that the correct
/// results are obtained when linear interpolation is used to generate intermediate values.
/// When using this type, it is necessary to assign each data colour space component to an input and output channel. These assignments
/// shall be as shown in Table 38. The channels are numbered according to the order in which their table occurs.
public struct lut8Type {
    public let sig: TagTypeSignature
    public let reserved: uInt32Number
    public let inputChan: UInt8
    public let outputChan: UInt8
    public let clutPoints: UInt8
    public let pad: UInt8
    public let e1: s15Fixed16Number
    public let e2: s15Fixed16Number
    public let e3: s15Fixed16Number
    public let e4: s15Fixed16Number
    public let e5: s15Fixed16Number
    public let e6: s15Fixed16Number
    public let e7: s15Fixed16Number
    public let e8: s15Fixed16Number
    public let e9: s15Fixed16Number
    public let inputTable: [[UInt8]]
    public let clutTable: [UInt8]
    public let outputTable: [[UInt8]]
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position
        
        guard size >= 8 else {
            throw ICCReadError.corrupted
        }
        
        /// 0 to 3 4 ‘mft1’ (6D667431h) (multi-function table with 1−byte precision) type signature
        self.sig = try TagTypeSignature(dataStream: &dataStream)
        guard self.sig ==  .lut8Type else {
            throw ICCReadError.corrupted
        }
        
        /// 4 to 7 4 Reserved, shall be set to 0
        self.reserved = try dataStream.read(endianess: .bigEndian)
        
        /// 8 1 Number of Input Channels (i) uInt8Number
        self.inputChan = try dataStream.read()
        
        /// 9 1 Number of Output Channels (o) uInt8Number
        self.outputChan = try dataStream.read()
        
        /// 10 1 Number of CLUT grid points (identical for each side) (g)
        self.clutPoints = try dataStream.read()
        
        /// 11 1 Reserved for padding (required to be 00h)
        self.pad = try dataStream.read()
        
        /// 12 to 15 4 Encoded e1 parameter s15Fixed16Number
        self.e1 = try s15Fixed16Number(dataStream: &dataStream)
        
        /// 16 to 19 4 Encoded e2 parameter s15Fixed16Number
        self.e2 = try s15Fixed16Number(dataStream: &dataStream)
        
        /// 20 to 23 4 Encoded e3 parameter s15Fixed16Number
        self.e3 = try s15Fixed16Number(dataStream: &dataStream)
        
        /// 24 to 27 4 Encoded e4 parameter s15Fixed16Number
        self.e4 = try s15Fixed16Number(dataStream: &dataStream)
        
        /// 28 to 31 4 Encoded e5 parameter s15Fixed16Number
        self.e5 = try s15Fixed16Number(dataStream: &dataStream)
        
        /// 32 to 35 4 Encoded e6 parameter s15Fixed16Number
        self.e6 = try s15Fixed16Number(dataStream: &dataStream)
        
        /// 36 to 39 4 Encoded e7 parameter s15Fixed16Number
        self.e7 = try s15Fixed16Number(dataStream: &dataStream)
        
        /// 40 to 43 4 Encoded e8 parameter s15Fixed16Number
        self.e8 = try s15Fixed16Number(dataStream: &dataStream)
        
        /// 44 to 47 4 Encoded e9 parameter s15Fixed16Number
        self.e9 = try s15Fixed16Number(dataStream: &dataStream)
        
        let clutCount = Int(pow(Double(self.clutPoints), Double(self.inputChan))) * Int(self.outputChan)
        guard 48 + Int(self.inputChan) * 256 + Int(clutCount) + Int(self.outputChan) * 256 <= size else {
            throw ICCReadError.corrupted
        }
        
        /// 48 to 47+(256i) 256i Input tables uInt8Number [...]
        var inputTable: [[UInt8]] = []
        inputTable.reserveCapacity(Int(self.inputChan))
        for _ in 0..<self.inputChan {
            inputTable.append(try dataStream.readBytes(count: 256))
        }
        
        self.inputTable = inputTable
        
        /// 48+(256i) to 47+(256i)+(g^i o) g^i o CLUT values uInt8Number [...]
        self.clutTable = try dataStream.readBytes(count: clutCount)
        
        /// 48+(256i)+(g^i o) to end 256o Output tables uInt8Number [...]
        var outputTable: [[UInt8]] = []
        outputTable.reserveCapacity(Int(self.outputChan))
        for _ in 0..<self.outputChan {
            outputTable.append(try dataStream.readBytes(count: 256))
        }
        
        self.outputTable = outputTable
        
        /// Seen padding.
        let remainingCount = Int(size) - (dataStream.position - startPosition)
        if remainingCount > 0 {
            guard dataStream.position + remainingCount <= dataStream.count else {
                throw ICCReadError.corrupted
            }
            
            dataStream.position += remainingCount
        }
        
        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }
}
