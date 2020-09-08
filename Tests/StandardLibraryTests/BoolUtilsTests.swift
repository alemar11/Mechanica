import XCTest
@testable import Mechanica

extension BoolUtilsTests {
  static var allTests = [
    ("testInt", testInt),
    ("testRandom", testRandom),
    ("testToggle", testToggle),
    ("testBinaryString", testBinaryString)
  ]
}

final class BoolUtilsTests: XCTestCase {

  func testInt() {
    XCTAssert(true.int == 1)
    XCTAssert(false.int == 0)
  }

  func testRandom() {
    let b = Bool.random()
    switch b {
    case true:
      XCTAssert(true)
      return
    case false:
      XCTAssert(true)
    }
  }

  func testToggle() {
    let b1 = true
    XCTAssertTrue(b1.toggled == false)
  }

  // MARK:- BinaryConvertible

  func testBinaryString() {
    XCTAssertEqual(true.binaryString, "1")
    XCTAssertEqual(false.binaryString, "0")
  }
}
