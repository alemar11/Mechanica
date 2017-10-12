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

import Foundation

// MARK: - FixedWidthIntegerRandomizable

/// **Mechanica**
///
/// FixedWidthInteger random protocol.
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

private let _wordSize = __WORDSIZE

// MARK: - UnsignedInteger

extension UInt {

  /// **Mechanica**
  ///
  /// - Parameters:
  ///   - min: min value
  ///   - max: max value
  /// - Returns: Returns a random UInt between `min` and `max` values. [min, max)
  /// - Warning: The range is exclusive [min, max).
  public static func random(min: UInt, max: UInt) -> UInt {
    switch _wordSize {
    case 32: return UInt(UInt32.random(min: UInt32(min), max: UInt32(max)))
    case 64: return UInt(UInt64.random(min: UInt64(min), max: UInt64(max)))
    default: return min
    }
  }

}

extension UInt64 {

  /// **Mechanica**
  ///
  /// - Parameters:
  ///   - min: min value
  ///   - max: max value
  /// - Returns: Returns a random UInt64 between `min` and `max` values.
  /// - Warning: The range is exclusive [min, max).
  public static func random(min: UInt64, max: UInt64) -> UInt64 {
    guard min != max else { return min }
    precondition(min < max, "\(max) should be greater than \(min).")

    guard max > UInt64(UInt32.max) else {
      return UInt64(UInt32.random(min: UInt32(min), max: UInt32(max)))
    }

    var m: UInt64
    let u = max - min
    var r = UInt64.random()

    if u > UInt64(Int64.max) {
      m = 1 + ~u
    } else {
      m = ((max - (u * 2)) + 1) % u
    }

    while r < m {
      r = UInt64.random()
    }

    return (r % u) + min
  }

}

extension UInt32 {

  /// **Mechanica**
  ///
  /// - Parameters:
  ///   - min: min value
  ///   - max: max value
  /// - Returns: Returns a random UInt32 between `min` and `max` values.
  /// - Warning: The range is exclusive [min, max).
  public static func random(min: UInt32, max: UInt32) -> UInt32 {
    guard min != max else { return min }
    precondition(min < max, "\(max) should be greater than \(min).")

    return arc4random_uniform(max - min) + min
  }

}

extension UInt16 {

  /// **Mechanica**
  ///
  /// - Parameters:
  ///   - min: min value
  ///   - max: max value
  /// - Returns: Returns a random UInt16 between `min` and `max` values.
  /// - Warning: The range is exclusive [min, max).
  public static func random(min: UInt16, max: UInt16) -> UInt16 {
    guard min != max else { return min }
    precondition(min < max, "\(max) should be greater than \(min).")

    return UInt16(arc4random_uniform(UInt32(max) - UInt32(min)) + UInt32(min))
  }

}

extension UInt8 {

  /// **Mechanica**
  ///
  /// - Parameters:
  ///   - min: min value
  ///   - max: max value
  /// - Returns: Returns a random UInt8 between `min` and `max` values.
  /// - Warning: The range is exclusive [min, max).
  public static func random(min: UInt8, max: UInt8) -> UInt8 {
    guard min != max else { return min }
    precondition(min < max, "\(max) should be greater than \(min).")
    
    return UInt8(arc4random_uniform(UInt32(max) - UInt32(min)) + UInt32(min))
  }

}

// MARK: - SignedInteger

extension Int {

  /// **Mechanica**
  ///
  /// - Parameters:
  ///   - min: min value
  ///   - max: max value
  /// - Returns: Returns a random Int between `min` and `max` values.
  /// - Warning: The range is exclusive [min, max).
  public static func random(min: Int, max: Int) -> Int {
    switch _wordSize {
    case 32: return Int(Int32.random(min: Int32(min), max: Int32(max)))
    case 64: return Int(Int64.random(min: Int64(min), max: Int64(max)))
    default: return min
    }
  }

}

extension Int64 {

  /// **Mechanica**
  ///
  /// - Parameters:
  ///   - min: min value
  ///   - max: max value
  /// - Returns: Returns a random Int64 between `min` and `max` values.
  /// - Warning: The range is exclusive [min, max).
  public static func random(min: Int64, max: Int64) -> Int64 {
    guard min != max else { return min }
    precondition(min < max, "\(max) should be greater than \(min).")
    
    let (partialValue, overflow) = max.subtractingReportingOverflow(min)
    let u = (overflow) ? UInt64.max - UInt64(~partialValue) : UInt64(partialValue)
    let r = UInt64.random(min: UInt64.min, max: u)

    if r > UInt64(Int64.max) {
      return Int64(r - (UInt64(~min) + 1))
    } else {
      return Int64(r) + min
    }
  }

}

extension Int32 {

  /// **Mechanica**
  ///
  /// - Parameters:
  ///   - min: min value
  ///   - max: max value
  /// - Returns: Returns a random Int32 between `min` and `max` values.
  /// - Warning: The range is exclusive [min, max).
  public static func random(min: Int32, max: Int32) -> Int32 {
    guard min != max else { return min }
    precondition(min < max, "\(max) should be greater than \(min).")
    
    let r = arc4random_uniform(UInt32(Int64(max) - Int64(min)))
    return Int32(Int64(r) + Int64(min))
  }

}

extension Int16 {

  /// **Mechanica**
  ///
  /// - Parameters:
  ///   - min: min value
  ///   - max: max value
  /// - Returns: Returns a random Int16 between `min` and `max` values.
  /// - Warning: The range is exclusive [min, max).
  public static func random(min: Int16, max: Int16) -> Int16 {
    guard min != max else { return min }
    precondition(min < max, "\(max) should be greater than \(min).")
    
    let r = arc4random_uniform(UInt32(Int32(max) - Int32(min)))
    return Int16(Int32(r) + Int32(min))
  }

}

extension Int8 {

  /// **Mechanica**
  ///
  /// - Parameters:
  ///   - min: min value
  ///   - max: max value
  /// - Returns: Returns a random Int8 between `min` and `max` values.
  /// - Warning: The range is exclusive [min, max).
  public static func random(min: Int8, max: Int8) -> Int8 {
    guard min != max else { return min }
    precondition(min < max, "\(max) should be greater than \(min).")
    
    let r = arc4random_uniform(UInt32(Int32(max) - Int32(min)))
    return Int8(Int32(r) + Int32(min))
  }

}
