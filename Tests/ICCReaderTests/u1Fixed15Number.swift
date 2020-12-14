@testable import ICCReader
import XCTest

final class u1Fixed15NumberTests: XCTestCase {
    func testExample() throws {
        XCTAssertEqual(0, u1Fixed15Number(rawValue: 0x0000).value)
        XCTAssertEqual(1.0, u1Fixed15Number(rawValue: 0x8000).value)
        XCTAssertEqual(1.0 + 32767.0 / 32768.0, u1Fixed15Number(rawValue: 0xFFFF).value)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
