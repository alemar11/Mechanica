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

import Foundation

import XCTest
@testable import Mechanica

class NSMutableAttributedStringUtilsTests: XCTestCase {

#if os(iOS) || os(macOS)

  func testBold() {

    do {
      // Given, When
      let testAttributedString = NSMutableAttributedString(string: "Tin Robots Attributed String 🤖👍🏽", attributes: [NSAttributedStringKey:Any]())
      testAttributedString.setBoldFont()
      // Then
      for value in 0...testAttributedString.string.length {
        let attributes = testAttributedString.attributes(at: value, longestEffectiveRange: nil, in: testAttributedString.string.nsRange)
        XCTAssertEqual(attributes[.font] as! Font, Font.boldSystemFont(ofSize: Font.systemFontSize))
      }
    }

    do {
      // Given, When
      let testAttributedString = NSMutableAttributedString(string: "Tin Robots Attributed String 🤖👍🏽", attributes: [NSAttributedStringKey:Any]())
      testAttributedString.setBoldFont(in: NSMakeRange(0, 5))
      // Then
      for value in 0...testAttributedString.string.length {
        let attributes = testAttributedString.attributes(at: value, longestEffectiveRange: nil, in: testAttributedString.string.nsRange)
        if value < 5 {
          XCTAssertEqual(attributes[.font] as! Font, Font.boldSystemFont(ofSize: Font.systemFontSize))
        } else {
          XCTAssertNil(attributes[.font])
        }
      }
    }

  }

  func testForegroundColor() {

    do {
      // Given, When
      let color = Color.red
      let testAttributedString = NSMutableAttributedString(string: "Tin Robots Attributed String 🤖👍🏽", attributes: [NSAttributedStringKey:Any]())
      testAttributedString.setColorForeground(color)
      // Then
      for value in 0...testAttributedString.string.length {
        let attributes = testAttributedString.attributes(at: value, longestEffectiveRange: nil, in: testAttributedString.string.nsRange)
        XCTAssertEqual(attributes[.foregroundColor] as! Color, Color.red)
      }
    }

    do {
      // Given, When
      let color = Color.red
      let testAttributedString = NSMutableAttributedString(string: "Tin Robots Attributed String 🤖👍🏽", attributes: [NSAttributedStringKey:Any]())
      testAttributedString.setColorForeground(color, in: NSMakeRange(0, 5))
      // Then
      for value in 0...testAttributedString.string.length {
        let attributes = testAttributedString.attributes(at: value, longestEffectiveRange: nil, in: testAttributedString.string.nsRange)
        if value < 5 {
          XCTAssertEqual(attributes[.foregroundColor] as! Color, Color.red)
        } else {
          XCTAssertNil(attributes[.foregroundColor])
        }
      }
    }

  }

