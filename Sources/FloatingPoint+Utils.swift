//
//  FloatingPoint+Utils.swift
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

extension FloatingPoint {

  /// **Mechanica**
  ///
  /// Returns a `new` rounded `FloatingPoint` to specified number of decimal `places`.
  public final func rounded(to decimalPlaces: Int) -> Self {
    guard decimalPlaces >= 0 else { return self }
    var divisor: Self = 1
    for _ in 0..<decimalPlaces { divisor.multiply(by: 10) }
    return (self * divisor).rounded() / divisor
  }

  /// **Mechanica**
  ///
  /// Rounds `self` to specified number of decimal `places`.
  public mutating func round(to decimalPlaces: Int) {
    self = rounded(to: decimalPlaces)
  }

  /// **Mechanica**
  ///
  /// Returns a `new` ceiled `FloatingPoint` to specified number of decimal `places`.
  public final func ceiled(to decimalPlaces: Int) -> Self {
    guard decimalPlaces >= 0 else { return self }
    var divisor: Self = 1
    for _ in 0..<decimalPlaces { divisor.multiply(by: 10) }
    return Darwin.ceil(self * divisor) / divisor // equals to (self * divisor).rounded(.up) / divisor
  }

  /// **Mechanica**
  ///
  /// Ceils `self` to specified number of decimal `places`.
  public mutating func ceil(to decimalPlaces: Int) {
    self = ceiled(to: decimalPlaces)
  }

  /// **Mechanica**
  ///
  /// Returns a `new` floored `FloatingPoint` to specified number of decimal `places`.
  public final func floored(to decimalPlaces: Int) -> Self {
    guard decimalPlaces >= 0 else { return self }
    var divisor: Self = 1
    for _ in 0..<decimalPlaces { divisor.multiply(by: 10) }
    return Darwin.floor(self * divisor) / divisor // equals to (self * divisor).rounded(.down) / divisor
  }

  /// **Mechanica**
  ///
  /// Floors `self` to specified number of decimal `places`.
  public mutating func floor(to decimalPlaces: Int) {
    self = floored(to: decimalPlaces)
  }

}
