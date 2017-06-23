//
//  FixedWidthIntegerRandomizable.swift
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

class FixedWidthIntegerIntervalRandomizableTests: XCTestCase {

  func testRandomInt() {

    /// Int

    XCTAssertTrue(Int.random(in: 1...1) == 1)
    XCTAssertTrue(Int.random(in: 1..<2) == 1)
    XCTAssertTrue(Int.random(min: 1, max: 1) == 1)
    XCTAssertTrue(Int.random(min: Int.max, max: Int.max) == Int.max)

    do {
      let randomInt = Int.random(in: 0...1)
      XCTAssertTrue((randomInt == 0) || (randomInt == 1))
    }

    do {
      let randomInt = Int.random(min: 0, max: 1)
      XCTAssertTrue((randomInt == 0) || (randomInt == 1))
    }

    XCTAssertTrue(Int.random(in: 1...100) <= 100)
    XCTAssertTrue(Int.random(min: 1, max: 100) <= 100)
    XCTAssertTrue(Int.min...Int.max ~= Int.random())
     XCTAssertTrue(Int32.min...Int32.max ~= Int32.random())
    XCTAssertFalse(Int.random(min: 50, max: 100) > 100)
    XCTAssertFalse(Int.random(min: 40, max: 50) < 40)

    /// Int64

    XCTAssertTrue(Int64.min...Int64.max ~= Int64.random())
    XCTAssertTrue(Int64.random(min: Int64.max, max: Int64.max) == Int64.max)

    /// Int32

    XCTAssertTrue(Int32.random(in: Int32.max-1..<Int32.max) == Int32.max-1)
    XCTAssertTrue(Int32.random(min: Int32.max, max: Int32.max) == Int32.max)

    /// Int16

    XCTAssertTrue(Int16.random(in: 1...1) == 1)
    XCTAssertTrue(Int16.random(min: 1, max: 1) == 1)
    XCTAssertTrue(Int16.random(min: Int16.max, max: Int16.max) == Int16.max)

    do {
      let randomInt = Int16.random(in: 0...1)
      XCTAssertTrue((randomInt == 0) || (randomInt == 1))
    }

    do {
      let randomInt = Int16.random(min: 0, max: 1)
      XCTAssertTrue((randomInt == 0) || (randomInt == 1))
    }

    XCTAssertTrue(Int16.random(in: 1...100) <= 100)
    XCTAssertTrue(Int16.random(min: 1, max: 100) <= 100)
    XCTAssertTrue(Int16.min...Int16.max ~= Int16.random())
    XCTAssertFalse(Int16.random(min: 50, max: 100) > 100)
    XCTAssertFalse(Int16.random(min: 40, max: 50) < 40)


    /// Int8

    XCTAssertTrue(Int8.random(in: 1...1) == 1)
    XCTAssertTrue(Int8.random(in: 11..<12) == 11)
    XCTAssertTrue(Int8.random(min: 1, max: 1) == 1)
    XCTAssertTrue(Int8.random(min: Int8.min, max: Int8.min) == Int8.min)

    do {
      let randomInt = Int8.random(in: 0...1)
      XCTAssertTrue((randomInt == 0) || (randomInt == 1))
    }

    do {
      let randomInt = Int8.random(min: 0, max: 1)
      XCTAssertTrue((randomInt == 0) || (randomInt == 1))
    }

    XCTAssertTrue(Int8.random(in: 1...100) <= 100)
    XCTAssertTrue(Int8.min...Int8.max ~= Int8.random(in: 1...100))
    XCTAssertTrue(Int8.random(min: 1, max: 100) <= 100)
    XCTAssertTrue(Int8.min...Int8.max ~= Int8.random())
    XCTAssertFalse(Int8.random(min: 50, max: 100) > 100)
    XCTAssertFalse(Int8.random(min: 40, max: 50) < 40)

  }

  func testRandomUInt() {

    /// UInt

    XCTAssertTrue(UInt.random(in: 1...255) <= 255)
    XCTAssertTrue(UInt.min...UInt.max ~= UInt.random(in: 1...UInt.max))
    XCTAssertTrue(UInt.min...UInt.max ~= UInt.random())
    XCTAssertTrue(UInt.random(min: 1, max: 100) <= 100)
    XCTAssertTrue(UInt.min...UInt.max ~= UInt.random())
    XCTAssertFalse(UInt.random(min: 50, max: 100) > 100)
    XCTAssertFalse(UInt.random(min: 40, max: 50) < 40)
    XCTAssertTrue(UInt.random(min: UInt.max, max: UInt.max) == UInt.max)

    /// UInt64

    XCTAssertTrue(UInt64.random(min: UInt64.max, max: UInt64.max) == UInt64.max)


    /// UInt32

    XCTAssertTrue(UInt32.random(in: 1...255) <= 255)
    XCTAssertTrue(UInt32.min...UInt32.max ~= UInt32.random(in: 1...UInt32.max))
    XCTAssertTrue(UInt32.min...UInt32.max ~= UInt32.random())
    XCTAssertTrue(UInt32.random(min: 1, max: 100) <= 100)
    XCTAssertTrue(UInt32.min...UInt32.max ~= UInt32.random())
    XCTAssertFalse(UInt32.random(min: 50, max: 100) > 100)
    XCTAssertFalse(UInt32.random(min: 4000, max: 5000) < 4000)
    XCTAssertTrue(UInt32.random(min: UInt32.max, max: UInt32.max) == UInt32.max)

    /// UInt16

    XCTAssertTrue(UInt16.random(in: 1...255) <= 255)
    XCTAssertTrue(UInt16.min...UInt16.max ~= UInt16.random(in: 1...UInt16.max))
    XCTAssertTrue(UInt16.min...UInt16.max ~= UInt16.random())
    XCTAssertTrue(UInt16.random(min: 1, max: 100) <= 100)
    XCTAssertTrue(UInt16.min...UInt16.max ~= UInt16.random())
    XCTAssertFalse(UInt16.random(min: 50, max: 100) > 100)
    XCTAssertFalse(UInt16.random(min: 4000, max: 5000) < 4000)
    XCTAssertTrue(UInt16.random(min: UInt16.max, max: UInt16.max) == UInt16.max)

    /// UInt8

    XCTAssertTrue(UInt8.random(in: 1...255) <= 255)
    XCTAssertTrue(UInt8.min...UInt8.max ~= UInt8.random(in: 1...100))
    XCTAssertTrue(UInt8.random(min: 1, max: 100) <= 100)
    XCTAssertTrue(UInt8.min...UInt8.max ~= UInt8.random())
    XCTAssertFalse(UInt8.random(min: 50, max: 100) > 100)
    XCTAssertFalse(UInt8.random(min: 40, max: 50) < 40)
    XCTAssertTrue(UInt8.random(min: UInt8.max, max: UInt8.max) == UInt8.max)

  }

