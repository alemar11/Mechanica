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
      guard let n = "1".toBool, n == true else {
        XCTAssert(false, "Couldn't get the correct Bool value.")
        return
      }
    }
    do {
      guard let n = "1 ".toBool, n == true else {
        XCTAssert(false, "Couldn't get the correct Bool value.")
        return
      }
    }
    do {
      guard let n = "false".toBool, n == false else {
        XCTAssert(false, "Couldn't get the correct Bool value.")
        return
      }
    }
    do {
      guard let n = "yes".toBool, n == true else {
        XCTAssert(false, "Couldn't get the correct Bool value.")
        return
      }
    }
    do {
      guard let n = " 👍🏽".toBool, n == true else {
        XCTAssert(false, "Couldn't get the correct Bool value.")
        return
      }
    }
    do {
      guard let n = "👎 ".toBool, n == false else {
        XCTAssert(false, "Couldn't get the correct Bool value.")
        return
      }
    }
    XCTAssertNil("1x".toBool, "Couldn't get the correct Bool value.")
    XCTAssertNil("yess".toBool, "Couldn't get the correct Bool value.")
    XCTAssertNil("01".toBool, "Couldn't get the correct Bool value.")
    XCTAssertNil("👍🏽👍🏽".toBool, "Couldn't get the correct Bool value.")
    XCTAssertNil("👍🏿👍🏽".toBool, "Couldn't get the correct Bool value.")
    XCTAssertNil("👎👎".toBool, "Couldn't get the correct Bool value.")
    XCTAssertNil("👎🏾👎🏼".toBool, "Couldn't get the correct Bool value.")
  }

  func testToBase64Decoded() {
    XCTAssertNil("123".toBase64Decoded, "Couldn't get the correct Base64 decoded value.")
    XCTAssert("SGVsbG8gV29ybGQh".toBase64Decoded == "Hello World!", "Couldn't get the correct Base64 decoded value.")
    XCTAssert("SGVsbG8gUm9ib3RzIfCfpJbwn6SW".toBase64Decoded ==  "Hello Robots!🤖🤖", "Couldn't get the correct Base64 decoded value.")
  }

  func testToBase64Encoded() {
    XCTAssert("Hello World!".toBase64Encoded == "SGVsbG8gV29ybGQh", "Couldn't get the correct Base64 encoded value.")
    XCTAssert("Hello Robots!🤖🤖".toBase64Encoded == "SGVsbG8gUm9ib3RzIfCfpJbwn6SW", "Couldn't get the correct Base64 encoded value.")
  }

  func testToDouble() {
    guard let n = "11".toDouble, n == 11 else {
      XCTAssert(false, "Couldn't get correct Double value.")
      return
    }
    guard let n2 = "11.04".toDouble, n2 == 11.04 else {
      XCTAssert(false, "Couldn't get correct Double value.")
      return
    }
    guard let n3 = "04".toDouble, n3 == 4 else {
      XCTAssert(false, "Couldn't get correct Double value.")
      return
    }
    XCTAssertNil("11t".toDouble, "Couldn't get correct Double value.")
    XCTAssertNil("11,04".toDouble, "Couldn't get correct Double value.")
  }

  func testToFloat() {

    /// Float
    do {
      guard let n = "11".toFloat, n == 11 else {
        XCTAssert(false, "Couldn't get correct Float value.")
        return
      }
      guard let n2 = "11.04".toFloat, n2 == 11.04 else {
        XCTAssert(false, "Couldn't get correct Float value.")
        return
      }
      guard let n3 = "04".toFloat, n3 == 4 else {
        XCTAssert(false, "Couldn't get correct Float value.")
        return
      }
    }

    /// Float 32
    do {
      guard let n = "11.0483".toFloat32, n == 11.0483 else {
        XCTAssert(false, "Couldn't get correct Float 32 value.")
        return
      }
      guard let n2 = "11.04830483048304830483048304830483".toFloat32, n2 == 11.0483046 else {
        XCTAssert(false, "Couldn't get correct Float 32 value.")
        return
      }

    }

    /// Float 64
    do {

      guard let n = "11.04830483048304830483048304830483".toFloat64, n == 11.048304830483048 else {
        XCTAssert(false, "Couldn't get correct Float 64 value.")
        return
      }

    }

    XCTAssertNil("11t".toFloat, "Couldn't get correct Float value.")
    XCTAssertNil("11,04830483048304830483048304830483".toFloat64, "Couldn't get correct Float 64 value.")
  }

  func testToInt() {

    /// Int
    do {
      guard let n = "11".toInt, n == 11 else {
        XCTAssert(false, "Couldn't get correct Int value.")
        return
      }

      guard let n2 = "04".toInt, n2 == 4 else {
        XCTAssert(false, "Couldn't get correct Int value.")
        return
      }
    }

    /// Int 8
    do {
      guard let n = "-128".toInt8, n == -128 else {
        XCTAssert(false, "Couldn't get correct Float value.")
        return
      }

      guard let n2 = "127".toInt8, n2 == 127 else {
        XCTAssert(false, "Couldn't get correct Float value.")
        return
      }

      guard let n3 = "00000011".toInt8, n3 == 11 else {
        XCTAssert(false, "Couldn't get correct Float value.")
        return
      }

    }

    /// Int 16
    do {
      guard let n = "-32768".toInt16, n == -32768 else {
        XCTAssert(false, "Couldn't get correct Float value.")
        return
      }
    }

    /// Int 32
    do {
      guard let n = "2147483647".toInt32, n == 2147483647 else {
        XCTAssert(false, "Couldn't get correct Int 32 value.")
        return
      }
    }

    /// Int 64
    do {
      guard let n = "9223372036854775807".toInt64, n == 9223372036854775807 else {
        XCTAssert(false, "Couldn't get correct Int 64 value.")
        return
      }

      guard let n2 = "-09223372036854775807".toInt64, n2 == -9223372036854775807 else {
        XCTAssert(false, "Couldn't get correct Int 64 value.")
        return
      }
    }

    XCTAssertNil("0t".toInt, "Couldn't get correct Int value.")
    XCTAssertNil("11,04".toInt, "Couldn't get correct Int value.")
    XCTAssertNil("11.04".toInt, "Couldn't get correct Int value.")
    XCTAssertNil("128".toInt8, "Couldn't get correct Int value.")
    XCTAssertNil("--2768".toInt32, "Couldn't get correct Int value.")
    XCTAssertNil("-42768".toInt16, "Couldn't get correct Int 16 value.")
    XCTAssertNotNil("-42768".toInt32, "Couldn't get correct Int 32 value.")
    XCTAssertNotNil("-42768".toInt32, "Couldn't get correct Int 64 value.")
    XCTAssertNotNil("-42768".toInt, "Couldn't get correct Int value.")
    XCTAssertNil("9223372036854775808".toInt64, "Couldn't get correct Int 64 value.")
  }

  func testToURL() {
    XCTAssertNotNil("tinrobots.org".toUrl, "Couldn't get correct URL value.")
    XCTAssertNil("tin🤖🤖.org".toUrl, "Couldn't get correct URL value.")
    XCTAssertNil("".toUrl, "Couldn't get correct URL value.")
    XCTAssertNotNil("a///c".toUrl, "Couldn't get correct URL value.")
  }

}
