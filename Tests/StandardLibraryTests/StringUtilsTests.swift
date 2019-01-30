//
// Mechanica
//
// Copyright © 2016-2019 Tinrobots.
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

extension StringUtilsTests {
  static var allTests = [
    ("testInitStaticString", testInitStaticString),
    ("testLength", testLength),
    ("testReverse", testReverse),
    ("testFirst", testFirst),
    ("testLast", testLast),
    ("testTruncate", testTruncate),
    ("testPad", testPad),
    ("testPadEnd", testPadEnd),
    ("testPadding", testPadding),
    ("testPaddingEnd", testPaddingEnd),
    ("testPaddingStart", testPaddingStart),
    ("testPadStart", testPadStart),
    ("testSubscript", testSubscript),
    ("testSubscriptWithRange", testSubscriptWithCountableRange),
    ("testSubscriptWithClosedRange", testSubscriptWithCountableClosedRange),
    ("testSubscriptWithPartialRangeUpTo", testSubscriptWithPartialRangeUpTo),
    ("testSubscriptWithPartialRangeThrough", testSubscriptWithPartialRangeThrough),
    ("testSubscriptWithCountablePartialRangeFrom", testSubscriptWithCountablePartialRangeFrom),
    ("testIsHomogeneous", testIsHomogeneous),
    ("testIsLowercase", testIsLowercase),
    ("testIsUppercase", testIsUppercase),
    ("testMultiply", testMultiply),
    ("testOptionalStringCoalescingOperator", testOptionalStringCoalescingOperator),
    ("testPrefix", testPrefix),
    ("testSuffix", testSuffix),
    ("testdroppingPrefix", testdroppingPrefix),
    ("testdroppingSuffix", testdroppingSuffix)
  ]
}

final class StringUtilsTests: XCTestCase {

  func testInitStaticString() {
    do {
      let ss: StaticString = "🇮🇹🧐"
      XCTAssertEqual(String(staticString: ss), "🇮🇹🧐")
    }
    do {
      let ss: StaticString = ""
      XCTAssertEqual(String(staticString: ss), "")
    }
    do {
      let ss: StaticString = "123qwert#!!%@%d"
      XCTAssertEqual(String(staticString: ss), "123qwert#!!%@%d")
    }
  }

  func testLength() {
    XCTAssertTrue("".length == 0)
    XCTAssertTrue(" ".length == 1)
    XCTAssertTrue("cafe".length == 4)
    XCTAssertTrue("cafè".length == 4)
    XCTAssertTrue("🇮🇹".length == 1)
    XCTAssertTrue("👍🏻".length == 1)
    XCTAssertTrue("👍🏽".length == 1)
    XCTAssertTrue("👨‍👨‍👧‍👦".length == 1)
  }

  func testPrefix() {
    do {
      let s = "Hello World 🖖🏽"
      XCTAssertTrue(s.prefix(maxLength: 0) == "")
      XCTAssertTrue(s.prefix(maxLength: 1) == "H")
      XCTAssertTrue(s.prefix(maxLength: 2) == "He")
      XCTAssertTrue(s.prefix(maxLength: 3) == "Hel")
      XCTAssertTrue(s.prefix(maxLength: 4) == "Hell")
      XCTAssertTrue(s.prefix(maxLength: 5) == "Hello")
      XCTAssertTrue(s.prefix(maxLength: 6) == "Hello ")
      XCTAssertTrue(s.prefix(maxLength: 13) == "Hello World 🖖🏽")
      XCTAssertTrue(s.prefix(maxLength: 14) == "Hello World 🖖🏽")
      XCTAssertTrue(s.prefix(maxLength: 100) == "Hello World 🖖🏽")
    }

    do {
      let s = "Hello World ★"
      XCTAssertTrue(s.prefix(maxLength: 13) == "Hello World ★")
      XCTAssertTrue(s.prefix(maxLength: 14) == "Hello World ★")
      XCTAssertTrue(s.prefix(maxLength: 100) == "Hello World ★")

    }
  }

