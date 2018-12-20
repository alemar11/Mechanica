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

#if canImport(UIKit)

import XCTest
import UIKit
@testable import Mechanica

final class UIEdgeInsetsUtilsTests: XCTestCase {

  func testHorizontal() {
    let inset = UIEdgeInsets(top: 70.0, left: 15.0, bottom: 5.0, right: 10.0)
    XCTAssertEqual(inset.horizontal, 25.0)
  }

  func testVertical() {
    let inset = UIEdgeInsets(top: 20.0, left: 10.0, bottom: 5.0, right: 10.0)
    XCTAssertEqual(inset.vertical, 25.0)
  }

  func testInitInset() {
    let inset = UIEdgeInsets(inset: 15.5)
    XCTAssertEqual(inset.top, 15.5)
    XCTAssertEqual(inset.bottom, 15.5)
    XCTAssertEqual(inset.right, 15.5)
    XCTAssertEqual(inset.left, 15.5)
  }

  func testInitVerticalHorizontal() {
    let inset = UIEdgeInsets(horizontal: 20.0, vertical: 20.0)
    XCTAssertEqual(inset.top, 10.0)
    XCTAssertEqual(inset.bottom, 10.0)
    XCTAssertEqual(inset.right, 10.0)
    XCTAssertEqual(inset.left, 10.0)
  }

}

#endif
