import XCTest
@testable import Mechanica

extension BinaryFloatingPointUtilsTests {
  static var allTests = [("testbinaryString", testbinaryString)]
}

final class BinaryFloatingPointUtilsTests: XCTestCase {

  // MARK: - BinaryConvertible

  /// http://www.binaryconvert.com/result_signed_int.html?decimal=045049049049
  func testbinaryString() {
    XCTAssertEqual(Float(-5.625).binaryString,"11000000101101000000000000000000")
    XCTAssertEqual(Float(329.390625).binaryString,"01000011101001001011001000000000")
    XCTAssertEqual(Float32(923.52).binaryString,"01000100011001101110000101001000")
    XCTAssertEqual(Float32(-1234.5678).binaryString,"11000100100110100101001000101011")
    XCTAssertEqual(Float32(50).binaryString,"01000010010010000000000000000000")
    XCTAssertEqual(Float32(-50).binaryString,"11000010010010000000000000000000")
    #if (arch(x86_64) || arch(arm64))
      XCTAssertEqual(Float64(-100.1235).binaryString,"1100000001011001000001111110011101101100100010110100001110010110")
      XCTAssertEqual(Float64(923.52).binaryString,"0100000010001100110111000010100011110101110000101000111101011100")
      XCTAssertEqual(Float64(-3.14e-3202).binaryString,"1000000000000000000000000000000000000000000000000000000000000000")
      XCTAssertEqual(Float64(5e-324).binaryString,"0000000000000000000000000000000000000000000000000000000000000001")
      XCTAssertEqual(Float64.pi.binaryString,"0100000000001001001000011111101101010100010001000010110100011000")
    #endif
  }

}

