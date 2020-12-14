//
//  File.swift
//  
//
//  Created by Hugh Bellamy on 14/12/2020.
//

import DataStream

public enum TagFactory {
    case chromacity(_: chromacityType)
    case colorantOrder(_: colorantOrderType)
    case colorantTable(_: colorantTableType)
    case curve(_: curveType)
    case data(_: dataType)
    case dateTime(_: dateTimeType)
    case lut16(_: lut16Type)
    case lut8(_: lut8Type)
    case lutAToB(_: lutAToBType)
    case lutBToA(_: lutBToAType)
    case measurement(_: measurementType)
    case multiLocalizedUnicode(_: multiLocalizedUnicodeType)
    case multiProcessElements(_: multiProcessElementsType)
    case namedColor2(_: namedColor2Type)
    case parametricCurve(_: parametricCurveType)
    case profileSequenceDesc(_: profileSequenceDescType)
    case profileSequenceIdentifier(_: profileSequenceIdentifierType)
    case responseCurveSet16(_: responseCurveSet16Type)
    case s15Fixed16Array(_: s15Fixed16ArrayType)
    case signature(_: signatureType<Signature>)
    case text(_: textType)
    case u16Fixed16Array(_: u16Fixed16ArrayType)
    case uInt16Array(_: uInt16ArrayType)
    case uInt32Array(_: uInt32ArrayType)
    case uInt64Array(_: uInt64ArrayType)
    case uInt8Array(_: uInt8ArrayType)
    case viewingConditions(_: viewingConditionsType)
    case xyz(_: XYZType)
    
    /* Removed */
    case crdInfo(_: crdInfoType)
    case deviceSettings(_: deviceSettingsType)
    case namedColor(_: namedColorType)
    case screening(_: screeningType)
    case textDescription(_: textDescriptionType)
    case ucrBg(_: ucrBgType)

    /* ICC Max */
    case dict(_: dictType)
    case embeddedHeightImage(_: embeddedHeightImageType)
    case embeddedNormalImage(_: embeddedNormalImageType)
    case float16Array(_: float16ArrayType)
    case float32Array(_: float32ArrayType)
    case float64Array(_: float64ArrayType)
    case gamutBoundaryDescription(_: gamutBoundaryDescriptionType)
    case sparseMatrixArray(_: sparseMatrixArrayType)
    case spectralViewingConditions(_: spectralViewingConditionsType)
    case tagArray(_: tagArrayType)
    case tagStruct(_: tagStructType)
    case utf16(_: utf16Type)
    case utf8(_: utf8Type)
    case utf8Zip(_: utf8ZipType)
    case zipXml(_: zipXmlType)
    
    /* Private */
    case displayMakeAndModel(_: displayMakeAndModelType)
    case videoCardGammaTable(_: videoCardGammaTableType)

    case unknown(_: unknownType)
    
