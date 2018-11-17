//
// Mechanica
//
// Copyright © 2016-2018 Tinrobots.
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

import XCTest
@testable import Mechanica

extension StringFoundationUtilsTests {
  static var allTests = [
    ("testBool", testBool),
    ("testBase64Decoded", testBase64Decoded),
    ("testBase64Encoded", testBase64Encoded),
    ("testFirstCharacterOfEachWord", testFirstCharacterOfEachWord),
    ("testStarts", testStarts),
    ("testEnds", testEnds),
    ("testHasLetters", testHasLetters),
    ("testHasNumbers", testHasNumbers),
    ("testIsBlank", testIsBlank),
    ("testIsAlphabetic", testIsAlphabetic),
    ("testIsAlphaNumeric", testIsAlphaNumeric),
    ("testIsNumeric", testIsNumeric),
    ("testIsValidUrl", testIsValidUrl),
    ("testIsValidSchemedUrl", testIsValidSchemedUrl),
    ("testIsValidHttpUrl", testIsValidHttpUrl),
    ("testIsValidHttpsUrl", testIsValidHttpsUrl),
    ("testIsValidFileURL", testIsValidFileURL),
    ("testIsValidEmail", testIsValidEmail),
    ("testIsEmojiCountryFlag", testIsEmojiCountryFlag),
    ("testContainsCharacters", testContainsCharacters),
    ("testReplace", testReplace),
    ("testCondensingExcessiveSpaces", testCondensingExcessiveSpaces),
    ("testCondensingExcessiveSpacesAndNewLines", testCondensingExcessiveSpacesAndNewLines),
    ("testSemanticVersionComparison", testSemanticVersionComparison),
    ("testSemanticVersion", testSemanticVersion),
    ("testFirstRange", testFirstRange),
    ("testMatches", testMatches),
    ("testTrim", testTrim),
    ("testTrimmed", testTrimmed),
    ("testCapitalizedFirstCharacter", testCapitalizedFirstCharacter),
    ("testDecapitalizedFirstCharacter", testDecapitalizedFirstCharacter),
    ("testRemovingCharacters", testRemovingCharacters),
    ("testURLEscaped", testURLEscaped),
    ("testCamelCased", testCamelCased),
    ("testKebabCased", testKebabCased),
    ("testPascalCased", testPascalCased),
    ("testSlugCased", testSlugCased),
    ("testSnakeCased", testSnakeCased),
    ("testSwapCased", testSwapCased),
    ("testNSRange", testNSRange),
    ("testContainsCaseSensitive", testContainsCaseSensitive),
    ("testSubscript", testSubscript),
    ("testReplacingCharacters", testReplacingCharacters),
    ("testReplacingFirstOccurrence", testReplacingFirstOccurrence),
    ("testRandom", testRandom),
    ("testRandomWithRangelength", testRandomWithRangelength)
  ]
}

final class StringFoundationUtilsTests: XCTestCase {

  func testBool() {
    do {
      guard let n = "1".bool, n == true else {
        XCTAssert(false, "Couldn't get the correct Bool value.")
        return
      }
    }
    do {
      guard let n = "1 ".bool, n == true else {
        XCTAssert(false, "Couldn't get the correct Bool value.")
        return
      }
    }
    do {
      guard let n = "false".bool, n == false else {
        XCTAssert(false, "Couldn't get the correct Bool value.")
        return
      }
    }
    do {
      guard let n = "yes".bool, n == true else {
        XCTAssert(false, "Couldn't get the correct Bool value.")
        return
      }
    }
    do {
      guard let n = " 👍🏽".bool, n == true else {
        XCTAssert(false, "Couldn't get the correct Bool value.")
        return
      }
    }
    do {
      guard let n = "👎 ".bool, n == false else {
        XCTAssert(false, "Couldn't get the correct Bool value.")
        return
      }
    }
    XCTAssertNil("1x".bool, "Couldn't get the correct Bool value.")
    XCTAssertNil("yess".bool, "Couldn't get the correct Bool value.")
    XCTAssertNil("01".bool, "Couldn't get the correct Bool value.")
    XCTAssertNil("👍🏽👍🏽".bool, "Couldn't get the correct Bool value.")
    XCTAssertNil("👍🏿👍🏽".bool, "Couldn't get the correct Bool value.")
    XCTAssertNil("👎👎".bool, "Couldn't get the correct Bool value.")
    XCTAssertNil("👎🏾👎🏼".bool, "Couldn't get the correct Bool value.")
  }

  func testBase64Decoded() {
    XCTAssertNil("123".base64Decoded, "Couldn't get the correct Base64 decoded value.")
    XCTAssert("SGVsbG8gV29ybGQh".base64Decoded == "Hello World!", "Couldn't get the correct Base64 decoded value.")
    XCTAssert("SGVsbG8gUm9ib3RzIfCfpJbwn6SW".base64Decoded ==  "Hello Robots!🤖🤖", "Couldn't get the correct Base64 decoded value.")
  }

  func testBase64Encoded() {
    XCTAssert("Hello World!".base64Encoded == "SGVsbG8gV29ybGQh", "Couldn't get the correct Base64 encoded value.")
    XCTAssert("Hello Robots!🤖🤖".base64Encoded == "SGVsbG8gUm9ib3RzIfCfpJbwn6SW", "Couldn't get the correct Base64 encoded value.")
  }

  func testFirstCharacterOfEachWord() {

    do {
      let text = "tin Robots ! 🤖"
      let initials = text.firstCharacterOfEachWord()
      XCTAssertEqual(initials, ["t", "R", "!", "🤖"])
    }

    do {
      let text = "\n"
      let initials = text.firstCharacterOfEachWord()
      XCTAssertTrue(initials.isEmpty)
    }

  }

  func testStarts() {
    // TODO: - Some emojis work differently on Linux (Swift 4.2)

    //case sensitive
    XCTAssertTrue("a".starts(with:"a"))
    XCTAssertFalse("a".starts(with:"A"))
    XCTAssertTrue("🤔a1".starts(with:"🤔"))

    #if !os(Linux)
    XCTAssertTrue("🖖🏽a1".starts(with:"🖖🏽"))
    #else
    XCTAssertTrue("🖖🏽a1".starts(with:"🖖"))
    #endif

    #if !os(Linux)
    XCTAssertTrue("🇮🇹🇮🇹🖖🏽 ".starts(with:"🇮🇹"))
    #else
    XCTAssertTrue("🇮🇹🇮🇹🖖🏽 ".starts(with:"🇮🇹🇮🇹"))
    #endif

    //case insensitive
    #if !os(Linux)
    XCTAssertTrue("🇮🇹🇮🇹🖖🏽 ".starts(with:"🇮🇹", caseSensitive: false))
    #else
    XCTAssertTrue("🇮🇹🇮🇹🖖🏽 ".starts(with:"🇮🇹🇮🇹", caseSensitive: false))
    #endif

    XCTAssertTrue("a".starts(with:"A", caseSensitive: false))
    XCTAssertTrue("Hello".starts(with:"hello", caseSensitive: false))
    XCTAssertFalse("Hello".starts(with:"helloo", caseSensitive: false))
  }

