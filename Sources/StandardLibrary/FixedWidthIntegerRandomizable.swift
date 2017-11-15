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

// MARK: - FixedWidthIntegerRandomizable

#if os(Linux)
  import Glibc
#else
  import Darwin
#endif

/// **Mechanica**
///
/// FixedWidthInteger random protocol.
public protocol FixedWidthIntegerRandomizable {

  /// **Mechanica**
  ///
  /// Returns a random value between `lowerBound` and `upperBound` -1 values.
  static func random(lowerBound: Self, upperBound: Self) -> Self

}

extension UInt64: FixedWidthIntegerRandomizable {}
extension Int64: FixedWidthIntegerRandomizable {}
extension UInt32: FixedWidthIntegerRandomizable {}
extension Int32: FixedWidthIntegerRandomizable {}
extension UInt16: FixedWidthIntegerRandomizable {}
extension Int16: FixedWidthIntegerRandomizable {}
extension UInt8: FixedWidthIntegerRandomizable {}
extension Int8: FixedWidthIntegerRandomizable {}
extension UInt: FixedWidthIntegerRandomizable {}
extension Int: FixedWidthIntegerRandomizable {}

private let _wordSize = __WORDSIZE

// MARK: - UnsignedInteger

extension UInt {

  /// **Mechanica**
  ///
  /// - Parameters:
  ///   - lowerBound: lowerBound value
  ///   - upperBound: upperBound value
  /// - Returns: Returns a random UInt between `lowerBound` and `upperBound` -1 values. [lowerBound, upperBound)
  /// - Warning: The range is exclusive [lowerBound, upperBound).
  public static func random(lowerBound: UInt, upperBound: UInt) -> UInt {
    switch _wordSize {
    case 32: return UInt(UInt32.random(lowerBound: UInt32(lowerBound), upperBound: UInt32(upperBound)))
    case 64: return UInt(UInt64.random(lowerBound: UInt64(lowerBound), upperBound: UInt64(upperBound)))
    default: return lowerBound
    }
  }

}

extension UInt64 {

  /// **Mechanica**
  ///
  /// - Parameters:
  ///   - lowerBound: lowerBound value
  ///   - upperBound: upperBound value
  /// - Returns: Returns a random UInt64 between `lowerBound` and `upperBound` -1 values.
  /// - Warning: The range is exclusive [lowerBound, upperBound).
  public static func random(lowerBound: UInt64, upperBound: UInt64) -> UInt64 {
    guard lowerBound != upperBound else { return lowerBound }
    precondition(lowerBound < upperBound, "\(upperBound) should be greater than \(lowerBound).")

    guard upperBound > UInt64(UInt32.max ) else {
      return UInt64(UInt32.random(lowerBound: UInt32(lowerBound), upperBound: UInt32(upperBound)))
    }

    var m: UInt64
    let u = upperBound - lowerBound
    var r = UInt64.random()

    if u > UInt64(Int64.max) {
      m = 1 + ~u
    } else {
      m = ((upperBound - (u * 2)) + 1) % u
    }

    while r < m {
      r = UInt64.random()
    }

    return (r % u) + lowerBound
  }

}

extension UInt32 {

  /// **Mechanica**
  ///
  /// - Parameters:
  ///   - lowerBound: lowerBound value
  ///   - upperBound: upperBound value
  /// - Returns: Returns a random UInt32 between `lowerBound` and `upperBound` -1 values.
  /// - Warning: The range is exclusive [lowerBound, upperBound).
  public static func random(lowerBound: UInt32, upperBound: UInt32) -> UInt32 {
    guard lowerBound != upperBound else { return lowerBound }
    precondition(lowerBound < upperBound, "\(upperBound) should be greater than \(lowerBound).")

    return arc4random_uniform(upperBound - lowerBound) + lowerBound
  }

}

extension UInt16 {

  /// **Mechanica**
  ///
  /// - Parameters:
  ///   - lowerBound: lowerBound value
  ///   - upperBound: upperBound value
  /// - Returns: Returns a random UInt16 between `lowerBound` and `upperBound` -1 values.
  /// - Warning: The range is exclusive [lowerBound, upperBound).
  public static func random(lowerBound: UInt16, upperBound: UInt16) -> UInt16 {
    guard lowerBound != upperBound else { return lowerBound }
    precondition(lowerBound < upperBound, "\(upperBound) should be greater than \(lowerBound).")

    return UInt16(arc4random_uniform(UInt32(upperBound) - UInt32(lowerBound)) + UInt32(lowerBound))
  }

}

extension UInt8 {

