import XCTest
@testable import Mechanica

extension SignedIntegerTests {
  static var allTests = [
    ("testPositiveOrNegativeValue", testPositiveOrNegativeValue),
    ("testBinaryString", testBinaryString)
  ]
}

final class SignedIntegerTests: XCTestCase {

  func testPositiveOrNegativeValue() {
    XCTAssertTrue(10.isPositive)
    XCTAssertFalse(10.isNegative)
    XCTAssertFalse((-10).isPositive)
    XCTAssertTrue((-10).isNegative)
  }

  // MARK: - BinaryConvertible

  /// http://www.binaryconvert.com/result_signed_int.html?decimal=045049049049
  func testBinaryString() {
    XCTAssertEqual(Int8(10).binaryString, "00001010")
    XCTAssertEqual(Int8(-1).binaryString, "11111111")
    XCTAssertEqual(Int8(0).binaryString, "00000000")
    XCTAssertEqual(Int8(127).binaryString, "01111111")
    XCTAssertEqual(Int8(-127).binaryString, "10000001")
    XCTAssertEqual(Int16(-1).binaryString, "1111111111111111")
    XCTAssertEqual(Int32(-111).binaryString,"11111111111111111111111110010001")

    #if (arch(x86_64) || arch(arm64))
      // For 64-bit systems
      XCTAssertEqual((-3).binaryString, "1111111111111111111111111111111111111111111111111111111111111101")
      XCTAssertEqual(255.binaryString, "0000000000000000000000000000000000000000000000000000000011111111")
      XCTAssertEqual(1.binaryString, "0000000000000000000000000000000000000000000000000000000000000001")
      XCTAssertEqual(11.binaryString,"0000000000000000000000000000000000000000000000000000000000001011")
      XCTAssertEqual(111.binaryString,"0000000000000000000000000000000000000000000000000000000001101111")
      XCTAssertEqual(Int.max.binaryString,"0111111111111111111111111111111111111111111111111111111111111111")
    #elseif (arch(i386) || arch(arm))
      // For 32-bit systems
      XCTAssertEqual((-3).binaryString, "11111111111111111111111111111101")
      XCTAssertEqual(255.binaryString, "00000000000000000000000011111111")
      XCTAssertEqual(1.binaryString, "00000000000000000000000000000001")
      XCTAssertEqual(11.binaryString,"00000000000000000000000000001011")
      XCTAssertEqual(111.binaryString,"00000000000000000000000001101111")
      XCTAssertEqual(Int.max.binaryString,"01111111111111111111111111111111")
    #endif
  }

}


