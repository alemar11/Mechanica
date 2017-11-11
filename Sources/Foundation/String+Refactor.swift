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
  
  // MARK: - Subscript with NSRange
  
  /// **Mechanica**
  ///
  ///  Returns the substring in the given `NSRange`
  ///
  ///  - parameter range: NSRange
  ///
  ///  - Returns: Substring in NSRange or nil.
  public subscript (nsRange: NSRange) -> String? {
    guard let range = Range(nsRange) else { return nil }
    
    return self[range]
  }
  
  // MARK: - Trimming Methods
  
  /// **Mechanica**
  ///
  /// Removes spaces and new lines from both ends of `self.
  public mutating func trim() {
    self = trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
  }
  
  /// **Mechanica**
  ///
  ///  Returns a `new` String made by removing spaces and new lines from both ends.
  public func trimmed() -> String {
    return trimmingCharacters(in: .whitespacesAndNewlines)
  }
  
  /// **Mechanica**
  ///
  ///  Strips the specified characters from the beginning of `self`.
  ///
  ///  - parameter set: characters to strip
  ///
  ///  - Returns: stripped string
  public func trimmedStart(characterSet set: CharacterSet = .whitespacesAndNewlines) -> String {
    if let range = rangeOfCharacter(from: set.inverted) {
      return String(self[range.lowerBound..<endIndex])
    }
    
    return ""
  }
  
  /// **Mechanica**
  ///
  ///  Strips the specified characters from the end of `self`.
  ///
  ///  - parameter set: characters to strip
  ///
  ///  - Returns: stripped string
  public func trimmedEnd(characterSet set: CharacterSet = .whitespacesAndNewlines) -> String {
    if let range = rangeOfCharacter(from: set.inverted, options: .backwards) {
      return String(self[..<range.upperBound])
    }
    
    return ""
  }
  
  // MARK: - CharacterSet
  
  /// **Mechanica**
  ///
  ///  Remove the characters in the given set.
  public mutating func removeCharacters(in set: CharacterSet) {
    for idx in indices.reversed() {
      if set.contains(String(self[idx]).unicodeScalars.first!) {
        remove(at: idx)
      }
    }
    
  }
  
  /// **Mechanica**
  ///
  ///  Returns a new `String` removing the characters in the given set.
  public func removingCharacters(in set: CharacterSet) -> String {
    var copy = self
    copy.removeCharacters(in: set)
    
    return copy
  }
  
  /// **Mechanica**
  ///
  /// Checks if if all the characters in the string belong to a specific `CharacterSet`.
  ///
  /// - Parameter characterSet: The `CharacterSet` used to test the string.
  /// - Returns: *true* if all the characters in the string belong to the `CharacterSet`, otherwise false.
  public func containsCharacters(in characterSet: CharacterSet) -> Bool {
    guard !isEmpty else { return false }
    for scalar in unicodeScalars {
      guard characterSet.contains(scalar) else { return false }
    }
    
    return true
  }
  
  /// **Mechanica**
  ///
  /// Returns a `new` string in which the characters in a specified `CountableRange` range of the String are replaced by a given string.
  public func replacingCharacters(in range: CountableRange<Int>, with replacement: String) -> String {
    let start = index(startIndex, offsetBy: range.lowerBound)
    let end   = index(start, offsetBy: range.count)
    
    return replacingCharacters(in: start ..< end, with: replacement)
  }
  
  /// **Mechanica**
  ///
  /// Returns a `new` string in which the characters in a specified `CountableClosedRange` range of the String are replaced by a given string.
  public func replacingCharacters(in range: CountableClosedRange<Int>, with replacement: String) -> String {
    let start = index(startIndex, offsetBy: range.lowerBound)
    let end   = index(start, offsetBy: range.count)
    
    return replacingCharacters(in: start ..< end, with: replacement)
  }
  
  // MARK: - Random
  
  /// **Mechanica**
  ///
  /// Generates a `new` random alphanumeric string of a given length (default 8).
  public static func random(length: UInt32 = 8) -> String {
    let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    var randomString: String = ""
    
    for _ in 0..<length {
      let randomValue = arc4random_uniform(UInt32(base.count))
      randomString += "\(base[base.index(base.startIndex, offsetBy: Int(randomValue))])"
    }
    
    return randomString
  }
  
  // MARK: - Cleaning Methods
  
  /// **Mechanica**
  ///
  ///  Condenses all white spaces repetitions in a single white space.
  ///  White space at the beginning or ending of the `String` are trimmed out.
  ///
  /// Example:
  ///
  ///     let aString = "test    too many    spaces"
  ///     aString.removeExcessiveSpaces  -> test too many spaces
  ///
  ///
  ///  - Returns: A `new` string where all white spaces repetitions are replaced with a single white space.
  public func condensingExcessiveSpaces() -> String {
    let components = self.components(separatedBy: .whitespaces)
    let filtered = components.filter {!$0.isEmpty}
    
    return filtered.joined(separator: " ")
  }
  
  /// **Mechanica**
  ///
  ///  Condenses all white spaces and new lines repetitions in a single white space.
  ///  White space and new lines at the beginning or ending of the `String` are trimmed out.
  ///
  ///  - Returns: A `new` string where all white spaces and new lines repetitions are replaced with a single white space.
  public func condensingExcessiveSpacesAndNewlines() -> String {
    let components = self.components(separatedBy: .whitespacesAndNewlines)
    let filtered = components.filter {!$0.isBlank}
    
    return filtered.joined(separator: " ")
  }
  
  /// **Mechanica**
  ///
  /// Returns a `new` String stripped of all accents and diacritics.
  ///
  /// Example:
  ///
  ///     let string = "äöüÄÖÜ" -> ÄÖÜ
  ///     let stripped = string.stripCombiningMarks -> aouAOU
  ///
  @available(iOS 9.0, macOS 10.11, tvOS 9.0, watchOS 2.0, *)
  func removingAccentsOrDiacritics() -> String {
    return applyingTransform(.stripCombiningMarks, reverse: false) ?? self
  }
  
}
