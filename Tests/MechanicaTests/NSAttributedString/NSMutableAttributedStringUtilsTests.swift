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

  func testRemovingAttrbiutes() {
    // Given
    let attributedString = NSMutableAttributedString(string: "Hello", attributes: [NSAttributedStringKey.foregroundColor: Color.red])
    attributedString += " "
    attributedString += NSAttributedString(string: "World", attributes: [NSAttributedStringKey.backgroundColor: Color.yellow])
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

  func testRemoveAttrbiutes() {
    // Given
    let attributedString = NSMutableAttributedString(string: "Hello", attributes: [NSAttributedStringKey.foregroundColor: Color.red])
    attributedString += " "
    attributedString += NSAttributedString(string: "World", attributes: [NSAttributedStringKey.backgroundColor: Color.yellow])
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

}
