//
//  ICCColorProfile+PrivateTags.swift
//  
//
//  Created by Hugh Bellamy on 08/02/2021.
//

public extension ICCColorProfile {
    /// Apple Computer 61616267 ‘aabg’ 2008-08-28 Tag
    var aabg: parametricCurveType? {
        guard let tag = getTag(signature: ICCTagSignature.aabg) else {
            return nil
        }

        if case let .parametricCurve(value) = tag.data {
            return value
        }
        
        return nil
    }

    /// Apple Computer 61616767 ‘aagg’ 2008-08-28 Tag
    var aagg: parametricCurveType? {
        guard let tag = getTag(signature: ICCTagSignature.aagg) else {
            return nil
        }

        if case let .parametricCurve(value) = tag.data {
            return value
        }
        
        return nil
    }

    /// Apple Computer 61617267 ‘aarg’ 2008-08-28 Tag
    var aarg: parametricCurveType? {
        guard let tag = getTag(signature: ICCTagSignature.aarg) else {
            return nil
        }

        if case let .parametricCurve(value) = tag.data {
            return value
        }
        
        return nil
    }

    /// Graham Gill 61727473 ‘arts’ 2014-09-17 Tag
    var arts: [Float]? {
        guard let tag = getTag(signature: ICCTagSignature.arts) else {
            return nil
        }

        if case let .s15Fixed16Array(value) = tag.data {
            return value
        }
        
        return nil
    }

    /// GretagMacbeth 43494544 ‘CIED’ 2002-10-11 Tag
    var cied: String? {
        guard let tag = getTag(signature: ICCTagSignature.cied) else {
            return nil
        }

        if case let .text(value) = tag.data {
            return value
        }
        
        return nil
    }

    /// Monaco Systems Inc. 44455644 ‘DEVD’ 2003-09-17 Tag
    var devd: String? {
        guard let tag = getTag(signature: ICCTagSignature.devd) else {
            return nil
        }

        if case let .text(value) = tag.data {
            return value
        }
        
        return nil
    }

    /// Apple Computer 6473636d ‘dscm’ 2004-05-28 Tag
    var dscm: [multiLocalizedUnicodeType.LocalizedString]? {
        guard let tag = getTag(signature: ICCTagSignature.dscm) else {
            return nil
        }

        if case let .multiLocalizedUnicode(value) = tag.data {
            return value
        }
        
        return nil
    }

    /// GretagMacbeth 676d7073 ‘gmps’ 2003-08-29 Tag
    var gmps: dataType? {
        guard let tag = getTag(signature: ICCTagSignature.gmps) else {
            return nil
        }

        if case let .data(value) = tag.data {
            return value
        }
        
        return nil
    }

    /// Apple Computer 6d6d6f64 ‘mmod’ 2004-05-28 Tag
    var displayMakeAndModel: displayMakeAndModelType? {
        guard let tag = getTag(signature: ICCTagSignature.displayMakeAndModel) else {
            return nil
        }

        if case let .displayMakeAndModel(value) = tag.data {
            return value
        }
        
        return nil
    }

    /// GretagMacbeth 506d7472 ‘Pmtr’ 2002-10-11 Tag
    var pmtr: String? {
        guard let tag = getTag(signature: ICCTagSignature.pmtr) else {
            return nil
        }

        if case let .text(value) = tag.data {
            return value
        }
        
        return nil
    }

    /// Apple Computer 76636774 'vcgt' Tag
    var videoCardGammaTable: videoCardGammaTableType? {
        guard let tag = getTag(signature: ICCTagSignature.videoCardGammaTable) else {
            return nil
        }

        if case let .videoCardGammaTable(value) = tag.data {
            return value
        }
        
        return nil
    }
}
