@testable import ICCReader
import XCTest

final class s15Fixed16NumberTests: XCTestCase {
    func testExample() throws {
        XCTAssertEqual(-32768.0, s15Fixed16Number(rawValue: 0x80000000).value)
        XCTAssertEqual(0, s15Fixed16Number(rawValue: 0x00000000).value)
        XCTAssertEqual(1.0, s15Fixed16Number(rawValue: 0x00010000).value)
        XCTAssertEqual(32767.0 + 65535.0 / 65536.0, s15Fixed16Number(rawValue: 0x7FFFFFFF).value)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
