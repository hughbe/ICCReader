@testable import ICCReader
import XCTest

final class u16Fixed16NumberTests: XCTestCase {
    func testExample() throws {
        XCTAssertEqual(0, u16Fixed16Number(rawValue: 0x00000000).value)
        XCTAssertEqual(1.0, u16Fixed16Number(rawValue: 0x00010000).value)
        XCTAssertEqual(65535.0 + 65535.0 / 65536.0, u16Fixed16Number(rawValue: 0xFFFFFFFF).value)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
