//
//  StringValidationTests.swift
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

import XCTest
@testable import Mechanica

class StringValidationTests: XCTestCase {

  func test_hasLetters() {
    XCTAssertTrue("a".hasLetters)
    XCTAssertTrue("11f5644+fadsdsf4".hasLetters)
    XCTAssertTrue("|!\"è£$%&)".hasLetters)

    XCTAssertFalse("|!\"£$%&)".hasLetters)
    XCTAssertFalse("@".hasLetters)
    XCTAssertFalse("11111".hasLetters)
    XCTAssertFalse("1,1".hasLetters)
    XCTAssertFalse("0.1".hasLetters)
  }

  func test_hasNumbers() {
    XCTAssertTrue("a1".hasNumbers)
    XCTAssertTrue(".ò@dasg9n".hasNumbers)
    XCTAssertFalse("|!\"£$%&)".hasNumbers)
    XCTAssertFalse("@".hasNumbers)
    XCTAssertFalse("abcdef".hasNumbers)
  }

  func test_isBlank() {
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

  func test_isHomogeneous() {
    XCTAssertTrue("~~~".isHomogeneous)
    XCTAssertTrue("aaa".isHomogeneous)
    XCTAssertTrue("🤔🤔".isHomogeneous)
    XCTAssertTrue("🤓".isHomogeneous)
    XCTAssertTrue("".isHomogeneous)

    XCTAssertFalse("AAa".isHomogeneous)
    XCTAssertFalse("as".isHomogeneous)
    XCTAssertFalse("aba".isHomogeneous)
    XCTAssertFalse(" ~~~".isHomogeneous)
  }

  func test_isAlphabetic() {
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

  func test_isAlphaNumeric() {
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

  func test_isNumeric() {
    XCTAssertTrue("123".isNumeric)
    XCTAssertTrue("0001".isNumeric)
    XCTAssertTrue("0000000000000000000000".isNumeric)

    XCTAssertFalse("000000000000000000000O".isNumeric)
    XCTAssertFalse("123,123".isNumeric)
    XCTAssertFalse("123.123".isNumeric)
    XCTAssertFalse("abc".isNumeric)
    XCTAssertFalse("abc1".isNumeric)
  }

  func test_isLowercased() {
    XCTAssertTrue("123".isLowercased)
    XCTAssertTrue("abcd123".isLowercased)
    XCTAssertTrue("123!?)".isLowercased)

    XCTAssertFalse("12A3".isLowercased)
    XCTAssertFalse("abcdE123".isLowercased)
    XCTAssertFalse("123!C?)".isLowercased)
  }

  func test_isUppercased() {
    XCTAssertTrue("123".isUppercased)
    XCTAssertTrue("ABC123".isUppercased)
    XCTAssertTrue("ABC...!?".isUppercased)

    XCTAssertFalse("abcdE123".isLowercased)
    XCTAssertFalse("123A!?)".isLowercased)
  }

  func test_isValideEmail() {
    //valid emails
    XCTAssertTrue("test@tinrobots.org".isValidEmail)
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

}
