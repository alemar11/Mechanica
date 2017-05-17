//
//  String+RegularExpressions.swift
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

// MARK: - Regular Expression Commons Patterns

extension String {

  /// **Mechanica**
  ///
  /// Common Regular Expression Patterns
  internal enum Pattern {

    /// **Mechanica**
    ///
    /// Pattern matches email addresses.
    static let email = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"

    /// **Mechanica**
    ///
    /// Pattern matches first alphanumeric character of each word.
    static let firstAlphanumericCharacter = "(\\b\\w|(?<=_)[^_])"

    /// **Mechanica**
    ///
    /// Pattern matches last alphanumeric character of each word.
    static let lastAlphanumericCharacter = "(\\w\\b|[^_](?=_))"

    /// **Mechanica**
    ///
    /// Pattern matches non-Alphanumeric characters.
    static let nonAlphanumeric = "[^a-zA-Z\\d]"

    /// **Mechanica**
    ///
    /// Pattern matches non-Alphanumeric and non-Whitespace characters.
    static let nonAlphanumericSpace = "[^a-zA-Z\\d\\s]"

  }

}

// MARK: - Regular Expression

extension String {

  /// **Mechanica**
  ///
  /// Returns a range equivalent to the given `NSRange` or `nil` if the range can't be converted.
  fileprivate func range(from nsRange: NSRange) -> Range<Index>? {
    guard let range = nsRange.toRange() else { return nil }
    let utf16Start = UTF16Index(range.lowerBound)
    let utf16End = UTF16Index(range.upperBound)

    guard
      let start = Index(utf16Start, within: self),
      let end = Index(utf16End, within: self)
      else { return nil }

    return start..<end
  }

  /// **Mechanica**
  ///
  /// - Parameters:
  ///   - pattern: a regular expression pattern.
  ///   - options: a list of `NSRegularExpression.Options`.
  /// - Returns: returns a list of matched ranges for `self` or empy. Defaults to [].
  func ranges(matching pattern: String, with options: NSRegularExpression.Options = []) -> [Range<String.Index>] {
    guard let regex = try? NSRegularExpression(pattern: pattern, options: options) else { return [] }
    let matches = regex.matches(in: self, options: [], range: NSRange(location: 0, length: characters.count))
    let ranges = matches.flatMap { return self.range(from: $0.range) }
    return ranges
  }

  /// **Mechanica**
  ///
  /// - Parameters:
  ///   - pattern: a regular expression pattern.
  ///   - options: a list of `NSRegularExpression.Options`.
  /// - Returns: returns a the first matched range for `self` or nil.
  func firstRange(matching pattern: String, with options: NSRegularExpression.Options = []) -> Range<String.Index>? {
    guard let regex = try? NSRegularExpression(pattern: pattern, options: options) else { return nil }
    let range = regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: characters.count)).flatMap { return self.range(from: $0.range) }
    return range
  }

  /// **Mechanica**
  ///
  /// - Parameters:
  ///   - pattern: a regular expression pattern.
  ///   - options: a list of `NSRegularExpression.Options`.
  /// - Returns: returns a list of matched strings for `self`.
  func strings(matching pattern: String, with options: NSRegularExpression.Options = []) -> [String] {
    var strings: [String] = []
    for range in ranges(matching: pattern, with: options) {
      strings.append(self.substring(with: range))
    }
    return strings
  }
  
}
