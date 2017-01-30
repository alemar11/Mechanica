//
//  FloatingPointUtilsTests.swift
//  Mechanica
//
//  Copyright © 2016 Tinrobots.
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

class FloatingPointUtilsTests: XCTestCase {

  var piFloat         = Float(3.141_592_653_589_793_238_46)   //  3.14159274
  var piDouble        = 3.14159_26535_89793_23846             //  3.1415926535897931
  var piFloat80       = Float80(3.14159_26535_89793_23846)    //  3.141592653589793116

  var negativeDouble  = -147.956455                           //  -147.95645500000001
  var randomFloat    = Float32(199.959019)                    //  199.959015
  var bigFloat        = Float80(0.9278766111959092165201989)  //  0.927876611195909251073

  func test_rounding() {

    XCTAssertEqual(piFloat.roundedToDecimalPlaces(0), 3.0)
    XCTAssertEqual(piFloat.roundedToDecimalPlaces(-1), 3.14159274)
    XCTAssertTrue((piFloat.roundedToDecimalPlaces(1000)).isNaN)

    XCTAssertEqual(piFloat.roundedToDecimalPlaces(7), 3.1415927)
    XCTAssertEqual(piDouble.roundedToDecimalPlaces(7), 3.1415927)
    XCTAssertEqual(piFloat80.roundedToDecimalPlaces(7), 3.1415927)

    piFloat.roundToDecimalPlaces(3)
    XCTAssertEqual(piFloat, 3.142)
    piDouble.roundToDecimalPlaces(2)
    XCTAssertEqual(piDouble, 3.14)
    piFloat80.roundToDecimalPlaces(1)
    XCTAssertEqual(piFloat80, 3.1)

    XCTAssertEqual(negativeDouble.roundedToDecimalPlaces(2), -147.96)
    negativeDouble.roundToDecimalPlaces(3)
    XCTAssertEqual(negativeDouble, -147.956)

    XCTAssertEqual(randomFloat.roundedToDecimalPlaces(0), 200)

    randomFloat.roundToDecimalPlaces(5)
    XCTAssertEqual(randomFloat, 199.95902)
    randomFloat.roundToDecimalPlaces(3)
    XCTAssertEqual(randomFloat, 199.959)
    XCTAssertEqual(randomFloat.roundedToDecimalPlaces(10), 199.959)
    XCTAssertEqual(randomFloat.roundedToDecimalPlaces(-5), 199.959)
    randomFloat.roundToDecimalPlaces(-66)
    XCTAssertEqual(randomFloat, 199.959)
    XCTAssertEqual(randomFloat.roundedToDecimalPlaces(0), 200)
    randomFloat.roundToDecimalPlaces(2)
    XCTAssertEqual(randomFloat, 199.96)

    XCTAssertEqual(bigFloat.roundedToDecimalPlaces(99), bigFloat)
    XCTAssertEqual(bigFloat.roundedToDecimalPlaces(-99), bigFloat)
    XCTAssertEqual(bigFloat.roundedToDecimalPlaces(0), 1)
    XCTAssertEqual(bigFloat.roundedToDecimalPlaces(10), 0.9278766112)

    bigFloat.roundToDecimalPlaces(16)
    XCTAssertEqual(bigFloat, 0.9278766111959093)
    bigFloat.roundToDecimalPlaces(-1)
    XCTAssertEqual(bigFloat, 0.9278766111959093)
    bigFloat.roundToDecimalPlaces(16)
    XCTAssertEqual(bigFloat, 0.9278766111959093)
    bigFloat.roundToDecimalPlaces(3)
    XCTAssertEqual(bigFloat, 0.928)

  }

