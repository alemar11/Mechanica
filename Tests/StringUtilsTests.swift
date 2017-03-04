//
//  StringExtensionTests.swift
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

class StringUtilsTests: XCTestCase {

  func test_length() {
    XCTAssertTrue("".length == 0)
    XCTAssertTrue(" ".length == 1)
    XCTAssertTrue("cafe".length == 4)
    XCTAssertTrue("cafè".length == 4)
    XCTAssertTrue("🇮🇹".length == 1)
    XCTAssertTrue("🇮🇹🇮🇹".length == 1)
    XCTAssertTrue("🇮🇹 🇮🇹".length == 3)
    XCTAssertTrue("👍🏻".length > 1) //2
    XCTAssertTrue("👍🏽".length > 1) //2
    XCTAssertTrue("👨‍👨‍👧‍👦".length > 1) //4
  }

  func test_starts() {
    //case sensitive
    XCTAssertTrue("a".starts(with:"a"))
    XCTAssertFalse("a".starts(with:"A"))
    XCTAssertTrue("🤔a1".starts(with:"🤔"))
    XCTAssertTrue("🖖🏽a1".starts(with:"🖖🏽"))
    XCTAssertTrue("🇮🇹🇮🇹🖖🏽 ".starts(with:"🇮🇹"))

    //case insensitive
    XCTAssertTrue("🇮🇹🇮🇹🖖🏽 ".starts(with:"🇮🇹", caseSensitive: false))
    XCTAssertTrue("a".starts(with:"A", caseSensitive: false))
    XCTAssertTrue("Hello".starts(with:"hello", caseSensitive: false))
    XCTAssertFalse("Hello".starts(with:"helloo", caseSensitive: false))
  }

  func test_ends() {
    //case sensitive
    XCTAssertTrue("a".ends(with:"a"))
    XCTAssertFalse("a".ends(with:"A"))
    XCTAssertTrue("a1🤔".ends(with:"🤔"))
    XCTAssertTrue("a1🖖🏽".ends(with:"🖖🏽"))
    XCTAssertTrue(" 🖖🏽🇮🇹🇮🇹".ends(with:"🇮🇹"))

    //case insensitive
    XCTAssertTrue(" 🖖🏽🇮🇹🇮🇹".ends(with:"🇮🇹", caseSensitive: false))
    XCTAssertTrue("a".ends(with:"A", caseSensitive: false))
    XCTAssertTrue("Hello".ends(with:"hello", caseSensitive: false))
    XCTAssertFalse("Hello".ends(with:"helloo", caseSensitive: false))
  }

