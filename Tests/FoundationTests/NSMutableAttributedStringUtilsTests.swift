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

final class NSMutableAttributedStringUtilsTests: XCTestCase {

  func testRemovingAttributes() {

      do {
        // Given
        let attributedString = NSMutableAttributedString(string: "Hello", attributes: [NSAttributedString.Key.foregroundColor: Color.red])
        attributedString += " "
        attributedString += NSAttributedString(string: "World", attributes: [NSAttributedString.Key.backgroundColor: Color.yellow])
        let range = NSRange(location: 0, length: attributedString.length)

        var attributesCount = 0
        var attributesCount2 = 0

        attributedString.enumerateAttributes(in: range, options: []) { (attributes, _, _) in
          if !attributes.keys.isEmpty { attributesCount += 1 }
        }

        // When
        let notAttributedString = attributedString.removingAllAttributes()
        let range2 = NSRange(location: 0, length: notAttributedString.length)

        // Then
        notAttributedString.enumerateAttributes(in: range2, options: []) { (attributes, _, _) in
          if !attributes.keys.isEmpty { attributesCount2 += 1 }
        }

        XCTAssertTrue(attributesCount != attributesCount2)
        XCTAssertTrue(attributesCount2 == 0)
      }

    do {
      let attributedString = NSMutableAttributedString(string: "Hello", attributes: [NSAttributedString.Key.foregroundColor: Color.red, NSAttributedString.Key.strikethroughColor: Color.blue])
      let range = NSRange(location: 0, length: attributedString.length)

      var attributesCount = 0
      var attributesCount2 = 0

      attributedString.enumerateAttributes(in: range, options: []) { (attributes, _, _) in
        if !attributes.keys.isEmpty { attributesCount += 1 }
      }

      // When
      let notAttributedString = attributedString.removingAllAttributes()
      let range2 = NSRange(location: 0, length: notAttributedString.length)

      // Then
      notAttributedString.enumerateAttributes(in: range2, options: []) { (attributes, _, _) in
        if !attributes.keys.isEmpty { attributesCount2 += 1 }
      }

      XCTAssertTrue(attributesCount != attributesCount2)
      XCTAssertTrue(attributesCount2 == 0)
    }
  }

  func testRemoveAttributes() {
    // Given
    let attributedString = NSMutableAttributedString(string: "Hello", attributes: [NSAttributedString.Key.foregroundColor: Color.red])
    attributedString += " "
    attributedString += NSAttributedString(string: "World", attributes: [NSAttributedString.Key.backgroundColor: Color.yellow])
    let range = NSRange(location: 0, length: attributedString.length)

    var attributesCount = 0
    var attributesCount2 = 0

    attributedString.enumerateAttributes(in: range, options: []) { (attributes, _, _) in
      if !attributes.keys.isEmpty { attributesCount += 1 }
    }

    // When
    attributedString.removeAllAttributes()
    let range2 = NSRange(location: 0, length: attributedString.length)

    // Then
    attributedString.enumerateAttributes(in: range2, options: []) { (attributes, _, _) in
      if !attributes.keys.isEmpty { attributesCount2 += 1 }
    }

    XCTAssertTrue(attributesCount != attributesCount2)
    XCTAssertTrue(attributesCount2 == 0)
  }