  /// **Mechanica**
  ///
  /// - Parameters:
  ///   - lowerBound: lowerBound value
  ///   - upperBound: upperBound value
  /// - Returns: Returns a random UInt8 between `lowerBound` and `upperBound` -1 values.
  /// - Warning: The range is exclusive [lowerBound, upperBound).
  public static func random(lowerBound: UInt8, upperBound: UInt8) -> UInt8 {
    guard lowerBound != upperBound else { return lowerBound }
    precondition(lowerBound < upperBound, "\(upperBound) should be greater than \(lowerBound).")

    return UInt8(arc4random_uniform(UInt32(upperBound) - UInt32(lowerBound)) + UInt32(lowerBound))
  }

}

// MARK: - SignedInteger

extension Int {

  /// **Mechanica**
  ///
  /// - Parameters:
  ///   - lowerBound: lowerBound value
  ///   - upperBound: upperBound value
  /// - Returns: Returns a random Int between `lowerBound` and `upperBound` -1 values.
  /// - Warning: The range is exclusive [lowerBound, upperBound).
  public static func random(lowerBound: Int, upperBound: Int) -> Int {
    switch _wordSize {
    case 32: return Int(Int32.random(lowerBound: Int32(lowerBound), upperBound: Int32(upperBound)))
    case 64: return Int(Int64.random(lowerBound: Int64(lowerBound), upperBound: Int64(upperBound)))
    default: return lowerBound
    }
  }

}

extension Int64 {

  /// **Mechanica**
  ///
  /// - Parameters:
  ///   - lowerBound: lowerBound value
  ///   - upperBound: upperBound value
  /// - Returns: Returns a random Int64 between `lowerBound` and `upperBound` -1 values.
  /// - Warning: The range is exclusive [lowerBound, upperBound).
  public static func random(lowerBound: Int64, upperBound: Int64) -> Int64 {
    guard lowerBound != upperBound else { return lowerBound }
    precondition(lowerBound < upperBound, "\(upperBound) should be greater than \(lowerBound).")

    let (partialValue, overflow) = upperBound.subtractingReportingOverflow(lowerBound)
    let u = (overflow) ? UInt64.max - UInt64(~partialValue) : UInt64(partialValue)
    let r = UInt64.random(lowerBound: UInt64.min, upperBound: u)

    if r > UInt64(Int64.max) {
      return Int64(r - (UInt64(~lowerBound) + 1))
    } else {
      return Int64(r) + lowerBound
    }
  }

}

extension Int32 {

  /// **Mechanica**
  ///
  /// - Parameters:
  ///   - lowerBound: lowerBound value
  ///   - upperBound: upperBound value
  /// - Returns: Returns a random Int32 between `lowerBound` and `upperBound` -1 values.
  /// - Warning: The range is exclusive [lowerBound, upperBound).
  public static func random(lowerBound: Int32, upperBound: Int32) -> Int32 {
    guard lowerBound != upperBound else { return lowerBound }
    precondition(lowerBound < upperBound, "\(upperBound) should be greater than \(lowerBound).")

    let r = arc4random_uniform(UInt32(Int64(upperBound) - Int64(lowerBound)))
    return Int32(Int64(r) + Int64(lowerBound))
  }

}

extension Int16 {

  /// **Mechanica**
  ///
  /// - Parameters:
  ///   - lowerBound: lowerBound value
  ///   - upperBound: upperBound value
  /// - Returns: Returns a random Int16 between `lowerBound` and `upperBound` -1 values.
  /// - Warning: The range is exclusive [lowerBound, upperBound).
  public static func random(lowerBound: Int16, upperBound: Int16) -> Int16 {
    guard lowerBound != upperBound else { return lowerBound }
    precondition(lowerBound < upperBound, "\(upperBound) should be greater than \(lowerBound).")

    let r = arc4random_uniform(UInt32(Int32(upperBound) - Int32(lowerBound)))
    return Int16(Int32(r) + Int32(lowerBound))
  }

}

extension Int8 {

  /// **Mechanica**
  ///
  /// - Parameters:
  ///   - lowerBound: lowerBound value
  ///   - upperBound: upperBound value
  /// - Returns: Returns a random Int8 between `lowerBound` and `upperBound` -1 values.
  /// - Warning: The range is exclusive [lowerBound, upperBound).
  public static func random(lowerBound: Int8, upperBound: Int8) -> Int8 {
    guard lowerBound != upperBound else { return lowerBound }
    precondition(lowerBound < upperBound, "\(upperBound) should be greater than \(lowerBound).")

    let r = arc4random_uniform(UInt32(Int32(upperBound) - Int32(lowerBound)))
    return Int8(Int32(r) + Int32(lowerBound))
  }

}
