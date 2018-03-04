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

  class CGPointUtilsTests: XCTestCase {

    func testDistance() {
      // https://www.mathportal.org/calculators/analytic-geometry/distance-and-midpoint-calculator.php
      XCTAssertEqual(CGPoint(x: 1, y: 2).distance(to: CGPoint(x: 4, y: 5)), 4.2426, accuracy: 0.0001)
      XCTAssertEqual(CGPoint(x: 1, y: 0).distance(to: CGPoint(x: 4, y: 0)), 3, accuracy: 0)
      XCTAssertEqual(CGPoint(x: 0, y: 10).distance(to: CGPoint(x: 0, y: 11)), 1, accuracy: 0)
      XCTAssertEqual(CGPoint(x: 0, y: 0).distance(to: CGPoint(x: 0, y: 0)), 0, accuracy: 0)
      XCTAssertEqual(CGPoint(x: 100, y: 0).distance(to: CGPoint(x: 0, y: 0)), 100, accuracy: 0)
      XCTAssertEqual(CGPoint(x: 100, y: 0).distance(to: CGPoint(x: 0, y: 0)), 100, accuracy: 0)
      XCTAssertEqual(CGPoint(x: 14, y: 30).distance(to: CGPoint(x: 23, y: 21)), 12.7279, accuracy: 0.0001)
      XCTAssertEqual(CGPoint(x: 14, y: 30).distance(to: CGPoint(x: 23, y: 21)), 12.7279, accuracy: 0.0001)
      XCTAssertEqual(CGPoint(x: 12.12, y: 11.11).distance(to: CGPoint(x: 14.41, y: 13.31)), 3.1755, accuracy: 0.0001)
    }
    
    func testStraightLine() {
      XCTAssertTrue(CGPoint(x: 1, y: 2).isOnStraightLine(passingThrough: CGPoint(x:0, y:0), and: CGPoint(x:0, y:0)))
      XCTAssertTrue(CGPoint(x: 1, y: 2).isOnStraightLine(passingThrough: CGPoint(x:1, y:100), and: CGPoint(x:1, y:11.3)))
      XCTAssertTrue(CGPoint(x: 3, y: 2).isOnStraightLine(passingThrough: CGPoint(x:0, y:-10), and: CGPoint(x:1, y:-6))) // y=4x-10
      // Conversions between integer and floating-point numeric types must be made explicit
      XCTAssertTrue(CGPoint(x: 7, y: 3).isOnStraightLine(passingThrough: CGPoint(x:0, y:Double(Double(11)/Double(6))), and: CGPoint(x:10, y:3.5))) // y=(1/6)x+11/6
    }

  }

#endif
