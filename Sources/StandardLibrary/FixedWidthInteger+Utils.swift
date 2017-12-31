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

extension FixedWidthInteger {

  /// **Mechanica**
  ///
  /// Creates a string representing the given value in the binary base.
  ///
  /// Example:
  ///
  ///     Int8(10).binaryString -> "00001010"
  ///     255.binaryString -> "11111111"
  ///     Int16(-1).binaryString -> "1111111111111111"
  ///     1.binaryString -> "0000000000000000000000000000000000000000000000000000000000000001" (Int 64 bit)
  ///     1.binaryString -> "00000000000000000000000000000001" (Int 32 bit)
  ///
  /// - Note: Negative integers are converted with the **two's complement operation**. For signed binary use `String(:radix:)`
  ///
  /// Example:
  ///
  ///     String(Int8(-127), radix: 2) -> -1111111
  ///     Int8(-127).binaryString -> 10000001
  ///
  var binaryString: String {
    var result: [String] = []

    for i in 0..<(Self.bitWidth / 8) {
      let byte = UInt8(truncatingIfNeeded: self >> (i * 8))
      let byteString = String(byte, radix: 2)
      let padding = String(repeating: "0", count: 8 - byteString.count)
      result.append(padding + byteString)
    }

    //return "0b" + result.reversed().joined(separator: "_")
     return result.reversed().joined(separator: "")
  }

}
