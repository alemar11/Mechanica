//
//  String+Utils.swift
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

  // MARK: - Helper Methods
  
  /// **Mechanica**
  ///
  /// Returns the length of the `String`.
  public var length: Int {
    return self.characters.count
  }
  
  /// **Mechanica**
  ///
  /// Reverse `self`.
  public mutating func reverse() {
    self = String(self.characters.reversed())
  }
  
  /// **Mechanica**
  ///
  /// Returns a `new` reversed `String`.
  /// Shorthand for *self.characters.reverse()*.
  public func reversed() -> String {
    return String(self.characters.reversed())
  }
  
  /// **Mechanica**
  ///
  /// Returns *true* if `self` starts with a given prefix.
  public func starts(with prefix: String, caseSensitive: Bool = true) -> Bool {
    if !caseSensitive {
      return lowercased().hasPrefix(prefix.lowercased())
    }
    return hasPrefix(prefix)
  }
  
  /// **Mechanica**
  ///
  /// Returns *true* if `self` ends with a given suffix.
  public func ends(with suffix: String, caseSensitive: Bool = true) -> Bool {
    if !caseSensitive {
      return lowercased().hasSuffix(suffix.lowercased())
    }
    return hasSuffix(suffix)
  }
  
  /// **Mechanica**
  ///
  ///  Checks if `self` contains a `String`.
  ///
  /// - Parameters:
  ///   -  string:       String to match.
  ///   - caseSensitive: Search option: *true* for case-sensitive, false for case-insensitive. (if *true* this function is equivalent to `self.contains(...)`)
  ///
  ///  - Returns: *true* if contains match, otherwise false.
  public func contains(_ string: String, caseSensitive: Bool) -> Bool {
    if (caseSensitive) {
      return self.contains(string)
    } else {
      return (self.range(of: string, options: .caseInsensitive) != nil)
    }
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
  ///  Returns a `new` string in which all occurrences of a target are replaced by another given string.
  ///
  /// - Parameters:
  ///   - target:         target string
  ///   - replacement:    replacement string
  ///   - caseSensitive:  `*true*` (default) for a case-sensitive replacemente
  public func replace(_ target: String, with replacement: String, caseSensitive: Bool = true) -> String {
    let compareOptions: String.CompareOptions = (caseSensitive == true) ? [.literal] : [.literal, .caseInsensitive]
    return self.replacingOccurrences(of: target, with: replacement, options: compareOptions, range: nil)
  }

  // MARK: - Random

  /// **Mechanica**
  ///
  /// Generates a `new` random alphanumeric string of a given length (default 8).
  public static func random(length: Int = 8) -> String {
    let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    var randomString: String = ""
    for _ in 0..<length {
      let randomValue = arc4random_uniform(UInt32(base.characters.count))
      randomString += "\(base[base.index(base.startIndex, offsetBy: Int(randomValue))])"
    }
    return randomString
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
    //return trimmedLeft().trimmedRight()
    return self.trimmingCharacters(in: .whitespacesAndNewlines)
  }
  
  /// **Mechanica**
  ///
  ///  Strips the specified characters from the beginning of `self`.
  ///
  ///  - parameter set: characters to strip
  ///
  ///  - Returns: stripped string
  public func trimmedLeft(characterSet set: CharacterSet = .whitespacesAndNewlines) -> String {
    if let range = rangeOfCharacter(from: set.inverted) {
      return self[range.lowerBound..<endIndex]
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
  public func trimmedRight(characterSet set: CharacterSet = .whitespacesAndNewlines) -> String {
    if let range = rangeOfCharacter(from: set.inverted, options: .backwards) {
      return self[startIndex..<range.upperBound]
    }
    return ""
  }

  /// **Mechanica**
  ///
  /// Returns a new `String` with each word capitalized.
  ///
  /// Example:
  ///
  ///     let string = "Hello World"
  ///     print(string.decapitalized()) // "hello world"
  ///
  /// - Note: It will be decapitalized the first character (if any) that's not a special character.
  public func decapitalized() -> String {
    let ranges = self.ranges(matching: String.Pattern.firstCharacter)
    var decapitalizedString = self
    for range in ranges {
      let character = self[range.lowerBound]
      let lowercasedCharacter = String(character).lowercased()
      decapitalizedString = decapitalizedString.replacingCharacters(in: range, with: lowercasedCharacter)
    }
    return decapitalizedString
  }

  /// **Mechanica**
  ///
  /// Returns a new `String` with each word decapitalized.
  ///
  /// Example:
  ///
  ///     let string = "hello world"
  ///     print(string.capitalized()) // "Hello World"
  ///
  /// - Note: It will be capitalized the first character (if any) that's not a special character.
  public func capitalized() -> String {
    let ranges = self.ranges(matching: String.Pattern.firstCharacter)
    var decapitalizedString = self
    for range in ranges {
      let character = self[range.lowerBound]
      let lowercasedCharacter = String(character).uppercased()
      decapitalizedString = decapitalizedString.replacingCharacters(in: range, with: lowercasedCharacter)
    }
    return decapitalizedString
  }

  /// **Mechanica**
  ///
  /// Produces a `new` string with the first character of the first word changed to the corresponding uppercase value.
  public func capitalizedFirstCharacter() -> String {
    guard (!self.isEmpty) else { return self }
    let capitalizedFirstCharacher = String(self[startIndex]).uppercased() //capitalized
    let result = capitalizedFirstCharacher + String(self.characters.dropFirst())
    return result
    
  }
  
  /// **Mechanica**
  ///
  /// Produces a `new` string with the first character of the first word changed to the corresponding uppercase value.
  public func decapitalizedFirstCharacter() -> String {
    guard (!self.isEmpty) else { return self }
    let capitalizedFirstCharacher = String(self[startIndex]).lowercased()
    let result = capitalizedFirstCharacher + String(self.characters.dropFirst())
    return result
    
  }
  
  /// **Mechanica**
  ///
  /// Returns a `new` string containing the first character of the `String`.
  public var first: String {
    let first = self.substring(to: self.index(after: self.startIndex))
    return first
  }
  
  /// **Mechanica**
  ///
  /// Returns a `new` string containing the last character of the `String`.
  public var last: String {
    let last = self.substring(from: self.index(before: self.endIndex))
    return last
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
    return String(self.characters.prefix(maxLength))
  }
  
  /// **Mechanica**
  ///
  ///  Returns a slice, up to maxLength in length, containing the final elements of `String`.
  ///
  ///  - Warning: If maxLength exceeds `String` character count, the result contains all the elements of `String`.
  ///  - parameter maxLength: substring max lenght
  public func suffix(maxLength: Int) -> String {
    guard maxLength > 0 else {
      return ""
    }
    return String(self.characters.suffix(maxLength))
  }
  
  // MARK: - Remove Methods
  
  /// **Mechanica**
  ///
  ///  Returns a new `String` containing the characters of the String from the one at a given position to the end.
  ///
  /// ```
  /// "hello".removingPrefix(upToPosition: 1) // "ello"
  /// ```
  ///
  ///  - parameter upToPosition: position (included) up to which remove the prefix.
  public func removingPrefix(upToPosition: Int = 1) -> String {
    guard (upToPosition >= 0 && upToPosition <= self.length) else { return "" }
    let startIndex = self.index(self.startIndex, offsetBy: upToPosition)
    return self.substring(from: startIndex)
  }

  /// **Mechanica**
  ///
  ///  Returns a new `String` removing the spcified prefix (if the string has it).
  ///
  /// ```
  /// "hello".removingPrefix("hel") // "lo"
  /// ```
  ///  - parameter prefix: prefix to be removed.
  public func removingPrefix(_ prefix: String) -> String {
    guard self.hasPrefix(prefix) else { return self }
    return self.removingPrefix(upToPosition: prefix.length)
  }
  
  /// **Mechanica**
  ///
  ///  Returns a new `String` containing the characters of the String up to, but not including, the one at a given position.
  ///
  ///  ```
  ///  "hello".removingSuffix(fromPosition: 1) == "hell"
  ///  ```
  ///
  ///  - parameter fromPosition: position (included) from which remove the suffix
  public func removingSuffix(fromPosition: Int = 1) -> String {
    guard (fromPosition >= 0 && fromPosition <= self.length) else { return "" }
    let startIndex = self.index(self.endIndex, offsetBy: -fromPosition)
    return self.substring(to: startIndex)
  }

  /// **Mechanica**
  ///
  ///  Returns a new `String` removing the spcified suffix (if the string has it).
  ///
  /// ```
  /// "hello".removingSuffix("0") // "hell"
  /// ```
  ///  - parameter prefix: prefix to be removed.
  public func removingSuffix(_ suffix: String) -> String {
    guard self.hasSuffix(suffix) else { return self }
    return self.removingSuffix(fromPosition: suffix.length)
  }

  /// **Mechanica**
  ///
  ///  Returns a new `String` removing the characters in the given set.
  public func removingCharacters(in set: CharacterSet) -> String {
    var chars = characters
    for idx in chars.indices.reversed() {
      if set.contains(String(chars[idx]).unicodeScalars.first!) {
        chars.remove(at: idx)
      }
    }
    return String(chars)
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
  
  // MARK: - Cleaning Methods
  
  /// **Mechanica**
  ///
  ///  Condenses all white spaces repetitions in a single white space.
  ///  White space at the beginning or ending of the `String` are trimmed out.
  ///
  ///  ```
  ///  let aString = "test    too many    spaces"
  ///  aString.removeExcessiveSpaces //test too many spaces
  ///  ```
  ///
  ///  - Returns: A `new` string where all white spaces repetitions are replaced with a single white space.
  public func condensingExcessiveSpaces() -> String {
    let components = self.components(separatedBy: .whitespaces)
    let filtered = components.filter({!$0.isEmpty})
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
    let filtered = components.filter({!$0.isBlank})
    return filtered.joined(separator: " ")
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
    guard (0..<self.characters.count ~= index) else { return nil }
    return String(Array(self.characters)[index])
  }
  
  /// **Mechanica**
  ///
  /// Returns a `new` string in which the characters in a specified `CountableClosedRange` range of the String are replaced by a given string.
  public func replacingCharacters(in range: CountableClosedRange<Int>, with replacement: String) -> String {
    let start = characters.index(characters.startIndex, offsetBy: range.lowerBound)
    let end   = characters.index(start, offsetBy: range.count)
    return self.replacingCharacters(in: start ..< end, with: replacement)
  }
  
  /// **Mechanica**
  ///
  /// Returns a `new` string in which the characters in a specified `CountableRange` range of the String are replaced by a given string.
  public func replacingCharacters(in range: CountableRange<Int>, with replacement: String) -> String {
    let start = characters.index(characters.startIndex, offsetBy: range.lowerBound)
    let end   = characters.index(start, offsetBy: range.count)
    return self.replacingCharacters(in: start ..< end, with: replacement)
  }
  
  /// **Mechanica**
  ///
  ///   Returns the substring in the given range.
  ///
  ///  - parameter range: range
  ///
  ///  - Returns: Substring in Range or nil.
  public subscript (range: Range<Int>) -> String? {
    guard (0...length ~= range.lowerBound) else { return nil }
    guard (0...length ~= range.upperBound) else { return nil }
    let start = index(startIndex, offsetBy: range.lowerBound)
    let end = index(startIndex, offsetBy: range.upperBound)
    return substring(with: Range(uncheckedBounds: (lower: start, upper: end)))
  }
  
  /// **Mechanica**
  ///
  ///  Returns the substring in the given `NSRange`
  ///
  ///  - parameter range: NSRange
  ///
  ///  - Returns: Substring in NSRange or nil.
  public subscript (nsRange: NSRange) -> String? {
    guard let range = nsRange.toRange() else { return nil }
    return self[range]
  }

  /// **Mechanica**
  ///
  ///  Returns the range of the first occurrence of a given string in the `String`.
  ///
  ///  - parameter substring: substring
  ///
  ///  - Returns: range of the first occurrence or nil.
  public subscript (substring: String) -> Range<String.Index>? {
    let range = Range(uncheckedBounds: (lower: startIndex, upper: endIndex) )
    return self.range(of: substring, options: .literal, range: range, locale: .current)
  }

  // MARK: - Regular Expression

  
  
  // MARK: - Case Operators
  
  /// **Mechanica**
  ///
  /// Produces a camel cased version of the `String`.
  ///
  /// Example:
  ///
  ///     let string = "HelloWorld"
  ///     print(string.camelCased()) // "helloWorld"
  ///
  /// - Returns: A camel cased copy of the `String`.
  public func camelCased() -> String {
    return pascalCased().decapitalizedFirstCharacter()
  }
  
  /// **Mechanica**
  ///
  /// Produces the kebab cased version of the `String`.
  ///
  /// Example:
  ///
  ///     let string = "Hello World"
  ///     print(string.kebabCased()) // "-Hello-World-"
  ///
  /// - Returns: The kebab cased copy of the `String`.
  public func kebabCased() -> String {
    return "-" + slugCased() + "-"
  }
  
  /// **Mechanica**
  ///
  /// Produces a pascal cased version of the `String`.
  ///
  /// Example:
  ///
  ///     let string = "HELLO WORLD"
  ///     print(string.pascalCased()) // "HelloWorld"
  ///
  /// - Returns: A pascal cased copy of the `String`.
  public func pascalCased() -> String {
    return self.replacingOccurrences(of: "_", with: " ").replacingOccurrences(of: "-", with: " ").components(separatedBy: .whitespaces).joined()
  }
  
  /// **Mechanica**
  ///
  /// Produces the slug version of the `String`.
  ///
  /// Example:
  ///
  ///     let string = "Hello World"
  ///     print(string.slugCased()) // "Hello-World"
  ///
  /// - Returns: The slug copy of the `String`.
  public func slugCased() -> String {
    return self.replacingOccurrences(of: "_", with: " ").replacingOccurrences(of: "-", with: " ").condensingExcessiveSpaces().replacingOccurrences(of: " ", with: "-").lowercased()
  }
  
  /// **Mechanica**
  ///
  /// Produces the snake cased version of the `String`.
  ///
  /// Example:
  ///
  ///     let string = "hello world"
  ///     print(string.snakeCased())
  ///     // Prints "hello_world"
  ///
  /// - Returns: The slug copy of the `String`.
  public func snakeCased() -> String {
    return self.replacingOccurrences(of: "_", with: " ").replacingOccurrences(of: "-", with: " ").condensingExcessiveSpaces().replacingOccurrences(of: " ", with: "_")
  }
  
  /// **Mechanica**
  ///
  /// Produces the swap cased version of the `String`.
  ///
  /// Example:
  ///
  ///     let string = "Hello World"
  ///     print(string.swapCased()) // "hELLO wORLD"
  ///
  /// - Returns: The swap cased copy of the `String`.
  public func swapCased() -> String {
    return characters.map({
      String($0).isLowercased ? String($0).uppercased() : String($0).lowercased()
    }).joined()
  }
  
}
