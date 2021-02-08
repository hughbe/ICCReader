//
//  embeddedHeightImageType.swift
//
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// [ICC.2:2019] 10.2.6 embeddedHeightImageType
/// This type provides support for embedding an image that defines a height map. The structure encoding shall be as given in Table 42.
/// The image data shall be encoded using the image file format defined by the Displacement Image Format field which can have the
/// values given in Table 44.
/// The contents of a Displacement Image shall be encoded as greyscale pixels used to identify the height of the displacement. A pixel
/// with a minimum pixel value shall have a displacement equal to the height in meters defined by the height in meters of minimum pixel
/// value field. A pixel with a maximum pixel value shall have a displacement equal to the height in meters defined by the height in
/// meters of maximum pixel value field.
/// The physical dimensions of the pixels in the image shall be encoded by using the appropriate encoding mechanisms of the
/// image-encoding format. The PNG format uses the pHYs chunk to specify the physical size of the image. The TIFF format uses the
/// perResolutionUnit, XResolution and YResolution tags to specify the physical dimensions.
public struct embeddedHeightImageType {
    public let sig: ICCSignature
    public let reserved: uInt32Number
    public let seamless: Bool
    public let encoding: ImageEncodingType
    public let minimumPixelValueHeight: float32Number
    public let maximumPixelValueHeight: float32Number
    public let imageData: [uInt8Number]
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position
        
        guard size >= 24 else {
            throw ICCReadError.corrupted
        }
        
        /// 0 to 3 4 ‘ehim’ (6568696dh) type signature
        self.sig = try ICCSignature(dataStream: &dataStream)
        guard self.sig ==  ICCTagTypeSignature.embeddedHeightImage else {
            throw ICCReadError.corrupted
        }
        
        /// 4 to 7 4 Reserved, shall be 0
        self.reserved = try dataStream.read(endianess: .bigEndian)
        
        /// 8 to 11 4 Seamless indicator See Table 43
        /// Not seamless 0
        /// Seamless 1
        self.seamless = (try dataStream.read(endianess: .bigEndian) != 0)
        
        /// 12 to 15 4 Height image encoding format See Table 44
        self.encoding = try ImageEncodingType(dataStream: &dataStream)
        
        /// 16 to 19 4 Height in meters of minimum pixel value float32Number
        self.minimumPixelValueHeight = try dataStream.readFloat(endianess: .bigEndian)
        
        /// 20 to 23 4 Height in meters of maximum pixel value float32Number
        self.maximumPixelValueHeight = try dataStream.readFloat(endianess: .bigEndian)
        
        /// 24 to end (tag data element size) − 12 Height image data
        self.imageData = try dataStream.readBytes(count: Int(size - 24))
        
        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }
}