  func testEnds() {
    // TODO: - Some emojis work differently on Linux (Swift 4.2)

    //case sensitive
    XCTAssertTrue("a".ends(with:"a"), "It should end with 'a'")
    XCTAssertFalse("a".ends(with:"A"), "It should end with 'A'")
    XCTAssertTrue("a1🤔".ends(with:"🤔"), "It should end with '🤔'")

    #if !os(Linux)
    XCTAssertTrue("a1🖖🏽".ends(with:"🖖🏽"))
    #else
    XCTAssertTrue("a1🖖🏽".ends(with:"🏽"))
    #endif

    #if !os(Linux)
    XCTAssertTrue(" 🖖🏽🇮🇹🇮🇹".ends(with:"🇮🇹"))
    #else
    XCTAssertTrue(" 🖖🏽🇮🇹🇮🇹".ends(with:"🇮🇹🇮🇹"))
    #endif

    //case insensitive
    #if !os(Linux)
    XCTAssertTrue(" 🖖🏽🇮🇹🇮🇹".ends(with:"🇮🇹", caseSensitive: false))
    #else
    XCTAssertTrue(" 🖖🏽🇮🇹🇮🇹".ends(with:"🇮🇹🇮🇹", caseSensitive: false))
    #endif
    XCTAssertTrue("a".ends(with:"A", caseSensitive: false))
    XCTAssertTrue("Hello".ends(with:"hello", caseSensitive: false))
    XCTAssertFalse("Hello".ends(with:"helloo", caseSensitive: false))
  }

  func testHasLetters() {
    XCTAssertTrue("a".hasLetters)
    XCTAssertTrue("11f5644+fadsdsf4".hasLetters)
    XCTAssertTrue("|!\"è£$%&)".hasLetters)

    XCTAssertFalse("|!\"£$%&)".hasLetters)
    XCTAssertFalse("@".hasLetters)
    XCTAssertFalse("11111".hasLetters)
    XCTAssertFalse("1,1".hasLetters)
    XCTAssertFalse("0.1".hasLetters)
  }

  func testHasNumbers() {
    XCTAssertTrue("a1".hasNumbers)
    XCTAssertTrue(".ò@dasg9n".hasNumbers)
    XCTAssertFalse("|!\"£$%&)".hasNumbers)
    XCTAssertFalse("@".hasNumbers)
    XCTAssertFalse("abcdef".hasNumbers)
  }

  func testIsBlank() {
    XCTAssertTrue("".isBlank)
    XCTAssertTrue(" ".isBlank)
    XCTAssertTrue("  ".isBlank)
    XCTAssertTrue("\n".isBlank)   //New line
    XCTAssertTrue("\r".isBlank)   //Carriage-return
    XCTAssertTrue("\t".isBlank)   //Horizontal tab
    XCTAssertTrue("\r\n".isBlank)
    XCTAssertTrue("\r\n ".isBlank)

    XCTAssertFalse("a ".isBlank)
    XCTAssertFalse("a \r\n ".isBlank)
  }



  func testIsAlphabetic() {
    XCTAssertTrue("abcd".isAlphabetic)
    XCTAssertTrue("abCd".isAlphabetic)
    XCTAssertTrue("ù".isAlphabetic)
    XCTAssertTrue("éøp".isAlphabetic)

    XCTAssertFalse("as1".isAlphabetic)
    XCTAssertFalse("@".isAlphabetic)
    XCTAssertFalse("a#ba".isAlphabetic)
    XCTAssertFalse(" ~~~".isAlphabetic)
    XCTAssertFalse("★abc".isAlphabetic)
    XCTAssertFalse("🚀".isAlphabetic)
  }

  func testIsAlphaNumeric() {
    XCTAssertTrue("123".isAlphaNumeric)
    XCTAssertTrue("0001".isAlphaNumeric)
    XCTAssertTrue("abcd".isAlphaNumeric)
    XCTAssertTrue("èéò".isAlphaNumeric)
    XCTAssertTrue("tinrobots12345".isAlphaNumeric)

    XCTAssertFalse("tinrobots.org".isAlphaNumeric)
    XCTAssertFalse("✓".isAlphaNumeric)
    XCTAssertFalse("#".isAlphaNumeric)
    XCTAssertFalse("🚀".isAlphaNumeric)
    XCTAssertFalse("abc✓".isAlphaNumeric)
    XCTAssertFalse("#123ad".isAlphaNumeric)
    XCTAssertFalse("🚀".isAlphaNumeric)
  }

  func testIsNumeric() {
    XCTAssertTrue("123".isNumeric)
    XCTAssertTrue("0001".isNumeric)
    XCTAssertTrue("0000000000000000000000".isNumeric)

    XCTAssertFalse("000000000000000000000O".isNumeric)
    XCTAssertFalse("123,123".isNumeric)
    XCTAssertFalse("123.123".isNumeric)
    XCTAssertFalse("abc".isNumeric)
    XCTAssertFalse("abc1".isNumeric)
  }

  func testIsValidUrl() {
    XCTAssert("https://tinrobots.org".isValidUrl)
    XCTAssert("http://tinrobots.org".isValidUrl)
    XCTAssert("ftp://tinrobots.org".isValidUrl)
  }

  func testIsValidSchemedUrl() {
    XCTAssertFalse("Tin Robots".isValidSchemedUrl)
    XCTAssert("https://tinrobots.org".isValidSchemedUrl)
    XCTAssert("ftp://tinrobots.org".isValidSchemedUrl)
    XCTAssertFalse("tinrobots.org".isValidSchemedUrl)
  }

  func testIsValidHttpsUrl() {
    XCTAssertFalse("Hello world!".isValidHttpsUrl)
    XCTAssert("https://tinrobots.org".isValidHttpsUrl)
    XCTAssertFalse("http://tinrobots.org".isValidHttpsUrl)
    XCTAssertFalse("tinrobots.org".isValidHttpsUrl)
  }

  func testIsValidHttpUrl() {
    XCTAssertFalse("Hello world!".isValidHttpUrl)
    XCTAssert("http://tinrobots.org".isValidHttpUrl)
    XCTAssertFalse("tinrobots.org".isValidHttpUrl)
  }

  func testIsValidFileURL() {
    XCTAssertFalse("Hello world!".isValidFileUrl)
    XCTAssert("file://path/to/folder/file.swift".isValidFileUrl)
    XCTAssert("file://path/to/folder/file".isValidFileUrl)
    XCTAssertFalse("tinrobots.org".isValidFileUrl)
  }

