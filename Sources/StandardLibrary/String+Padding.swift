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

// MARK: - Padding Operations

public extension String {

  /// **Mechanica**
  ///
  ///  Returns a `new` String  with the center-padded version of `self` if it's shorter than `length` using a `token`. Padding characters are truncated if they can't be evenly divided by length.
  ///
  /// Example 1:
  ///
  ///     let string = "Hello World"
  ///     string.padding(length: 13) -> " Hello World "
  ///
  /// Example 2:
  ///
  ///     let string = "Hello World"
  ///     string.padding(length: 13, withToken: "*") -> "*Hello World*"
  ///
  /// - Parameters:
  ///   - length: The final length of your string. If the provided length is less than or equal to the original string, the original string is returned.
  ///   - token: The string used to pad the String (Defaults to a white space).
  /// - Returns: The padded copy of the string.
  /// - Note: If the the sum-total of characters added is odd, the left side of the string will have one less instance of the token.
  public func padding(length: Int, with token: String = " ") -> String {
    guard count < length else { return self }

    let delta = Int(ceil(Double(length-count)/2))
    return paddingStart(length: length-delta, with: token).paddingEnd(length: length, with: token)
  }

  /// **Mechanica**
  ///
  /// Pads `self on the left and right sides if it's shorter than `length` using a `token`. Padding characters are truncated if they can't be evenly divided by length.
  ///
  /// - Parameters:
  ///   - length: The final length of your string. If the provided length is less than or equal to the original string, the original string is returned. If the the sum-total of characters added is odd, the left side of the string will have one less instance of the token.
  ///   - token: The string used to pad the String (Defaults to a white space).
  /// - Note: If the the sum-total of characters added is odd, the left side of the string will have one less instance of the token.
  public mutating func pad(length: Int, with token: String = " ") {
    self = padding(length: length, with: token)
  }

  /// **Mechanica**
  ///
  ///  Returns a `new` String  with the left-padded version of `self` if it's shorter than `length` using a `token`. Padding characters are truncated if they can't be evenly divided by length.
  ///
  /// Example 1:
  ///
  ///     let string = "Hello World"
  ///     string.paddingStart(length: 13) -> "  Hello World"
  ///
  /// Example 2:
  ///
  ///     let string = "Hello World"
  ///     string.paddingStart(length: 13, withToken: "*") -> "**Hello World"
  ///
  /// - Parameters:
  ///   - length: The final length of your string. If the provided length is less than or equal to the original string, the original string is returned. If the the sum-total of characters added is odd, the left side of the string will have one less instance of the token.
  ///   - token: The string used to pad the String (Defaults to a white space).
  /// - Returns: The left-padded copy of the string.
  public func paddingStart(length: Int, with token: String = " ") -> String {
    guard count < length else { return self }

    let padLength = length - count
    if padLength < token.count {
      return token[token.startIndex..<token.index(token.startIndex, offsetBy: padLength)] + self
    } else {
      var padding = token
      while padding.count < padLength {
        padding.append(token)
      }
      return padding[padding.startIndex..<padding.index(padding.startIndex, offsetBy: padLength)] + self
    }
  }

  /// **Mechanica**
  ///
  /// Pads `self` on the left side if it's shorter than `length` using a `token`. Padding characters are truncated if they exceed length.
  ///
  /// - Parameters:
  ///   - length: The final length of your string. If the provided length is less than or equal to the original string, the original string is returned. If the the sum-total of characters added is odd, the left side of the string will have one less instance of the token.
  ///   - token: The string used to pad the String (Defaults to a white space).
  public mutating func padStart(length: Int, with token: String = " ") {
    self = paddingStart(length: length, with: token)
  }

  /// **Mechanica**
  ///
  ///  Returns a `new` String  with the right-padded version of `self` if it's shorter than `length` using a `token`. Padding characters are truncated if they can't be evenly divided by length.
  ///
  /// Example 1:
  ///
  ///     let string = "Hello World"
  ///     string.paddingEnd(length: 13) -> "Hello World  "
  ///
  /// Example 2:
  ///
  ///     let string = "Hello World"
  ///     string.paddingEnd(length: 13, withToken: "*", ) -> "Hello World**"
  ///
  /// - Parameters:
  ///   - length: The final length of your string. If the provided length is less than or equal to the original string, the original string is returned.
  ///   - token: The string used to pad the String. Must be 1 character in length (Defaults to a white space).
  /// - Returns: The right-padded copy of the string.
  public func paddingEnd(length: Int, with token: String = " ") -> String {
    guard count < length else { return self }

    let padLength = length - count
    if padLength < token.count {
      return self + token[token.startIndex..<token.index(token.startIndex, offsetBy: padLength)]
    } else {
      var padding = token
      while padding.count < padLength {
        padding.append(token)
      }
      return self + padding[padding.startIndex..<padding.index(padding.startIndex, offsetBy: padLength)]
    }
  }

  /// **Mechanica**
  ///
  /// Pads `self` on the right side if it's shorter than `length` using a `token`. Padding characters are truncated if they exceed length.
  ///
  /// - Parameters:
  ///   - length: The final length of your string. If the provided length is less than or equal to the original string, the original string is returned. If the the sum-total of characters added is odd, the left side of the string will have one less instance of the token.
  ///   - token: The string used to pad the String (Defaults to a white space).
  public mutating func padEnd(length: Int, with token: String = " ") {
    self = paddingEnd(length: length, with: token)
  }

}
