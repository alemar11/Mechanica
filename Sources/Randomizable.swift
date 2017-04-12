//
//  Randomizable.swift
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

/// **Mechanica**
///
/// Types conforming to Randomizable protocol can generate a random value.
public protocol Randomizable {

  /// **Mechanica**
  ///
  /// Returns a random value.
  static func random() -> Self
}

/// **Mechanica**
///
/// Types conforming to RangeRandomizable protocol can generate a random value in a closed interval range.
public protocol RangeRandomizable: Randomizable {

  /// **Mechanica**
  ///
  /// Returns a random value bounded by a closed interval range.
  static func random(min: Self, max: Self) -> Self

}

//extension RangeRandomizable where Self: Strideable, Self.Stride: SignedInteger {
//
//  /// **Mechanica**
//  ///
//  /// Returns a random value given a `CountableClosedRange`.
//  public static func random(in range: CountableClosedRange<Self>) -> Self {
//    return random(min: range.lowerBound, max: range.upperBound)
//  }
//
//  /// **Mechanica**
//  ///
//  /// Returns a random value given a `CountableRange`.
//  public static func random(in range: CountableRange<Self>) -> Self {
//    return random(min: range.lowerBound, max:range.upperBound-1)
//  }
//
//}
