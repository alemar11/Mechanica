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

// MARK: - BinaryConvertible

extension SignedInteger where Self: BinaryConvertible {

  /// **Mechanica**
  ///
  /// Creates a string representing the given value in the binary base.
  ///
  /// Example:
  ///
  ///     255.binaryString //"11111111"
  ///     Int16(-1).binaryString //"1111111111111111"
  ///     1.binaryString  //"0000000000000000000000000000000000000000000000000000000000000001" (Int 64 bit)
  ///     1.binaryString  //"00000000000000000000000000000001" (Int 32 bit)
  ///
  /// - Note: Negative integers are converted with the **two's complement operation**. For signed binary use `String(:,radix:)`
  ///
  /// Example:
  ///
  ///     String(Int8(-127), radix: 2) // -1111111
  ///     Int8(-127).binaryString // 10000001
  ///
  public var binaryString: String {
    let size = MemoryLayout.size(ofValue: self) * 8
    let signed = Int(self)
    let unsigned = UInt(bitPattern: signed)
    var binaryString = String(unsigned, radix:2)
    switch binaryString.count {
    case let count where count > size:
      let startIndex = binaryString.index(binaryString.startIndex, offsetBy: count-size)
      let endIndex   = binaryString.index(startIndex, offsetBy: count, limitedBy: binaryString.endIndex) ?? binaryString.endIndex
      binaryString = String(binaryString[startIndex..<endIndex])
    default:
      binaryString = String(repeating: "0", count: (size - binaryString.count)) + binaryString
    }
    return binaryString

  }

}

extension Int8:  BinaryConvertible {}
extension Int16: BinaryConvertible {}
extension Int32: BinaryConvertible {}
extension Int64: BinaryConvertible {}
extension Int:   BinaryConvertible {}