  func testIsValidEmail() {
    //valid emails
    XCTAssertTrue("test@tinrobots.org".isValidEmail)
    XCTAssertTrue("TEST@tinrobots.org".isValidEmail)
    XCTAssertTrue("test@tinrobots.ORG".isValidEmail)
    XCTAssertTrue("test@TINROBOTS.org".isValidEmail)
    XCTAssertTrue("test123@tinrobots.org".isValidEmail)
    XCTAssertTrue("123test@tinrobots.org".isValidEmail)
    XCTAssertTrue("test.test@tinrobots.org".isValidEmail)
    XCTAssertTrue("test.test.test@tinrobots.org".isValidEmail)
    XCTAssertTrue("testtesttesttesttesttesttesttesttesttesttesttesttesttesttesttest@tinrobots.org".isValidEmail)
    XCTAssertTrue("TesttesttesTtesttesttesttesttesttesttesttesttesttesttesttesttest@tinrobots.org".isValidEmail)
    XCTAssertTrue("testtesttesttesttesttesttesttesttesttesttesttesttesttesttesttest@tinrobotstinrobotstinrobotstinrobots.org".isValidEmail)
    XCTAssertTrue("tEsT@tinrobots.xyz".isValidEmail)
    XCTAssertTrue("test@tinrobots.xyz".isValidEmail)
    XCTAssertTrue("test@tin.robots.org".isValidEmail)

    //invalid emails
    XCTAssertFalse("mailto:test@.tinrobots.org".isValidEmail)
    XCTAssertFalse("test@.tinrobots.org".isValidEmail)
    XCTAssertFalse("test.@tinrobots.org".isValidEmail)
    XCTAssertFalse("te@st@tinrobots.org".isValidEmail)
    XCTAssertFalse("test@tinrobots..org".isValidEmail)
    XCTAssertFalse("test@tinrobots.org.".isValidEmail)
    XCTAssertFalse("test@tinrobotsorg".isValidEmail)
    XCTAssertFalse("testtinrobots.org".isValidEmail)
    XCTAssertFalse("@tinrobots..org".isValidEmail)
    XCTAssertFalse("    @tinrobots..org".isValidEmail)
    XCTAssertFalse("test @tinrobots.org".isValidEmail)
    XCTAssertFalse("test @ tinrobots.org".isValidEmail)
    XCTAssertFalse("test🤓@tin.robots.org".isValidEmail)
    XCTAssertFalse("test@tinrobots.org.🤓".isValidEmail)
    XCTAssertFalse("test@tinrobots.🤓.org".isValidEmail)

    /// tests for the internal _isValidEmail

    #if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)

    //valid emails
    XCTAssertTrue("test@tinrobots.org"._isValidEmail)
    XCTAssertTrue("TEST@tinrobots.org"._isValidEmail)
    XCTAssertTrue("test@tinrobots.ORG"._isValidEmail)
    XCTAssertTrue("test@TINROBOTS.org"._isValidEmail)
    XCTAssertTrue("test123@tinrobots.org"._isValidEmail)
    XCTAssertTrue("123test@tinrobots.org"._isValidEmail)
    XCTAssertTrue("test.test@tinrobots.org"._isValidEmail)
    XCTAssertTrue("test.test.test@tinrobots.org"._isValidEmail)
    XCTAssertTrue("testtesttesttesttesttesttesttesttesttesttesttesttesttesttesttest@tinrobots.org"._isValidEmail)
    XCTAssertTrue("TesttesttesTtesttesttesttesttesttesttesttesttesttesttesttesttest@tinrobots.org"._isValidEmail)
    XCTAssertTrue("testtesttesttesttesttesttesttesttesttesttesttesttesttesttesttest@tinrobotstinrobotstinrobotstinrobots.org"._isValidEmail)
    XCTAssertTrue("tEsT@tinrobots.xyz"._isValidEmail)
    XCTAssertTrue("test@tinrobots.xyz"._isValidEmail)
    XCTAssertTrue("test@tin.robots.org"._isValidEmail)

    //invalid emails
    XCTAssertFalse("mailto:test@.tinrobots.org"._isValidEmail)
    XCTAssertFalse("test@.tinrobots.org"._isValidEmail)
    XCTAssertFalse("test.@tinrobots.org"._isValidEmail)
    XCTAssertFalse("te@st@tinrobots.org"._isValidEmail)
    XCTAssertFalse("test@tinrobots..org"._isValidEmail)
    XCTAssertFalse("test@tinrobots.org."._isValidEmail)
    XCTAssertFalse("test@tinrobotsorg"._isValidEmail)
    XCTAssertFalse("testtinrobots.org"._isValidEmail)
    XCTAssertFalse("@tinrobots..org"._isValidEmail)
    XCTAssertFalse("    @tinrobots..org"._isValidEmail)
    XCTAssertFalse("test @tinrobots.org"._isValidEmail)
    XCTAssertFalse("test @ tinrobots.org"._isValidEmail)
    XCTAssertFalse("test🤓@tin.robots.org"._isValidEmail)
    XCTAssertFalse("test@tinrobots.org.🤓"._isValidEmail)
    XCTAssertFalse("test@tinrobots.🤓.org"._isValidEmail)

    #endif
  }

  func testIsEmojiCountryFlag() {
    XCTAssertFalse("🚩".isEmojiCountryFlag)
    XCTAssertFalse("🏳️‍🌈".isEmojiCountryFlag)
    XCTAssertFalse("🎌".isEmojiCountryFlag)
    XCTAssertFalse("🇯🇵🇯🇵".isEmojiCountryFlag)

    XCTAssertTrue("🇯🇵".isEmojiCountryFlag)
    XCTAssertTrue("🇮🇹".isEmojiCountryFlag)
    XCTAssertTrue("🇺🇸".isEmojiCountryFlag)
  }

  func testContainsCharacters() {
    XCTAssertFalse("".containsCharacters(in: .letters))
    XCTAssertTrue("AaBbCc".containsCharacters(in: .letters))
    XCTAssertFalse("A1aBbCc".containsCharacters(in: .letters))
    XCTAssertTrue("AaB bCc".containsCharacters(in: CharacterSet.letters.union(CharacterSet.whitespaces)))
    XCTAssertFalse("A1a BbCc".containsCharacters(in: .letters))
    XCTAssertTrue("123".containsCharacters(in: .decimalDigits))
  }

  func testReplace() {
    XCTAssertEqual("AaBbCc".replace("a", with: "Z"), "AZBbCc")
    XCTAssertEqual("AaBbCc".replace("a", with: "a"), "AaBbCc")
    XCTAssertNotEqual("AaBbCc".replace("a", with: "A"), "AaBbCc")
    XCTAssertEqual("AaBbCc".replace("", with: "A"), "AaBbCc")
    XCTAssertEqual("AaBbCc".replace("AaBbCc", with: "123"), "123")
    XCTAssertEqual("aaBbCa".replace("a", with: "1"), "11BbC1")
    XCTAssertEqual("AaBbCc🤔".replace("🤔", with: "🤔🤔"), "AaBbCc🤔🤔")
    XCTAssertEqual("".replace("🤔", with: "🤔🤔"), "")
    XCTAssertEqual("".replace("", with: "🤔"), "")
    XCTAssertEqual("Italy 🇮🇹\u{200B}🇮🇹\u{200B}🇮🇹".replace("\u{200B}", with: " "), "Italy 🇮🇹 🇮🇹 🇮🇹")
    XCTAssertEqual("AaBbCc".replace("a", with: "Z", caseSensitive: false), "ZZBbCc")
    XCTAssertEqual("AaBbCc".replace("a", with: "a", caseSensitive: false), "aaBbCc")
    XCTAssertEqual("AaBbCc".replace("a", with: "A", caseSensitive: false), "AABbCc")
    XCTAssertEqual("AaBbCc".replace("", with: "A", caseSensitive: false), "AaBbCc")
  }

  func testReplacingFirstOccurrence() {
    XCTAssertEqual("x x x".replacingFirstOccurrence(of: "x", with: "!"), "! x x")
    XCTAssertEqual("xxx".replacingFirstOccurrence(of: "x", with: "!"), "!xx")
    XCTAssertEqual("x x x".replacingFirstOccurrence(of: "x ", with: " "), " x x")
    XCTAssertEqual("x x 🧐".replacingFirstOccurrence(of: "🧐", with: "🇮🇹"), "x x 🇮🇹")
    XCTAssertEqual("".replacingFirstOccurrence(of: "🧐", with: "🇮🇹"), "")
  }

  func testCondensingExcessiveSpaces() {
    XCTAssertTrue("test spaces too many".condensingExcessiveSpaces() == "test spaces too many")
    XCTAssertTrue("test  spaces    too many".condensingExcessiveSpaces() == "test spaces too many")
    XCTAssertTrue(" test spaces too many ".condensingExcessiveSpaces() == "test spaces too many")
    XCTAssertTrue(" test spaces too many".condensingExcessiveSpaces() == "test spaces too many")
    XCTAssertTrue("test spaces too many ".condensingExcessiveSpaces() == "test spaces too many")
  }