  func testAddition() {

    /// addition between NSMutableAttributedStrings
    do {
      let s1 = NSMutableAttributedString(string: "Hello")
      let s2 = NSMutableAttributedString(string: " ")
      let s3 = NSMutableAttributedString(string: "World")

      let s4 = s1 + s2 + s3
      XCTAssertTrue(s4.string == "Hello World")
    }

    do {
      let s1 = NSMutableAttributedString(string: "Hello", attributes: [NSAttributedString.Key.foregroundColor: Color.red])
      let s2 = NSMutableAttributedString(string: " ")
      let s3 = NSMutableAttributedString(string: "World", attributes: [NSAttributedString.Key.backgroundColor: Color.yellow])

      let s4 = s1 + s2 + s3
      let firstCharAttributes = s4.attributes(at: 0, longestEffectiveRange: nil, in: NSMakeRange(0, 0))
      let lastCharAttributes = s4.attributes(at: 10, longestEffectiveRange: nil, in: NSMakeRange(9, 10))
      let redColor = firstCharAttributes[NSAttributedString.Key.foregroundColor] as? Color
      let yellowColor = lastCharAttributes[NSAttributedString.Key.backgroundColor] as? Color
      XCTAssertTrue(s1 !== s4)
      XCTAssertNotNil(redColor)
      XCTAssertNotNil(yellowColor)
      XCTAssertTrue(redColor! == .red)
      XCTAssertTrue(yellowColor! == .yellow)
      XCTAssertTrue(s4.string == "Hello World")
    }

    /// addition between NSMutableAttributedStrings and NSAttributedString
    do {
      let s1 = NSMutableAttributedString(string: "Hello", attributes: [NSAttributedString.Key.foregroundColor: Color.red])
      let s2 = NSMutableAttributedString(string: " ")
      let s3 = NSAttributedString(string: "World", attributes: [NSAttributedString.Key.backgroundColor: Color.yellow])

      let s4 = s1 + s2 + s3
      let firstCharAttributes = s4.attributes(at: 0, longestEffectiveRange: nil, in: NSMakeRange(0, 0))
      let lastCharAttributes = s4.attributes(at: 10, longestEffectiveRange: nil, in: NSMakeRange(9, 10))
      let redColor = firstCharAttributes[NSAttributedString.Key.foregroundColor] as? Color
      let yellowColor = lastCharAttributes[NSAttributedString.Key.backgroundColor] as? Color
      XCTAssertTrue(s1 !== s4)
      XCTAssertNotNil(redColor)
      XCTAssertNotNil(yellowColor)
      XCTAssertTrue(redColor! == .red)
      XCTAssertTrue(yellowColor! == .yellow)
      XCTAssertTrue(s4.string == "Hello World")
    }

    /// addition between NSAttributedStrings and NSMutableAttributedString
    do {
      let s1 = NSAttributedString(string: "Hello", attributes: [NSAttributedString.Key.foregroundColor: Color.red])
      let s2 = NSMutableAttributedString(string: " ")
      let s3 = NSAttributedString(string: "World", attributes: [NSAttributedString.Key.backgroundColor: Color.yellow])

      let s4 = s1 + s2 + s3
      let firstCharAttributes = s4.attributes(at: 0, longestEffectiveRange: nil, in: NSMakeRange(0, 0))
      let lastCharAttributes = s4.attributes(at: 10, longestEffectiveRange: nil, in: NSMakeRange(9, 10))
      let redColor = firstCharAttributes[NSAttributedString.Key.foregroundColor] as? Color
      let yellowColor = lastCharAttributes[NSAttributedString.Key.backgroundColor] as? Color
      XCTAssertTrue(s1 !== s4)
      XCTAssertNotNil(redColor)
      XCTAssertNotNil(yellowColor)
      XCTAssertTrue(redColor! == .red)
      XCTAssertTrue(yellowColor! == .yellow)
      XCTAssertTrue(s4.string == "Hello World")
    }

    /// addition between NSAttributedString, String and NSMutableAttributedString
    do {
      let s1 = NSAttributedString(string: "Hello", attributes: [NSAttributedString.Key.foregroundColor: Color.red])
      let s2 = " "
      let s3 = NSMutableAttributedString(string: "World", attributes: [NSAttributedString.Key.backgroundColor: Color.yellow])

      let s4 = s1 + s2 + s3
      let firstCharAttributes = s4.attributes(at: 0, longestEffectiveRange: nil, in: NSMakeRange(0, 0))
      let lastCharAttributes = s4.attributes(at: 10, longestEffectiveRange: nil, in: NSMakeRange(9, 10))
      let redColor = firstCharAttributes[NSAttributedString.Key.foregroundColor] as? Color
      let yellowColor = lastCharAttributes[NSAttributedString.Key.backgroundColor] as? Color
      XCTAssertTrue(s1 !== s4)
      XCTAssertNotNil(redColor)
      XCTAssertNotNil(yellowColor)
      XCTAssertTrue(redColor! == .red)
      XCTAssertTrue(yellowColor! == .yellow)
      XCTAssertTrue(s4.string == "Hello World")
    }

    /// addition between NSMutableAttributedString and String
    do {
      let s1 = "Hello"
      let s2 = " "
      let s3 = NSMutableAttributedString(string: "World", attributes: [NSAttributedString.Key.backgroundColor: Color.yellow])

      let s4 = s1 + s2 + s3
      let firstCharAttributes = s4.attributes(at: 0, longestEffectiveRange: nil, in: NSMakeRange(0, 0))
      let lastCharAttributes = s4.attributes(at: 10, longestEffectiveRange: nil, in: NSMakeRange(9, 10))
      let yellowColor = lastCharAttributes[NSAttributedString.Key.backgroundColor] as? Color
      XCTAssertTrue(firstCharAttributes.isEmpty)
      XCTAssertNotNil(yellowColor)
      XCTAssertTrue(yellowColor! == .yellow)
      XCTAssertTrue(s4.string == "Hello World")
    }

  }

  func testCompoundAddition() {
    do {
      let s = NSMutableAttributedString(string: "Hello", attributes: [NSAttributedString.Key.foregroundColor: Color.red])
      s += " "
      s += NSAttributedString(string: "World", attributes: [NSAttributedString.Key.backgroundColor: Color.yellow])

      let firstCharAttributes = s.attributes(at: 0, longestEffectiveRange: nil, in: NSMakeRange(0, 0))
      let lastCharAttributes = s.attributes(at: 10, longestEffectiveRange: nil, in: NSMakeRange(9, 10))
      let redColor = firstCharAttributes[NSAttributedString.Key.foregroundColor] as? Color
      let yellowColor = lastCharAttributes[NSAttributedString.Key.backgroundColor] as? Color
      XCTAssertNotNil(redColor)
      XCTAssertNotNil(yellowColor)
      XCTAssertTrue(redColor! == .red)
      XCTAssertTrue(yellowColor! == .yellow)
      XCTAssertTrue(s.string == "Hello World")
    }

    do {
      let s = NSMutableAttributedString(string: "Hello", attributes: [NSAttributedString.Key.foregroundColor: Color.red])
      s += NSMutableAttributedString(string: " ")
      s += NSAttributedString(string: "World", attributes: [NSAttributedString.Key.backgroundColor: Color.yellow])

      let firstCharAttributes = s.attributes(at: 0, longestEffectiveRange: nil, in: NSMakeRange(0, 0))
      let lastCharAttributes = s.attributes(at: 10, longestEffectiveRange: nil, in: NSMakeRange(9, 10))
      let redColor = firstCharAttributes[NSAttributedString.Key.foregroundColor] as? Color
      let yellowColor = lastCharAttributes[NSAttributedString.Key.backgroundColor] as? Color
      XCTAssertNotNil(redColor)
      XCTAssertNotNil(yellowColor)
      XCTAssertTrue(redColor! == .red)
      XCTAssertTrue(yellowColor! == .yellow)
      XCTAssertTrue(s.string == "Hello World")
    }
  }

}
