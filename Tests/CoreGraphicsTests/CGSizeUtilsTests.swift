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

class CGSizeUtilsTests: XCTestCase {

  func testAspectFit() {
    XCTAssertEqual(CGSize(width: 100, height: 50).aspectFit(boundingSize: .zero), .zero)
    XCTAssertEqual(CGSize(width: 100, height: 50).aspectFit(boundingSize: CGSize(width: 70, height: 30)), CGSize(width: 60, height: 30))
    XCTAssertEqual(CGSize(width: 100, height: 50).aspectFit(boundingSize: CGSize(width: 100, height: 50)), CGSize(width: 100, height: 50))
    XCTAssertEqual(CGSize(width: 100, height: 50).aspectFit(boundingSize: CGSize(width: 150, height: 50)), CGSize(width: 100, height: 50))
    XCTAssertEqual(CGSize(width: 100, height: 50).aspectFit(boundingSize: CGSize(width: 150, height: 60)), CGSize(width: 120, height: 60))
  }

  func testAdd() {
    //TODO: work in progress
  }

  func testAddEqual() {

  }

  func testSubtract() {
    
  }

  func testSubtractEqual() {

  }

  func testMultiplyScalar() {

  }

  func testMultiplyScalarEqual() {

  }

  func testOperators() {
    var size = CGSize(width: 10, height: 10)
    let size2 = CGSize(width: 10, height: 10)
    XCTAssertEqual(CGSize(width: 20, height: 20), size + size2)
    XCTAssertEqual(CGSize(width: 0, height: 0), size - size2)
    XCTAssertEqual(CGSize(width: 20, height: 20), size * 2)

    size += size2
    XCTAssertEqual(CGSize(width: 20, height: 20), size)

    size -= size2
    XCTAssertEqual(CGSize(width: 10, height: 10), size)

    size *= 2
    XCTAssertEqual(CGSize(width: 20, height: 20), size)
  }

}

#endif
