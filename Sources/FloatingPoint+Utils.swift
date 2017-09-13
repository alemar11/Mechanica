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

extension FloatingPoint {

  /// **Mechanica**
  ///
  /// Returns a `new` rounded `FloatingPoint` to specified number of decimal `places`.
  ///
  /// Example:
  ///
  ///     var piFloat = Float(3.141_592_653_589_793_238_46)
  ///
  ///     piFloat.rounded(to: 0) // 3.0
  ///     piFloat.rounded(to: 7) // 3.1415927
  ///
  public func rounded(to decimalPlaces: Int) -> Self {
    guard decimalPlaces >= 0 else { return self }
    var divisor: Self = 1
    for _ in 0..<decimalPlaces { divisor *= 10 }
    return (self * divisor).rounded() / divisor
  }

  /// **Mechanica**
  ///
  /// Rounds `self` to specified number of decimal `places`.
  ///
  /// Example:
  ///
  ///     var piFloat = Float(3.141_592_653_589_793_238_46)
  ///
  ///     piFloat.round(to: 3) // piFloat is 3.142
  ///     piFloat.round(to: 7) // piFloat is 3.1415927
  ///
  public mutating func round(to decimalPlaces: Int) {
    self = rounded(to: decimalPlaces)
  }

  /// **Mechanica**
  ///
  /// Returns a `new` ceiled `FloatingPoint` to specified number of decimal `places`.
  ///
  /// Example:
  ///
  ///     var piFloat = Float(3.141_592_653_589_793_238_46)
  ///
  ///     piFloat.ceiled(to: 0) // 4.0
  ///     piFloat.ceiled(to: 5) // 3.1416
  ///
  public func ceiled(to decimalPlaces: Int) -> Self {
    guard decimalPlaces >= 0 else { return self }
    var divisor: Self = 1
    for _ in 0..<decimalPlaces { divisor *= 10  }
    return Darwin.ceil(self * divisor) / divisor // equals to (self * divisor).rounded(.up) / divisor
  }

  /// **Mechanica**
  ///
  /// Ceils `self` to specified number of decimal `places`.
  ///
  /// Example:
  ///
  ///     var piFloat = Float(3.141_592_653_589_793_238_46)
  ///
  ///     piFloat.ceil(to: 0) // piFloat is 4.0
  ///     piFloat.ceil(to: 5) // piFloat is 3.1416
  ///
  public mutating func ceil(to decimalPlaces: Int) {
    self = ceiled(to: decimalPlaces)
  }

  /// **Mechanica**
  ///
  /// Returns a `new` floored `FloatingPoint` to specified number of decimal `places`.
  ///
  /// Example:
  ///
  ///     var piFloat = Float(3.141_592_653_589_793_238_46)
  ///
  ///     piFloat.floored(to: 0) // 3.0
  ///     piFloat.floored(to: 5) // 3.14159
  ///
  public func floored(to decimalPlaces: Int) -> Self {
    guard decimalPlaces >= 0 else { return self }
    var divisor: Self = 1
    for _ in 0..<decimalPlaces { divisor *= 10 }
    return Darwin.floor(self * divisor) / divisor // equals to (self * divisor).rounded(.down) / divisor
  }

  /// **Mechanica**
  ///
  /// Floors `self` to specified number of decimal `places`.
  ///
  /// Example:
  ///
  ///     var piFloat = Float(3.141_592_653_589_793_238_46)
  ///
  ///     piFloat.floor(to: 0) // piFloat is 3.0
  ///     piFloat.floor(to: 5) // piFloat is 3.14159
  ///
  public mutating func floor(to decimalPlaces: Int) {
    self = floored(to: decimalPlaces)
  }

}
