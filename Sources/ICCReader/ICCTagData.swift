//
//  ICCTagData.swift
//  
//
//  Created by Hugh Bellamy on 14/12/2020.
//

import DataStream

public enum ICCTagData {
    case chromacity(_: chromacityType)
    case colorantOrder(_: [uInt8Number])
    case colorantTable(_: [colorantTableType.Colorant])
    case curve(_: curveType)
    case data(_: dataType)
    case dateTime(_: dateTimeNumber)
    case lut16(_: lut16Type)
    case lut8(_: lut8Type)
    case lutAToB(_: lutAToBType)
    case lutBToA(_: lutBToAType)
    case measurement(_: measurementType)
    case multiLocalizedUnicode(_: [multiLocalizedUnicodeType.LocalizedString])
    case multiProcessElements(_: multiProcessElementsType)
    case namedColor2(_: namedColor2Type)
    case parametricCurve(_: parametricCurveType)
    case profileSequenceDesc(_: [profileSequenceDescType.ProfileDescription])
    case profileSequenceIdentifier(_: [profileSequenceIdentifierType.ProfileIdentifier])
    case responseCurveSet16(_: responseCurveSet16Type)
    case s15Fixed16Array(_: [Float])
    case signature(_: ICCSignature)
    case text(_: String)
    case u16Fixed16Array(_: [Float])
    case uInt16Array(_: [UInt16])
    case uInt32Array(_: [UInt32])
    case uInt64Array(_: [UInt64])
    case uInt8Array(_: [UInt8])
    case viewingConditions(_: viewingConditionsType)
    case xyz(_: [XYZNumber])
    
    /* Removed */
    case crdInfo(_: crdInfoType)
    case deviceSettings(_: [deviceSettingsType.PlatformEntry])
    case namedColor(_: namedColorType)
    case screening(_: screeningType)
    case textDescription(_: textDescriptionType)
    case ucrBg(_: ucrBgType)

    /* ICC Max */
    case dict(_: dictType)
    case embeddedHeightImage(_: embeddedHeightImageType)
    case embeddedNormalImage(_: embeddedNormalImageType)
    case float16Array(_: [UInt16])
    case float32Array(_: [Float])
    case float64Array(_: [Double])
    case gamutBoundaryDescription(_: gamutBoundaryDescriptionType)
    case sparseMatrixArray(_: sparseMatrixArrayType)
    case spectralViewingConditions(_: spectralViewingConditionsType)
    case tagArray(_: tagArrayType)
    case tagStruct(_: tagStructType)
    case utf16(_: String)
    case utf8(_: String)
    case utf8Zip(_: [UInt8])
    case zipXml(_: [UInt8])
    
    /* Private */
    case displayMakeAndModel(_: displayMakeAndModelType)
    case videoCardGammaTable(_: videoCardGammaTableType)

    case unknown(signature: ICCSignature, data: [UInt8])
    
