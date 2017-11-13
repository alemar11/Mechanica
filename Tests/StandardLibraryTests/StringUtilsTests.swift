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

class StringUtilsTests: XCTestCase {

  func testLength() {
    XCTAssertTrue("".length == 0)
    XCTAssertTrue(" ".length == 1)
    XCTAssertTrue("cafe".length == 4)
    XCTAssertTrue("cafè".length == 4)
    XCTAssertTrue("🇮🇹".length == 1)
    XCTAssertTrue("👍🏻".length == 1) //2
    XCTAssertTrue("👍🏽".length == 1) //2
    XCTAssertTrue("👨‍👨‍👧‍👦".length == 1) //4
  }

  func testReverse() {
    var a = "a"
    a.reverse()
    XCTAssertTrue(a == "a")
    var aa = "aa"
    aa.reverse()
    XCTAssertTrue(aa == "aa")
    var abc = "abc"
    abc.reverse()
    XCTAssertTrue(abc == "cba")
    var 🤔aa = "🤔aa"
    🤔aa.reverse()
    XCTAssertTrue(🤔aa == "aa🤔")
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

  func testFirst(){
    XCTAssertTrue("Hello".first == "H")
    XCTAssertTrue("∂Hello".first == "∂")
    XCTAssertTrue(" Hello".first == " ")
  }

  func testLast(){
    XCTAssertTrue("Hello".last == "o")
    XCTAssertTrue("Hello∂".last == "∂")
    XCTAssertTrue("Hello ".last == " ")
  }

  func testTruncate() {
    let s = "Hello World"
    XCTAssertTrue(s.truncate(at: 0) == "…")
    XCTAssertTrue(s.truncate(at: 0, withTrailing: nil) == "")
    XCTAssertTrue(s.truncate(at: 5) == "Hello…")
    XCTAssertTrue(s.truncate(at: -5) == "")
    XCTAssertTrue(s.truncate(at: 10) == "Hello Worl…")
    XCTAssertTrue(s.truncate(at: 10, withTrailing: nil) == "Hello Worl")
    XCTAssertTrue(s.truncate(at: 11) == "Hello World")
    XCTAssertTrue(s.truncate(at: 11,withTrailing: nil) == "Hello World")
    XCTAssertTrue(s.truncate(at: 100) == "Hello World")

    let s2 = "Hello 🗺"
    XCTAssertTrue(s2.truncate(at: 5) == "Hello…")
    XCTAssertTrue(s2.truncate(at: 6) == "Hello …")
    XCTAssertTrue(s2.truncate(at: 7) == "Hello 🗺")

    let s3 = "a😀bb😄😄ccc😄😬😄"
    XCTAssertTrue(s3.truncate(at: 0) == "…")
    XCTAssertTrue(s3.truncate(at: 1) == "a…")
    XCTAssertTrue(s3.truncate(at: 2) == "a😀…")
    XCTAssertTrue(s3.truncate(at: 3) == "a😀b…")
    XCTAssertTrue(s3.truncate(at: 4) == "a😀bb…")
    XCTAssertTrue(s3.truncate(at: 5) == "a😀bb😄…")
    XCTAssertTrue(s3.truncate(at: 6) == "a😀bb😄😄…")

    let s4 = "a🇮🇹bb🇮🇹🇮🇹ccc🇮🇹🇮🇹🇮🇹"
    XCTAssertTrue(s4.truncate(at: 0) == "…")
    XCTAssertTrue(s4.truncate(at: 1) == "a…")
    XCTAssertTrue(s4.truncate(at: 2) == "a🇮🇹…")
    XCTAssertTrue(s4.truncate(at: 3) == "a🇮🇹b…")
    XCTAssertTrue(s4.truncate(at: 4) == "a🇮🇹bb…")
    XCTAssertTrue(s4.truncate(at: 5) == "a🇮🇹bb🇮🇹…")
    XCTAssertTrue(s4.truncate(at: 6) == "a🇮🇹bb🇮🇹🇮🇹…")

    let s5 = "\u{2126}"
    XCTAssertTrue(s5.truncate(at: 0) == "…")
    XCTAssertTrue(s5.truncate(at: 4) == "Ω")
    XCTAssertTrue(s5.truncate(at: 100) == "Ω")

    let s6 = "cafè"
    XCTAssertTrue(s6.truncate(at: 1) == "c…")
    XCTAssertTrue(s6.truncate(at: 4) == "cafè")

    let s7 = "👍👍👍👍" // 4 characters
    XCTAssertTrue(s7.truncate(at: 1) == "👍…")
    XCTAssertTrue(s7.truncate(at: 2) == "👍👍…")
    XCTAssertTrue(s7.truncate(at: 3) == "👍👍👍…")

    let s8 = "👍👍🏻👍🏼👍🏾"
    XCTAssertTrue(s8.truncate(at: 1) == "👍…")
    XCTAssertTrue(s8.truncate(at: 2) == "👍👍🏻…")
    XCTAssertTrue(s8.truncate(at: 3) == "👍👍🏻👍🏼…")
    XCTAssertTrue(s8.truncate(at: 4) == "👍👍🏻👍🏼👍🏾")
    XCTAssertTrue(s8.truncate(at: 5) == "👍👍🏻👍🏼👍🏾")

    //flags sperated by a ZERO WIDTH SPACE
    let s9 = "🇮🇹\u{200B}🇮🇹\u{200B}🇮🇹"
    XCTAssertTrue(s9.truncate(at: 1) == "🇮🇹…")
    XCTAssertTrue(s9.truncate(at: 2) == "🇮🇹​…")
    XCTAssertTrue(s9.truncate(at: 3) == "🇮🇹​🇮🇹…")
    XCTAssertTrue(s9.truncate(at: 4) == "🇮🇹​🇮🇹​…")
    XCTAssertTrue(s9.truncate(at: 5) == "🇮🇹​🇮🇹​🇮🇹")
  }

  func testSubscript() {
    let string = "∆Test😗🇮🇹"

    XCTAssertTrue(string[0] == "∆")
    XCTAssertTrue(string[1] == "T")
    XCTAssertTrue(string[5] == "😗")
    XCTAssertTrue(string[6] == "🇮🇹")
    XCTAssertNil(string[-1])
    XCTAssertNil(string[7])
    XCTAssertNil(string[10])
    XCTAssertTrue(string[string.length - 1] == "🇮🇹")
    XCTAssertTrue(string[0..<1] == "∆")
    XCTAssertTrue(string[1..<6] == "Test😗")
    XCTAssertNotNil(string["Test"])
    XCTAssertNotNil(string["😗"])

    // MARK: - Range

    XCTAssertTrue(string[Range(0..<3)] == "∆Te")
    XCTAssertTrue(string[Range(3..<3)] == "")
    XCTAssertTrue(string[Range(3..<6)] == "st😗")
    XCTAssertTrue(string[Range(0..<string.length)] == "∆Test😗🇮🇹")
    XCTAssertNil(string[Range(string.length ..< string.length+1)])
    XCTAssertTrue(string[Range(string.length ..< string.length)] == "")

    XCTAssertNil(string[Range(1 ..< 100)])
    XCTAssertNil(string[Range(-1 ..< 1)])
    XCTAssertNil(string[Range(1 ..< string.length+1)])
    XCTAssertNil(string[Range(100 ..< 200)])
    XCTAssertNil(string[Range(-1 ..< string.length)])
    XCTAssertNil(string[Range(-1 ..< 1)])
    XCTAssertNil(string[Range(string.length+10 ..< string.length+10)])

    // MARK: - NSRange

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

  // MARK: - Operators

  func testMultiply() {
    XCTAssert("a"*2 == "aa")
    XCTAssert("aA"*2 == "aAaA")
    XCTAssert("Hello World "+"!"*2 == "Hello World !!")
    XCTAssert("🇮🇹"*3 == "🇮🇹🇮🇹🇮🇹")
    XCTAssert(2*"a" == "aa")
    XCTAssert(2*"aA" == "aAaA")
    XCTAssert(2*"Hello World "+"!" == "Hello World Hello World !")
    XCTAssert(3*"🇮🇹" == "🇮🇹🇮🇹🇮🇹")
  }

  func testOptionalStringCoalescingOperator() {
    let someValue: Int? = 10
    let stringValue = "\(someValue ??? "unknown")"
    XCTAssert(stringValue == "10")
    let someValue2: Int? = nil
    let stringValue2 = "\(someValue2 ??? "unknown")"
    XCTAssert(stringValue2 == "unknown")
  }

}

