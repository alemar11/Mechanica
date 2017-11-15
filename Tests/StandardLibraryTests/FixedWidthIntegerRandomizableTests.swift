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

class FixedWidthIntegerIntervalRandomizableTests: XCTestCase {

  static var allTests = [
    ("testRandomlowerBound", testRandomlowerBound),
    ("testRandomUInt", testRandomUInt),
    ("testOverflow", testOverflow)
  ]
  
  func testRandomlowerBound() {

    /// Int
    XCTAssertTrue(Int.random(lowerBound: 1, upperBound: 1) == 1)
    XCTAssertTrue(Int.random(lowerBound: Int.max, upperBound: Int.max) == Int.max)

    do {
      let randolowerBoundt = Int.random(lowerBound: 0, upperBound: 1)
      XCTAssertTrue((randolowerBoundt == 0) || (randolowerBoundt == 1))
    }

    XCTAssertTrue(Int.random(lowerBound: 1, upperBound: 100) <= 100)
    XCTAssertTrue(Int.min...Int.max ~= Int.random())
    XCTAssertTrue(Int32.min...Int32.max ~= Int32.random())
    XCTAssertFalse(Int.random(lowerBound: 50, upperBound: 100) > 100)
    XCTAssertFalse(Int.random(lowerBound: 40, upperBound: 50) < 40)

    /// Int64
    XCTAssertTrue(Int64.min...Int64.max ~= Int64.random())
    XCTAssertTrue(Int64.random(lowerBound: Int64.max, upperBound: Int64.max) == Int64.max)

    /// Int32
    XCTAssertTrue(Int32.random(lowerBound: Int32.max, upperBound: Int32.max) == Int32.max)

    /// Int16
    XCTAssertTrue(Int16.random(lowerBound: 1, upperBound: 1) == 1)
    XCTAssertTrue(Int16.random(lowerBound: Int16.max, upperBound: Int16.max) == Int16.max)

    do {
      let randolowerBoundt = Int16.random(lowerBound: 0, upperBound: 1)
      XCTAssertTrue((randolowerBoundt == 0) || (randolowerBoundt == 1))
    }

    XCTAssertTrue(Int16.random(lowerBound: 1, upperBound: 100) <= 100)
    XCTAssertTrue(Int16.min...Int16.max ~= Int16.random())
    XCTAssertFalse(Int16.random(lowerBound: 50, upperBound: 100) > 100)
    XCTAssertFalse(Int16.random(lowerBound: 40, upperBound: 50) < 40)

    /// Int8
    XCTAssertTrue(Int8.random(lowerBound: 1, upperBound: 1) == 1)
    XCTAssertTrue(Int8.random(lowerBound: 11, upperBound: 12) == 11)
    XCTAssertTrue(Int8.random(lowerBound: Int8.min, upperBound: Int8.min) == Int8.min)

    do {
      let randolowerBoundt = Int8.random(lowerBound: 0, upperBound: 1)
      XCTAssertTrue((randolowerBoundt == 0) || (randolowerBoundt == 1))
    }

    XCTAssertTrue(Int8.random(lowerBound: 1, upperBound: 100) <= 100)
    XCTAssertTrue(Int8.min...Int8.max ~= Int8.random())
    XCTAssertFalse(Int8.random(lowerBound: 50, upperBound: 100) > 100)
    XCTAssertFalse(Int8.random(lowerBound: 40, upperBound: 50) < 40)

  }