    public init(dataStream: inout DataStream, size: UInt32, header: ExtendedProfileHeader) throws {
        guard size >= 4 else {
            throw ICCReadError.corrupted
        }
        
        let startPosition = dataStream.position
        let signature = try KnownSignature<TagTypeSignature>(dataStream: &dataStream)
        dataStream.position = startPosition

        guard case let .known(sig) = signature else {
            guard case .unknown = signature else {
                throw ICCReadError.corrupted
            }
            
            self = .unknown(try unknownType(dataStream: &dataStream, size: size))
            return
        }
        
        switch sig {
        case .chromacityType:
            self = .chromacity(try chromacityType(dataStream: &dataStream, size: size))
        case .colorantOrderType:
            self = .colorantOrder(try colorantOrderType(dataStream: &dataStream, size: size))
        case .colorantTableType:
            self = .colorantTable(try colorantTableType(dataStream: &dataStream, size: size))
        case .curveType:
            self = .curve(try curveType(dataStream: &dataStream, size: size))
        case .dataType:
            self = .data(try dataType(dataStream: &dataStream, size: size))
        case .dateTimeType:
            self = .dateTime(try dateTimeType(dataStream: &dataStream, size: size))
        case .lut16Type:
            self = .lut16(try lut16Type(dataStream: &dataStream, size: size))
        case .lut8Type:
            self = .lut8(try lut8Type(dataStream: &dataStream, size: size))
        case .lutAToBType:
            self = .lutAToB(try lutAToBType(dataStream: &dataStream, size: size))
        case .lutBToAType:
            self = .lutBToA(try lutBToAType(dataStream: &dataStream, size: size))
        case .measurementType:
            self = .measurement(try measurementType(dataStream: &dataStream, size: size))
        case .multiLocalizedUnicodeType:
            self = .multiLocalizedUnicode(try multiLocalizedUnicodeType(dataStream: &dataStream, size: size))
        case .multiProcessElementsType:
            self = .multiProcessElements(try multiProcessElementsType(dataStream: &dataStream, size: size))
        case .namedColor2Type:
            self = .namedColor2(try namedColor2Type(dataStream: &dataStream, size: size))
        case .parametricCurveType:
            self = .parametricCurve(try parametricCurveType(dataStream: &dataStream, size: size))
        case .profileSequenceDescType:
            self = .profileSequenceDesc(try profileSequenceDescType(dataStream: &dataStream, size: size))
        case .profileSequenceIdentifierType:
            self = .profileSequenceIdentifier(try profileSequenceIdentifierType(dataStream: &dataStream, size: size))
        case .responseCurveSet16Type:
            self = .responseCurveSet16(try responseCurveSet16Type(dataStream: &dataStream, size: size))
        case .s15Fixed16ArrayType:
            self = .s15Fixed16Array(try s15Fixed16ArrayType(dataStream: &dataStream, size: size))
        case .signatureType:
            self = .signature(try signatureType(dataStream: &dataStream, size: size))
        case .textType:
            self = .text(try textType(dataStream: &dataStream, size: size))
        case .u16Fixed16ArrayType:
            self = .u16Fixed16Array(try u16Fixed16ArrayType(dataStream: &dataStream, size: size))
        case .ucrBgType:
            self = .ucrBg(try ucrBgType(dataStream: &dataStream, size: size))
        case .uInt16ArrayType:
            self = .uInt16Array(try uInt16ArrayType(dataStream: &dataStream, size: size))
        case .uInt32ArrayType:
            self = .uInt32Array(try uInt32ArrayType(dataStream: &dataStream, size: size))
        case .uInt64ArrayType:
            self = .uInt64Array(try uInt64ArrayType(dataStream: &dataStream, size: size))
        case .uInt8ArrayType:
            self = .uInt8Array(try uInt8ArrayType(dataStream: &dataStream, size: size))
        case .viewingConditionsType:
            self = .viewingConditions(try viewingConditionsType(dataStream: &dataStream, size: size))
        case .xyzType:
            self = .xyz(try XYZType(dataStream: &dataStream, size: size))
            
        /* Removed */
        case .crdInfoType:
            self = .crdInfo(try crdInfoType(dataStream: &dataStream, size: size))
        case .deviceSettingsType:
            self = .deviceSettings(try deviceSettingsType(dataStream: &dataStream, size: size))
        case .namedColorType:
            self = .namedColor(try namedColorType(dataStream: &dataStream, size: size, header: header))
        case .screeningType:
            self = .screening(try screeningType(dataStream: &dataStream, size: size))
        case .textDescriptionType:
            self = .textDescription(try textDescriptionType(dataStream: &dataStream, size: size))
        
        /* ICC Max */
        case .dictType:
            self = .dict(try dictType(dataStream: &dataStream, size: size))
        case .embeddedHeightImageType:
            self = .embeddedHeightImage(try embeddedHeightImageType(dataStream: &dataStream, size: size))
        case .embeddedNormalImageType:
            self = .embeddedNormalImage(try embeddedNormalImageType(dataStream: &dataStream, size: size))
        case .float16ArrayType:
            self = .float16Array(try float16ArrayType(dataStream: &dataStream, size: size))
        case .float32ArrayType:
            self = .float32Array(try float32ArrayType(dataStream: &dataStream, size: size))
        case .float64ArrayType:
            self = .float64Array(try float64ArrayType(dataStream: &dataStream, size: size))
        case .gamutBoundaryDescriptionType:
            self = .gamutBoundaryDescription(try gamutBoundaryDescriptionType(dataStream: &dataStream, size: size))
        case .sparseMatrixArrayType:
            self = .sparseMatrixArray(try sparseMatrixArrayType(dataStream: &dataStream, size: size))
        case .spectralViewingConditionsType:
            self = .spectralViewingConditions(try spectralViewingConditionsType(dataStream: &dataStream, size: size))
        case .tagArrayType:
            self = .tagArray(try tagArrayType(dataStream: &dataStream, size: size))
        case .tagStructType:
            self = .tagStruct(try tagStructType(dataStream: &dataStream, size: size, header: header))
        case .utf16Type:
            self = .utf16(try utf16Type(dataStream: &dataStream, size: size))
        case .utf8Type:
            self = .utf8(try utf8Type(dataStream: &dataStream, size: size))
        case .utf8ZipType:
            self = .utf8Zip(try utf8ZipType(dataStream: &dataStream, size: size))
        case .zipXmlType:
            self = .zipXml(try zipXmlType(dataStream: &dataStream, size: size))
            
        /* Private */
        case .videoCardGammaTableType:
            self = .videoCardGammaTable(try videoCardGammaTableType(dataStream: &dataStream, size: size))
        case .displayMakeAndModelType:
            self = .displayMakeAndModel(try displayMakeAndModelType(dataStream: &dataStream, size: size))
        case .displayNativeInformationType,
             .ncpi,
             .vcgp,
             .zxml,
             .msbn,
             .tcpt,
             .sdin:
            self = .unknown(try unknownType(dataStream: &dataStream, size: size))
        }
        
        guard dataStream.position - startPosition == size else {
            throw ICCReadError.corrupted
        }
    }
    
    public struct unknownType {
        public let sig: Signature
        public let reserved: uInt32Number
        public let data: [UInt8]
        
        public init(dataStream: inout DataStream, size: UInt32) throws {
            let startPosition = dataStream.position
            
            guard size >= 8 else {
                throw ICCReadError.corrupted
            }
            
            /// 0 to 3 4 type signature
            self.sig = try Signature(dataStream: &dataStream)
            
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
