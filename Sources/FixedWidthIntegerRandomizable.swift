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

import Foundation

// MARK: - FixedWidthIntegerRandomizable

/// **Mechanica**
/// - TODO: Rename this protocol `FixedWidthIntegerRandomizable` with Swift 4.
public protocol FixedWidthIntegerRandomizable {

  /// **Mechanica**
  ///
  /// Returns a random value between `min` and `max` values.
  static func random(min: Self, max: Self) -> Self

}

extension UInt64: FixedWidthIntegerRandomizable {}
extension Int64:  FixedWidthIntegerRandomizable {}
extension UInt32: FixedWidthIntegerRandomizable {}
extension Int32:  FixedWidthIntegerRandomizable {}
extension UInt16: FixedWidthIntegerRandomizable {}
extension Int16:  FixedWidthIntegerRandomizable {}
extension UInt8:  FixedWidthIntegerRandomizable {}
extension Int8:   FixedWidthIntegerRandomizable {}
extension UInt:   FixedWidthIntegerRandomizable {}
extension Int:    FixedWidthIntegerRandomizable {}

extension FixedWidthInteger where Stride: SignedInteger, Self: FixedWidthIntegerRandomizable {

  /// **Mechanica**
  ///
  /// Returns a random Integer bounded by a closed interval range.
  public static func random(in range: CountableClosedRange<Self>) -> Self {
    return random(min: range.lowerBound, max:range.upperBound)
  }

  /// **Mechanica**
  ///
  /// Returns a random Integer bounded by a closed interval range.
  public static func random(in range: CountableRange<Self>) -> Self {
    return random(min: range.lowerBound, max:range.upperBound-1)
  }

}

private let _wordSize = __WORDSIZE

private func arc4random<T: ExpressibleByIntegerLiteral>(type: T.Type) -> T {
  var result: T = 0
  arc4random_buf(&result, Int(MemoryLayout<T>.size))
  return result
}

// MARK: - UnsignedInteger

extension UInt {

  /// **Mechanica**
  ///
  /// - Parameters:
  ///   - min: min value (default UInt)
  ///   - max: max value (default UInt)
  /// - Returns: Returns a random UInt between `min` and `max` values.
  public static func random(min: UInt = min, max: UInt = max) -> UInt {
    switch (_wordSize) {
    case 32: return UInt(UInt32.random(min: UInt32(min), max: UInt32(max)))
    case 64: return UInt(UInt64.random(min: UInt64(min), max: UInt64(max)))
    default: return min
    }
  }

  /// **Mechanica**
  ///
  /// - Returns: Returns a random UInt between `min` and `max` values.
  public static func random() -> UInt {
    return random(min: min, max: max)
  }

}

extension UInt64 {

  /// **Mechanica**
  ///
  /// - Parameters:
  ///   - min: min value (default UInt64)
  ///   - max: max value (default UInt64)
  /// - Returns: Returns a random UInt64 between `min` and `max` values.
  public static func random(min: UInt64 = min, max: UInt64 = max) -> UInt64 {
    guard (min != max) else { return min }
    precondition(min < max, "\(max) should be greater than \(min).")
    var m: UInt64
    let u = max - min
    var r = arc4random(type: UInt64.self)

    if u > UInt64(Int64.max) {
      m = 1 + ~u
    } else {
      //m = ((max - (u * 2)) + 1) % u //crashes if min = 0
      m = ((max - u) + 1) % u
    }

    while r < m {
      r = arc4random(type: UInt64.self)
    }

    return (r % u) + min
  }

  /// **Mechanica**
  ///
  /// - Returns: Returns a random UInt64 between `min` and `max` values.
  public static func random() -> UInt64 {
    return random(min: min, max: max)
  }

}

extension UInt32 {

  /// **Mechanica**
  ///
  /// - Parameters:
  ///   - min: min value (default UInt32)
  ///   - max: max value (default UInt32)
  /// - Returns: Returns a random UInt32 between `min` and `max` values.
  public static func random(min: UInt32 = min, max: UInt32 = max) -> UInt32 {
    guard (min != max) else { return min }
    precondition(min < max, "\(max) should be greater than \(min).")
    return arc4random_uniform(max - min) + min
  }

  /// **Mechanica**
  ///
  /// - Returns: Returns a random UInt32 between `min` and `max` values.
  public static func random() -> UInt32 {
    return random(min: min, max: max)
  }

}

extension UInt16 {

  /// **Mechanica**
  ///
  /// - Parameters:
  ///   - min: min value (default UInt16)
  ///   - max: max value (default UInt16)
  /// - Returns: Returns a random UInt16 between `min` and `max` values.
  public static func random(min: UInt16 = min, max: UInt16 = max) -> UInt16 {
    guard (min != max) else { return min }
    precondition(min < max, "\(max) should be greater than \(min).")
    return UInt16(arc4random_uniform(UInt32(max) - UInt32(min)) + UInt32(min))
  }

