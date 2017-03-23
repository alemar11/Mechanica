//
//  IntegerRandomTests.swift
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

class IntegerRandomTests: XCTestCase {

  func test_randomInt() {

    /// Int

    XCTAssertTrue(Int.random(in: 1...1) == 1)
    XCTAssertTrue(Int.random(min: 1, max: 1) == 1)

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
    XCTAssertTrue(Int64.min...Int64.max ~= Int64.random())
    XCTAssertFalse(Int.random(min: 50, max: 100) > 100)
    XCTAssertFalse(Int.random(min: 40, max: 50) < 40)

    /// Int8

    XCTAssertTrue(Int8.random(in: 1...1) == 1)
    XCTAssertTrue(Int8.random(min: 1, max: 1) == 1)

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

  func test_randomUInt() {

    /// UInt

    XCTAssertTrue(UInt.random(in: 1...255) <= 255)
    let randomUInt = UInt.random(in: 0...UInt.max)
    XCTAssertTrue( (UInt.min <= randomUInt) && (randomUInt <= UInt.max))
    //let val = UInt.random(in: 1...UInt.max)
    XCTAssertTrue(UInt.min...UInt.max ~= UInt.random(in: 1...UInt.max))
    XCTAssertTrue(UInt.min...UInt.max ~= UInt.random())
    XCTAssertTrue(UInt.random(min: 1, max: 100) <= 100)
    //XCTAssertTrue(UInt.min...UInt.max ~= UInt.random())
    XCTAssertFalse(UInt.random(min: 50, max: 100) > 100)
    XCTAssertFalse(UInt.random(min: 40, max: 50) < 40)

    /// UInt8

    XCTAssertTrue(UInt8.random(in: 1...255) <= 255)
    XCTAssertTrue(UInt8.min...UInt8.max ~= UInt8.random(in: 1...100))
    XCTAssertTrue(UInt8.random(min: 1, max: 100) <= 100)
    XCTAssertTrue(UInt8.min...UInt8.max ~= UInt8.random())
    XCTAssertFalse(UInt8.random(min: 50, max: 100) > 100)
    XCTAssertFalse(UInt8.random(min: 40, max: 50) < 40)

  }

  func test_overflow() {
//    do {
//      let range: CountableClosedRange<Int8> = -118...10
//      var expectedAtLeastOnePositive = false
//      var expectedAtLeastOneNegative = false
//      for _ in 1...1000 {
//        let value = Int8.random(in: range)
//        print(value)
//        XCTAssertTrue(range ~= value)
//        if (value.isNegative) { expectedAtLeastOnePositive = true }
//        if (value.isPositive ){ expectedAtLeastOneNegative = true }
//      }
//      XCTAssertTrue(expectedAtLeastOnePositive && expectedAtLeastOneNegative)
//    }
//
//    do {
//      let range: CountableClosedRange<Int8> = -100...100
//      var expectedAtLeastOnePositive = false
//      var expectedAtLeastOneNegative = false
//      for _ in 1...1_000_000 {
//        let value = Int8.random(in: range)
//        print(value)
//        XCTAssertTrue(range ~= value)
//        if (value.isPositive) { expectedAtLeastOnePositive = true }
//        if (value.isNegative) { expectedAtLeastOneNegative = true }
//      }
//      XCTAssertTrue(expectedAtLeastOnePositive && expectedAtLeastOneNegative)
//    }

    do {
      // to many 127 as result...
      let range: CountableClosedRange<Int8> = -128...127
      var expectedAtLeastOnePositive = false
      var expectedAtLeastOneNegative = false
      for _ in 1...1_000_000 {
        let value = Int8.random(in: range)
        print(value)
        XCTAssertTrue(range ~= value)
        if (value.isPositive) { expectedAtLeastOnePositive = true }
        if (value.isNegative) { expectedAtLeastOneNegative = true }
      }
      XCTAssertTrue(expectedAtLeastOnePositive && expectedAtLeastOneNegative)
    }
  }

  //  func test_randomPerformance() {
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