  func test_reverse() {
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

  func test_reversed() {
    XCTAssertTrue("a".reversed() == "a")
    XCTAssertTrue("aa".reversed() == "aa")
    XCTAssertTrue("abc".reversed() == "cba")
    XCTAssertTrue("🤔aa".reversed() == "aa🤔")
  }

  func test_contains_caseSensitive() {
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

  func test_containsCharacters() {
    XCTAssertFalse("".containsCharacters(in: .letters))
    XCTAssertTrue("AaBbCc".containsCharacters(in: .letters))
    XCTAssertFalse("A1aBbCc".containsCharacters(in: .letters))
    XCTAssertTrue("AaB bCc".containsCharacters(in: CharacterSet.letters.union(CharacterSet.whitespaces)))
    XCTAssertFalse("A1a BbCc".containsCharacters(in: .letters))
    XCTAssertTrue("123".containsCharacters(in: .decimalDigits))
  }
  
  func test_replace() {
    XCTAssertTrue("AaBbCc".replace("a", with: "Z") == "AZBbCc")
    XCTAssertTrue("AaBbCc".replace("a", with: "a") == "AaBbCc")
    XCTAssertFalse("AaBbCc".replace("a", with: "A") == "AaBbCc")
    XCTAssertTrue("AaBbCc".replace("", with: "A") == "AaBbCc")
    XCTAssertTrue("AaBbCc".replace("AaBbCc", with: "123") == "123")
    XCTAssertTrue("aaBbCa".replace("a", with: "1") == "11BbC1")

    XCTAssertTrue("AaBbCc🤔".replace("🤔", with: "🤔🤔") == "AaBbCc🤔🤔")
    XCTAssertTrue("".replace("🤔", with: "🤔🤔") == "")
    XCTAssertTrue("".replace("", with: "🤔") == "")

    XCTAssertTrue("Italy 🇮🇹\u{200B}🇮🇹\u{200B}🇮🇹".replace("\u{200B}", with: " ") == "Italy 🇮🇹 🇮🇹 🇮🇹")

    XCTAssertTrue("AaBbCc".replace("a", with: "Z", caseSensitive: false) == "ZZBbCc")
    XCTAssertTrue("AaBbCc".replace("a", with: "a", caseSensitive: false) == "aaBbCc")
    XCTAssertTrue("AaBbCc".replace("a", with: "A", caseSensitive: false) == "AABbCc")
    XCTAssertTrue("AaBbCc".replace("", with: "A", caseSensitive: false) == "AaBbCc")
  }

  func test_trim() {
    var s1 = "   Hello World   "
    s1.trim()
    XCTAssertTrue(s1 == "Hello World")
  }

  func test_trimmed() {
    let s1 = "   Hello World   "
    XCTAssertTrue(s1.trimmedLeft() == "Hello World   ")
    XCTAssertTrue(s1.trimmedRight() == "   Hello World")
    XCTAssertTrue(s1.trimmed() == "Hello World")

    let s2 = "   \u{200B} Hello World   "
    XCTAssertTrue(s2.trimmedLeft() == "Hello World   ")
    XCTAssertTrue(s2.trimmed() == "Hello World")

    let s3 = "Hello World\n\n   "
    XCTAssertTrue(s3.trimmedRight() == "Hello World")
    XCTAssertTrue(s3.trimmed() == "Hello World")


    let s4 = "abcdefg"
    XCTAssertTrue(s4.trimmedRight(characterSet: NSCharacterSet.alphanumerics) == "")
    XCTAssertTrue(s4.trimmedLeft(characterSet: NSCharacterSet.alphanumerics) == "")

    let s5 = "  abcdefg  "
    XCTAssertTrue(s5.trimmedRight(characterSet: NSCharacterSet.alphanumerics) == "  abcdefg  ")
    XCTAssertTrue(s5.trimmedLeft(characterSet: NSCharacterSet.alphanumerics) == "  abcdefg  ")
    XCTAssertTrue(s5.trimmed() == "abcdefg")
  }

  func test_capitalizedFirstCharacter() {
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
  
  func test_decapitalizedFirstCharacter() {
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

  func test_prefix() {
    let s = "Hello World 🖖🏽"
    XCTAssertTrue(s.prefix(maxLength: -100) == "")
    XCTAssertTrue(s.prefix(maxLength: 0) == "")
    XCTAssertTrue(s.prefix(maxLength: 1) == "H")
    XCTAssertTrue(s.prefix(maxLength: 2) == "He")
    XCTAssertTrue(s.prefix(maxLength: 3) == "Hel")
    XCTAssertTrue(s.prefix(maxLength: 4) == "Hell")
    XCTAssertTrue(s.prefix(maxLength: 5) == "Hello")
    XCTAssertTrue(s.prefix(maxLength: 6) == "Hello ")
    XCTAssertTrue(s.prefix(maxLength: 13) == "Hello World 🖖")
    XCTAssertTrue(s.prefix(maxLength: 14) == "Hello World 🖖🏽")
    XCTAssertTrue(s.prefix(maxLength: 100) == "Hello World 🖖🏽")
  }

  func test_suffix() {
    let s = "Hello World 🖖🏽"
    XCTAssertTrue(s.suffix(maxLength: -100) == "")
    XCTAssertTrue(s.suffix(maxLength: 0) == "")
    XCTAssertTrue(s.suffix(maxLength: 1) == "🏽")
    XCTAssertTrue(s.suffix(maxLength: 2) == "🖖🏽")
    XCTAssertTrue(s.suffix(maxLength: 3) == " 🖖🏽")
    XCTAssertTrue(s.suffix(maxLength: 4) == "d 🖖🏽")
    XCTAssertTrue(s.suffix(maxLength: 5) == "ld 🖖🏽")
    XCTAssertTrue(s.suffix(maxLength: 6) == "rld 🖖🏽")
    XCTAssertTrue(s.suffix(maxLength: 13) == "ello World 🖖🏽")
    XCTAssertTrue(s.suffix(maxLength: 14) == "Hello World 🖖🏽")
    XCTAssertTrue(s.suffix(maxLength: 100) == "Hello World 🖖🏽")
  }

  func test_condensingExcessiveSpaces() {
    XCTAssertTrue("test spaces too many".condensingExcessiveSpaces() == "test spaces too many")
    XCTAssertTrue("test  spaces    too many".condensingExcessiveSpaces() == "test spaces too many")
    XCTAssertTrue(" test spaces too many ".condensingExcessiveSpaces() == "test spaces too many")
    XCTAssertTrue(" test spaces too many".condensingExcessiveSpaces() == "test spaces too many")
    XCTAssertTrue("test spaces too many ".condensingExcessiveSpaces() == "test spaces too many")
  }

  func test_condensingExcessiveSpacesAndNewLines() {
    XCTAssertTrue("test\n spaces too many".condensingExcessiveSpacesAndNewlines() == "test spaces too many")
    XCTAssertTrue("\n\ntest  spaces    too many".condensingExcessiveSpacesAndNewlines() == "test spaces too many")
    XCTAssertTrue(" test spaces too many \n\n".condensingExcessiveSpacesAndNewlines() == "test spaces too many")
    XCTAssertTrue(" test spaces too\n many".condensingExcessiveSpacesAndNewlines() == "test spaces too many")
    XCTAssertTrue("test\n\n spaces \n\n too many ".condensingExcessiveSpacesAndNewlines() == "test spaces too many")
  }

  func test_first(){
    let s = "Hello"
    XCTAssertTrue(s.first == "H")
  }


  func test_last(){
    let s = "Hello"
    XCTAssertTrue(s.last == "o")
  }

  func test_removingPrefix() {

    let s = "hello"
    XCTAssertTrue(s.removingPrefix(upToPosition: 0) == "hello")
    XCTAssertTrue(s.removingPrefix() == "ello")
    XCTAssertTrue(s.removingPrefix(upToPosition: 1) == "ello")
    XCTAssertTrue(s.removingPrefix(upToPosition: 3) == "lo")
    XCTAssertTrue(s.removingPrefix(upToPosition: 5) == "")
    XCTAssertTrue(s.removingPrefix(upToPosition: 100) == "")
    XCTAssertTrue(s.removingPrefix(upToPosition: -1) == "")
    XCTAssertTrue("".removingPrefix(upToPosition: 1) == "")
  }

  func test_removingSuffix() {

    let s = "hello"
    XCTAssertTrue(s.removingSuffix(fromPosition: 0) == "hello")
    XCTAssertTrue(s.removingSuffix() == "hell")
    XCTAssertTrue(s.removingSuffix(fromPosition: 1) == "hell")
    XCTAssertTrue(s.removingSuffix(fromPosition: 3) == "he")
    XCTAssertTrue(s.removingSuffix(fromPosition: 5) == "")
    XCTAssertTrue(s.removingSuffix(fromPosition: 100) == "")
    XCTAssertTrue(s.removingSuffix(fromPosition: -1) == "")
    XCTAssertTrue("".removingSuffix(fromPosition: 1) == "")
  }

  func test_removingCharacters() {
    do {
      let s = "123Hello45 !World..5"
      let result1 = s.removingCharacters(in: CharacterSet.letters.inverted)
      XCTAssertTrue(result1 == "HelloWorld")
      let result2 = s.removingCharacters(in: CharacterSet.letters)
      XCTAssertTrue(result2 == "12345 !..5")
      /// CharacterSet.capitalizedLetters returns a character set containing the characters in Unicode General Category Lt aka "Letter, titlecase". 
      /// That are "Ligatures containing uppercase followed by lowercase letters (e.g., ǅ, ǈ, ǋ, and ǲ)"
      let result4 = s.removingCharacters(in: CharacterSet.capitalizedLetters)
      XCTAssertTrue(result4 == "123Hello45 !World..5")
    }

    do {
      let s = "H ello"
      let result1 = s.removingCharacters(in: CharacterSet.letters.inverted)
      XCTAssertTrue(result1 == "Hello")
      let result2 = s.removingCharacters(in: CharacterSet.decimalDigits)
      XCTAssertTrue(s == result2)
    }

  }

  func test_truncate() {
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

    /// Currently, Swift counts multiple flags following each other as a single Character, and it seems this will still be “correct” in Unicode 9
    /// Multiple emoji flags are counted as 1 character: "🇮🇹🇮🇹".characters.count is 1
    /// Swift can't understand them without a separation character.
    /// http://stackoverflow.com/questions/26862282/swift-countelements-return-incorrect-value-when-count-flag-emoji
    /// https://oleb.net/blog/2016/12/emoji-4-0/
    XCTAssertTrue(s4.truncate(at: 5) == "a🇮🇹bb🇮🇹🇮🇹…")
    XCTAssertTrue(s4.truncate(at: 6) == "a🇮🇹bb🇮🇹🇮🇹c…")

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

    let s8 = "👍👍🏻👍🏼👍🏾" // 7 characters (4x👍 + 3 skin tone)
    XCTAssertTrue(s8.truncate(at: 1) == "👍…")
    XCTAssertTrue(s8.truncate(at: 2) == "👍👍…") //skin tone truncated
    XCTAssertTrue(s8.truncate(at: 3) == "👍👍🏻…")
    XCTAssertTrue(s8.truncate(at: 4) == "👍👍🏻👍…") //skin tone truncated
    XCTAssertTrue(s8.truncate(at: 5) == "👍👍🏻👍🏼…")

    //flags sperated by a ZERO WIDTH SPACE
    let s9 = "🇮🇹\u{200B}🇮🇹\u{200B}🇮🇹"
    XCTAssertTrue(s9.truncate(at: 1) == "🇮🇹…")
    XCTAssertTrue(s9.truncate(at: 2) == "🇮🇹​…")
    XCTAssertTrue(s9.truncate(at: 3) == "🇮🇹​🇮🇹…")
    XCTAssertTrue(s9.truncate(at: 4) == "🇮🇹​🇮🇹​…")
    XCTAssertTrue(s9.truncate(at: 5) == "🇮🇹​🇮🇹​🇮🇹")
  }

  func test_subscript() {
    let string = "∆Test😗"

    XCTAssertTrue(string[0] == "∆")
    XCTAssertTrue(string[1] == "T")

    XCTAssertNil(string[-1])
    XCTAssertNil(string[6])
    XCTAssertNil(string[10])

    XCTAssertTrue(string[string.length - 1] == "😗")

    XCTAssertTrue(string[0..<1] == "∆")
    XCTAssertTrue(string[1..<6] == "Test😗")

    XCTAssertNotNil(string["Test"])
    XCTAssertNotNil(string["😗"])


    // MARK: - Range

    XCTAssertTrue(string[Range(0..<3)] == "∆Te")
    XCTAssertTrue(string[Range(3..<3)] == "")
    XCTAssertTrue(string[Range(3..<6)] == "st😗")
    XCTAssertTrue(string[Range(0..<string.length)] == "∆Test😗")

    //XCTAssertNil(string[Range(string.length+1 ..< string.length)])
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

    XCTAssertNil(string[""])
    let range2 = string["∆"]
    XCTAssertTrue(range2! == string.startIndex ..< string.index(string.startIndex, offsetBy: 1))
    let range3 = string["est"] //2,3,4
    XCTAssert(range3! ~= string.index(string.startIndex, offsetBy: 2) ..< string.index(string.startIndex, offsetBy: 5))
    XCTAssertNil(string["k"])
    XCTAssertNil(string["123est"])
  }

  func test_replacingCharacters() {

    let s = "Hello World" //10 characters
    do{
      let countableRange = CountableRange(uncheckedBounds: (lower: 0, upper: 2)) //[0,2[
      let newString = s.replacingCharacters(in: countableRange, with: "1")
      XCTAssertTrue(newString == "1llo World")

      let countableClosedRange = CountableClosedRange(uncheckedBounds: (lower: 0, upper: 2)) //[0,2]
      let newString2 = s.replacingCharacters(in: countableClosedRange, with: "1")
      XCTAssertTrue(newString2 == "1lo World")
    }
    do{
      let countableRange = CountableRange(uncheckedBounds: (lower: 0, upper: 11)) //[0,11[
      let newString = s.replacingCharacters(in: countableRange, with: "1")
      XCTAssertTrue(newString == "1")

      let countableClosedRange = CountableClosedRange(uncheckedBounds: (lower: 0, upper: s.characters.count-1)) //[0,9]
      let newString2 = s.replacingCharacters(in: countableClosedRange, with: "1")
      XCTAssertTrue(newString2 == "1")
    }
  }

  func test_random() {

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
  
  // MARK: - Case Operators
  
  func test_camelCased() {
    XCTAssertEqual("Hello World".camelCased(), "helloWorld")
    XCTAssertEqual("  Hello World".camelCased(), "helloWorld")
    XCTAssertEqual("HelloWorld".camelCased(), "helloWorld")
    XCTAssertEqual("-Hello_World-".camelCased(), "helloWorld")
    XCTAssertEqual("-Hello_ World-".camelCased(), "helloWorld")
    XCTAssertEqual("Hell0W0rld".camelCased(), "hell0W0rld")
    XCTAssertEqual("helloWorld".camelCased(), "helloWorld")
  }
  
  func test_decapitalized() {
    // TODO: Decapitalized needs to be fixed to work with multiple words.
  }
  
  
  func test_kebabCased() {
    XCTAssertEqual("Hello World".kebabCased(), "-hello-world-")
    XCTAssertEqual("Hello_World".kebabCased(), "-hello-world-")
    XCTAssertEqual("_Hello_World".kebabCased(), "-hello-world-")
    XCTAssertEqual("_Hello_  World".kebabCased(), "-hello-world-")
    XCTAssertEqual("-HeLL0_W0rld-".kebabCased(), "-hell0-w0rld-")
    XCTAssertEqual("HelloWorld".kebabCased(), "-helloworld-")
  }
  
  func test_pascalCased() {
    XCTAssertEqual("Hello World".pascalCased(), "HelloWorld")
    XCTAssertEqual("HelloWorld".pascalCased(), "HelloWorld")
    XCTAssertEqual("HelloWorld ".pascalCased(), "HelloWorld")
    XCTAssertEqual("-Hello_World-".pascalCased(), "HelloWorld")
    XCTAssertEqual("-Hello_ World-".pascalCased(), "HelloWorld")
    XCTAssertEqual("Hell0W0rld".pascalCased(), "Hell0W0rld")
  }
  
  func test_slugCased() {
    XCTAssertEqual("Hello World".slugCased(), "hello-world")
    XCTAssertEqual("Hello_World".slugCased(), "hello-world")
    XCTAssertEqual("Hello-World".slugCased(), "hello-world")
    XCTAssertEqual("Hello- World".slugCased(), "hello-world")
    XCTAssertEqual("-Hello- World".slugCased(), "hello-world")
    XCTAssertEqual("HeLL0 W0rld".slugCased(), "hell0-w0rld")
    XCTAssertEqual("HelloWorld".slugCased(), "helloworld")
  }
  
  func test_snakeCased() {
    XCTAssertEqual("Hello World".snakeCased(), "Hello_World")
    XCTAssertEqual("hello world".snakeCased(), "hello_world")
    XCTAssertEqual("hello_world".snakeCased(), "hello_world")
    XCTAssertEqual("hello__world".snakeCased(), "hello_world")
    XCTAssertEqual("hello__ world".snakeCased(), "hello_world")
    XCTAssertEqual(" hello_world".snakeCased(), "hello_world")
    XCTAssertEqual("Hell0W0rld".snakeCased(), "Hell0W0rld")
    XCTAssertEqual("HelloWorld".snakeCased(), "HelloWorld")
  }
  
  func test_swapCased() {
    XCTAssertEqual("Hello World".swapCased(), "hELLO wORLD")
    XCTAssertEqual("hELLO wORLD".swapCased(), "Hello World")
    XCTAssertEqual("HelloWorld".swapCased(), "hELLOwORLD")
    XCTAssertEqual("-Hello_World-".swapCased(), "-hELLO_wORLD-")
    XCTAssertEqual("Hell0W0rld".swapCased(), "hELL0w0RLD")
  }
  
}