  /// **Mechanica**
  ///
  /// - Returns: Returns a random UInt16 between `min` and `max` values.
  public static func random() -> UInt16 {
    return random(min: min, max: max)
  }

}

extension UInt8 {

  /// **Mechanica**
  ///
  /// - Parameters:
  ///   - min: min value (default UInt8)
  ///   - max: max value (default UInt8)
  /// - Returns: Returns a random UInt8 between `min` and `max` values.
  public static func random(min: UInt8 = min, max: UInt8 = max) -> UInt8 {
    guard (min != max) else { return min }
    precondition(min < max, "\(max) should be greater than \(min).")
    return UInt8(arc4random_uniform(UInt32(max) - UInt32(min)) + UInt32(min))
  }

  /// **Mechanica**
  ///
  /// - Returns: Returns a random UInt8 between `min` and `max` values.
  public static func random() -> UInt8 {
    return random(min: min, max: max)
  }

}

// MARK: - SignedInteger

extension Int {

  /// **Mechanica**
  ///
  /// - Parameters:
  ///   - min: min value (default Int.min)
  ///   - max: max value (default Int.max)
  /// - Returns: Returns a random Int between `min` and `max` values.
  public static func random(min: Int = min, max: Int = max) -> Int {
    switch (_wordSize) {
    case 32: return Int(Int32.random(min: Int32(min), max: Int32(max)))
    case 64: return Int(Int64.random(min: Int64(min), max: Int64(max)))
    default: return min
    }
  }

  /// **Mechanica**
  ///
  /// - Returns: Returns a random Int between `min` and `max` values.
  public static func random() -> Int {
    return random(min: min, max: max)
  }

}

extension Int64 {

  /// **Mechanica**
  ///
  /// - Parameters:
  ///   - min: min value (default Int64.min)
  ///   - max: max value (default Int64.max)
  /// - Returns: Returns a random Int64 between `min` and `max` values.
  public static func random(min: Int64 = min, max: Int64 = max) -> Int64 {
    guard (min != max) else { return min }
    precondition(min < max, "\(max) should be greater than \(min).")
    let (partialValue, overflow) = max.subtractingReportingOverflow(min) //Int64.subtractWithOverflow(max, min)
    let u = (overflow == ArithmeticOverflow.overflow) ? UInt64.max - UInt64(~partialValue) : UInt64(partialValue)
    let r = UInt64.random(max: u)

    if r > UInt64(Int64.max) {
      return Int64(r - (UInt64(~min) + 1))
    } else {
      return Int64(r) + min
    }
  }

  /// **Mechanica**
  ///
  /// - Returns: Returns a random Int64 between `min` and `max` values.
  public static func random() -> Int64 {
    return random(min: min, max: max)
  }

}

extension Int32 {

  /// **Mechanica**
  ///
  /// - Parameters:
  ///   - min: min value (default Int32.min)
  ///   - max: max value (default Int32.max)
  /// - Returns: Returns a random Int32 between `min` and `max` values.
  public static func random(min: Int32 = min, max: Int32 = max) -> Int32 {
    guard (min != max) else { return min }
    precondition(min < max, "\(max) should be greater than \(min).")
    let r = arc4random_uniform(UInt32(Int64(max) - Int64(min)))
    return Int32(Int64(r) + Int64(min))
  }

  /// **Mechanica**
  ///
  /// - Returns: Returns a random Int32 between `min` and `max` values.
  public static func random() -> Int32 {
    return random(min: min, max: max)
  }

}

extension Int16 {

  /// **Mechanica**
  ///
  /// - Parameters:
  ///   - min: min value (default Int16.min)
  ///   - max: max value (default Int16.max)
  /// - Returns: Returns a random Int16 between `min` and `max` values.
  public static func random(min: Int16 = min, max: Int16 = max) -> Int16 {
    guard (min != max) else { return min }
    precondition(min < max, "\(max) should be greater than \(min).")
    let r = arc4random_uniform(UInt32(Int32(max) - Int32(min)))
    return Int16(Int32(r) + Int32(min))
  }

  /// **Mechanica**
  ///
  /// - Returns: Returns a random Int16 between `min` and `max` values.
  public static func random() -> Int16 {
    return random(min: min, max: max)
  }

}

extension Int8 {

  /// **Mechanica**
  ///
  /// - Parameters:
  ///   - min: min value (default Int8.min)
  ///   - max: max value (default Int8.max)
  /// - Returns: Returns a random Int8 between `min` and `max` values.
  public static func random(min: Int8 = min, max: Int8 = max) -> Int8 {
    guard (min != max) else { return min }
    precondition(min < max, "\(max) should be greater than \(min).")
    let r = arc4random_uniform(UInt32(Int32(max) - Int32(min)))
    return Int8(Int32(r) + Int32(min))
  }

  /// **Mechanica**
  ///
  /// - Returns: Returns a random Int8 between `min` and `max` values.
  public static func random() -> Int8 {
    return random(min: min, max: max)
  }

}
