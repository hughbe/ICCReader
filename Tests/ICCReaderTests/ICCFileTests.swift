@testable import ICCReader
import XCTest

final class MetafileTests: XCTestCase {
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
