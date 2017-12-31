//
// Mechanica
//
// Copyright © 2016-2018 Tinrobots.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

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

class BinaryIntegerUtilsTests: XCTestCase {

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
