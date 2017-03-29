//
//  UnsignedInteger+Utils.swift
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

// MARK:- BinaryConvertible

extension UnsignedInteger where Self: BinaryConvertible {
  
  /// **Mechanica**
  ///
  /// Creates a string representing the given value in the binary base.
  ///
  /// ```
  /// Int8(10).binaryString //"00001010"
  /// ```
  ///
  public var binaryString: String {
    let binaryString = String(self, radix:2)
    let size = MemoryLayout.size(ofValue: self) * 8
    return String(repeating: "0", count: (size - binaryString.characters.count)) + binaryString
  }
  
}

extension UInt8:  BinaryConvertible {}
extension UInt16: BinaryConvertible {}
extension UInt32: BinaryConvertible {}
extension UInt64: BinaryConvertible {}
extension UInt:   BinaryConvertible {}
