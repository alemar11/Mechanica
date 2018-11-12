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

extension DataUtilsTests {
  static var allTests = [
    ("testBytes", testBytes),
    ("testHexEncodedString", testHexEncodedString)
  ]
}

final class DataUtilsTests: XCTestCase {

  func testBytes() {
    let data = "tinrobots".data(using: .utf8)
    let bytes = data?.bytes
    XCTAssertNotNil(bytes)
    XCTAssertEqual(bytes?.count, 9)
  }

  func testHexEncodedString() {
    let data = Data(bytes: [0, 1, 127, 128, 255])
    XCTAssertEqual(data.hexEncodedString, "00017f80ff")
  }


}
