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

class SignedIntegerTests: XCTestCase {

  // MARK: - BinaryConvertible

  /// http://www.binaryconvert.com/result_signed_int.html?decimal=045049049049
  func testToBinaryString() {
    XCTAssertEqual(Int8(10).toBinaryString, "00001010")
    XCTAssertEqual(Int8(-1).toBinaryString, "11111111")
    XCTAssertEqual(Int8(0).toBinaryString, "00000000")
    XCTAssertEqual(Int8(127).toBinaryString, "01111111")
    XCTAssertEqual(Int8(-127).toBinaryString, "10000001")
    XCTAssertEqual(Int16(-1).toBinaryString, "1111111111111111")
    XCTAssertEqual(Int32(-111).toBinaryString,"11111111111111111111111110010001")

    #if (arch(x86_64) || arch(arm64))
      // For 64-bit systems
      XCTAssertEqual((-3).toBinaryString, "1111111111111111111111111111111111111111111111111111111111111101")
      XCTAssertEqual(255.toBinaryString, "0000000000000000000000000000000000000000000000000000000011111111")
      XCTAssertEqual(1.toBinaryString, "0000000000000000000000000000000000000000000000000000000000000001")
      XCTAssertEqual(11.toBinaryString,"0000000000000000000000000000000000000000000000000000000000001011")
      XCTAssertEqual(111.toBinaryString,"0000000000000000000000000000000000000000000000000000000001101111")
      XCTAssertEqual(Int.max.toBinaryString,"0111111111111111111111111111111111111111111111111111111111111111")
    #elseif (arch(i386) || arch(arm))
      // For 32-bit systems
      XCTAssertEqual((-3).binaryString, "11111111111111111111111111111101")
      XCTAssertEqual(255.binaryString, "00000000000000000000000011111111")
      XCTAssertEqual(1.binaryString, "00000000000000000000000000000001")
      XCTAssertEqual(11.binaryString,"00000000000000000000000000001011")
      XCTAssertEqual(111.binaryString,"00000000000000000000000001101111")
      XCTAssertEqual(Int.max.binaryString,"01111111111111111111111111111111")
    #endif
  }

}


