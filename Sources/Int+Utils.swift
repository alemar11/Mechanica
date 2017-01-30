//
//  Bool+Utils.swift
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

extension Int {
  
  /// **Mechanica**
  ///
  /// Determine if self is even (equivalent to `self % 2 == 0`).
  public var isEven: Bool {
    return (self % 2 == 0)
  }
  
  /// **Mechanica**
  ///
  /// Determine if self is odd (equivalent to `self % 2 != 0`).
  public var isOdd: Bool {
    return (self % 2 != 0)
  }
  
  /// **Mechanica**
  ///
  /// Determine if self is positive (equivalent to `self > 0`).
  public var isPositive: Bool {
    return (self > 0)
  }
  
  /// **Mechanica**
  ///
  /// Determine if self is negative (equivalent to `self < 0`).
  public var isNegative: Bool {
    return (self < 0)
  }
  
  /// **Mechanica**
  ///
  /// Returns a random Int bounded by a closed interval range.
  public static func random(_ range: ClosedRange<Int>) -> Int {
    return range.lowerBound + Int(arc4random_uniform(UInt32(range.upperBound - range.lowerBound + 1)))
  }
  
  /// **Mechanica**
  ///
  /// Returns a random Int between the given range.
  public static func random(min: Int, max: Int) -> Int {
    //return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    return random(min...max)
  }
  
}
