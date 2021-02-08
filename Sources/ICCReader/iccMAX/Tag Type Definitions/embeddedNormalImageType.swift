//
//  embeddedNormalImageType.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// [ICC.2:2019] 10.2.7 embeddedNormalImageType
/// This type provides support for embedding an image that defines a normal map. The structure encoding shall be as given in Table 45.
/// The normal image data can be created so that when the normal map is tiled across a surface it has no visible seams. The Seamless
/// indicator field indicates if the normal image is seamless and has the values as given in Table 46.
/// The image data shall be encoded using the image file format defined by the Normal Image Format field which can have the values
/// as given in Table 47.
/// The contents of a Normal Image shall be encoded as RGB pixels used to identify XYZ direction of the normal vector for each point
/// in the image. RGBs are mapped to XYZ directions as follows:
/// 1) red maps from (0 − maximum red value) to X (−1,0 – 1,0);
/// 2) green maps from (0 − maximum green value) to Y (−1,0 – 1,0);
/// 3) blue maps from (0 − maximum blue value) to Z (0,0 – 1,0).
/// Since normals point towards the observer, negative values of Z are not encoded. The maximum values for the red, green, and blue
/// channels can be found by accessing the appropriate fields of the PNG and TIFF files. The length of the vector specified by the XYZ
/// direction shall be equal to 1,0.
/// The physical dimensions of the pixels in the image shall be encoded by using the appropriate encoding mechanisms of the
/// image-encoding format. The PNG format uses the pHYs chunk to specify the physical size of the image. The TIFF format uses the
/// perResolutionUnit, XResolution and YResolution tags to specify the physical dimensions.
public struct embeddedNormalImageType {
    public let sig: ICCSignature
    public let reserved: uInt32Number
    public let seamless: Bool
    public let encoding: ImageEncodingType
    public let imageData: [uInt8Number]
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position
        
        guard size >= 16 else {
            throw ICCReadError.corrupted
        }
        
        /// 0 to 3 4 ‘enim’ (656e696dh) type signature
        self.sig = try ICCSignature(dataStream: &dataStream)
        guard self.sig ==  ICCTagTypeSignature.embeddedNormalImage else {
            throw ICCReadError.corrupted
        }
        
        /// 4 to 7 4 Reserved, shall be 0
        self.reserved = try dataStream.read(endianess: .bigEndian)
        
        /// 8 to 11 4 Seamless indicator See Table 46
        /// Not seamless 0
        /// Seamless 1
        self.seamless = (try dataStream.read(endianess: .bigEndian) != 0)
        
        /// 12 to 15 4 Normal image encoding format See Table 47
        self.encoding = try ImageEncodingType(dataStream: &dataStream)
        
        /// 16 to end (tag data element size) − 12 Normal image data
        self.imageData = try dataStream.readBytes(count: Int(size - 24))
        
        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }
}
