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

extension StringUtilsTests {
  static var allTests = [
    ("testInitStaticString", testInitStaticString),
    ("testLength", testLength),
    ("testReverse", testReverse),
    ("testFirst", testFirst),
    ("testLast", testLast),
    ("testTruncate", testTruncate),
    ("testSplit", testSplit),
    ("testSubscript", testSubscript),
    ("testSubscriptWithRange", testSubscriptWithCountableRange),
    ("testSubscriptWithClosedRange", testSubscriptWithCountableClosedRange),
    ("testSubscriptWithPartialRangeUpTo", testSubscriptWithPartialRangeUpTo),
    ("testSubscriptWithPartialRangeThrough", testSubscriptWithPartialRangeThrough),
    ("testSubscriptWithCountablePartialRangeFrom", testSubscriptWithCountablePartialRangeFrom),
    ("testIsHomogeneous", testIsHomogeneous),
    ("testIsLowercased", testIsLowercased),
    ("testIsUppercased", testIsUppercased),
    ("testMultiply", testMultiply),
    ("testOptionalStringCoalescingOperator", testOptionalStringCoalescingOperator)
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

    #if !os(Linux)
      // Not implemented on Linux: https://bugs.swift.org/browse/SR-6076
      XCTAssertTrue("👍🏻".length == 1) //2
      XCTAssertTrue("👍🏽".length == 1) //2
      XCTAssertTrue("👨‍👨‍👧‍👦".length == 1) //4
    #endif
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

    #if !os(Linux)
      // Not implemented on Linux: https://bugs.swift.org/browse/SR-6076
      XCTAssertTrue(s4.truncate(at: 5) == "a🇮🇹bb🇮🇹…")
      XCTAssertTrue(s4.truncate(at: 6) == "a🇮🇹bb🇮🇹🇮🇹…")
    #endif

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

    #if !os(Linux)
      // Not implemented on Linux: https://bugs.swift.org/browse/SR-6076
      XCTAssertTrue(s8.truncate(at: 2) == "👍👍🏻…")
      XCTAssertTrue(s8.truncate(at: 3) == "👍👍🏻👍🏼…")
      XCTAssertTrue(s8.truncate(at: 4) == "👍👍🏻👍🏼👍🏾")
      XCTAssertTrue(s8.truncate(at: 5) == "👍👍🏻👍🏼👍🏾")
    #endif

    //flags sperated by a ZERO WIDTH SPACE
    let s9 = "🇮🇹\u{200B}🇮🇹\u{200B}🇮🇹"
    XCTAssertTrue(s9.truncate(at: 1) == "🇮🇹…")
    XCTAssertTrue(s9.truncate(at: 2) == "🇮🇹​…")
    XCTAssertTrue(s9.truncate(at: 3) == "🇮🇹​🇮🇹…")
    XCTAssertTrue(s9.truncate(at: 4) == "🇮🇹​🇮🇹​…")
    XCTAssertTrue(s9.truncate(at: 5) == "🇮🇹​🇮🇹​🇮🇹")
  }

  func testSplit() {
    let string = "∆Test😗🇮🇹"
    XCTAssertTrue(string.split(by: 0).isEmpty)
    XCTAssertEqual(string.split(by: 1), ["∆", "T", "e", "s", "t", "😗", "🇮🇹"])
    XCTAssertEqual(string.split(by: 3), ["∆Te", "st😗", "🇮🇹"])
    XCTAssertEqual(string.split(by: 100), [string])
    XCTAssertEqual("There are fourty-eight characters in this string".split(by: 20), ["There are fourty-eig", "ht characters in thi","s string"])
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

