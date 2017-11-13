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

import XCTest
@testable import Mechanica

class StringNSStringTests: XCTestCase {

  func testToBool() {
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

  func testToBase64Decoded() {
    XCTAssertNil("123".base64Decoded, "Couldn't get the correct Base64 decoded value.")
    XCTAssert("SGVsbG8gV29ybGQh".base64Decoded == "Hello World!", "Couldn't get the correct Base64 decoded value.")
    XCTAssert("SGVsbG8gUm9ib3RzIfCfpJbwn6SW".base64Decoded ==  "Hello Robots!🤖🤖", "Couldn't get the correct Base64 decoded value.")
  }

  func testToBase64Encoded() {
    XCTAssert("Hello World!".base64Encoded == "SGVsbG8gV29ybGQh", "Couldn't get the correct Base64 encoded value.")
    XCTAssert("Hello Robots!🤖🤖".base64Encoded == "SGVsbG8gUm9ib3RzIfCfpJbwn6SW", "Couldn't get the correct Base64 encoded value.")
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

  func testIsValideEmail() {
    //valid emails
    XCTAssertTrue("test@tinrobots.org".isValidEmail)
    XCTAssertTrue("test123@tinrobots.org".isValidEmail)
    XCTAssertTrue("123test@tinrobots.org".isValidEmail)
    XCTAssertTrue("test.test@tinrobots.org".isValidEmail)
    XCTAssertTrue("test.test.test@tinrobots.org".isValidEmail)
    XCTAssertTrue("testtesttesttesttesttesttesttesttesttesttesttesttesttesttesttest@tinrobots.org".isValidEmail)
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

  func testSemanticVersion() {

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


}

// MARK: - Tests Resources

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
