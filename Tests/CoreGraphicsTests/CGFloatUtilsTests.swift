//
// Mechanica
//
// Copyright © 2016-2019 Tinrobots.
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

  final class CGFloatUtilsTests: XCTestCase {

    func testDegreesToRadians() {
      XCTAssertEqual(CGFloat(180).degreesToRadians, CGFloat.pi)
      XCTAssertEqual(CGFloat(45).degreesToRadians, CGFloat.pi/4)
    }

    func testRadiansToDegrees() {
      XCTAssertEqual(CGFloat.pi.radiansToDegrees, 180)
      XCTAssertEqual((CGFloat.pi/4).radiansToDegrees, 45)
    }

    func testShortestAngle() {
      XCTAssertEqual(CGFloat.shortestAngleInRadians(from: .pi, to: .pi * 2), .pi)

      #if (arch(i386) || arch(arm))
        XCTAssertEqual(CGFloat.shortestAngleInRadians(from: 0, to: .pi * (3/2)).rounded(), (-CGFloat.pi/2).rounded())
        XCTAssertEqual(CGFloat.shortestAngleInRadians(from: 0, to: -.pi * 2).rounded(), 0)
        XCTAssertEqual(CGFloat.shortestAngleInRadians(from: 0, to: -CGFloat.pi).rounded(to: 4), (CGFloat.pi).rounded(to: 4))
      #else
        XCTAssertEqual(CGFloat.shortestAngleInRadians(from: 0, to: .pi * (3/2)), -.pi/2)
        XCTAssertEqual(CGFloat.shortestAngleInRadians(from: 0, to: -.pi * 2), 0)
        XCTAssertEqual(CGFloat.shortestAngleInRadians(from: 0, to: -.pi), .pi)
      #endif

      XCTAssertEqual(CGFloat.shortestAngleInRadians(from: .pi * (1/4), to: .pi * (3/2)), -.pi * (3/4))
      XCTAssertEqual(CGFloat.shortestAngleInRadians(from: CGFloat(350).degreesToRadians, to: CGFloat(15).degreesToRadians).rounded(), CGFloat(25).degreesToRadians.rounded()) // from 350° to 15° = 25°
      XCTAssertEqual(CGFloat.shortestAngleInRadians(from: CGFloat(250).degreesToRadians, to: CGFloat(190).degreesToRadians).rounded(), CGFloat(-60).degreesToRadians.rounded()) // from 250° to 190° = 60°
      XCTAssertEqual(CGFloat.shortestAngleInRadians(from: CGFloat(190).degreesToRadians, to: CGFloat(250).degreesToRadians).rounded(), CGFloat(60).degreesToRadians.rounded())
    }

  }

#endif