    public init(dataStream: inout DataStream, size: UInt32, header: ExtendedProfileHeader) throws {
        guard size >= 4 else {
            throw ICCReadError.corrupted
        }
        
        let startPosition = dataStream.position
        let signature = try ICCSignature(dataStream: &dataStream)
        dataStream.position = startPosition

        switch signature {
        case ICCTagTypeSignature.chromacity:
            self = .chromacity(try chromacityType(dataStream: &dataStream, size: size))
        case ICCTagTypeSignature.colorantOrder:
            let data = try colorantOrderType(dataStream: &dataStream, size: size)
            self = .colorantOrder(data.values)
        case ICCTagTypeSignature.colorantTable:
            let data = try colorantTableType(dataStream: &dataStream, size: size)
            self = .colorantTable(data.values)
        case ICCTagTypeSignature.curve:
            self = .curve(try curveType(dataStream: &dataStream, size: size))
        case ICCTagTypeSignature.data:
            self = .data(try dataType(dataStream: &dataStream, size: size))
        case ICCTagTypeSignature.dateTime:
            let data = try dateTimeType(dataStream: &dataStream, size: size)
            self = .dateTime(data.date)
        case ICCTagTypeSignature.lut16:
            self = .lut16(try lut16Type(dataStream: &dataStream, size: size))
        case ICCTagTypeSignature.lut8:
            self = .lut8(try lut8Type(dataStream: &dataStream, size: size))
        case ICCTagTypeSignature.lutAToB:
            self = .lutAToB(try lutAToBType(dataStream: &dataStream, size: size))
        case ICCTagTypeSignature.lutBToA:
            self = .lutBToA(try lutBToAType(dataStream: &dataStream, size: size))
        case ICCTagTypeSignature.measurement:
            self = .measurement(try measurementType(dataStream: &dataStream, size: size))
        case ICCTagTypeSignature.multiLocalizedUnicode:
            let data = try multiLocalizedUnicodeType(dataStream: &dataStream, size: size)
            self = .multiLocalizedUnicode(data.values)
        case ICCTagTypeSignature.multiProcessElements:
            self = .multiProcessElements(try multiProcessElementsType(dataStream: &dataStream, size: size))
        case ICCTagTypeSignature.namedColor2:
            self = .namedColor2(try namedColor2Type(dataStream: &dataStream, size: size))
        case ICCTagTypeSignature.parametricCurve:
            self = .parametricCurve(try parametricCurveType(dataStream: &dataStream, size: size))
        case ICCTagTypeSignature.profileSequenceDesc:
            let data = try profileSequenceDescType(dataStream: &dataStream, size: size)
            self = .profileSequenceDesc(data.values)
        case ICCTagTypeSignature.profileSequenceIdentifier:
            let data = try profileSequenceIdentifierType(dataStream: &dataStream, size: size)
            self = .profileSequenceIdentifier(data.values)
        case ICCTagTypeSignature.responseCurveSet16:
            self = .responseCurveSet16(try responseCurveSet16Type(dataStream: &dataStream, size: size))
        case ICCTagTypeSignature.s15Fixed16Array:
            let data = try s15Fixed16ArrayType(dataStream: &dataStream, size: size)
            self = .s15Fixed16Array(data.values.map { $0.value })
        case ICCTagTypeSignature.Signature:
            let data = try signatureType(dataStream: &dataStream, size: size)
            self = .signature(data.signature)
        case ICCTagTypeSignature.text:
            let data = try textType(dataStream: &dataStream, size: size)
            self = .text(data.data)
        case ICCTagTypeSignature.u16Fixed16Array:
            let data = try u16Fixed16ArrayType(dataStream: &dataStream, size: size)
            self = .u16Fixed16Array(data.values.map { $0.value })
        case ICCTagTypeSignature.ucrBg:
            self = .ucrBg(try ucrBgType(dataStream: &dataStream, size: size))
        case ICCTagTypeSignature.uInt16Array:
            let data = try uInt16ArrayType(dataStream: &dataStream, size: size)
            self = .uInt16Array(data.values)
        case ICCTagTypeSignature.uInt32Array:
            let data = try uInt32ArrayType(dataStream: &dataStream, size: size)
            self = .uInt32Array(data.values)
        case ICCTagTypeSignature.uInt64Array:
            let data = try uInt64ArrayType(dataStream: &dataStream, size: size)
            self = .uInt64Array(data.values)
        case ICCTagTypeSignature.uInt8Array:
            let data = try uInt8ArrayType(dataStream: &dataStream, size: size)
            self = .uInt8Array(data.values)
        case ICCTagTypeSignature.viewingConditions:
            self = .viewingConditions(try viewingConditionsType(dataStream: &dataStream, size: size))
        case ICCTagTypeSignature.xyz:
            let data = try XYZType(dataStream: &dataStream, size: size)
            self = .xyz(data.values)
            
        /* Removed */
        case ICCTagTypeSignature.crdInfo:
            self = .crdInfo(try crdInfoType(dataStream: &dataStream, size: size))
        case ICCTagTypeSignature.deviceSettings:
            let data = try deviceSettingsType(dataStream: &dataStream, size: size)
            self = .deviceSettings(data.entries)
        case ICCTagTypeSignature.namedColor:
            self = .namedColor(try namedColorType(dataStream: &dataStream, size: size, header: header))
        case ICCTagTypeSignature.screening:
            self = .screening(try screeningType(dataStream: &dataStream, size: size))
        case ICCTagTypeSignature.textDescription:
            self = .textDescription(try textDescriptionType(dataStream: &dataStream, size: size))
        
        /* ICC Max */
        case ICCTagTypeSignature.dict:
            self = .dict(try dictType(dataStream: &dataStream, size: size))
        case ICCTagTypeSignature.embeddedHeightImage:
            self = .embeddedHeightImage(try embeddedHeightImageType(dataStream: &dataStream, size: size))
        case ICCTagTypeSignature.embeddedNormalImage:
            self = .embeddedNormalImage(try embeddedNormalImageType(dataStream: &dataStream, size: size))
        case ICCTagTypeSignature.float16Array:
            let data = try float16ArrayType(dataStream: &dataStream, size: size)
            self = .float16Array(data.values)
        case ICCTagTypeSignature.float32Array:
            let data = try float32ArrayType(dataStream: &dataStream, size: size)
            self = .float32Array(data.values)
        case ICCTagTypeSignature.float64Array:
            let data = try float64ArrayType(dataStream: &dataStream, size: size)
            self = .float64Array(data.values)
        case ICCTagTypeSignature.gamutBoundaryDescription:
            self = .gamutBoundaryDescription(try gamutBoundaryDescriptionType(dataStream: &dataStream, size: size))
        case ICCTagTypeSignature.sparseMatrixArray:
            self = .sparseMatrixArray(try sparseMatrixArrayType(dataStream: &dataStream, size: size))
        case ICCTagTypeSignature.spectralViewingConditions:
            self = .spectralViewingConditions(try spectralViewingConditionsType(dataStream: &dataStream, size: size))
        case ICCTagTypeSignature.tagArray:
            self = .tagArray(try tagArrayType(dataStream: &dataStream, size: size))
        case ICCTagTypeSignature.tagStruct:
            self = .tagStruct(try tagStructType(dataStream: &dataStream, size: size, header: header))
        case ICCTagTypeSignature.utf16:
            let data = try utf16Type(dataStream: &dataStream, size: size)
            self = .utf16(data.value)
        case ICCTagTypeSignature.utf8:
            let data = try utf8Type(dataStream: &dataStream, size: size)
            self = .utf8(data.value)
        case ICCTagTypeSignature.utf8Zip:
            let data = try utf8ZipType(dataStream: &dataStream, size: size)
            self = .utf8Zip(data.compressedData)
        case ICCTagTypeSignature.zipXml:
            let data = try zipXmlType(dataStream: &dataStream, size: size)
            self = .zipXml(data.compressedData)
            
        /* Private */
        case ICCTagTypeSignature.videoCardGammaTable:
            self = .videoCardGammaTable(try videoCardGammaTableType(dataStream: &dataStream, size: size))
        case ICCTagTypeSignature.displayMakeAndModel:
            self = .displayMakeAndModel(try displayMakeAndModelType(dataStream: &dataStream, size: size))
        default:
            let data = try unknownType(dataStream: &dataStream, size: size)
            self = .unknown(signature: data.sig, data: data.data)
        }
        
        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }
    
    public struct unknownType {
        public let sig: ICCSignature
        public let reserved: uInt32Number
        public let data: [UInt8]
        
        public init(dataStream: inout DataStream, size: UInt32) throws {
            let startPosition = dataStream.position
            
            guard size >= 8 else {
                throw ICCReadError.corrupted
            }
            
            /// 0 to 3 4 type signature
            self.sig = try ICCSignature(dataStream: &dataStream)
            
            /// 4 to 7 4 Reserved, shall be set to 0
            self.reserved = try dataStream.read(endianess: .bigEndian)
            
            /// 8 to end Variable
            self.data = try dataStream.readBytes(count: Int(size) - 8)
            
            guard dataStream.position - startPosition == size else {
                throw ICCReadError.corrupted
            }

        }
    }
}
