@testable import ICCReader
import XCTest

final class u8Fixed8NumberTests: XCTestCase {
    func testExample() throws {
        XCTAssertEqual(0, u8Fixed8Number(rawValue: 0x0000).value)
        XCTAssertEqual(1.0, u8Fixed8Number(rawValue: 0x0100).value)
        XCTAssertEqual(255.0 + 255.0 / 256.0, u8Fixed8Number(rawValue: 0xFFFF).value)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
