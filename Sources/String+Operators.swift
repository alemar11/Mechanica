//
//  String+Operators.swift
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

extension String {
  
  /// **Mechanica**
  ///
  /// Creates a `new` string representing the given string repeated the specified number of times.
  public static func * (lhs: String, rhs: Int) -> String {
    return  String(repeating: lhs, count: rhs)
  }
  
  /// **Mechanica**
  ///
  /// Creates a `new` string representing the given string repeated the specified number of times.
  public static func * (lhs: Int, rhs: String) -> String {
    return  String(repeating: rhs, count: lhs)
  }
  
}

infix operator ???: NilCoalescingPrecedence

/// **Mechanica**
///
/// Optional-string-coalescing operator.
///
/// The ??? operator takes any `optional` on its left side and a `default` string value on the right, returning a string.
/// If the optional value is non-nil, it unwraps it and returns its string description, otherwise it returns the default value.
///
/// [Credits](https://oleb.net/blog/2016/12/optionals-string-interpolation/)
public func ??? <T>(optional: T?, defaultValue: @autoclosure () -> String) -> String {
  return optional.map { String(describing: $0) } ?? defaultValue()
}


