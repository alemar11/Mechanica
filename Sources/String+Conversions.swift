//
//  String+Conversions.swift
//  Mechanica
//
//  Copyright © 2016 Tinrobots.
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

extension String {
  
  /// **Mechanica**
  ///
  /// Return a Bool value by parsing `self`.
  public var bool: Bool? {
    let string = self.trimmed().lowercased()
    switch (string) {
      case "true", "yes", "1":
        return true
      case "false", "no", "0":
      return false
    default:
      return nil
    }
  }
  
  /// **Mechanica**
  ///
  /// Returns a Double value by parsing `self`.
  public var double: Double? {
    return Double(self)
  }
  
  /// **Mechanica**
  ///
  /// Returns a Float value by parsing `self`.
  public var float: Float? {
    return Float(self)
  }
  
  /// **Mechanica**
  ///
  /// Returns a Float32 value by parsing `self`.
  public var float32: Float32? {
    return Float32(self)
  }
  
  /// **Mechanica**
  ///
  /// Returns a Float64 value by parsing `self`.
  public var float64: Float64? {
    return Float64(self)
  }
  
  /// **Mechanica**
  ///
  /// Returns a Int value by parsing `self`.
  public var int: Int? {
    return Int(self)
  }
  
  /// **Mechanica**
  ///
  /// Returns a Int8 value by parsing `self`.
  public var int8: Int8? {
    return Int8(self)
  }
  
  /// **Mechanica**
  ///
  /// Returns a Int16 value by parsing `self`.
  public var int16: Int16? {
    return Int16(self)
  }
  
  /// **Mechanica**
  ///
  /// Returns a Int32 value by parsing `self`.
  public var int32: Int32? {
    return Int32(self)
  }
  
  /// **Mechanica**
  ///
  /// Returns a Int64 value by parsing `self`.
  public var int64: Int64? {
    return Int64(self)
  }
  
  /// **Mechanica**
  ///
  /// Returns an URL initialized with `self`.
  public var url: URL? {
    return URL(string: self)
  }
  
  /// **Mechanica**
  ///
  /// Returns a `new` string decoded from base64.
  public var base64Decoded: String? {
    guard let decodedData = Data(base64Encoded: self) else {
      return nil
    }
    return String(data: decodedData, encoding: .utf8)
  }
  
  /// **Mechanica**
  ///
  /// Returns a `new` string encoded in base64.
  public var base64Encoded: String? {
    let plainData = self.data(using: .utf8)
    return plainData?.base64EncodedString()
  }
}
