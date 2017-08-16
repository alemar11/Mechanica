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

extension Bool {

  /// **Mechanica**
  ///
  /// Instantiates a `new` Bool given an `input` value.
  public init(input: String) {
    switch input.lowercased() {
    case "1", "true", "t", "yes", "y", "👍🏻", "👍", "👍🏼", "👍🏽", "👍🏾", "👍🏿":
      self = true
    default:
      self = false
    }
  }
  
  /// **Mechanica**
  ///
  /// Returns 1 if true, or 0 if false.
  public var int: Int {
    return self ? 1 : 0
  }

  /// **Mechanica**
  ///
  /// Returns `true` if true, or `false` if false.
  public var string: String {
    return description
  }

  /// **Mechanica**
  ///
  /// Returns a `new` Bool with the inverted value of `self`.
  public var toggled: Bool {
    return !self
  }

  /// **Mechanica**
  ///
  /// Inverts the value of `self`.
  public mutating func toggle() {
    self = !self
  }

  /// **Mechanica**
  ///
  /// Returns `true` or `false` randomly.
  static public func random() -> Bool {
    return arc4random_uniform(2) == 0
  }

}

// MARK: - BinaryConvertible

extension Bool: BinaryConvertible {

  /// **Mechanica**
  ///
  /// Creates a string representing the given value in the binary base.
  ///
  /// ```
  /// true.binaryString //"1"
  /// ```
  ///
  public var binaryString: String {
    return self ? "1" : "0"
  }

}
