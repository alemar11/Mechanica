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

#if os(Linux)
  import Glibc
#else
  import Darwin
#endif

extension String {

  // MARK: - Standard Library

  /// **Mechanica**
  ///
  /// Returns a `new` string containing the first character of the `String`.
  public var first: String {
    let first = self[..<index(after: startIndex)]

    return String(first)
  }

  /// **Mechanica**
  ///
  /// Checks if all of the characters in a string are all the same.
  public var isHomogeneous: Bool {
    for char in dropFirst() where char != first {
      return false
    }
    return true
  }

  /// **Mechanica**
  ///
  /// Returns true if all the characters are lowercased.
  public var isLowercased: Bool {
    return self == lowercased()
  }

  /// **Mechanica**
  ///
  /// Returns true, if all characters are uppercased. Otherwise, false.
  public var isUppercased: Bool {
    return self == uppercased()
  }

  /// **Mechanica**
  ///
  /// Returns a `new` string containing the last character of the `String`.
  public var last: String {
    let last = self[index(before: endIndex)...]

    return String(last)
  }

  /// **Mechanica**
  ///
  /// Returns the length of the `String`.
  public var length: Int {
    return count
  }

  /// **Mechanica**
  ///
  ///  Returns a `new` String  with the center-padded version of `self` if it's shorter than `length` using a `token`. Padding characters are truncated if they can't be evenly divided by length.
  ///
  /// Example 1:
  ///
  ///     let string = "Hello World"
  ///     string.padding(length: 15) -> "  Hello World  "
  ///
  /// Example 2:
  ///
  ///     let string = "Hello World"
  ///     string.padding(length: 15, withToken: "*") -> "**Hello World**"
  ///
  /// - Parameters:
  ///   - length: The final length of your string. If the provided length is less than or equal to the original string, the original string is returned.
  ///   - token: The string used to pad the String (defaults to a white space).
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
  /// Example 1:
  ///
  ///     let string = "Hello World"
  ///     string.pad(length: 15) -> "  Hello World  "
  ///
  /// Example 2:
  ///
  ///     let string = "Hello World"
  ///     string.pad(length: 15, withToken: "*") -> "**Hello World**"
  ///
  /// - Parameters:
  ///   - length: The final length of your string. If the provided length is less than or equal to the original string, the original string is returned.
  /// If the the sum-total of characters added is odd, the left side of the string will have one less instance of the token.
  ///   - token: The string used to pad the String (defaults to a white space).
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
  ///     string.paddingStart(length: 15) -> "    Hello World"
  ///
  /// Example 2:
  ///
  ///     let string = "Hello World"
  ///     string.paddingStart(length: 15, withToken: "*") -> "****Hello World"
  ///
  /// - Parameters:
  ///   - length: The final length of your string.
  ///   - token: The string used to pad the String (defaults to a white space).
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
  /// Example 1:
  ///
  ///     let string = "Hello World"
  ///     string.padStart(length: 15) -> "    Hello World"
  ///
  /// Example 2:
  ///
  ///     let string = "Hello World"
  ///     string.padStart(length: 15, withToken: "*") -> "****Hello World"
  ///
  /// - Parameters:
  ///   - length: The final length of your string.
  ///   - token: The string used to pad the String (defaults to a white space).
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
  ///     string.paddingEnd(length: 15) -> "Hello World    "
  ///
  /// Example 2:
  ///
  ///     let string = "Hello World"
  ///     string.paddingEnd(length: 15, withToken: "*", ) -> "Hello World****"
  ///
  /// - Parameters:
  ///   - length: The final length of your string.
  ///   - token: The string used to pad the String (defaults to a white space).
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
  /// Example 1:
  ///
  ///     let string = "Hello World"
  ///     string.padEnd(length: 15) -> "Hello World    "
  ///
  /// Example 2:
  ///
  ///     let string = "Hello World"
  ///     string.padEnd(length: 15, withToken: "*", ) -> "Hello World****"
  ///
  /// - Parameters:
  ///   - length: The final length of your string.
  ///   - token: The string used to pad the String (defaults to a white space).
  public mutating func padEnd(length: Int, with token: String = " ") {
    self = paddingEnd(length: length, with: token)
  }

