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

extension String {

  // MARK: - Helper Methods

  /// **Mechanica**
  ///
  /// Returns the length of the `String`.
  public var length: Int {
    return count
  }

  /// **Mechanica**
  ///
  /// Reverse `self`.
  public mutating func reverse() {
    self = String(reversed())
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
    if caseSensitive {
      return contains(string)
    } else {
      return range(of: string, options: .caseInsensitive) != nil
    }
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

    return replacingOccurrences(of: target, with: replacement, options: compareOptions, range: nil)
  }

  /// **Mechanica**
  ///
  /// Returns a list containing the first character of each word contained in `self`.
  func firstCharacterOfEachWord() -> [String] {
    return components(separatedBy: .whitespacesAndNewlines).filter { !$0.isEmpty }.map { String($0.prefix(1)) }
  }

  /// **Mechanica**
  ///
  /// Returns a percent-escaped string following RFC 3986 for a query string key or value.
  public var urlEscaped: String? {
    return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
  }

  // MARK: - Semantic Version
  
  /// **Mechanica**
  ///
  /// Makes sure that we always have a semantic version in the form MAJOR.MINOR.PATCH
  func ensureSemanticVersionCorrectness() -> String {
    if self.isEmpty { return "0.0.0" }

    var copy = self

    let versionComponents = components(separatedBy: ".")
    guard 1 ... 3 ~= versionComponents.count else { fatalError("Invalid number of semantic version components (\(versionComponents.count)).") }

    let notNumericComponents = versionComponents.filter { !$0.isNumeric }
    guard notNumericComponents.isEmpty else { fatalError("Each semantic version component should have a numeric value.") }

    for _ in versionComponents.count..<3 {
      copy += ".0"
    }

    return copy
  }

  /// **Mechanica**
  ///
  /// If `self` is a semantic version, returns a tuple with major, minor and patch components.
  public var semanticVersion: (Int, Int, Int) {
    let versionComponents = ensureSemanticVersionCorrectness().components(separatedBy: ".")
    let major = Int(versionComponents[0]) ?? 0
    let minor = Int(versionComponents[1]) ?? 0
    let patch = Int(versionComponents[2]) ?? 0

    return (major, minor, patch)
  }
  
  /// **Mechanica**
  ///
  /// Return a Bool value by parsing `self`.
  public var bool: Bool? {
    switch self.trimmed().lowercased() {
    case "1", "true", "t", "yes", "y", "👍", "👍🏻", "👍🏼", "👍🏽", "👍🏾", "👍🏿":
      return true
    case "0", "false", "f", "no", "n", "👎", "👎🏻", "👎🏼", "👎🏽", "👎🏾", "👎🏿":
      return false
    default:
      return nil
    }
  }

  /// **Mechanica**
  ///
  /// Produces a `new` string with the first character of the first word changed to the corresponding uppercase value.
  public func capitalizedFirstCharacter() -> String {
    guard !isEmpty else { return self }
    let capitalizedFirstCharacher = String(self[startIndex]).uppercased() //capitalized
    let result = capitalizedFirstCharacher + String(dropFirst())

    return result
  }

  /// **Mechanica**
  ///
  /// Produces a `new` string with the first character of the first word changed to the corresponding uppercase value.
  public func decapitalizedFirstCharacter() -> String {
    guard !isEmpty else { return self }

    let capitalizedFirstCharacher = String(self[startIndex]).lowercased()
    let result = capitalizedFirstCharacher + String(dropFirst())

    return result
  }

  // MARK: - Suffix and Prefix Methods

  /// **Mechanica**
  ///
  /// Returns a `new` string containing the first character of the `String`.
  public var first: String {
    let first = self[..<index(after: startIndex)]

    return String(first)
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

}
