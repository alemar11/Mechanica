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

class StringConversionsTests: XCTestCase {

  func testToBool() {
    do {
      guard let n = "1".bool, n == true else {
        XCTAssert(false, "Couldn't get the correct Bool value.")
        return
      }
    }
    do {
      guard let n = "1 ".bool, n == true else {
        XCTAssert(false, "Couldn't get the correct Bool value.")
        return
      }
    }
    do {
      guard let n = "false".bool, n == false else {
        XCTAssert(false, "Couldn't get the correct Bool value.")
        return
      }
    }
    do {
      guard let n = "yes".bool, n == true else {
        XCTAssert(false, "Couldn't get the correct Bool value.")
        return
      }
    }
    do {
      guard let n = " 👍🏽".bool, n == true else {
        XCTAssert(false, "Couldn't get the correct Bool value.")
        return
      }
    }
    do {
      guard let n = "👎 ".bool, n == false else {
        XCTAssert(false, "Couldn't get the correct Bool value.")
        return
      }
    }
    XCTAssertNil("1x".bool, "Couldn't get the correct Bool value.")
    XCTAssertNil("yess".bool, "Couldn't get the correct Bool value.")
    XCTAssertNil("01".bool, "Couldn't get the correct Bool value.")
    XCTAssertNil("👍🏽👍🏽".bool, "Couldn't get the correct Bool value.")
    XCTAssertNil("👍🏿👍🏽".bool, "Couldn't get the correct Bool value.")
    XCTAssertNil("👎👎".bool, "Couldn't get the correct Bool value.")
    XCTAssertNil("👎🏾👎🏼".bool, "Couldn't get the correct Bool value.")
  }

  func testToBase64Decoded() {
    XCTAssertNil("123".base64Decoded, "Couldn't get the correct Base64 decoded value.")
    XCTAssert("SGVsbG8gV29ybGQh".base64Decoded == "Hello World!", "Couldn't get the correct Base64 decoded value.")
    XCTAssert("SGVsbG8gUm9ib3RzIfCfpJbwn6SW".base64Decoded ==  "Hello Robots!🤖🤖", "Couldn't get the correct Base64 decoded value.")
  }

  func testToBase64Encoded() {
    XCTAssert("Hello World!".base64Encoded == "SGVsbG8gV29ybGQh", "Couldn't get the correct Base64 encoded value.")
    XCTAssert("Hello Robots!🤖🤖".base64Encoded == "SGVsbG8gUm9ib3RzIfCfpJbwn6SW", "Couldn't get the correct Base64 encoded value.")
  }

}
