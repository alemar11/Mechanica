//
//  SignedInteger+Utils.swift
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
  /// Determine if self is even (equivalent to `self % 2 == 0`).
  public final var isEven: Bool {
    return (self % 2 == 0)
  }

  /// **Mechanica**
  ///
  /// Determine if self is odd (equivalent to `self % 2 != 0`).
  public final var isOdd: Bool {
    return (self % 2 != 0)
  }

  /// **Mechanica**
  ///
  /// Determine if self is positive (equivalent to `self > 0`).
  public final var isPositive: Bool {
    return (self > 0)
  }

  /// **Mechanica**
  ///
  /// Determine if self is negative (equivalent to `self < 0`).
  public final var isNegative: Bool {
    return (self < 0)
  }

}

extension SignedInteger {

  /// **Mechanica**
  ///
  /// Creates a string representing the given value in the binary base.
  ///
  /// `255.binaryString` //"11111111"
  ///
  public final func binaryString() -> String {
    return String(self, radix: 2)
  }

  /// **Mechanica**
  ///
  /// Creates a string representing the given value in the hexadecimal base.
  ///
  /// `255.hexadecimalString` //"ff"
  ///
  public final func hexadecimalString(uppercase: Bool = true) -> String {
    return String(self, radix: 16, uppercase: false)
  }
  
}
