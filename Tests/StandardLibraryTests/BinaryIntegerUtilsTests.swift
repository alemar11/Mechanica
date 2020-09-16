import XCTest
@testable import Mechanica

extension BinaryIntegerUtilsTests {
  static var allTests = [
    ("testIsEven", testIsEven),
    ("testIsOdd", testIsOdd),
    ("testIsPositive", testIsPositive),
    ("testIsNegative", testIsNegative)
  ]
}

final class BinaryIntegerUtilsTests: XCTestCase {

  func testIsEven() {
    XCTAssertTrue(2.isEven)
    XCTAssertTrue((-2).isEven)
    XCTAssertTrue(22.isEven)
    XCTAssertTrue((-22).isEven)
    XCTAssertTrue(202220.isEven)
    XCTAssertFalse(3.isEven)
    XCTAssertFalse(27.isEven)
    XCTAssertFalse((-27).isEven)
    XCTAssertFalse(202221.isEven)
    XCTAssertFalse((-202221).isEven)
  }

  func testIsOdd() {
    XCTAssertTrue(1.isOdd)
    XCTAssertTrue((-1).isOdd)
    XCTAssertTrue(11.isOdd)
    XCTAssertTrue((-11).isOdd)
    XCTAssertTrue(171717.isOdd)
    XCTAssertTrue((-171717).isOdd)

    XCTAssertFalse(2.isOdd)
    XCTAssertFalse((-2).isOdd)
    XCTAssertFalse(22.isOdd)
    XCTAssertFalse((-22).isOdd)
    XCTAssertFalse(202220.isOdd)
    XCTAssertFalse((-202220).isOdd)
  }

  func testIsPositive() {
    XCTAssertTrue(2.isPositive)
    XCTAssertTrue(21.isPositive)
    XCTAssertTrue(202220.isPositive)
    XCTAssertFalse((-2).isPositive)
    XCTAssertFalse((-21).isPositive)
    XCTAssertFalse((-202220).isPositive)
  }

  func testIsNegative() {
    XCTAssertTrue((-2).isNegative)
    XCTAssertTrue((-21).isNegative)
    XCTAssertTrue((-202220).isNegative)
    XCTAssertFalse(2.isNegative)
    XCTAssertFalse(21.isNegative)
    XCTAssertFalse(202220.isNegative)
  }

}
