//
//  Integer+Random.swift
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

extension Integer {

  /// **Mechanica**
  ///
  /// Returns a random value.
  public static func random() -> Self {
    var result: Self = 0
    withUnsafeMutablePointer(to: &result) { resultPtr in
      arc4random_buf(UnsafeMutablePointer(resultPtr), MemoryLayout<Self>.size)
    }
    //arc4random_buf(UnsafeMutablePointer(&result), MemoryLayout<Self>.size)
    return result
  }

}

/// **Mechanica**
///
/// Types adopting the `FixedWidthInteger` protocol can be used as `Integer` with a fixed width.
public protocol FixedWidthInteger : Integer {

  /// **Mechanica**
  ///
  /// max value
  static var max: Self { get }

  /// **Mechanica**
  ///
  /// min value
  static var min: Self { get }
}

extension UInt64: FixedWidthInteger {}
extension Int64:  FixedWidthInteger {}
extension UInt32: FixedWidthInteger {}
extension Int32:  FixedWidthInteger {}
extension UInt16: FixedWidthInteger {}
extension Int16:  FixedWidthInteger {}
extension UInt8:  FixedWidthInteger {}
extension Int8:   FixedWidthInteger {}
extension UInt:   FixedWidthInteger {}
extension Int:    FixedWidthInteger {}

extension FixedWidthInteger where Stride: SignedInteger {

  /// **Mechanica**
  ///
  /// Returns a random FixedWidthInteger bounded by a closed interval range.
  public static func random(in range: CountableClosedRange<Self>) -> Self {
    let rangeSize = range.upperBound - range.lowerBound
    guard (rangeSize != 0) else { return range.upperBound }
    var randomValue = random()
    let (result, overflow) = subtractWithOverflow(range.upperBound, range.lowerBound)
    let maxDivisible = overflow ? max - ~result : result
    while randomValue < maxDivisible { randomValue = random() }
    return (randomValue % rangeSize) + range.lowerBound
  }

  /// **Mechanica**
  ///
  /// Returns a random FixedWidthInteger between `min` and `max` values.
  internal static func random(min: Self, max: Self) -> Self {
    return random(in: min...max)
  }

}
