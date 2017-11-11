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

extension String {
  
  // MARK: - NSString

  /// **Mechanica**
  ///
  /// Returns the last path component of the receiver.
  /// - Note: This method only works with file paths (not, for example, string representations of URLs).
  var lastPathComponent: String {
    return (self as NSString).lastPathComponent
  }

  /// **Mechanica**
  ///
  /// Return the path extension, if any, of the string as interpreted as a path.
  /// - Note: This method only works with file paths (not, for example, string representations of URLs).
  var pathExtension: String {
    return (self as NSString).pathExtension
  }

  /// **Mechanica**
  ///
  /// Returns a `new` string made by deleting the last path component from the receiver, along with any final path separator.
  /// - Note: This method only works with file paths (not, for example, string representations of URLs).
  var deletingLastPathComponent: String {
    return (self as NSString).deletingLastPathComponent
  }

  /// **Mechanica**
  ///
  /// Returns a `new` string made by deleting the extension (if any, and only the last) from the receiver.
  var deletingPathExtension: String {
    return (self as NSString).deletingPathExtension
  }

  /// **Mechanica**
  ///
  /// Returns the file-system path components of the receiver.
  var pathComponents: [String] {
    return (self as NSString).pathComponents
  }

  /// **Mechanica**
  ///
  /// Returns a new string made by appending to the receiver a given string.
  func appendingPathComponent(_ path: String) -> String {
    let nsString = self as NSString
    return nsString.appendingPathComponent(path)
  }

  /// **Mechanica**
  ///
  /// Returns a new string made by appending to the receiver an extension separator followed by a given extension.
  func appendingPathExtension(_ ext: String) -> String? {
    let nsString = self as NSString
    return nsString.appendingPathExtension(ext)
  }
  
  // MARK: - NSRange
  
  /// **Mechanica**
  ///
  /// Returns the `NSRange` of `self`.
  public var nsRange: NSRange {
    let range = self.startIndex...
    
    return NSRange(range, in: self)
  }
  
  // MARK: - Regular Expression
  
  /// **Mechanica**
  ///
  /// Returns a range equivalent to the given `NSRange` or `nil` if the range can't be converted.
  @available(*, deprecated, message: "Swift 4 supports conversion between NSRange and Range ( Range.init?(_:in) )")
  private func range(from nsRange: NSRange) -> Range<Index>? {
    guard let range = Range(nsRange) else { return nil }
    let utf16Start = UTF16Index(encodedOffset: range.lowerBound)
    let utf16End = UTF16Index(encodedOffset: range.upperBound)
    
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
  /// - Returns: returns a list of matched ranges for `self`.
  public func ranges(matching pattern: String, options: NSRegularExpression.Options = []) -> [Range<String.Index>] {
    guard let regex = try? NSRegularExpression(pattern: pattern, options: options) else { return [] }
    let matches = regex.matches(in: self, options: [], range: NSRange(startIndex..<endIndex, in: self))
    let ranges = matches.flatMap { Range($0.range, in: self) }
    
    return ranges
  }
  
  /// **Mechanica**
  ///
  /// - Parameters:
  ///   - pattern: a regular expression pattern.
  ///   - options: a list of `NSRegularExpression.Options`.
  /// - Returns: returns a the first matched range for `self` or nil.
  public func firstRange(matching pattern: String, options: NSRegularExpression.Options = []) -> Range<String.Index>? {
    guard let regex = try? NSRegularExpression(pattern: pattern, options: options) else { return nil }
    
    let range = regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)).flatMap { Range($0.range, in: self) }
    
    return range
  }
  
  /// **Mechanica**
  ///
  /// - Parameters:
  ///   - pattern: a regular expression pattern.
  ///   - options: a list of `NSRegularExpression.Options`.
  /// - Returns: returns a list of matched strings for `self`.
  func matches(for pattern: String, options: NSRegularExpression.Options = []) -> [String] {
    var strings = [String]()
    
    for range in ranges(matching: pattern, options: options) {
      strings.append(String(self[range]))
    }
    
    return strings
  }
  
  /// **Mechanica**
  ///
  /// - Parameters:
  ///   - pattern: a regular expression pattern.
  ///   - options: a list of `NSRegularExpression.Options`.
  /// - Returns: returns the first matched string for `self`.
  func firstMatch(for pattern: String, options: NSRegularExpression.Options = []) -> String? {
    guard let range = firstRange(matching: pattern) else { return nil }
    
    return String(self[range])
  }
  
  // MARK: - Data
  
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
