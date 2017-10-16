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

class StringValidationTests: XCTestCase {
  
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
  
  func testIsHomogeneous() {
    XCTAssertTrue("~~~".isHomogeneous)
    XCTAssertTrue("aaa".isHomogeneous)
    XCTAssertTrue("🤔🤔".isHomogeneous)
    XCTAssertTrue("🤓".isHomogeneous)
    XCTAssertTrue("".isHomogeneous)
    XCTAssertTrue(" ".isHomogeneous)
    
    XCTAssertFalse("AAa".isHomogeneous)
    XCTAssertFalse("as".isHomogeneous)
    XCTAssertFalse("aba".isHomogeneous)
    XCTAssertFalse(" ~~~".isHomogeneous)
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
  
  func testIsLowercased() {
    XCTAssertTrue("123".isLowercased)
    XCTAssertTrue("abcd123".isLowercased)
    XCTAssertTrue("123!?)".isLowercased)
    
    XCTAssertFalse("12A3".isLowercased)
    XCTAssertFalse("abcdE123".isLowercased)
    XCTAssertFalse("123!C?)".isLowercased)
  }
  
  func testIsUppercased() {
    XCTAssertTrue("123".isUppercased)
    XCTAssertTrue("ABC123".isUppercased)
    XCTAssertTrue("ABC...!?".isUppercased)
    
    XCTAssertFalse("abcdE123".isLowercased)
    XCTAssertFalse("123A!?)".isLowercased)
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
  
}