  func testOverflow() {
    
    do {
      let range: CountableClosedRange<Int8> = -118...10
      var expectedAtLeastOnePositive = false
      var expectedAtLeastOneNegative = false
      for _ in 1...100 {
        let value = Int8.random(in: range)
        XCTAssertTrue(range ~= value, "\(value) should be contained in \(range)")
        if (value.isNegative) { expectedAtLeastOnePositive = true }
        if (value.isPositive ){ expectedAtLeastOneNegative = true }
      }
      XCTAssertTrue(expectedAtLeastOnePositive && expectedAtLeastOneNegative)
    }

    do {
      let range: CountableClosedRange<Int8> = -100...100
      var expectedAtLeastOnePositive = false
      var expectedAtLeastOneNegative = false
      for _ in 1...100 {
        let value = Int8.random(in: range)
        XCTAssertTrue(range ~= value, "\(value) should be contained in \(range)")
        if (value.isPositive) { expectedAtLeastOnePositive = true }
        if (value.isNegative) { expectedAtLeastOneNegative = true }
      }
      XCTAssertTrue(expectedAtLeastOnePositive && expectedAtLeastOneNegative)
    }

    do {
      let range: CountableClosedRange<Int8> = -128...127
      var expectedAtLeastOnePositive = false
      var expectedAtLeastOneNegative = false
      for _ in 1...100 {
        let value = Int8.random(in: range)
        XCTAssertTrue(range ~= value, "\(value) should be contained in \(range)")
        if (value.isPositive) { expectedAtLeastOnePositive = true }
        if (value.isNegative) { expectedAtLeastOneNegative = true }
      }
      XCTAssertTrue(expectedAtLeastOnePositive && expectedAtLeastOneNegative)
    }

    do {
      let range = UInt64.min..<UInt64.max
      var expectedAtLeastOnePositive = false
      var expectedAtLeastOneNegative = false
      for _ in 1...100 {
        let value = UInt64.random(in: range)
        XCTAssertTrue(range ~= value, "\(value) should be contained in \(range)")
        if (value.isPositive) { expectedAtLeastOnePositive = true }
        if (value.isNegative) { expectedAtLeastOneNegative = true }
      }
      XCTAssertTrue(expectedAtLeastOnePositive && !expectedAtLeastOneNegative)
    }

    do {
      let range = UInt64.min..<UInt64.max
      var expectedAtLeastOnePositive = false
      var expectedAtLeastOneNegative = false
      for _ in 1...100 {
        let value = UInt64.random(in: range)
        XCTAssertTrue(range ~= value, "\(value) should be contained in \(range)")
        if (value.isPositive) { expectedAtLeastOnePositive = true }
        if (value.isNegative) { expectedAtLeastOneNegative = true }
      }
      XCTAssertTrue(expectedAtLeastOnePositive && !expectedAtLeastOneNegative)
    }
    
    do {
      let range: CountableClosedRange<Int64> = Int64.min...0
      var expectedAtLeastOnePositive = false
      var expectedAtLeastOneNegative = false
      for _ in 1...100 {
        let value = Int64.random(in: range)
        XCTAssertTrue(range ~= value, "\(value) should be contained in \(range)")
        if (value.isPositive) { expectedAtLeastOnePositive = true }
        if (value.isNegative) { expectedAtLeastOneNegative = true }
      }
      XCTAssertTrue(!expectedAtLeastOnePositive && expectedAtLeastOneNegative)
    }

    do {
      let range: CountableClosedRange<Int32> = 0...Int32.max
      var expectedAtLeastOnePositive = false
      var expectedAtLeastOneNegative = false
      for _ in 1...100 {
        let value = Int32.random(in: range)
        XCTAssertTrue(range ~= value, "\(value) should be contained in \(range)")
        if (value.isPositive) { expectedAtLeastOnePositive = true }
        if (value.isNegative) { expectedAtLeastOneNegative = true }
      }
      XCTAssertTrue(expectedAtLeastOnePositive && !expectedAtLeastOneNegative)
    }
    
  }

  //  func testRandomPerformance() {
  //    measure {
  //      for _ in 1...10000 {
  //      Int._random(in: -100000...10000)
  //      //Int.random(in: -100000...10000)
  //      }
  //    }
  //  }

}


fileprivate extension Int {

  /// **Mechanica**
  ///
  /// Returns a random Int bounded by a closed interval range.
  fileprivate static func _random(in range: ClosedRange<Int>) -> Int {
    return range.lowerBound + Int(arc4random_uniform(UInt32(range.upperBound - range.lowerBound + 1)))
  }
  
}