  func testCondensingExcessiveSpacesAndNewLines() {
    XCTAssertTrue("test\n spaces too many".condensingExcessiveSpacesAndNewlines() == "test spaces too many")
    XCTAssertTrue("\n\ntest  spaces    too many".condensingExcessiveSpacesAndNewlines() == "test spaces too many")
    XCTAssertTrue(" test spaces too many \n\n".condensingExcessiveSpacesAndNewlines() == "test spaces too many")
    XCTAssertTrue(" test spaces too\n many".condensingExcessiveSpacesAndNewlines() == "test spaces too many")
    XCTAssertTrue("test\n\n spaces \n\n too many ".condensingExcessiveSpacesAndNewlines() == "test spaces too many")
  }

  func testSemanticVersionComparison() {
    // Equal

    /// true
    XCTAssertTrue("1".isSemanticVersionEqual(to: "1"))
    XCTAssertTrue("1".isSemanticVersionEqual(to: "1.0"))
    XCTAssertTrue("1".isSemanticVersionEqual(to: "1.000.000"))
    XCTAssertTrue("1.0.0".isSemanticVersionEqual(to: "1.0000"))
    XCTAssertTrue("1.00.00".isSemanticVersionEqual(to: "1.000.000"))
    XCTAssertTrue("1.0.0".isSemanticVersionEqual(to: "1"))
    XCTAssertTrue("1.0.0".isSemanticVersionEqual(to: "1.0"))
    XCTAssertTrue("1.0.0".isSemanticVersionEqual(to: "1.0.0"))
    XCTAssertTrue("1.0.0000".isSemanticVersionEqual(to: "1.0.0"))
    XCTAssertTrue("0.1".isSemanticVersionEqual(to: "0.1"))
    XCTAssertTrue("0.1.0".isSemanticVersionEqual(to: "0.1.0"))
    XCTAssertTrue("".isSemanticVersionEqual(to: ""))
    XCTAssertTrue("0".isSemanticVersionEqual(to: "0.0.0"))
    XCTAssertTrue("0.0".isSemanticVersionEqual(to: "0"))
    XCTAssertTrue("0.0.0".isSemanticVersionEqual(to: ""))

    /// false
    XCTAssertFalse("1".isSemanticVersionEqual(to: "1.111"))
    XCTAssertFalse("1".isSemanticVersionEqual(to: "0"))
    XCTAssertFalse("1".isSemanticVersionEqual(to: "0.100.0"))
    XCTAssertFalse("1.0.0".isSemanticVersionEqual(to: "0.3"))
    XCTAssertFalse("1.0.0".isSemanticVersionEqual(to: "2"))
    XCTAssertFalse("1.0.0".isSemanticVersionEqual(to: "2.0.0"))
    XCTAssertFalse("0.1".isSemanticVersionEqual(to: "0.1.1"))
    XCTAssertFalse("0.1".isSemanticVersionEqual(to: "0.10"))
    XCTAssertFalse("0.1".isSemanticVersionEqual(to: "0.10000.0"))
    XCTAssertFalse("0.1.0".isSemanticVersionEqual(to: "0.9.0"))
    XCTAssertFalse("".isSemanticVersionEqual(to: "100"))
    XCTAssertFalse("0".isSemanticVersionEqual(to: "0.100.0"))
    XCTAssertFalse("0.0".isSemanticVersionEqual(to: "0.1.999"))
    XCTAssertFalse("0.0.1".isSemanticVersionEqual(to: ""))
    XCTAssertFalse("\(Int.max)".isSemanticVersionLesser(than: "\(Int.max)"))
    XCTAssertFalse("\(UInt.max)".isSemanticVersionLesser(than: "\(UInt.max)"))

    // Greater

    /// true
    XCTAssertTrue("1".isSemanticVersionGreater(than: "0.1"))
    XCTAssertTrue("1.00".isSemanticVersionGreater(than: "000.1"))
    XCTAssertTrue("1.1".isSemanticVersionGreater(than: "1.0.100"))
    XCTAssertTrue("1.1".isSemanticVersionGreater(than: "1.0.01"))
    XCTAssertTrue("1.0.1".isSemanticVersionGreater(than: "0.10.01"))
    XCTAssertTrue("100".isSemanticVersionGreater(than: "1"))
    XCTAssertTrue("9.0.1".isSemanticVersionGreater(than: "9"))
    XCTAssertTrue("0.0.1".isSemanticVersionGreater(than: ""))
    XCTAssertTrue("\(Int.max)".isSemanticVersionGreater(than: ""))
    XCTAssertTrue("\(UInt.max)".isSemanticVersionGreater(than: ""))

    /// false
    XCTAssertFalse("1".isSemanticVersionGreater(than: "10.1"))
    XCTAssertFalse("1.00".isSemanticVersionGreater(than: "1.00.1"))
    XCTAssertFalse("1.1".isSemanticVersionGreater(than: "1.1.100"))
    XCTAssertFalse("1.1".isSemanticVersionGreater(than: "1.1.01"))
    XCTAssertFalse("1.0.1".isSemanticVersionGreater(than: "1.10.01"))
    XCTAssertFalse("0.100".isSemanticVersionGreater(than: "1"))
    XCTAssertFalse("9.0.1".isSemanticVersionGreater(than: "9.1"))
    XCTAssertFalse("".isSemanticVersionGreater(than: "0.0.1"))
    XCTAssertFalse("\(Int.max)".isSemanticVersionGreater(than: "\(UInt.max)"))

    // Lesser

    /// true
    XCTAssertTrue("1".isSemanticVersionLesser(than: "10.1"))
    XCTAssertTrue("1.00".isSemanticVersionLesser(than: "1.00.1"))
    XCTAssertTrue("1.1".isSemanticVersionLesser(than: "1.1.100"))
    XCTAssertTrue("1.1".isSemanticVersionLesser(than: "1.1.01"))
    XCTAssertTrue("1.0.1".isSemanticVersionLesser(than: "1.10.01"))
    XCTAssertTrue("0.100".isSemanticVersionLesser(than: "1"))
    XCTAssertTrue("9.0.1".isSemanticVersionLesser(than: "9.1"))
    XCTAssertTrue("".isSemanticVersionLesser(than: "0.0.1"))
    XCTAssertTrue("\(Int.max)".isSemanticVersionLesser(than: "\(UInt.max)"))

    /// false
    XCTAssertFalse("1".isSemanticVersionLesser(than: "0.1"))
    XCTAssertFalse("1.00".isSemanticVersionLesser(than: "000.1"))
    XCTAssertFalse("1.1".isSemanticVersionLesser(than: "1.0.100"))
    XCTAssertFalse("1.1".isSemanticVersionLesser(than: "1.0.01"))
    XCTAssertFalse("1.0.1".isSemanticVersionLesser(than: "0.10.01"))
    XCTAssertFalse("100".isSemanticVersionLesser(than: "1"))
    XCTAssertFalse("9.0.1".isSemanticVersionLesser(than: "9"))
    XCTAssertFalse("0.0.1".isSemanticVersionLesser(than: ""))
    XCTAssertFalse("\(Int.max)".isSemanticVersionLesser(than: ""))
    XCTAssertFalse("\(UInt.max)".isSemanticVersionLesser(than: ""))

    // Greater or Equal

    /// true
    XCTAssertTrue("1".isSemanticVersionGreaterOrEqual(to: "0.1"))
    XCTAssertTrue("1.00".isSemanticVersionGreaterOrEqual(to: "000.1"))
    XCTAssertTrue("1.1".isSemanticVersionGreaterOrEqual(to: "1.0.100"))
    XCTAssertTrue("1.1".isSemanticVersionGreaterOrEqual(to: "1.0.01"))
    XCTAssertTrue("1.0.1".isSemanticVersionGreaterOrEqual(to: "0.10.01"))
    XCTAssertTrue("100".isSemanticVersionGreaterOrEqual(to: "1"))
    XCTAssertTrue("9.0.1".isSemanticVersionGreaterOrEqual(to: "9"))
    XCTAssertTrue("0.0.1".isSemanticVersionGreaterOrEqual(to: ""))
    XCTAssertTrue("\(Int.max)".isSemanticVersionGreaterOrEqual(to: ""))
    XCTAssertTrue("\(UInt.max)".isSemanticVersionGreaterOrEqual(to: ""))

    XCTAssertTrue("1".isSemanticVersionGreaterOrEqual(to: "1"))
    XCTAssertTrue("1.00".isSemanticVersionGreaterOrEqual(to: "1"))
    XCTAssertTrue("1.1".isSemanticVersionGreaterOrEqual(to: "1.1"))
    XCTAssertTrue("1.1".isSemanticVersionGreaterOrEqual(to: "1.1.00"))
    XCTAssertTrue("100".isSemanticVersionGreaterOrEqual(to: "100"))
    XCTAssertTrue("9.0.1".isSemanticVersionGreaterOrEqual(to: "9.0.1"))
    XCTAssertTrue("".isSemanticVersionGreaterOrEqual(to: ""))
    XCTAssertTrue("\(Int.max)".isSemanticVersionGreaterOrEqual(to: "\(Int.max)"))
    XCTAssertTrue("\(UInt.max)".isSemanticVersionGreaterOrEqual(to: "\(UInt.max)"))

    /// false
    XCTAssertFalse("1".isSemanticVersionGreaterOrEqual(to: "10.1"))
    XCTAssertFalse("1.00".isSemanticVersionGreaterOrEqual(to: "1.00.1"))
    XCTAssertFalse("1.1".isSemanticVersionGreaterOrEqual(to: "1.1.100"))
    XCTAssertFalse("1.1".isSemanticVersionGreaterOrEqual(to: "1.1.01"))
    XCTAssertFalse("1.0.1".isSemanticVersionGreaterOrEqual(to: "1.10.01"))
    XCTAssertFalse("0.100".isSemanticVersionGreaterOrEqual(to: "1"))
    XCTAssertFalse("9.0.1".isSemanticVersionGreaterOrEqual(to: "9.1"))
    XCTAssertFalse("".isSemanticVersionGreaterOrEqual(to: "0.0.1"))
    XCTAssertFalse("\(Int.max)".isSemanticVersionGreaterOrEqual(to: "\(UInt.max)"))


    // Lesser or Equal

    /// true
    XCTAssertTrue("1".isSemanticVersionLesserOrEqual(to: "10.1"))
    XCTAssertTrue("1.00".isSemanticVersionLesserOrEqual(to: "1.00.1"))
    XCTAssertTrue("1.1".isSemanticVersionLesserOrEqual(to: "1.1.100"))
    XCTAssertTrue("1.1".isSemanticVersionLesserOrEqual(to: "1.1.01"))
    XCTAssertTrue("1.0.1".isSemanticVersionLesserOrEqual(to: "1.10.01"))
    XCTAssertTrue("0.100".isSemanticVersionLesserOrEqual(to: "1"))
    XCTAssertTrue("9.0.1".isSemanticVersionLesserOrEqual(to: "9.1"))
    XCTAssertTrue("".isSemanticVersionLesserOrEqual(to: "0.0.1"))
    XCTAssertTrue("\(Int.max)".isSemanticVersionLesserOrEqual(to: "\(UInt.max)"))

    XCTAssertTrue("1".isSemanticVersionLesserOrEqual(to: "1"))
    XCTAssertTrue("1.00".isSemanticVersionLesserOrEqual(to: "1.0"))
    XCTAssertTrue("1.1".isSemanticVersionLesserOrEqual(to: "1.1.00"))
    XCTAssertTrue("1.1".isSemanticVersionLesserOrEqual(to: "1.1"))
    XCTAssertTrue("1.0.1".isSemanticVersionLesserOrEqual(to: "1.0.1"))
    XCTAssertTrue("0.100".isSemanticVersionLesserOrEqual(to: "0.100"))
    XCTAssertTrue("9.0.1".isSemanticVersionLesserOrEqual(to: "9.0.1"))
    XCTAssertTrue("".isSemanticVersionLesserOrEqual(to: "0.0.0"))
    XCTAssertTrue("\(Int.max)".isSemanticVersionLesserOrEqual(to: "\(UInt.max)"))
    XCTAssertTrue("\(UInt.max)".isSemanticVersionLesserOrEqual(to: "\(UInt.max)"))

    /// false
    XCTAssertFalse("1".isSemanticVersionLesserOrEqual(to: "0.1"))
    XCTAssertFalse("1.00".isSemanticVersionLesserOrEqual(to: "000.1"))
    XCTAssertFalse("1.1".isSemanticVersionLesserOrEqual(to: "1.0.100"))
    XCTAssertFalse("1.1".isSemanticVersionLesserOrEqual(to: "1.0.01"))
    XCTAssertFalse("1.0.1".isSemanticVersionLesserOrEqual(to: "0.10.01"))
    XCTAssertFalse("100".isSemanticVersionLesserOrEqual(to: "1"))
    XCTAssertFalse("9.0.1".isSemanticVersionLesserOrEqual(to: "9"))
    XCTAssertFalse("0.0.1".isSemanticVersionLesserOrEqual(to: ""))
    XCTAssertFalse("\(Int.max)".isSemanticVersionLesserOrEqual(to: ""))
    XCTAssertFalse("\(UInt.max)".isSemanticVersionLesserOrEqual(to: ""))

  }

