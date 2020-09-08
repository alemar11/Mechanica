import XCTest
@testable import Mechanica

extension DataUtilsTests {
  static var allTests = [
    ("testBytes", testBytes),
    ("testHexEncodedString", testHexEncodedString)
  ]
}

final class DataUtilsTests: XCTestCase {

  func testBytes() {
    let data = "tinrobots".data(using: .utf8)
    let bytes = data?.bytes
    XCTAssertNotNil(bytes)
    XCTAssertEqual(bytes?.count, 9)
  }

  func testHexEncodedString() {
    let data = Data([0, 1, 127, 128, 255])
    XCTAssertEqual(data.hexEncodedString, "00017f80ff")
  }

}
