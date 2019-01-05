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

extension CharacterUtilsTests {
  static var allTests = [
    ("testIsEmojiCountryFlag", testIsEmojiCountryFlag),
    ("testIsWhitespace", testIsWhitespace)

  ]
}

final class CharacterUtilsTests: XCTestCase {

  func testIsEmojiCountryFlag() {
    XCTAssertTrue(Character("🇮🇹").isEmojiCountryFlag)
    XCTAssertTrue(Character("🇯🇵").isEmojiCountryFlag)
    XCTAssertTrue(Character("🇨🇦").isEmojiCountryFlag)
    XCTAssertTrue(Character("🇦🇶").isEmojiCountryFlag)
    XCTAssertFalse(Character("🏴").isEmojiCountryFlag)
    XCTAssertFalse(Character("🏁").isEmojiCountryFlag)
    XCTAssertFalse(Character("🏳️").isEmojiCountryFlag)
    #if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
    XCTAssertFalse(Character("🏳️‍🌈").isEmojiCountryFlag) // it crashes on Linux
    #endif

    XCTAssertFalse(Character("a").isEmojiCountryFlag)
    XCTAssertFalse(Character(".").isEmojiCountryFlag)
    XCTAssertFalse(Character("🚩").isEmojiCountryFlag)
    XCTAssertFalse(Character("\\").isEmojiCountryFlag)
    XCTAssertFalse(Character("😇").isEmojiCountryFlag)
  }

  func testIsWhitespace() {
    XCTAssertTrue(Character(" ").isWhitespace)
    XCTAssertTrue(Character("\n").isWhitespace)
    XCTAssertTrue(Character("\r").isWhitespace)
    XCTAssertTrue(Character("\t").isWhitespace)

    XCTAssertFalse(Character("a").isWhitespace)
    XCTAssertFalse(Character(".").isWhitespace)
    XCTAssertFalse(Character("\\").isWhitespace)
    XCTAssertFalse(Character("😇").isWhitespace)
  }

}