  func testSemanticVersion() {
    XCTAssertTrue("1".semanticVersion == (1,0,0))
    XCTAssertTrue("1.0".semanticVersion == (1,0,0))
    XCTAssertTrue("1.0.0".semanticVersion == (1,0,0))
    XCTAssertTrue("".semanticVersion == (0,0,0))
  }

  #if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)

  func testLastPathComponent() {
    XCTAssert("/tmp/scratch.tiff".lastPathComponent == "scratch.tiff")
    XCTAssert("/tmp/scratch".lastPathComponent == "scratch")
    XCTAssert("scratch///".lastPathComponent == "scratch")
    XCTAssert("/".lastPathComponent == "/")
  }

  func testPathExtension() {
    XCTAssert("/tmp/scratch.tiff".pathExtension == "tiff")
    XCTAssert(".scratch.tiff".pathExtension == "tiff")
    XCTAssert("/tmp/scratch".pathExtension == "")
    XCTAssert("/tmp/scratch..tiff".pathExtension == "tiff")
  }

  func testDeletingLastPathComponent() {
    XCTAssert("/tmp/scratch.tiff".deletingLastPathComponent == "/tmp")
    XCTAssert( "/tmp/lock/".deletingLastPathComponent == "/tmp")
    XCTAssert( "/tmp/".deletingLastPathComponent == "/")
    XCTAssert("/tmp".deletingLastPathComponent == "/")
    XCTAssert( "/".deletingLastPathComponent == "/")
    XCTAssert("scratch.tiff".deletingLastPathComponent == "")
  }

  func testDeletingPathExtension() {
    XCTAssert("/tmp/scratch.tiff".deletingPathExtension == "/tmp/scratch")
    XCTAssert("/tmp/".deletingPathExtension == "/tmp")
    XCTAssert("scratch.bundle/".deletingPathExtension == "scratch")
    XCTAssert("scratch..tiff".deletingPathExtension == "scratch.")
    XCTAssert(".tiff".deletingPathExtension == ".tiff")
    XCTAssert("/".deletingPathExtension == "/")
  }

