//
//  BinaryFloatingPoint+Utils.swift
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

// MARK: - BinaryConvertible

extension BinaryFloatingPoint where Self: BinaryConvertible {

  /// **Mechanica**
  ///
  /// Creates a string representing the given value in the binary base.
  ///
  /// ```
  /// Float(-5.625).binaryString //"11000000101101000000000000000000
  /// ```
  ///
  public var binaryString: String {
    let floatingPointSign = (sign == FloatingPointSign.minus) ? "1" : "0"
    let exponentBitCount = Self.exponentBitCount
    let mantissaBitCount = Self.significandBitCount
    var exponent = String(self.exponentBitPattern, radix: 2)
    var mantissa = String(self.significandBitPattern, radix: 2)
    if (exponentBitCount > exponent.characters.count) {
      exponent = String(repeating: "0", count: (exponentBitCount - exponent.characters.count)) + exponent
    }
    if (mantissaBitCount > mantissa.characters.count) {
      mantissa = String(repeating: "0", count: (mantissaBitCount - mantissa.characters.count)) + mantissa
    }
    return "\(floatingPointSign)\(exponent)\(mantissa)"
  }

}

extension Float:    BinaryConvertible {}
extension Float64:  BinaryConvertible {}

// Float80 is apparently only available on macOS, but it will compile on the iOS/tvOS/watchOS simulator because that's run in macOS.
#if os(macOS)
extension Float80:  BinaryConvertible {}
#endif
