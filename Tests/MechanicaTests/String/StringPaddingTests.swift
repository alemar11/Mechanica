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

class StringPaddingTests: XCTestCase {

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
      print(string)
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
      print(string)
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
      print(string)
      XCTAssertEqual(string, "** _T1n R0bots!_ ***")
    }

    do {
      var string = "a"
      string.pad(length: 6, with: "123")
      XCTAssertEqual(string, "12a123")
    }
  }
    
}