  func testPathComponents() {
    let path = "tmp/scratch";
    let pathComponents = path.pathComponents
    XCTAssert(pathComponents[0] == "tmp")
    XCTAssert(pathComponents[1] == "scratch")

    let path2 = "/tmp/scratch"
    let pathComponents2 = path2.pathComponents
    XCTAssert(pathComponents2[0] == "/")
    XCTAssert(pathComponents2[1] == "tmp")
    XCTAssert(pathComponents2[2] == "scratch")
  }

  func testAppendingPathComponent() {
    let scratch = "scratch.tiff"
    XCTAssert("/tmp".appendingPathComponent(scratch) == "/tmp/scratch.tiff")
    XCTAssert("/tmp/".appendingPathComponent(scratch) == "/tmp/scratch.tiff")
    XCTAssert("/".appendingPathComponent(scratch) == "/scratch.tiff")
    XCTAssert("".appendingPathComponent(scratch) == "scratch.tiff")
  }

  func testAppendingPathExtension() {
    let ext = "tiff"
    XCTAssert("/tmp/scratch.old".appendingPathExtension(ext) == "/tmp/scratch.old.tiff")
    XCTAssert("/tmp/scratch.".appendingPathExtension(ext) == "/tmp/scratch..tiff")
    XCTAssert("/tmp/".appendingPathExtension(ext) == "/tmp.tiff")
    XCTAssert("scratch".appendingPathExtension(ext) == "scratch.tiff")
  }

  #endif

  func testFirstRange() {

    do {
      let pattern = "^https?:\\/\\/.*"
      XCTAssertNotNil("HTTP://www.example.com".firstRange(matching: pattern, options: .caseInsensitive))
      XCTAssertNil("HTTP://www.example.com".firstRange(matching: pattern))
    }

    do {
      let text = "Hello World - Tin Robots 🤖😀🤖"
      let range = text.firstRange(matching: String.Pattern.firstAlphaNumericCharacter)
      XCTAssertNotNil(range)
      XCTAssertEqual(text[range!], "H")
      let invalidPattern = "//⛏"
      XCTAssertNil(text.firstRange(matching: invalidPattern))
    }

    do {
      let text = "mail -> info@tinrobots.com!"
      let range = text.firstRange(matching: String.Pattern.email)
      XCTAssertNotNil(range)
      XCTAssertEqual(text[range!], "info@tinrobots.com")
    }

    do {
      let text = "mail -> robot1@tinrobots.com! robot2@tinrobots.com!"
      let range = text.firstRange(matching: String.Pattern.email)
      XCTAssertNotNil(range)
      XCTAssertEqual(text[range!], "robot1@tinrobots.com")
    }

  }

  func testMatches() {

    do {
      //https://regex101.com/r/jLz7Sz/1
      let datePattern = "\\b(?:20)?(\\d\\d)[-./](0?[1-9]|1[0-2])[-./](3[0-1]|[1-2][0-9]|0?[1-9])\\b"
      let text = "   2015/10/10,11-10-20,     13/2/2     1981-2-2   2010-13-10"
      XCTAssertEqual(text.matches(for: datePattern),["2015/10/10", "11-10-20", "13/2/2"])
      XCTAssertEqual(text.firstMatch(for: datePattern),"2015/10/10")
    }

    do {
      let text = "Hello World - Tin Robots 🤖😀🤖"
      XCTAssertEqual(text.matches(for: String.Pattern.firstAlphaNumericCharacter),["H", "W", "T", "R"])
      XCTAssertEqual(text.matches(for: String.Pattern.lastAlphaNumericCharacter),["o", "d", "n", "s"])
      let invalidPattern = "//⛏"
      XCTAssertTrue(text.matches(for: invalidPattern).isEmpty)
      XCTAssertNil(text.firstMatch(for: invalidPattern))
    }

    do {
      let text = "🤖😀🤖"
      XCTAssertTrue(text.matches(for: String.Pattern.firstAlphaNumericCharacter).isEmpty)
      XCTAssertTrue(text.matches(for: String.Pattern.firstAlphaNumericCharacter).isEmpty)
      XCTAssertNil(text.firstMatch(for: String.Pattern.firstAlphaNumericCharacter))
    }

    do {
      let text = "qwerty? qwerty? <a href=\"https://github.com/tinrobots\">TinRobots on GitHub</a> or <a href=\"https://github.com/tinrobots/Mechanica\">Mechanica on GitHub</a>."
      let linkRegexPattern = "<a\\s+[^>]*href=\"([^\"]*)\"[^>]*>"
      XCTAssertEqual(text.matches(for: linkRegexPattern, options: .caseInsensitive), ["<a href=\"https://github.com/tinrobots\">", "<a href=\"https://github.com/tinrobots/Mechanica\">"])
      XCTAssertEqual(text.firstMatch(for: linkRegexPattern, options: .caseInsensitive), "<a href=\"https://github.com/tinrobots\">")
    }

  }

  func testTrim() {
    var s1 = "   Hello World   "
    s1.trim()
    XCTAssertTrue(s1 == "Hello World")
  }

  func testTrimmed() {
    let s1 = "   Hello World   "
    XCTAssertTrue(s1.trimmedStart() == "Hello World   ")
    XCTAssertTrue(s1.trimmedEnd() == "   Hello World")
    XCTAssertTrue(s1.trimmed() == "Hello World")

    let s2 = "   \u{200B} Hello World   "
    XCTAssertTrue(s2.trimmedStart() == "Hello World   ")
    XCTAssertTrue(s2.trimmed() == "Hello World")

    let s3 = "Hello World\n\n   "
    XCTAssertTrue(s3.trimmedEnd() == "Hello World")
    XCTAssertTrue(s3.trimmed() == "Hello World")


    let s4 = "abcdefg"
    XCTAssertTrue(s4.trimmedEnd(characterSet: .alphanumerics) == "")
    XCTAssertTrue(s4.trimmedStart(characterSet: .alphanumerics) == "")

    let s5 = "  abcdefg  "
    XCTAssertTrue(s5.trimmedEnd(characterSet: .alphanumerics) == "  abcdefg  ")
    XCTAssertTrue(s5.trimmedStart(characterSet: .alphanumerics) == "  abcdefg  ")
    XCTAssertTrue(s5.trimmed() == "abcdefg")
  }

  func testCapitalizedFirstCharacter() {
    let s1 = "   hello world   "
    XCTAssertTrue(s1.capitalizedFirstCharacter() == s1)
    let s2 = "hello world   "
    XCTAssertTrue(s2.capitalizedFirstCharacter() == "Hello world   ")
    let s3 = "1 hello world   "
    XCTAssertTrue(s3.capitalizedFirstCharacter() == s3)
    let s4 = "🇮🇹 hello world   "
    XCTAssertTrue(s4.capitalizedFirstCharacter() == s4)
    let s5 = "🇮🇹🇮🇹 hello world   "
    XCTAssertTrue(s5.capitalizedFirstCharacter() == s5)
    let s6 = "Hello world   "
    XCTAssertTrue(s6.capitalizedFirstCharacter() == s6)
    let s7 = "\na"
    XCTAssertTrue(s7.capitalizedFirstCharacter() == s7)
    let s8 = ""
    XCTAssertTrue(s8.capitalizedFirstCharacter() == s8)
    let s9 = "h e l l o w o r l d"
    XCTAssertTrue(s9.capitalizedFirstCharacter() == "H e l l o w o r l d")
    let s10 = "\u{200B}hello\u{200B}"
    XCTAssertTrue(s10.capitalizedFirstCharacter() == s10)
  }

