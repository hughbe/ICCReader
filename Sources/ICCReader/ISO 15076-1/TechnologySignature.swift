//
//  TechnologySignature.swift
//  
//
//  Created by Hugh Bellamy on 12/12/2020.
//

/// [ICC.1:2010] 9.2.47 technologyTag
/// Tag signature: ‘tech’ (74656368h)
/// Permitted tag type: signatureType
/// The device technology signatures that shall be used are listed in Table 29.
public enum TechnologySignature: String {
    /// Film scanner ‘fscn’ 6673636Eh
    case filmScanner = "fscn"

    /// Digital camera ‘dcam’ 6463616Dh
    case digitalCamera = "dcam"

    /// Reflective scanner ‘rscn’ 7273636Eh
    case reflectiveScanner = "rscn"

    /// Ink jet printer ‘ijet’ 696A6574h
    case inkJetPrinter = "ijet"

    /// Thermal wax printer ‘twax’ 74776178h
    case thermalWaxPrinter = "twax"

    /// Electrophotographic printer ‘epho’ 6570686Fh
    case electrophotographicPrinter = "epho"

    /// Electrostatic printer ‘esta’ 65737461h
    case electorstaticPrinter = "esta"

    /// Dye sublimation printer ‘dsub’ 64737562h
    case dyeSublimationPrinter = "dsub"

    /// Photographic paper printer ‘rpho’ 7270686Fh
    case photographicPaperPrinter = "rpho"

    /// Film writer ‘fprn’ 6670726Eh
    case filmWriter = "fprn"

    /// Video monitor ‘vidm’ 7669646Dh
    case videoMonitor = "vidm"

    /// Video camera ‘vidc’ 76696463h
    case videoCamera = "vidc"

    /// Projection television ‘pjtv’ 706A7476h
    case projectionTelevision = "pjtv"

    /// Cathode ray tube display ‘CRT ’ 43525420h
    case cathodeRayTubeDisplay = "CRT "

    /// Passive matrix display ‘PMD ’ 504D4420h
    case passiveMatrixDisplay = "PMD "

    /// Active matrix display ‘AMD ’ 414D4420h
    case activeMatrixDisplay = "AMD "

    /// Photo CD ‘KPCD’ 4B504344h
    case photoCD = "KPCD"

    /// Photographic image setter ‘imgs’ 696D6773h
    case photographicImageSetter = "imgs"

    /// Gravure ‘grav’ 67726176h
    case gravure = "grav"

    /// Offset lithography ‘offs’ 6F666673h
    case offsetLithography = "offs"

    /// Silkscreen ‘silk’ 73696C6Bh
    case silkscreen = "silk"

    /// Flexography ‘flex’ 666C6578h
    case flexography = "flex"

    /// Motion picture film scanner ‘mpfs’ 6D706673h
    case motionPictureFilmScanner = "mpfs"

    /// Motion picture film recorder ‘mpfr’ 6D706672h
    case motionPictureFilmRecorder = "mpfr"

    /// Digital motion picture camera ‘dmpc’ 646D7063h
    case digitalMotionPictureCamera = "dmpc"

    /// Digital cinema projector ‘dcpj’ 64636A70h
    case digitalCinemaProjector = "dcpj"

}
