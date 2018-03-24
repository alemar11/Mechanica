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

extension OptionalUtilsTests {
  static var allTests = [
    ("testHasValue", testHasValue),
    ("testOr", testOr),
    ("testOrWithAutoclosure", testOrWithAutoclosure),
    ("testOrWithClosure", testOrWithClosure),
    ("testOrThrowException", testOrThrowException)
  ]
}

final class OptionalUtilsTests: XCTestCase {

  func testHasValue() {
    var value: Any?
    XCTAssert(!value.hasValue)
    value = "tinrobots"
    XCTAssert(value.hasValue)
  }

  func testOr() {
    let value1: String? = "hello"
    XCTAssertEqual(value1.or("world"), "hello")

    let value2: String? = nil
    XCTAssertEqual(value2.or("world"), "world")
  }

  func testOrWithAutoclosure() {
    func runMe() -> String {
      return "world"
    }
    let value1: String? = "hello"
    XCTAssertEqual(value1.or(else: runMe()), "hello")

    let value2: String? = nil
    XCTAssertEqual(value2.or(else: runMe()), "world")
  }

  func testOrWithClosure() {
    let value1: String? = "hello"
    XCTAssertEqual(value1.or(else: { return "world" }), "hello")

    let value2: String? = nil
    XCTAssertEqual(value2.or(else: { return "world" }), "world")
  }

  func testOrThrowException() {
    enum DemoError: Error { case test }

    let value1: String? = "hello"
    XCTAssertNoThrow(try value1.or(throw: DemoError.test))

    let value2: String? = nil
    XCTAssertThrowsError(try value2.or(throw: DemoError.test))
  }

}
