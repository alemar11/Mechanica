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

      do {
        let size = CGSize(width: 100, height: 50).aspectFit(boundingSize: CGSize(width: 70, height: 30))
        #if (arch(i386) || arch(arm))
          XCTAssertEqual(size.width.rounded(.down), 60)
          XCTAssertEqual(size.height.rounded(.down), 30)
        #else
          XCTAssertEqual(size.width, 60)
          XCTAssertEqual(size.height, 30)
        #endif
      }

      do {
        let size = CGSize(width: 100, height: 50).aspectFit(boundingSize: CGSize(width: 90, height: 30))
        #if (arch(i386) || arch(arm))
          XCTAssertEqual(size.width.rounded(.down), 60)
          XCTAssertEqual(size.height.rounded(.down), 30)
        #else
          XCTAssertEqual(size.width, 60)
          XCTAssertEqual(size.height, 30)
        #endif
      }

      do {
        let size = CGSize(width: 100, height: 50).aspectFit(boundingSize: CGSize(width: 100, height: 50))
        #if (arch(i386) || arch(arm))
          XCTAssertEqual(size.width.rounded(.down), 100)
          XCTAssertEqual(size.height.rounded(.down), 50)
        #else
          XCTAssertEqual(size.width, 100)
          XCTAssertEqual(size.height, 50)
        #endif
      }

      do {
        let size = CGSize(width: 100, height: 50).aspectFit(boundingSize: CGSize(width: 150, height: 60))
        #if (arch(i386) || arch(arm))
          XCTAssertEqual(size.width.rounded(.down), 120)
          XCTAssertEqual(size.height.rounded(.down), 60)
        #else
          XCTAssertEqual(size.width, 120)
          XCTAssertEqual(size.height, 60)
        #endif
      }

    }

    func testAdd() {
       XCTAssertEqual(CGSize(width: 20, height: 20), CGSize(width: 10, height: 10) + CGSize(width: 10, height: 10))
       XCTAssertEqual(CGSize(width: 30, height: 20), CGSize(width: 10, height: 10) + CGSize(width: 20, height: 10))
       XCTAssertEqual(CGSize(width: 20, height: 20), CGSize(width: 20, height: 20) + CGSize.zero)
    }

    func testAddEqual() {
      var size = CGSize(width: 10, height: 10)

      size += CGSize(width: 10, height: 10)
      XCTAssertEqual(CGSize(width: 20, height: 20), size)
    }

    func testSubtract() {
      XCTAssertEqual(CGSize(width: 0, height: 0), CGSize(width: 10, height: 10) - CGSize(width: 10, height: 10))
       XCTAssertEqual(CGSize(width: -10, height: 0), CGSize(width: 10, height: 10) - CGSize(width: 20, height: 10))
    }

    func testSubtractEqual() {
      var size = CGSize(width: 10, height: 10)
      
      size -= CGSize(width: 10, height: 10)
      XCTAssertEqual(CGSize.zero, size)

    }

    func testMultiplyScalar() {
       XCTAssertEqual(CGSize(width: 20, height: 20), CGSize(width: 10, height: 10) * 2)
    }

    func testMultiplyScalarEqual() {
      var size = CGSize(width: 10, height: 10)
      size *= 2
      XCTAssertEqual(CGSize(width: 20, height: 20), size)
    }

  }

#endif
