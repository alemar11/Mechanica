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

#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)

class CGRectUtilsTests: XCTestCase {

  func testInit() {
    let rect = CGRect(width: 100, height: 50)
    XCTAssertEqual(rect.origin, .zero)
    XCTAssertEqual(rect.size, CGSize(width: 100, height: 50))
  }

  func testRounded() {
    XCTAssertEqual(CGRect.zero.rounded(rule: .down), .zero)
    XCTAssertEqual(CGRect(x: 10, y: 11, width: 12, height: 13).rounded(rule: .down), CGRect(x: 10, y: 11, width: 12, height: 13))
    XCTAssertEqual(CGRect(x: 10.3, y: 11.5, width: 12.7, height: 13.0).rounded(rule: .down), CGRect(x: 10, y: 11, width: 12, height: 13))
    XCTAssertEqual(CGRect.zero.ceil, .zero)
    XCTAssertEqual(CGRect(x: 10, y: 11, width: 12, height: 13).rounded(rule: .up), CGRect(x: 10, y: 11, width: 12, height: 13))
    XCTAssertEqual(CGRect(x: 10.3, y: 11.5, width: 12.7, height: 13.0).rounded(rule: .up), CGRect(x: 11, y: 12, width: 13, height: 13))
  }

  func testArea() {
    XCTAssertEqual(CGRect.zero.area, 0)
    XCTAssertEqual(CGRect(width: 100, height: 50).area, 5000)
    XCTAssertEqual(CGRect(width: 100, height: 0).area, 0)
    XCTAssertEqual(CGRect(width: 100, height: 0.1).area, 10)
  }

}

#endif
