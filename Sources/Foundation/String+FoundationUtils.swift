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

  // MARK: - Foundation

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

  /// **Mechanica**
  ///
  /// Returns a Bool value by parsing `self`.
  ///
  /// Example:
  ///
  ///     "👍🏼".bool -> true
  ///     "0".bool -> false
  ///
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
  /// Produces a `new` string with the first character of the first word changed to the corresponding uppercase value.
  public func decapitalizedFirstCharacter() -> String {
    guard !isEmpty else { return self }

    let capitalizedFirstCharacher = String(self[startIndex]).lowercased()
    let result = capitalizedFirstCharacher + String(dropFirst())

    return result
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
  /// Returns a list containing the first character of each word contained in `self`.
  func firstCharacterOfEachWord() -> [String] {
    return components(separatedBy: .whitespacesAndNewlines).filter { !$0.isEmpty }.map { String($0.prefix(1)) }
  }

  /// **Mechanica**
  ///
  /// Returns true if the `String` contains one or more letters.
  public var hasLetters: Bool {
    return !isEmpty && rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
  }

  /// **Mechanica**
  ///
  /// Returns true if the `String` contains one or more numbers.
  public var hasNumbers: Bool {
    return !isEmpty && rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
  }

  /// **Mechanica**
  ///
  /// Returns true if the `String` contains only letters.
  public var isAlphabetic: Bool {
    return !isEmpty && rangeOfCharacter(from: NSCharacterSet.letters.inverted) == nil
  }

  /// **Mechanica**
  ///
  /// Returns true if the `String` contains at least one letter and one number.
  public var isAlphaNumeric: Bool {
    return !isEmpty && rangeOfCharacter(from: NSCharacterSet.alphanumerics.inverted) == nil
  }

  /// **Mechanica**
  ///
  /// Checks if the `String` is **blank** (a string that is either empty or contains only space/newline characters).
  public var isBlank: Bool {
    return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty
  }

  /// **Mechanica**
  ///
  /// Returns `true` if `self` is a country emoji flag.
  ///
  /// - Note: to check if a string contains a flag use: `self.contains { $0.isFlag }`
  /// - Note: to extrapolate the flags in a string use: `self.filter { $0.isFlag }`
  public var isEmojiCountryFlag: Bool {
    guard count == 1 else { return false }

    return first!.isFlag
  }

  /// **Mechanica**
  ///
  /// Checks if the `String` contains only numbers.
  public var isNumeric: Bool {
    return !isEmpty && rangeOfCharacter(from: NSCharacterSet.decimalDigits.inverted) == nil
  }

  /// **Mechanica**
  ///
  /// Checks if `self` is a semantic version with a value equal to a given `version`.
  public func isSemanticVersionEqual(to version: String) -> Bool {
    return ensureSemanticVersionCorrectness().compare(version.ensureSemanticVersionCorrectness(), options: .numeric) == .orderedSame
  }

  /// **Mechanica**
  ///
  /// Checks if `self` is a semantic version with a value greater than given `version`.
  public func isSemanticVersionGreater(than version: String) -> Bool {
    return ensureSemanticVersionCorrectness().compare(version.ensureSemanticVersionCorrectness(), options: .numeric) == .orderedDescending
  }

  /// **Mechanica**
  ///
  /// Checks if `self` is a semantic version with a value greater or equal to a given `version`.
  public func isSemanticVersionGreaterOrEqual(to version: String) -> Bool {
    return ensureSemanticVersionCorrectness().compare(version.ensureSemanticVersionCorrectness(), options: .numeric) != .orderedAscending
  }

  /// **Mechanica**
  ///
  /// Checks if `self` is a semantic version with a value lesser than a given `version`.
  public func isSemanticVersionLesser(than version: String) -> Bool {
    return ensureSemanticVersionCorrectness().compare(version.ensureSemanticVersionCorrectness(), options: .numeric) == .orderedAscending
  }

  /// **Mechanica**
  ///
  /// Checks if `self` is a semantic version with a value lesser or equal to a given `version`.
  public func isSemanticVersionLesserOrEqual(to version: String) -> Bool {
    return ensureSemanticVersionCorrectness().compare(version.ensureSemanticVersionCorrectness(), options: .numeric) != .orderedDescending
  }

  /// **Mechanica**
  ///
  /// Returns true if the `String` is a valid email.
  public var isValidEmail: Bool {
    // https://medium.com/@darthpelo/email-validation-in-swift-3-0-acfebe4d879a
    // http://www.cocoawithlove.com/2009/06/verifying-that-string-is-email-address.html
    // swiftlint:disable line_length
    let emailPattern = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
    // swiftlint:enable line_length
    return NSPredicate(format: "SELF MATCHES[c] %@", emailPattern).evaluate(with: self)
  }

  /// **Mechanica**
  ///
  /// Different implementation for `isValidEmail` computed property.
  private var _isValidEmail: Bool {
    guard !self.lowercased().hasPrefix("mailto:") else { return false }
    guard let emailDetector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else { return false }

    let matches = emailDetector.matches(in: self, options: NSRegularExpression.MatchingOptions.anchored, range: NSRange(location: 0, length: length))

    guard matches.count == 1 else { return false }

    return matches[0].url?.absoluteString == "mailto:\(self)"
  }

  /// **Mechanica**
  ///
  /// Checks if string is a valid file URL.
  ///
  /// Example:
  ///
  ///     "file://Documents/file.txt".isValidFileUrl -> true
  ///
  public var isValidFileUrl: Bool {
    return URL(string: self)?.isFileURL ?? false
  }

  /// **Mechanica**
  ///
  /// Checks if string is a valid http URL.
  ///
  /// Example:
  ///
  ///     "http://tinrobots.org".isValidHttpUrl -> true
  ///
  public var isValidHttpUrl: Bool {
    guard let url = URL(string: self) else { return false }
    return url.scheme == "http"
  }

  /// **Mechanica**
  ///
  /// Checks if string is a valid https URL.
  ///
  /// Example:
  ///
  ///     "https://tinrobots.org".isValidHttpsUrl -> true
  ///
  public var isValidHttpsUrl: Bool {
    guard let url = URL(string: self) else { return false }
    return url.scheme == "https"
  }

  /// **Mechanica**
  ///
  /// Check if the `String` is a valid schemed URL.
  ///
  /// Example:
  ///
  ///     "https://tinrobots.org".isValidSchemedUrl -> true
  ///     "tinrobots.org".isValidSchemedUrl -> false
  ///
  public var isValidSchemedUrl: Bool {
    guard let url = URL(string: self) else { return false }
    return url.scheme != nil
  }

  /// **Mechanica**
  ///
  /// Checks if string is a valid URL.
  ///
  /// Example:
  ///
  ///     "https://tinrobots.org".isValidUrl -> true
  ///
  public var isValidUrl: Bool {
    return URL(string: self) != nil
  }

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
  /// Returns a `new` string in which the characters in a specified `CountableClosedRange` range of the String are replaced by a given string.
  public func replacingCharacters(in range: CountableClosedRange<Int>, with replacement: String) -> String {
    let start = index(startIndex, offsetBy: range.lowerBound)
    let end   = index(start, offsetBy: range.count)

    return replacingCharacters(in: start ..< end, with: replacement)
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
  /// Returns *true* if `self` starts with a given prefix.
  public func starts(with prefix: String, caseSensitive: Bool = true) -> Bool {
    if !caseSensitive {
      return lowercased().hasPrefix(prefix.lowercased())
    }

    return hasPrefix(prefix)
  }

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

  // MARK: - CharacterSet

  /// **Mechanica**
  ///
  /// Returns the `NSRange` of `self`.
  public var nsRange: NSRange {
    let range = self.startIndex...

    return NSRange(range, in: self)
  }

  // MARK: - Case Operators

  /// **Mechanica**
  ///
  /// Produces a camel cased version of the `String`.
  ///
  /// Example:
  ///
  ///     let string = "HelloWorld"
  ///     print(string.camelCased()) -> "helloWorld"
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
  ///     print(string.kebabCased()) -> "-Hello-World-"
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
  ///     print(string.pascalCased()) -> "HelloWorld"
  ///
  /// - Returns: A pascal cased copy of the `String`.
  public func pascalCased() -> String {
    return replacingOccurrences(of: "_", with: " ").replacingOccurrences(of: "-", with: " ").components(separatedBy: .whitespaces).joined()
  }

  /// **Mechanica**
  ///
  /// Produces the slug version of the `String`.
  ///
  /// Example:
  ///
  ///     let string = "Hello World"
  ///     print(string.slugCased()) -> "Hello-World"
  ///
  /// - Returns: The slug copy of the `String`.
  public func slugCased() -> String {
    return replacingOccurrences(of: "_", with: " ").replacingOccurrences(of: "-", with: " ").condensingExcessiveSpaces().replacingOccurrences(of: " ", with: "-").lowercased()
  }

  /// **Mechanica**
  ///
  /// Produces the snake cased version of the `String`.
  ///
  /// Example:
  ///
  ///     let string = "hello world"
  ///     print(string.snakeCased())
  ///     -> Prints "hello_world"
  ///
  /// - Returns: The slug copy of the `String`.
  public func snakeCased() -> String {
    return replacingOccurrences(of: "_", with: " ").replacingOccurrences(of: "-", with: " ").condensingExcessiveSpaces().replacingOccurrences(of: " ", with: "_")
  }

  /// **Mechanica**
  ///
  /// Produces the swap cased version of the `String`.
  ///
  /// Example:
  ///
  ///     let string = "Hello World"
  ///     print(string.swapCased()) -> "hELLO wORLD"
  ///
  /// - Returns: The swap cased copy of the `String`.
  public func swapCased() -> String {
    return map({String($0).isLowercased ? String($0).uppercased() : String($0).lowercased()}).joined()
  }

  // MARK: - NSString

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
  /// Returns the last path component of the receiver.
  /// - Note: This method only works with file paths (not, for example, string representations of URLs).
  var lastPathComponent: String {
    return (self as NSString).lastPathComponent
  }

  /// **Mechanica**
  ///
  /// Returns the file-system path components of the receiver.
  var pathComponents: [String] {
    return (self as NSString).pathComponents
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
  /// Returns a percent-escaped string following RFC 3986 for a query string key or value.
  public var urlEscaped: String? {
    return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
  }

  // MARK: - Regular Expression

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

}