  /// **Mechanica**
  ///
  ///  Returns a substring, up to maxLength in length, containing the initial elements of the `String`.
  ///
  ///  - Warning: If maxLength exceeds self.count, the result contains all the elements of self.
  ///  - parameter maxLength: substring max lenght
  ///
  public func prefix(maxLength: Int) -> String {
    guard maxLength > 0 else { return "" }

    return String(prefix(maxLength))
  }

  /// **Mechanica**
  ///
  /// Returns a new `String` containing the characters of the String from the one at a given position to the end.
  ///
  /// Example:
  ///
  ///     "hello".removingPrefix(upToPosition: 1) -> "ello"
  ///
  ///  - parameter upToPosition: position (included) up to which remove the prefix.
  public func removingPrefix(upToPosition: Int = 1) -> String {
    guard upToPosition >= 0 && upToPosition <= length else { return "" }

    let startIndex = index(self.startIndex, offsetBy: upToPosition)

    return String(self[startIndex...])
  }

  /// **Mechanica**
  ///
  ///  Returns a new `String` removing the spcified prefix (if the string has it).
  ///
  /// Example:
  ///
  ///     "hello".removingPrefix("hel") -> "lo"
  ///
  ///  - parameter prefix: prefix to be removed.
  public func removingPrefix(_ prefix: String) -> String {
    guard hasPrefix(prefix) else { return self }

    return removingPrefix(upToPosition: prefix.length)
  }

  /// **Mechanica**
  ///
  ///  Returns a new `String` containing the characters of the String up to, but not including, the one at a given position.
  ///  - parameter fromPosition: position (included) from which remove the suffix
  ///
  /// Example:
  ///
  ///     "hello".removingSuffix(fromPosition: 1) -> "hell"
  ///
  public func removingSuffix(fromPosition: Int = 1) -> String {
    guard fromPosition >= 0 && fromPosition <= length else { return "" }

    let startIndex = index(endIndex, offsetBy: -fromPosition)

    return String(self[..<startIndex])
  }

  /// **Mechanica**
  ///
  /// Returns a new `String` removing the spcified suffix (if the string has it).
  ///
  /// Example:
  ///
  ///     "hello".removingSuffix("0") -> "hell"
  ///
  ///  - parameter prefix: prefix to be removed.
  public func removingSuffix(_ suffix: String) -> String {
    guard hasSuffix(suffix) else { return self }

    return removingSuffix(fromPosition: suffix.length)
  }

  /// **Mechanica**
  ///
  /// Reverse `self`.
  public mutating func reverse() {
    self = String(reversed())
  }

  /// **Mechanica**
  ///
  ///  Returns a slice, up to maxLength in length, containing the final elements of `String`.
  ///
  ///  - Warning: If maxLength exceeds `String` character count, the result contains all the elements of `String`.
  ///  - parameter maxLength: substring max lenght
  public func suffix(maxLength: Int) -> String {
    guard maxLength > 0 else { return "" }

    return String(suffix(maxLength))
  }

  /// **Mechanica**
  ///
  ///  Truncates the `String` to the given length (number of characters) and appends optional trailing string if longer.
  ///  The default trailing is the ellipsis (…).
  ///  - parameter length:   number of characters after which the `String` is truncated
  ///  - parameter trailing: optional trailing string
  ///
  public func truncate(at length: Int, withTrailing trailing: String? = "…") -> String {

    switch length {
    case 0..<self.length:
      return self.prefix(maxLength: length) + (trailing ?? "")
    case _ where length >= self.length:
      return self // no truncation needed
    default:
      return ""
    }

  }

  // MARK: - Subscript Methods

  /// **Mechanica**
  ///
  ///  Gets the character at the specified index as String.
  ///
  ///  - parameter index: index Position of the character to get
  ///
  ///  - Returns: Character as String or nil if the index is out of bounds
  public subscript (index: Int) -> String? {
    guard 0..<count ~= index else { return nil }

    return String(Array(self)[index])
  }

  /// **Mechanica**
  ///
  ///   Returns the substring in the given range.
  ///
  ///  - parameter range: range
  ///
  ///  - Returns: Substring in Range or nil.
  public subscript (range: Range<Int>) -> String? {
    guard 0...length ~= range.lowerBound else { return nil }
    guard 0...length ~= range.upperBound else { return nil }

    let start = index(startIndex, offsetBy: range.lowerBound)
    let end = index(startIndex, offsetBy: range.upperBound)
    let range = Range(uncheckedBounds: (lower: start, upper: end))

    return String(self[range])
  }

  // MARK: - Operators

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
