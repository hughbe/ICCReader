@testable import ICCReader
import XCTest

final class MetafileTests: XCTestCase {
    func testHeader() throws {
        do {
            let data = try getData(name: "sRGB_v4_ICC_preference_displayclass", fileExtension: "icc")
            let file = try ICCColorProfile(data: data)
            XCTAssertEqual(60988, file.header.size)
            XCTAssertEqual("none", file.header.cmm)
            XCTAssertEqual(4, file.header.version.majorVersion)
            XCTAssertEqual(2, file.header.version.minorVersion)
            XCTAssertEqual(0, file.header.version.bugFixVersion)
            XCTAssertEqual(0, file.header.version.subClassMajorVersion)
            XCTAssertEqual(0, file.header.version.subClassMinorVersion)
            XCTAssertEqual(ICCColorProfileClassSignature.displayDevices, file.header.class)
            XCTAssertEqual(ColorSpaceSignature.rgb, file.header.colorSpace)
            XCTAssertEqual(ColorSpaceSignature.lab, file.header.pcs)
            XCTAssertEqual(2009, file.header.date.year)
            XCTAssertEqual(08, file.header.date.month)
            XCTAssertEqual(10, file.header.date.day)
            XCTAssertEqual(17, file.header.date.hours)
            XCTAssertEqual(28, file.header.date.minutes)
            XCTAssertEqual(ICCColorProfilePlatformSignature.none, file.header.platform)
            XCTAssertFalse(file.header.flags.cannotBeUsedIndependentlyFromEmbeddedColorData)
            XCTAssertFalse(file.header.flags.embedded)
            XCTAssertFalse(file.header.flags.mcsChannelsSubsetOfMcsChannelsInProfile)
            XCTAssertEqual("none", file.header.manufacturer)
            XCTAssertEqual("none", file.header.model)
            XCTAssertEqual(.perceptual, file.header.renderingIntent)
            XCTAssertEqual(XYZNumber(x: 0.9642029, y: 1, z: 0.8249054), file.header.pcsIlluminant)
            XCTAssertEqual("none", file.header.creator)
        }
        do {
            let data = try getData(name: "AdobeRGB1998", fileExtension: "icc")
            let file = try ICCColorProfile(data: data)
            XCTAssertEqual(2, file.header.version.majorVersion)
            XCTAssertEqual(1, file.header.version.minorVersion)
            XCTAssertEqual(0, file.header.version.bugFixVersion)
            XCTAssertEqual(0, file.header.version.subClassMajorVersion)
            XCTAssertEqual(0, file.header.version.subClassMinorVersion)
        }
    }
    
    func testExample() throws {
        do {
            let data = try getData(name: "AdobeRGB1998", fileExtension: "icc")
            let file = try ICCColorProfile(data: data)
            print(file)
        }
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
