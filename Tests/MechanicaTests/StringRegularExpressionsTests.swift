//
//  StringRegularExpressionsTests.swift
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

class StringRegularExpressionsTests: XCTestCase {
  
  func test_firstRange() {
    
    do {
      let pattern = "^https?:\\/\\/.*"
      XCTAssertNotNil("HTTP://www.example.com".firstRange(matching: pattern, options: .caseInsensitive))
      XCTAssertNil("HTTP://www.example.com".firstRange(matching: pattern))
    }
    
    do {
      let text = "Hello World - Tin Robots 🤖😀🤖"
      let range = text.firstRange(matching: String.Pattern.firstAlphanumericCharacter)
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
  
  func test_strings() {
    
    do {
      //https://regex101.com/r/jLz7Sz/1
      let datePattern = "\\b(?:20)?(\\d\\d)[-./](0?[1-9]|1[0-2])[-./](3[0-1]|[1-2][0-9]|0?[1-9])\\b"
      let text = "   2015/10/10,11-10-20,     13/2/2     1981-2-2   2010-13-10"
      XCTAssertEqual(text.strings(matching: datePattern),["2015/10/10", "11-10-20", "13/2/2"])
    }
    
    do {
      let text = "Hello World - Tin Robots 🤖😀🤖"
      XCTAssertEqual(text.strings(matching: String.Pattern.firstAlphanumericCharacter),["H", "W", "T", "R"])
      XCTAssertEqual(text.strings(matching: String.Pattern.lastAlphanumericCharacter),["o", "d", "n", "s"])
      let invalidPattern = "//⛏"
      XCTAssertTrue(text.strings(matching: invalidPattern).isEmpty)
    }
    
    do {
      let text = "🤖😀🤖"
      XCTAssertTrue(text.strings(matching: String.Pattern.firstAlphanumericCharacter).isEmpty)
      XCTAssertTrue(text.strings(matching: String.Pattern.lastAlphanumericCharacter).isEmpty)
    }
    
    do {
      let text = "qwerty? qwerty? <a href=\"https://github.com/tinrobots\">TinRobots on GitHub</a> or <a href=\"https://github.com/tinrobots/Mechanica\">Mechanica on GitHub</a>."
      let linkRegexPattern = "<a\\s+[^>]*href=\"([^\"]*)\"[^>]*>"
      XCTAssertEqual(text.strings(matching: linkRegexPattern, options: .caseInsensitive),["<a href=\"https://github.com/tinrobots\">", "<a href=\"https://github.com/tinrobots/Mechanica\">"])
    }
    
  }
  
  //  func test_findStringInitialsPerformance() {
  //    let text = "Tin Robots 🤖😀🤖"
  //    self.measure {
  //      //let initials = text.strings(matching: String.Pattern.firstAlphanumericCharacter)
  //      let initials = text.firstCharacterOfEachWord().filter{$0.isAlphaNumeric}
  //      XCTAssertEqual(initials, ["T", "R"])
  //    }
  //  }
  
}

