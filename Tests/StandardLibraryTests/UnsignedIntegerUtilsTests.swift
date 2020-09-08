import XCTest
@testable import Mechanica

extension UnsignedIntegerUtilsTests {
  static var allTests = [ ("testBinaryString", testBinaryString) ]
}

final class UnsignedIntegerUtilsTests: XCTestCase {

  // MARK: - BinaryConvertible

  /// http://www.binaryconvert.com/result_signed_int.html?decimal=045049049049
  func testBinaryString() {
    XCTAssertEqual(UInt8(10).binaryString,"00001010")
    XCTAssertEqual(UInt8(255).binaryString,"11111111")
    XCTAssertEqual(UInt16(10).binaryString,"0000000000001010")
    XCTAssertEqual(UInt32(255).binaryString,"00000000000000000000000011111111")
    XCTAssertEqual(UInt64(12345).binaryString,"0000000000000000000000000000000000000000000000000011000000111001")
  }

}
