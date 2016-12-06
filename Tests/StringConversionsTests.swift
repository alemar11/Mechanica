//
//  StringConversionsTests.swift
//  Mechanica
//
//  Copyright © 2016 Tinrobots.
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
    
  func test_bool() {
    guard let n = "1".bool, n == true else {
      XCTAssert(false, "Couldn't get the correct Bool value.")
      return
    }
    guard let n2 = "false".bool, n2 == false else {
      XCTAssert(false, "Couldn't get the correct Bool value.")
      return
    }
    guard let n3 = "yes".bool, n3 == true else {
      XCTAssert(false, "Couldn't get the correct Bool value.")
      return
    }
    XCTAssertNil("1x".bool, "Couldn't get the correct Bool value.")
    XCTAssertNil("yess".bool, "Couldn't get the correct Bool value.")
    XCTAssertNil("01".bool, "Couldn't get the correct Bool value.")
  }
  
  func test_base64Decoded() {
    XCTAssertNil("123".base64Decoded, "Couldn't get the correct Base64 decoded value.")
    XCTAssert("SGVsbG8gV29ybGQh".base64Decoded == "Hello World!", "Couldn't get the correct Base64 decoded value.")
    XCTAssert("SGVsbG8gUm9ib3RzIfCfpJbwn6SW".base64Decoded ==  "Hello Robots!🤖🤖", "Couldn't get the correct Base64 decoded value.")
  }
  
  func test_base64Encoded() {
    XCTAssert("Hello World!".base64Encoded == "SGVsbG8gV29ybGQh", "Couldn't get the correct Base64 encoded value.")
    XCTAssert("Hello Robots!🤖🤖".base64Encoded == "SGVsbG8gUm9ib3RzIfCfpJbwn6SW", "Couldn't get the correct Base64 encoded value.")
  }
  
  func test_double() {
    guard let n = "11".double, n == 11 else {
      XCTAssert(false, "Couldn't get correct Double value.")
      return
    }
    guard let n2 = "11.04".double, n2 == 11.04 else {
      XCTAssert(false, "Couldn't get correct Double value.")
      return
    }
    guard let n3 = "04".double, n3 == 4 else {
      XCTAssert(false, "Couldn't get correct Double value.")
      return
    }
    XCTAssertNil("11t".double, "Couldn't get correct Double value.")
    XCTAssertNil("11,04".double, "Couldn't get correct Double value.")
  }
  
  func test_float() {
    
    /// Float
    do {
      guard let n = "11".float, n == 11 else {
        XCTAssert(false, "Couldn't get correct Float value.")
        return
      }
      guard let n2 = "11.04".float, n2 == 11.04 else {
        XCTAssert(false, "Couldn't get correct Float value.")
        return
      }
      guard let n3 = "04".float, n3 == 4 else {
        XCTAssert(false, "Couldn't get correct Float value.")
        return
      }
    }
    
    /// Float 32
    do {
      guard let n = "11.0483".float32, n == 11.0483 else {
        XCTAssert(false, "Couldn't get correct Float 32 value.")
        return
      }
      guard let n2 = "11.04830483048304830483048304830483".float32, n2 == 11.0483046 else {
        XCTAssert(false, "Couldn't get correct Float 32 value.")
        return
      }

    }
    
    /// Float 64
    do {

      guard let n = "11.04830483048304830483048304830483".float64, n == 11.048304830483048 else {
        XCTAssert(false, "Couldn't get correct Float 64 value.")
        return
      }
      
    }
    
    XCTAssertNil("11t".float, "Couldn't get correct Float value.")
    XCTAssertNil("11,04830483048304830483048304830483".float64, "Couldn't get correct Float 64 value.")
  }
  
  func test_int() {
    
    /// Int
    do {
      guard let n = "11".int, n == 11 else {
        XCTAssert(false, "Couldn't get correct Int value.")
        return
      }
      
      guard let n2 = "04".int, n2 == 4 else {
        XCTAssert(false, "Couldn't get correct Int value.")
        return
      }
    }
    
    /// Int 8
    do {
      guard let n = "-128".int8, n == -128 else {
        XCTAssert(false, "Couldn't get correct Float value.")
        return
      }
      
      guard let n2 = "127".int8, n2 == 127 else {
        XCTAssert(false, "Couldn't get correct Float value.")
        return
      }
      
      guard let n3 = "00000011".int8, n3 == 11 else {
        XCTAssert(false, "Couldn't get correct Float value.")
        return
      }
      
    }
    
    /// Int 16
    do {
      guard let n = "-32768".int16, n == -32768 else {
        XCTAssert(false, "Couldn't get correct Float value.")
        return
      }
    }
    
    /// Int 32
    do {
      guard let n = "2147483647".int32, n == 2147483647 else {
        XCTAssert(false, "Couldn't get correct Int 32 value.")
        return
      }
    }
    
    /// Int 64
    do {
      guard let n = "9223372036854775807".int64, n == 9223372036854775807 else {
        XCTAssert(false, "Couldn't get correct Int 64 value.")
        return
      }
      
      guard let n2 = "-09223372036854775807".int64, n2 == -9223372036854775807 else {
        XCTAssert(false, "Couldn't get correct Int 64 value.")
        return
      }
    }
    
    XCTAssertNil("0t".int, "Couldn't get correct Int value.")
    XCTAssertNil("11,04".int, "Couldn't get correct Int value.")
    XCTAssertNil("11.04".int, "Couldn't get correct Int value.")
    XCTAssertNil("128".int8, "Couldn't get correct Int value.")
    XCTAssertNil("--2768".int32, "Couldn't get correct Int value.")
    XCTAssertNil("-42768".int16, "Couldn't get correct Int 16 value.")
    XCTAssertNotNil("-42768".int32, "Couldn't get correct Int 32 value.")
    XCTAssertNotNil("-42768".int32, "Couldn't get correct Int 64 value.")
    XCTAssertNotNil("-42768".int, "Couldn't get correct Int value.")
    XCTAssertNil("9223372036854775808".int64, "Couldn't get correct Int 64 value.")
  }
  
  func test_URL() {
    XCTAssertNotNil("tinrobots.org".url, "Couldn't get correct URL value.")
    XCTAssertNil("tin🤖🤖.org".url, "Couldn't get correct URL value.")
    XCTAssertNil("".url, "Couldn't get correct URL value.")
    XCTAssertNotNil("a///c".url, "Couldn't get correct URL value.")
  }
  
}
