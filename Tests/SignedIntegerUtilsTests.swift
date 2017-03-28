//
//  SignedIntegerUtilsTests.swift
//  Mechanica
//
//  Copyright © 2016-2017 Tinrobots.
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

class SignedIntegerTests: XCTestCase {
  
  // MARK: - BinaryConvertible
  
  /// http://www.binaryconvert.com/result_signed_int.html?decimal=045049049049
  func test_binaryString() {
    XCTAssertEqual(Int8(10).binaryString, "00001010")
    XCTAssertEqual(Int8(-1).binaryString, "11111111")
    XCTAssertEqual((-3).binaryString, "1111111111111111111111111111111111111111111111111111111111111101")
    XCTAssertEqual(255.binaryString, "0000000000000000000000000000000000000000000000000000000011111111")
    XCTAssertEqual(Int8(0).binaryString, "00000000")
    XCTAssertEqual(1.binaryString, "0000000000000000000000000000000000000000000000000000000000000001")
    XCTAssertEqual(Int16(-1).binaryString, "1111111111111111")
    XCTAssertEqual(11.binaryString,"0000000000000000000000000000000000000000000000000000000000001011")
    XCTAssertEqual(111.binaryString,"0000000000000000000000000000000000000000000000000000000001101111")
    XCTAssertEqual(Int.max.binaryString,"0111111111111111111111111111111111111111111111111111111111111111")
    XCTAssertEqual(Int32(-111).binaryString,"11111111111111111111111110010001")
  }
  
  // MARK: - Utils
  
  func test_hexadecimalString(uppercase: Bool = true) {
    XCTAssertEqual(255.hexadecimalString(), "ff")
    XCTAssertEqual(255.hexadecimalString(uppercase: false), "ff")
    XCTAssertEqual(255.hexadecimalString(uppercase: true), "FF")
    XCTAssertEqual(0.hexadecimalString(), "0")
    XCTAssertEqual(1.hexadecimalString(), "1")
    XCTAssertEqual(11.hexadecimalString(),"B")
    XCTAssertEqual(111.hexadecimalString(uppercase: true),"6F")
    XCTAssertEqual(111222.hexadecimalString(),"1B276")
    XCTAssertEqual(Int.max.hexadecimalString(uppercase: true), "7FFFFFFFFFFFFFFF")
    XCTAssertEqual(Int.max.hexadecimalString(uppercase: false), "7fffffffffffffff")
    
    //XCTAssertEqual(Int8(-11).hexadecimalString(), "-B")
  }
  
}