  func testDecapitalizedFirstCharacter() {
    let s1 = "   hello world   "
    XCTAssertTrue(s1.decapitalizedFirstCharacter() == s1)
    let s2 = "Hello world   "
    XCTAssertTrue(s2.decapitalizedFirstCharacter() == "hello world   ")
    let s3 = "1 hello world   "
    XCTAssertTrue(s3.decapitalizedFirstCharacter() == s3)
    let s4 = "🇮🇹 hello world   "
    XCTAssertTrue(s4.decapitalizedFirstCharacter() == s4)
    let s5 = "🇮🇹🇮🇹 hello world   "
    XCTAssertTrue(s5.decapitalizedFirstCharacter() == s5)
    let s6 = "hello world   "
    XCTAssertTrue(s6.decapitalizedFirstCharacter() == s6)
    let s7 = "\na"
    XCTAssertTrue(s7.decapitalizedFirstCharacter() == s7)
    let s8 = ""
    XCTAssertTrue(s8.decapitalizedFirstCharacter() == s8)
    let s9 = "H e l l o w o r l d"
    XCTAssertTrue(s9.decapitalizedFirstCharacter() == "h e l l o w o r l d")
    let s10 = "\u{200B}hello\u{200B}"
    XCTAssertTrue(s10.decapitalizedFirstCharacter() == s10)
  }

  #if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)

  @available(iOS 9.0, macOS 10.11, tvOS 9.0, watchOS 2.0, *)
  func testRemovingAccentsOrDiacritics() {
    XCTAssertTrue("äöüÄÖÜ".removingAccentsOrDiacritics() == "aouAOU")
    XCTAssertTrue("1".removingAccentsOrDiacritics() == "1")
    XCTAssertTrue("🇮🇹".removingAccentsOrDiacritics() == "🇮🇹")
    XCTAssertTrue("Hello World!".removingAccentsOrDiacritics() == "Hello World!")
    XCTAssertTrue("è".removingAccentsOrDiacritics() == "e")
  }

  #endif

  func testRemovingCharacters() {
    do {
      let s = "123Hello45 !World..5"
      let result1 = s.removingCharacters(in: CharacterSet.letters.inverted)
      XCTAssertTrue(result1 == "HelloWorld")
      let result2 = s.removingCharacters(in: .letters)
      XCTAssertTrue(result2 == "12345 !..5")
      /// CharacterSet.capitalizedLetters returns a character set containing the characters in Unicode General Category Lt aka "Letter, titlecase".
      /// That are "Ligatures containing uppercase followed by lowercase letters (e.g., ǅ, ǈ, ǋ, and ǲ)"
      let result4 = s.removingCharacters(in: .capitalizedLetters)
      XCTAssertTrue(result4 == "123Hello45 !World..5")
    }

    do {
      let s = "H ello"
      let result1 = s.removingCharacters(in: CharacterSet.letters.inverted)
      XCTAssertTrue(result1 == "Hello")
      let result2 = s.removingCharacters(in: .decimalDigits)
      XCTAssertTrue(s == result2)
    }

  }

  func testURLEscaped() {
    XCTAssertTrue("Hello_World".urlEscaped == "Hello_World")
    XCTAssertTrue("Hello Günter".urlEscaped == "Hello%20G%C3%BCnter")
  }

  // MARK: - Case Operators

  func testCamelCased() {
    XCTAssertEqual("Hello World".camelCased(), "helloWorld")
    XCTAssertEqual("  Hello World".camelCased(), "helloWorld")
    XCTAssertEqual("HelloWorld".camelCased(), "helloWorld")
    XCTAssertEqual("-Hello_World-".camelCased(), "helloWorld")
    XCTAssertEqual("-Hello_ World-".camelCased(), "helloWorld")
    XCTAssertEqual("Hell0W0rld".camelCased(), "hell0W0rld")
    XCTAssertEqual("helloWorld".camelCased(), "helloWorld")
  }

  func testKebabCased() {
    XCTAssertEqual("Hello World".kebabCased(), "-hello-world-")
    XCTAssertEqual("Hello_World".kebabCased(), "-hello-world-")
    XCTAssertEqual("_Hello_World".kebabCased(), "-hello-world-")
    XCTAssertEqual("_Hello_  World".kebabCased(), "-hello-world-")
    XCTAssertEqual("-HeLL0_W0rld-".kebabCased(), "-hell0-w0rld-")
    XCTAssertEqual("HelloWorld".kebabCased(), "-helloworld-")
    XCTAssertEqual("     HelloWorld".kebabCased(), "-helloworld-")
  }

  func testPascalCased() {
    XCTAssertEqual("Hello World".pascalCased(), "HelloWorld")
    XCTAssertEqual("HelloWorld".pascalCased(), "HelloWorld")
    XCTAssertEqual("HelloWorld ".pascalCased(), "HelloWorld")
    XCTAssertEqual("-Hello_World-".pascalCased(), "HelloWorld")
    XCTAssertEqual("-Hello_ World-".pascalCased(), "HelloWorld")
    XCTAssertEqual("Hell0W0rld".pascalCased(), "Hell0W0rld")
  }

  func testSlugCased() {
    XCTAssertEqual("Hello World".slugCased(), "hello-world")
    XCTAssertEqual("Hello_World".slugCased(), "hello-world")
    XCTAssertEqual("Hello-World".slugCased(), "hello-world")
    XCTAssertEqual("Hello- World".slugCased(), "hello-world")
    XCTAssertEqual("-Hello- World".slugCased(), "hello-world")
    XCTAssertEqual("HeLL0 W0rld".slugCased(), "hell0-w0rld")
    XCTAssertEqual("HelloWorld".slugCased(), "helloworld")
  }

  func testSnakeCased() {
    XCTAssertEqual("Hello World".snakeCased(), "Hello_World")
    XCTAssertEqual("hello world".snakeCased(), "hello_world")
    XCTAssertEqual("hello_world".snakeCased(), "hello_world")
    XCTAssertEqual("hello__world".snakeCased(), "hello_world")
    XCTAssertEqual("hello__ world".snakeCased(), "hello_world")
    XCTAssertEqual(" hello_world".snakeCased(), "hello_world")
    XCTAssertEqual("Hell0W0rld".snakeCased(), "Hell0W0rld")
    XCTAssertEqual("HelloWorld".snakeCased(), "HelloWorld")
  }

  func testSwapCased() {
    XCTAssertEqual("Hello World".swapCased(), "hELLO wORLD")
    XCTAssertEqual("hELLO wORLD".swapCased(), "Hello World")
    XCTAssertEqual("HelloWorld".swapCased(), "hELLOwORLD")
    XCTAssertEqual("-Hello_World-".swapCased(), "-hELLO_wORLD-")
    XCTAssertEqual("Hell0W0rld".swapCased(), "hELL0w0RLD")
  }

  func testNSRange() {
    let string = "Hello World 👩🏽‍🌾👨🏼‍🚒💃🏾"
    let range = string.startIndex...

    XCTAssert(string.nsRange.length == string[range].utf16.count)

  }

