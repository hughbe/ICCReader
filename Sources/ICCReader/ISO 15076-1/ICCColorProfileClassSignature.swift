//
//  ICCColorProfileClassSignature.swift
//  
//
//  Created by Hugh Bellamy on 07/03/2021.
//

/// 7.2.7 Profile/device class field (bytes 12 to15)
/// This field shall contain one of the profile class Signatures shown in Table 14.
/// There are three basic classes of device profiles: Input, Display and Output profiles. In addition to the three basic device profile
/// classes, eight additional colour processing profiles are defined. These profiles provide a standard implementation for use by
/// the CMM in general colour processing, or for the convenience of CMMs which may use these types to store calculated transforms.
/// These eight additional profile classes are DeviceLink, ColorSpace, ColorEncodingSpace, Abstract, NamedColor,
/// MultiplexIdentification, MultiplexLink and MultiplexVisualization.
public enum ICCColorProfileClassSignature {
    /// Input Device profile ‘scnr’ 73636E72h
    public static let inputDevices: ICCSignature = "scnr"
    
    /// Display Device profile ‘mntr’ 6D6E7472h
    public static let displayDevices: ICCSignature = "mntr"
    
    /// Output Device profile ‘prtr’ 70727472h
    public static let outputDevices: ICCSignature = "prtr"
    
    /// DeviceLink profile ‘link’ 6C696E6Bh
    public static let deviceLink: ICCSignature = "link"
    
    /// ColorSpace profile ‘spac’ 73706163h
    public static let colorSpace: ICCSignature = "spac"
    
    /// Abstract profile ‘abst’ 61627374h
    public static let abstract: ICCSignature = "abst"
    
    /// NamedColor profile ‘nmcl’ 6E6D636Ch
    public static let namedColor: ICCSignature = "nmcl"
    
    /// ColorEncodingSpace profile ‘cenc‘ 63656E63h
    public static let colorEncodingSpace: ICCSignature = "cenc"
    
    /// MultiplexIdentification profile ‘mid ’ 6D696420h
    public static let multiplexIdentification: ICCSignature = "mid "
    
    /// MultiplexLink profile ‘mlnk’ 6d6c6e6bh
    public static let multiplexLink: ICCSignature = "mlnk"
    
    /// MultiplexVisualization profile ‘mvis’ 6d766973h
    public static let multiplexVisualizationor: ICCSignature = "mvis"
}