  func testBackgroundColor() {

    do {
      // Given, When
      let color = Color.red
       let testAttributedString = NSMutableAttributedString(string: "Tin Robots Attributed String 🤖👍🏽", attributes: [NSAttributedStringKey:Any]())
      testAttributedString.setColorBackground(color)
      // Then
      for value in 0...testAttributedString.string.length {
        let attributes = testAttributedString.attributes(at: value, longestEffectiveRange: nil, in: testAttributedString.string.nsRange)
        XCTAssertEqual(attributes[.backgroundColor] as! Color, Color.red)
      }
    }

    do {
      // Given, When
      let color = Color.red
       let testAttributedString = NSMutableAttributedString(string: "Tin Robots Attributed String 🤖👍🏽", attributes: [NSAttributedStringKey:Any]())
      testAttributedString.setColorBackground(color, in: NSMakeRange(0, 5))
      // Then
      for value in 0...testAttributedString.string.length {
        let attributes = testAttributedString.attributes(at: value, longestEffectiveRange: nil, in: testAttributedString.string.nsRange)
        if value < 5 {
          XCTAssertEqual(attributes[.backgroundColor] as! Color, Color.red)
        } else {
          XCTAssertNil(attributes[.backgroundColor])
        }
      }
    }

  }

#endif

func testUnderLine() {
  do {
    // Given, When
     let testAttributedString = NSMutableAttributedString(string: "Tin Robots Attributed String 🤖👍🏽", attributes: [NSAttributedStringKey:Any]())
    testAttributedString.setUnderline()
    // Then
    for value in 0...testAttributedString.string.length {
      let attributes = testAttributedString.attributes(at: value, longestEffectiveRange: nil, in: testAttributedString.string.nsRange)
      XCTAssertEqual(attributes[.underlineStyle] as! Int, NSUnderlineStyle.styleSingle.rawValue)
    }
  }

  do {
    // Given, When
     let testAttributedString = NSMutableAttributedString(string: "Tin Robots Attributed String 🤖👍🏽", attributes: [NSAttributedStringKey:Any]())
    testAttributedString.setUnderline(in: NSMakeRange(0, 5), style: .patternDashDot)
    // Then
    for value in 0...testAttributedString.string.length {
      let attributes = testAttributedString.attributes(at: value, longestEffectiveRange: nil, in: testAttributedString.string.nsRange)
      if value < 5 {
        XCTAssertEqual(attributes[.underlineStyle] as! Int, NSUnderlineStyle.patternDashDot.rawValue)
      } else {
        XCTAssertNil(attributes[.underlineStyle])
      }
    }
  }
}

func testStrikethrough() {
  do {
    // Given, When
     let testAttributedString = NSMutableAttributedString(string: "Tin Robots Attributed String 🤖👍🏽", attributes: [NSAttributedStringKey:Any]())
    testAttributedString.setStrikethrough()
    // Then
    for value in 0...testAttributedString.string.length {
      let attributes = testAttributedString.attributes(at: value, longestEffectiveRange: nil, in: testAttributedString.string.nsRange)
      XCTAssertEqual(attributes[.strikethroughStyle] as! NSNumber, NSNumber(value: NSUnderlineStyle.styleSingle.rawValue as Int))
    }
  }

  do {
    // Given, When
     let testAttributedString = NSMutableAttributedString(string: "Tin Robots Attributed String 🤖👍🏽", attributes: [NSAttributedStringKey:Any]())
    testAttributedString.setStrikethrough(in: NSMakeRange(0, 5))
    // Then
    for value in 0...testAttributedString.string.length {
      let attributes = testAttributedString.attributes(at: value, longestEffectiveRange: nil, in: testAttributedString.string.nsRange)
      if value < 5 {
        XCTAssertEqual(attributes[.strikethroughStyle] as! NSNumber, NSNumber(value: NSUnderlineStyle.styleSingle.rawValue as Int))
      } else {
        XCTAssertNil(attributes[.strikethroughStyle])
      }
    }
  }
}

#if os(iOS)

  func testItalic() {
    do {
      // Given, When
      let testAttributedString = NSMutableAttributedString(string: "Tin Robots Attributed String 🤖👍🏽", attributes: [NSAttributedStringKey:Any]())
      testAttributedString.setItalicFont()
      // Then
      for value in 0...testAttributedString.string.length {
        let attributes = testAttributedString.attributes(at: value, longestEffectiveRange: nil, in: testAttributedString.string.nsRange)
        XCTAssertEqual(attributes[NSAttributedStringKey.font] as! Font, Font.italicSystemFont(ofSize: UIFont.systemFontSize))
      }
    }

    do {
      // Given, When
       let testAttributedString = NSMutableAttributedString(string: "Tin Robots Attributed String 🤖👍🏽", attributes: [NSAttributedStringKey:Any]())
       testAttributedString.setItalicFont(in: NSMakeRange(0, 5))
      // Then
      for value in 0...testAttributedString.string.length {
        let attributes = testAttributedString.attributes(at: value, longestEffectiveRange: nil, in: testAttributedString.string.nsRange)
        if value < 5 {
          XCTAssertEqual(attributes[NSAttributedStringKey.font] as! Font, Font.italicSystemFont(ofSize: UIFont.systemFontSize))
        } else {
          XCTAssertNil(attributes[.font])
        }
      }
    }
  }

#endif

}
