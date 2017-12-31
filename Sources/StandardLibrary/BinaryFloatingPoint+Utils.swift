//
// Mechanica
//
// Copyright © 2016-2018 Tinrobots.
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

extension BinaryFloatingPoint {

  /// **Mechanica**
  ///
  /// Creates a string representing the given value in the binary base.
  ///
  /// Example:
  ///
  ///     Float(-5.625).binaryString -> "11000000101101000000000000000000
  ///
  public var binaryString: String {
    let floatingPointSign = (sign == FloatingPointSign.minus) ? "1" : "0"
    let exponentBitCount = Self.exponentBitCount
    let mantissaBitCount = Self.significandBitCount

    var exponent = String(Int(self.exponentBitPattern), radix: 2)
    var mantissa = String(Int(self.significandBitPattern), radix: 2)

    if exponentBitCount > exponent.count {
      exponent = String(repeating: "0", count: (exponentBitCount - exponent.count)) + exponent
    }
    if mantissaBitCount > mantissa.count {
      mantissa = String(repeating: "0", count: (mantissaBitCount - mantissa.count)) + mantissa
    }

    return "\(floatingPointSign)\(exponent)\(mantissa)"
  }

}