  func test_ceiling() {

    XCTAssertEqual(piFloat.ceiledToDecimalPlaces(0), 4.0)
    XCTAssertEqual(piFloat.ceiledToDecimalPlaces(-1), 3.14159274)
    XCTAssertTrue((piFloat.ceiledToDecimalPlaces(1000)).isNaN)

    XCTAssertEqual(piFloat.ceiledToDecimalPlaces(5), 3.1416)
    XCTAssertEqual(piDouble.ceiledToDecimalPlaces(5), 3.1416)
    XCTAssertEqual(piFloat80.ceiledToDecimalPlaces(5), 3.1416)

    piFloat.ceilToDecimalPlaces(3)
    XCTAssertEqual(piFloat, 3.142)
    piDouble.ceilToDecimalPlaces(2)
    XCTAssertEqual(piDouble, 3.15)
    piFloat80.ceilToDecimalPlaces(1)
    XCTAssertEqual(piFloat80, 3.2)

    XCTAssertEqual(negativeDouble.ceiledToDecimalPlaces(2), -147.95)
    negativeDouble.ceilToDecimalPlaces(3)
    XCTAssertEqual(negativeDouble, -147.956)

    XCTAssertEqual(randomFloat.ceiledToDecimalPlaces(0), 200)
    randomFloat.ceilToDecimalPlaces(4)
    XCTAssertEqual(randomFloat, 199.9591)
    randomFloat.ceilToDecimalPlaces(3)
    XCTAssertEqual(randomFloat, 199.96)
    XCTAssertEqual(randomFloat.ceiledToDecimalPlaces(10), 199.96)
    XCTAssertEqual(randomFloat.ceiledToDecimalPlaces(-5), 199.96)
    randomFloat.ceilToDecimalPlaces(-66)
    XCTAssertEqual(randomFloat, 199.96)
    XCTAssertEqual(randomFloat.ceiledToDecimalPlaces(0), 200)
    randomFloat.ceilToDecimalPlaces(2)
    XCTAssertEqual(randomFloat, 199.96)
    randomFloat.ceilToDecimalPlaces(1)
    XCTAssertEqual(randomFloat, 200)

    XCTAssertEqual(bigFloat.ceiledToDecimalPlaces(99), bigFloat)
    XCTAssertEqual(bigFloat.ceiledToDecimalPlaces(-99), bigFloat)
    XCTAssertEqual(bigFloat.ceiledToDecimalPlaces(0), 1)
    XCTAssertEqual(bigFloat.ceiledToDecimalPlaces(10), 0.9278766112)
    bigFloat.ceilToDecimalPlaces(16)
    XCTAssertEqual(bigFloat, 0.9278766111959093)
    bigFloat.ceilToDecimalPlaces(-1)
    XCTAssertEqual(bigFloat, 0.9278766111959093)
    bigFloat.ceilToDecimalPlaces(16)
    XCTAssertEqual(bigFloat, 0.9278766111959093)
    bigFloat.ceilToDecimalPlaces(3)
    XCTAssertEqual(bigFloat, 0.928)

  }

  func test_flooring() {

    XCTAssertEqual(piFloat.flooredToDecimalPlaces(0), 3.0)
    XCTAssertEqual(piFloat.flooredToDecimalPlaces(-1), 3.14159274)
    XCTAssertTrue((piFloat.flooredToDecimalPlaces(1000)).isNaN)

    XCTAssertEqual(piFloat.flooredToDecimalPlaces(5), 3.14159)
    XCTAssertEqual(piDouble.flooredToDecimalPlaces(5), 3.14159)
    XCTAssertEqual(piFloat80.flooredToDecimalPlaces(5), 3.14159)

    piFloat.floorToDecimalPlaces(3)
    XCTAssertEqual(piFloat, 3.141)
    piDouble.floorToDecimalPlaces(2)
    XCTAssertEqual(piDouble, 3.14)
    piFloat80.floorToDecimalPlaces(1)
    XCTAssertEqual(piFloat80, 3.1)

    XCTAssertEqual(randomFloat.flooredToDecimalPlaces(0), 199)
    randomFloat.floorToDecimalPlaces(4)
    XCTAssertEqual(randomFloat, 199.959)
    randomFloat.floorToDecimalPlaces(3)
    XCTAssertEqual(randomFloat, 199.959)
    XCTAssertEqual(randomFloat.flooredToDecimalPlaces(10), 199.959)
    XCTAssertEqual(randomFloat.flooredToDecimalPlaces(-5), 199.959)
    randomFloat.floorToDecimalPlaces(-66)
    XCTAssertEqual(randomFloat, 199.959)
    XCTAssertEqual(randomFloat.flooredToDecimalPlaces(0), 199)
    randomFloat.floorToDecimalPlaces(2)
    XCTAssertEqual(randomFloat, 199.95)
    randomFloat.floorToDecimalPlaces(1)
    XCTAssertEqual(randomFloat, 199.9)

    XCTAssertEqual(bigFloat.flooredToDecimalPlaces(99), bigFloat)
    XCTAssertEqual(bigFloat.flooredToDecimalPlaces(-99), bigFloat)
    XCTAssertEqual(bigFloat.flooredToDecimalPlaces(0), 0)
    XCTAssertEqual(bigFloat.flooredToDecimalPlaces(10), 0.9278766111)
    bigFloat.floorToDecimalPlaces(16)
    XCTAssertEqual(bigFloat, 0.9278766111959092)
    bigFloat.floorToDecimalPlaces(-1)
    XCTAssertEqual(bigFloat, 0.9278766111959092)
    bigFloat.floorToDecimalPlaces(16)
    XCTAssertEqual(bigFloat, 0.9278766111959092)
    bigFloat.floorToDecimalPlaces(3)
    XCTAssertEqual(bigFloat, 0.927)

  }

}
