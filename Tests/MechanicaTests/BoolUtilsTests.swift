//
// Mechanica
//
// Copyright © 2016-2017 Tinrobots.
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

class BoolUtilsTests: XCTestCase {

  func testInt() {
    XCTAssert(true.int == 1)
    XCTAssert(false.int == 0)
  }

  func testString() {
    XCTAssert(true.string == "true")
    XCTAssert(false.string == "false")
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
    var b2 = false
    b2.toggle()
    XCTAssertTrue(b2)
  }

  // MARK:- BinaryConvertible

  func testBinaryString() {
    XCTAssertEqual(true.binaryString, "1")
    XCTAssertEqual(false.binaryString, "0")
  }
}
