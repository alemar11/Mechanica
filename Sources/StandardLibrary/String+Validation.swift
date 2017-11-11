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

public extension String {

  // MARK: - Validation Methods

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
  /// Checks if the `String` contains only numbers.
  public var isNumeric: Bool {
    return !isEmpty && rangeOfCharacter(from: NSCharacterSet.decimalDigits.inverted) == nil
  }

  /// **Mechanica**
  ///
  /// Returns true if the `String` contains at least one letter and one number.
  public var isAlphaNumeric: Bool {
    return !isEmpty && rangeOfCharacter(from: NSCharacterSet.alphanumerics.inverted) == nil
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
  /// Checks if the `String` is **blank** (a string that is either empty or contains only space/newline characters).
  public var isBlank: Bool {
    return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty
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
  /// Returns true if the `String` is a valid email.
  /// - Seealso: [link 1](https://medium.com/@darthpelo/email-validation-in-swift-3-0-acfebe4d879a)
  /// - Seealso: [link 2](http://www.cocoawithlove.com/2009/06/verifying-that-string-is-email-address.html)
  public var isValidEmail: Bool {
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
  /// Returns `true` if `self` is a country emoji flag.
  ///
  /// - Note: to check if a string contains a flag use: `self.contains { $0.isFlag }`
  /// - Note: to extrapolate the flags in a string use: `self.filter { $0.isFlag }`
  public var isEmojiCountryFlag: Bool {
    guard count == 1 else { return false }

    return first!.isFlag
  }

  // MARK: - Semantic Versioning

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

}