  func testRandomUInt() {

    /// UInt
    XCTAssertTrue(UInt.min...UInt.max ~= UInt.random())
    XCTAssertTrue(UInt.random(lowerBound: 1, upperBound: 100) <= 100)
    XCTAssertTrue(UInt.min...UInt.max ~= UInt.random())
    XCTAssertFalse(UInt.random(lowerBound: 50, upperBound: 100) > 100)
    XCTAssertFalse(UInt.random(lowerBound: 40, upperBound: 50) < 40)
    XCTAssertTrue(UInt.random(lowerBound: UInt.max, upperBound: UInt.max) == UInt.max)

    /// UInt64
    XCTAssertTrue(UInt64.random(lowerBound: UInt64.max, upperBound: UInt64.max) == UInt64.max)
    XCTAssertTrue(UInt64.random() <= UInt64.max)

    /// UInt32
    XCTAssertTrue(UInt32.min...UInt32.max ~= UInt32.random())
    XCTAssertTrue(UInt32.random(lowerBound: 1, upperBound: 100) <= 100)
    XCTAssertTrue(UInt32.min...UInt32.max ~= UInt32.random())
    XCTAssertFalse(UInt32.random(lowerBound: 50, upperBound: 100) > 100)
    XCTAssertFalse(UInt32.random(lowerBound: 4000, upperBound: 5000) < 4000)
    XCTAssertTrue(UInt32.random(lowerBound: UInt32.max, upperBound: UInt32.max) == UInt32.max)

    /// UInt16
    XCTAssertTrue(UInt16.min...UInt16.max ~= UInt16.random())
    XCTAssertTrue(UInt16.random(lowerBound: 1, upperBound: 100) <= 100)
    XCTAssertTrue(UInt16.min...UInt16.max ~= UInt16.random())
    XCTAssertFalse(UInt16.random(lowerBound: 50, upperBound: 100) > 100)
    XCTAssertFalse(UInt16.random(lowerBound: 4000, upperBound: 5000) < 4000)
    XCTAssertTrue(UInt16.random(lowerBound: UInt16.max, upperBound: UInt16.max) == UInt16.max)

    /// UInt8
    XCTAssertTrue(UInt8.random(lowerBound: 1, upperBound: 100) <= 100)
    XCTAssertTrue(UInt8.min...UInt8.max ~= UInt8.random())
    XCTAssertFalse(UInt8.random(lowerBound: 50, upperBound: 100) > 100)
    XCTAssertFalse(UInt8.random(lowerBound: 40, upperBound: 50) < 40)
    XCTAssertTrue(UInt8.random(lowerBound: UInt8.max, upperBound: UInt8.max) == UInt8.max)

  }

  func testOverflow() {

    do {
      var expectedAtLeastOnePositive = false
      var expectedAtLeastOneNegative = false
      for _ in 1...100 {
        let value = Int8.random(lowerBound: -118, upperBound: 10)
        if (value.isNegative) { expectedAtLeastOnePositive = true }
        if (value.isPositive ){ expectedAtLeastOneNegative = true }
      }
      XCTAssertTrue(expectedAtLeastOnePositive && expectedAtLeastOneNegative)
    }

    do {
      var expectedAtLeastOnePositive = false
      var expectedAtLeastOneNegative = false
      for _ in 1...100 {
        let value = Int8.random(lowerBound: -100, upperBound: 100)
        if (value.isPositive) { expectedAtLeastOnePositive = true }
        if (value.isNegative) { expectedAtLeastOneNegative = true }
      }
      XCTAssertTrue(expectedAtLeastOnePositive && expectedAtLeastOneNegative)
    }

    do {
      var expectedAtLeastOnePositive = false
      var expectedAtLeastOneNegative = false
      for _ in 1...100 {
        let value = Int8.random(lowerBound: -128, upperBound: 127)
        if (value.isPositive) { expectedAtLeastOnePositive = true }
        if (value.isNegative) { expectedAtLeastOneNegative = true }
      }
      XCTAssertTrue(expectedAtLeastOnePositive && expectedAtLeastOneNegative)
    }

    do {
      var expectedAtLeastOnePositive = false
      var expectedAtLeastOneNegative = false
      for _ in 1...100 {
        let value = Int64.random(lowerBound: .min, upperBound: 0)
        if (value.isPositive) { expectedAtLeastOnePositive = true }
        if (value.isNegative) { expectedAtLeastOneNegative = true }
      }
      XCTAssertTrue(!expectedAtLeastOnePositive && expectedAtLeastOneNegative)
    }

    do {
      var expectedAtLeastOnePositive = false
      var expectedAtLeastOneNegative = false
      for _ in 1...100 {
        let value = Int32.random(lowerBound: 0, upperBound: .max)
        if (value.isPositive) { expectedAtLeastOnePositive = true }
        if (value.isNegative) { expectedAtLeastOneNegative = true }
      }
      XCTAssertTrue(expectedAtLeastOnePositive && !expectedAtLeastOneNegative)
    }

  }

}