  func testContainsCaseSensitive() {
    XCTAssertTrue("AaBbCc".contains("a", caseSensitive: true))
    XCTAssertTrue("AaBbCc".contains("Aa", caseSensitive: true))

    XCTAssertFalse("AaBbCc".contains("aa", caseSensitive: true)) //case sensitive
    XCTAssertTrue("AaBbCc".contains("aa", caseSensitive: false)) //case insensitive
    XCTAssertTrue("AaBbCc".contains("Aa", caseSensitive: true)) //case sensitive
    XCTAssertFalse("AaBbCc".contains("aa", caseSensitive: true)) //case sensitive

    XCTAssertFalse("HELLO world".contains("hello", caseSensitive: true)) //case sensitive
    XCTAssertTrue("HELLO world".contains("hello", caseSensitive: false)) //case insensitive
    XCTAssertFalse("HELLO world".contains("abc", caseSensitive: false)) //case insensitive

    XCTAssertTrue("AaB🤔bCc".contains("🤔", caseSensitive: true))
    XCTAssertFalse("AaB🤔bCc".contains("🤔🤔", caseSensitive: true))
    XCTAssertTrue("Italy 🇮🇹\u{200B}🇮🇹\u{200B}🇮🇹".contains("ta", caseSensitive: true))
    XCTAssertTrue("Italy 🇮🇹\u{200B}🇮🇹\u{200B}🇮🇹".contains("\u{200B}", caseSensitive: true))
    XCTAssertTrue("Italy 🇮🇹\u{200B}🇮🇹\u{200B}🇮🇹".contains("🇮🇹", caseSensitive: true))
    XCTAssertTrue("Italy 🇮🇹\u{200B}🇮🇹\u{200B}🇮🇹".contains("🇮🇹", caseSensitive: false))
    XCTAssertFalse("Italy 🇮🇹\u{200B}🇮🇹\u{200B}🇮🇹".contains("{20", caseSensitive: true))
  }

  func testSubscript() {
    let string = "∆Test😗🇮🇹"

    // NSRange

    let nsrange = NSRange(location: 0, length: 1)
    XCTAssertTrue(string[nsrange] == "∆")

    let nsrange2 = NSRange(location: 4, length: 2)
    XCTAssertTrue(string[nsrange2] == "t😗")

    let nsrange3 = NSRange(location: 40, length: 2)
    XCTAssertNil(string[nsrange3])

    let nsrange4 = NSRange(location: -1, length: 2)
    XCTAssertNil(string[nsrange4])

    let nsrange5 = NSRange(location: 1, length: 1)
    XCTAssertTrue(string[nsrange5] == "T")

    let nsrange6 = NSRange(location: 2, length: 1)
    XCTAssertTrue(string[nsrange6] == "e")

    let nsrange7 = NSRange(location: 6, length: 1)
    XCTAssertTrue(string[nsrange7] == "🇮🇹")

    XCTAssertNil(string[""])
    let range2 = string["∆"]
    XCTAssertTrue(range2! == string.startIndex ..< string.index(string.startIndex, offsetBy: 1))
    let range3 = string["est"] //2,3,4
    XCTAssert(range3! ~= string.index(string.startIndex, offsetBy: 2) ..< string.index(string.startIndex, offsetBy: 5))
    XCTAssertNil(string["k"])
    XCTAssertNil(string["123est"])


    // Substring
    XCTAssertNotNil(string["Test"])
    XCTAssertNotNil(string["😗"])

  }

  func testReplacingCharacters() {

    let s = "Hello World" //10 characters
    do {
      let countableRange = CountableRange(uncheckedBounds: (lower: 0, upper: 2)) //[0,2[
      let newString = s.replacingCharacters(in: countableRange, with: "1")
      XCTAssertTrue(newString == "1llo World")

      let countableClosedRange = CountableClosedRange(uncheckedBounds: (lower: 0, upper: 2)) //[0,2]
      let newString2 = s.replacingCharacters(in: countableClosedRange, with: "1")
      XCTAssertTrue(newString2 == "1lo World")
    }
    do {
      let countableRange = CountableRange(uncheckedBounds: (lower: 0, upper: 11)) //[0,11[
      let newString = s.replacingCharacters(in: countableRange, with: "1")
      XCTAssertTrue(newString == "1")

      let countableClosedRange = CountableClosedRange(uncheckedBounds: (lower: 0, upper: s.count-1)) //[0,9]
      let newString2 = s.replacingCharacters(in: countableClosedRange, with: "1")
      XCTAssertTrue(newString2 == "1")
    }
  }

  func testRandom() {

    do {
      let randomString = String.random()
      XCTAssertTrue(randomString.length == 8)
      XCTAssertTrue(randomString.isAlphaNumeric)
    }

    do {
      let randomString = String.random(length: 1)
      XCTAssertTrue(randomString.length == 1)
      XCTAssertTrue(randomString.isAlphaNumeric)
    }

    do {
      let randomString = String.random(length: 100)
      XCTAssertTrue(randomString.length == 100)
      XCTAssertTrue(randomString.isAlphaNumeric)
    }

    do {
      let randomString = String.random(length: 1, characters: "a")
      XCTAssertEqual(randomString.length, 1)
      XCTAssertTrue(randomString.isAlphaNumeric)
      XCTAssertEqual(randomString, "a")
    }

    do {
      let randomString = String.random(length: 3, characters: "aaaaa")
      XCTAssertEqual(randomString.length, 3)
      XCTAssertTrue(randomString.isAlphaNumeric)
      XCTAssertEqual(randomString, "aaa")
    }

    do {
      let randomString = String.random(length: 1, characters: "a0bc123")
      XCTAssertEqual(randomString.length, 1)
      XCTAssertTrue(randomString.isAlphaNumeric)
      XCTAssertTrue("a0bc123".contains(randomString, caseSensitive: false))
    }

    do {
      let randomString = String.random(length: 1000, characters: "a0bc?123")
      XCTAssertEqual(randomString.length, 1000)
    }

    do {
      let randomString = String.random(length: 1000, characters: "")
      XCTAssertEqual(randomString.length, 0)
      XCTAssertEqual(randomString, "")
    }

  }

  func testRandomWithRangelength() {
    do {
      let range = UInt32(1)...UInt32(2)
      let randomString = String.random(length: range, characters: "a")
      XCTAssertTrue(randomString.length == 1 || randomString.length == 2)
      XCTAssertTrue(randomString.isAlphaNumeric)
      XCTAssertTrue(randomString == "a" || randomString == "aa")
    }

    do {
      let range = UInt32(1)...UInt32(1)
      let randomString = String.random(length: range, characters: "ab")
      XCTAssertTrue(randomString.length == 1)
      XCTAssertTrue(randomString.isAlphaNumeric)
      XCTAssertTrue(randomString == "a" || randomString == "b")
    }

    do {
      let range = UInt32(1)...UInt32(1000)
      let randomString = String.random(length: range)
      XCTAssertTrue(randomString.length >= 1 && randomString.length <= 1000)
      XCTAssertTrue(randomString.isAlphaNumeric)
    }

    do {
      let range = UInt32(1)...UInt32(100)
      let randomString = String.random(length: range, characters: "")
      XCTAssertTrue(randomString.length == 0)
      XCTAssertTrue(randomString == "")
    }

  }

}

// MARK: - Fixtures

fileprivate extension String {

  // MARK: - Regular Expression Commons Patterns

  /// **Mechanica**
  ///
  /// Common Regular Expression Patterns
  fileprivate enum Pattern {

    /// **Mechanica**
    ///
    /// Pattern matches email addresses.
    fileprivate static let email = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"

    /// **Mechanica**
    ///
    /// Pattern matches first alphanumeric character of each word.
    fileprivate static let firstAlphaNumericCharacter = "(\\b\\w|(?<=_)[^_])"

    /// **Mechanica**
    ///
    /// Pattern matches last alphanumeric character of each word.
    fileprivate static let lastAlphaNumericCharacter = "(\\w\\b|[^_](?=_))"

    /// **Mechanica**
    ///
    /// Pattern matches non-Alphanumeric characters.
    fileprivate static let nonAlphanumeric = "[^a-zA-Z\\d]"

    /// **Mechanica**
    ///
    /// Pattern matches non-Alphanumeric and non-Whitespace characters.
    fileprivate static let nonAlphanumericSpace = "[^a-zA-Z\\d\\s]"

  }

}