  func testSuffix() {
    do {
      let s = "Hello World 🖖🏽"
      XCTAssertTrue(s.suffix(maxLength: 0) == "")
      XCTAssertTrue(s.suffix(maxLength: 1) == "🖖🏽")
      XCTAssertTrue(s.suffix(maxLength: 2) == " 🖖🏽")
      XCTAssertTrue(s.suffix(maxLength: 3) == "d 🖖🏽")
      XCTAssertTrue(s.suffix(maxLength: 4) == "ld 🖖🏽")
      XCTAssertTrue(s.suffix(maxLength: 5) == "rld 🖖🏽")
      XCTAssertTrue(s.suffix(maxLength: 13) == "Hello World 🖖🏽")
      XCTAssertTrue(s.suffix(maxLength: 100) == "Hello World 🖖🏽")
    }

    do {
      let s = "Hello World ★"
      XCTAssertTrue(s.suffix(maxLength: 0) == "")
      XCTAssertTrue(s.suffix(maxLength: 1) == "★")
      XCTAssertTrue(s.suffix(maxLength: 2) == " ★")
      XCTAssertTrue(s.suffix(maxLength: 3) == "d ★")
      XCTAssertTrue(s.suffix(maxLength: 4) == "ld ★")
      XCTAssertTrue(s.suffix(maxLength: 5) == "rld ★")
      XCTAssertTrue(s.suffix(maxLength: 13) == "Hello World ★")
      XCTAssertTrue(s.suffix(maxLength: 100) == "Hello World ★")
    }
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

  func testPaddingStart() {
    XCTAssertEqual("Hello World".paddingStart(length: 15), "    Hello World")
    XCTAssertEqual("Hello World".paddingStart(length: 15, with: "*"), "****Hello World")

    XCTAssertEqual("Tin".paddingStart(length: 0), "Tin")
    XCTAssertEqual("Tin".paddingStart(length: 1), "Tin")
    XCTAssertEqual("Tin".paddingStart(length: 2), "Tin")
    XCTAssertEqual("Tin".paddingStart(length: 3), "Tin")
    XCTAssertEqual("Tin".paddingStart(length: 4), " Tin")

    XCTAssertEqual("Tin Robots!".paddingStart(length: 15), "    Tin Robots!")
    XCTAssertEqual("-Tin_Robots!-".paddingStart(length: 15), "  -Tin_Robots!-")
    XCTAssertEqual(" _T1n R0bots!_ ".paddingStart(length: 20), "      _T1n R0bots!_ ")
    XCTAssertEqual("Tin Robots!".paddingStart(length: 5), "Tin Robots!")

    XCTAssertEqual("Tin Robots!".paddingStart(length: 15, with: "*"), "****Tin Robots!")
    XCTAssertEqual("-Tin_Robots!-".paddingStart(length: 15, with: "*"), "**-Tin_Robots!-")
    XCTAssertEqual(" _T1n R0bots!_ ".paddingStart(length: 20, with: "*"), "***** _T1n R0bots!_ ")
    XCTAssertEqual("Tin Robots!".paddingStart(length: 5, with: "*"), "Tin Robots!")

    XCTAssertEqual("abcde".paddingStart(length: 6, with: "123"), "1abcde")
    XCTAssertEqual("abcd".paddingStart(length: 6, with: "123"), "12abcd")
    XCTAssertEqual("abc".paddingStart(length: 6, with: "123"), "123abc")
    XCTAssertEqual("ab".paddingStart(length: 6, with: "123"), "1231ab")
    XCTAssertEqual("a".paddingStart(length: 6, with: "123"), "12312a")
  }

  func testPadStart() {
    do {
      var string = "Tin"
      string.padStart(length: 1)
      XCTAssertEqual(string, "Tin")
    }

    do {
      var string = "Tin"
      string.padStart(length: 2)
      XCTAssertEqual(string, "Tin")
    }

    do {
      var string = "Tin"
      string.padStart(length: 3)
      XCTAssertEqual(string, "Tin")
    }

    do {
      var string = "Tin"
      string.padStart(length: 4)
      XCTAssertEqual(string, " Tin")
    }

    do {
      var string = "Tin Robots!"
      string.padStart(length: 15)
      XCTAssertEqual(string, "    Tin Robots!")
    }

    do {
      var string = "Tin Robots!"
      string.padStart(length: 15, with: "*")
      XCTAssertEqual(string, "****Tin Robots!")
    }

    do {
      var string = " _T1n R0bots!_ "
      string.padStart(length: 20, with: "*")
      XCTAssertEqual(string, "***** _T1n R0bots!_ ")
    }

    do {
      var string = "a"
      string.padStart(length: 6, with: "123")
      XCTAssertEqual(string, "12312a")
    }
  }

  func testPaddingEnd() {
    XCTAssertEqual("Hello World".paddingEnd(length: 15), "Hello World    ")
    XCTAssertEqual("Hello World".paddingEnd(length: 15, with: "*"), "Hello World****")

    XCTAssertEqual("Tin".paddingEnd(length: 0), "Tin")
    XCTAssertEqual("Tin".paddingEnd(length: 1), "Tin")
    XCTAssertEqual("Tin".paddingEnd(length: 2), "Tin")
    XCTAssertEqual("Tin".paddingEnd(length: 3), "Tin")
    XCTAssertEqual("Tin".paddingEnd(length: 4), "Tin ")

    XCTAssertEqual("Tin Robots!".paddingEnd(length: 15), "Tin Robots!    ")
    XCTAssertEqual("-Tin_Robots!-".paddingEnd(length: 15), "-Tin_Robots!-  ")
    XCTAssertEqual(" _T1n R0bots!_ ".paddingEnd(length: 20), " _T1n R0bots!_      ")
    XCTAssertEqual("Tin Robots!".paddingEnd(length: 5), "Tin Robots!")

    XCTAssertEqual("Tin Robots!".paddingEnd(length: 15, with: "*"), "Tin Robots!****")
    XCTAssertEqual("-Tin_Robots!-".paddingEnd(length: 15, with: "*"), "-Tin_Robots!-**")
    XCTAssertEqual(" _T1n R0bots!_ ".paddingEnd(length: 20, with: "*"), " _T1n R0bots!_ *****")
    XCTAssertEqual("Tin Robots!".paddingEnd(length: 5, with: "*"), "Tin Robots!")

    XCTAssertEqual("abcde".paddingEnd(length: 6, with: "123"), "abcde1")
    XCTAssertEqual("abcd".paddingEnd(length: 6, with: "123"), "abcd12")
    XCTAssertEqual("abc".paddingEnd(length: 6, with: "123"), "abc123")
    XCTAssertEqual("ab".paddingEnd(length: 6, with: "123"), "ab1231")
    XCTAssertEqual("a".paddingEnd(length: 6, with: "123"), "a12312")
  }

  func testPadEnd() {
    do {
      var string = "Tin"
      string.padEnd(length: 1)
      XCTAssertEqual(string, "Tin")
    }

    do {
      var string = "Tin"
      string.padEnd(length: 2)
      XCTAssertEqual(string, "Tin")
    }

    do {
      var string = "Tin"
      string.padEnd(length: 3)
      XCTAssertEqual(string, "Tin")
    }

    do {
      var string = "Tin"
      string.padEnd(length: 4)
      XCTAssertEqual(string, "Tin ")
    }

    do {
      var string = "Tin Robots!"
      string.padEnd(length: 15)
      XCTAssertEqual(string, "Tin Robots!    ")
    }

    do {
      var string = "Tin Robots!"
      string.padEnd(length: 15, with: "*")
      XCTAssertEqual(string, "Tin Robots!****")
    }

    do {
      var string = " _T1n R0bots!_ "
      string.padEnd(length: 20, with: "*")
      XCTAssertEqual(string, " _T1n R0bots!_ *****")
    }

    do {
      var string = "a"
      string.padEnd(length: 6, with: "123")
      XCTAssertEqual(string, "a12312")
    }
  }

  func testPadding() {
    XCTAssertEqual("Hello World".padding(length: 15), "  Hello World  ")
    XCTAssertEqual("Hello World".padding(length: 15, with: "*"), "**Hello World**")

    XCTAssertEqual("Tin".padding(length: 0), "Tin")
    XCTAssertEqual("Tin".padding(length: 1), "Tin")
    XCTAssertEqual("Tin".padding(length: 2), "Tin")
    XCTAssertEqual("Tin".padding(length: 3), "Tin")
    XCTAssertEqual("Tin".padding(length: 4), "Tin ")
    XCTAssertEqual("Tin".padding(length: 5), " Tin ")
    XCTAssertEqual("Tin".padding(length: 6), " Tin  ")
    XCTAssertEqual("Tin".padding(length: 7), "  Tin  ")

    XCTAssertEqual("Tin Robots!".padding(length: 15), "  Tin Robots!  ")
    XCTAssertEqual("-Tin_Robots!-".padding(length: 15), " -Tin_Robots!- ")
    XCTAssertEqual(" _T1n R0bots!_ ".padding(length: 20), "   _T1n R0bots!_    ")
    XCTAssertEqual("Tin Robots!".padding(length: 5), "Tin Robots!")

    XCTAssertEqual("Tin Robots!".padding(length: 15, with: "*"), "**Tin Robots!**")
    XCTAssertEqual("-Tin_Robots!-".padding(length: 15, with: "*"), "*-Tin_Robots!-*")
    XCTAssertEqual(" _T1n R0bots!_ ".padding(length: 20, with: "*"), "** _T1n R0bots!_ ***")
    XCTAssertEqual("Tin Robots!".padding(length: 5, with: "*"), "Tin Robots!")

    XCTAssertEqual("abcde".padding(length: 6, with: "123"), "abcde1")
    XCTAssertEqual("abcd".padding(length: 6, with: "123"), "1abcd1")
    XCTAssertEqual("abc".padding(length: 6, with: "123"), "1abc12")
    XCTAssertEqual("ab".padding(length: 6, with: "123"), "12ab12")
    XCTAssertEqual("a".padding(length: 6, with: "123"), "12a123")
  }

  func testPad() {
    do {
      var string = "Tin"
      string.pad(length: 1)
      XCTAssertEqual(string, "Tin")
    }

    do {
      var string = "Tin"
      string.pad(length: 2)
      XCTAssertEqual(string, "Tin")
    }

    do {
      var string = "Tin"
      string.pad(length: 3)
      XCTAssertEqual(string, "Tin")
    }

    do {
      var string = "Tin"
      string.pad(length: 4)
      XCTAssertEqual(string, "Tin ")
    }

    do {
      var string = "Tin Robots!"
      string.pad(length: 15)
      XCTAssertEqual(string, "  Tin Robots!  ")
    }

    do {
      var string = "Tin Robots!"
      string.pad(length: 15, with: "*")
      XCTAssertEqual(string, "**Tin Robots!**")
    }

    do {
      var string = " _T1n R0bots!_ "
      string.pad(length: 20, with: "*")
      XCTAssertEqual(string, "** _T1n R0bots!_ ***")
    }

    do {
      var string = "a"
      string.pad(length: 6, with: "123")
      XCTAssertEqual(string, "12a123")
    }
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
  }

  func testSubscriptWithCountableRange() {
    let string = "∆Test😗🇮🇹"

    XCTAssertEqual(string[0 ..< 0]!, "")
    XCTAssertEqual(string[0 ..< 3], "∆Te")
    XCTAssertEqual(string[3 ..< 4], "s")
    XCTAssertEqual(string[3 ..< 3], "")
    XCTAssertEqual(string[3 ..< 6], "st😗")
    XCTAssertEqual(string[0 ..< string.length], "∆Test😗🇮🇹")
    XCTAssertNil(string[string.length ..< string.length+1])
    XCTAssertEqual(string[string.length ..< string.length], "")

    XCTAssertNil(string[1 ..< 100])
    XCTAssertNil(string[-1 ..< 1])
    XCTAssertNil(string[1 ..< string.length+1])
    XCTAssertNil(string[100 ..< 200])
    XCTAssertNil(string[-1 ..< string.length])
    XCTAssertNil(string[-1 ..< 1])
    XCTAssertNil(string[string.length+10 ..< string.length+10])
  }

  func testSubscriptWithCountableClosedRange() {
    let string = "∆Test😗🇮🇹"

    XCTAssertEqual(string[0 ... 2], "∆Te")
    XCTAssertEqual(string[3 ... 3], "s")
    XCTAssertEqual(string[3 ... 5], "st😗")
    XCTAssertEqual(string[0 ... string.length-1], "∆Test😗🇮🇹")

    XCTAssertNil(string[string.length ... string.length])
    XCTAssertEqual(string[string.length ..< string.length], "")

    XCTAssertNil(string[1 ..< 100])
    XCTAssertNil(string[-1 ..< 1])
    XCTAssertNil(string[1 ..< string.length+1])
    XCTAssertNil(string[100 ..< 200])
    XCTAssertNil(string[-1 ..< string.length])
    XCTAssertNil(string[-1 ..< 1])
    XCTAssertNil(string[string.length+10 ..< string.length+10])
  }

  func testSubscriptWithPartialRangeUpTo() {
    let string = "∆Test😗🇮🇹"

    XCTAssertEqual(string[..<0], "")
    XCTAssertEqual(string[..<1], "∆")
    XCTAssertEqual(string[..<7], "∆Test😗🇮🇹")

    XCTAssertNil(string[..<100])
    XCTAssertNil(string[..<(-1)])
  }

  func testSubscriptWithPartialRangeThrough() {
    let string = "∆Test😗🇮🇹"

    XCTAssertEqual(string[...0], "∆")
    XCTAssertEqual(string[...1], "∆T")
    XCTAssertEqual(string[...6], "∆Test😗🇮🇹")

    XCTAssertNil(string[...7])
    XCTAssertNil(string[...100])
    XCTAssertNil(string[...(-1)])
  }

  func testSubscriptWithCountablePartialRangeFrom() {
    let string = "∆Test😗🇮🇹"

    XCTAssertEqual(string[0...], "∆Test😗🇮🇹")
    XCTAssertEqual(string[5...], "😗🇮🇹")

    XCTAssertNil(string[(-1)...])
    XCTAssertNil(string[7...])
    XCTAssertNil(string[100...])
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

  func testIsLowercase() {
    XCTAssertTrue("123".isLowercase)
    XCTAssertTrue("abcd123".isLowercase)
    XCTAssertTrue("123!?)".isLowercase)

    XCTAssertFalse("12A3".isLowercase)
    XCTAssertFalse("abcdE123".isLowercase)
    XCTAssertFalse("123!C?)".isLowercase)
  }

  func testIsUppercase() {
    XCTAssertTrue("123".isUppercase)
    XCTAssertTrue("ABC123".isUppercase)
    XCTAssertTrue("ABC...!?".isUppercase)

    XCTAssertFalse("abcdE123".isLowercase)
    XCTAssertFalse("123A!?)".isLowercase)
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

  //#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)

  func testdroppingPrefix() {

    let s = "hello"
    XCTAssertTrue(s.droppingPrefix(upToPosition: 0) == "hello")
    XCTAssertTrue(s.droppingPrefix() == "ello")
    XCTAssertTrue(s.droppingPrefix(upToPosition: 1) == "ello")
    XCTAssertTrue(s.droppingPrefix(upToPosition: 3) == "lo")
    XCTAssertTrue(s.droppingPrefix(upToPosition: 5) == "")
    XCTAssertTrue(s.droppingPrefix(upToPosition: 100) == "")
    XCTAssertTrue(s.droppingPrefix(upToPosition: -1) == "")
    XCTAssertTrue("".droppingPrefix(upToPosition: 1) == "")
    XCTAssertTrue(s.droppingPrefix("") == "hello")
    XCTAssertTrue(s.droppingPrefix("h") == "ello")
    XCTAssertTrue(s.droppingPrefix("hel") == "lo")
    XCTAssertTrue(s.droppingPrefix("abc") == "hello")
    XCTAssertTrue(s.droppingPrefix("\n") == "hello")
    XCTAssertTrue("\na".droppingPrefix("\n") == "a")
  }

  func testdroppingSuffix() {

    let s = "hello"
    XCTAssertTrue(s.droppingSuffix(fromPosition: 0) == "hello")
    XCTAssertTrue(s.droppingSuffix() == "hell")
    XCTAssertTrue(s.droppingSuffix(fromPosition: 1) == "hell")
    XCTAssertTrue(s.droppingSuffix(fromPosition: 3) == "he")
    XCTAssertTrue(s.droppingSuffix(fromPosition: 5) == "")
    XCTAssertTrue(s.droppingSuffix(fromPosition: 100) == "")
    XCTAssertTrue(s.droppingSuffix(fromPosition: -1) == "")
    XCTAssertTrue("".droppingSuffix(fromPosition: 1) == "")
    XCTAssertTrue(s.droppingSuffix("abc") == "hello")
    XCTAssertTrue(s.droppingSuffix("o") == "hell")
    XCTAssertTrue(s.droppingSuffix("llo") == "he")
    XCTAssertTrue(s.droppingSuffix("hello") == "")
    XCTAssertTrue("\na".droppingSuffix("a") == "\n")

  }

  //#endif

}

