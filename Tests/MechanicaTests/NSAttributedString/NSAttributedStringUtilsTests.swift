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

class NSAttributedStringUtilsTests: XCTestCase {

  let testAttributedString = NSAttributedString(string: "Tin Robots Attributed String 🤖", attributes: [NSAttributedStringKey:Any]())

  #if os(iOS) || os(macOS)

  func testBold() {
    // Given, When
    let boldString = testAttributedString.bold()
    let newAttributesSeen = boldString.attributes(at: 0, longestEffectiveRange: nil, in: NSMakeRange(0, boldString.length))
    // Then
    XCTAssertEqual(newAttributesSeen[NSAttributedStringKey.font] as! Font, Font.boldSystemFont(ofSize: Font.systemFontSize))
  }

  #endif

  func testUnderLine() {
    // Given, When
    let underLineString = testAttributedString.underline()
    let newAttributesSeen = underLineString.attributes(at: 0, longestEffectiveRange: nil, in: NSMakeRange(0, underLineString.length))
    // Then
    XCTAssertEqual(newAttributesSeen[NSAttributedStringKey.underlineStyle] as! Int, NSUnderlineStyle.styleSingle.rawValue)
  }

  func testStrikethrough() {
    // Given, When
    let strikeThroughString = testAttributedString.strikethrough()
    let newAttributesSeen = strikeThroughString.attributes(at: 0, longestEffectiveRange: nil, in: NSMakeRange(0, strikeThroughString.length))
    // Then
    XCTAssertEqual(newAttributesSeen[NSAttributedStringKey.strikethroughStyle] as! NSNumber, NSNumber(value: NSUnderlineStyle.styleSingle.rawValue as Int))
  }

  #if os(iOS)

  func testItalic() {
    // Given, When
    let italicString = testAttributedString.italic()
    let newAttributesSeen = italicString.attributes(at: 0, longestEffectiveRange: nil, in: NSMakeRange(0, italicString.length))
    // Then
    XCTAssertEqual(newAttributesSeen[NSAttributedStringKey.font] as! Font, Font.italicSystemFont(ofSize: UIFont.systemFontSize))
  }

  #endif

  func testInitHTML(){
    do {
      // Given, When
      let html = """
                  <html>
                    <head><style type=\"text/css\">@font-face {font-family: Avenir-Roman}body {font-family: Avenir-Roman;font-size:15;margin: 0;padding: 0}</style>
                  </head>
                  <body style=\"background-color: #E6E6FA;\"><span style=\"background-color: #9999ff;\">Hello World</span></body>
                  """
      let s = NSAttributedString(html: html)
      // Then
      XCTAssertNotNil(s)

      XCTAssertTrue(s!.string == "Hello World")
      guard let font = s!.attribute(NSAttributedStringKey.font, at: 0, effectiveRange: nil) as? Font else {
        XCTAssert(false, "No Avenir-Roman font name found.")
        return
      }
      XCTAssertTrue(font.familyName == "Avenir")
      XCTAssertTrue(font.fontName == "Avenir-Roman")
      XCTAssertTrue(font.pointSize == 15.00)

      guard let color = s!.attribute(NSAttributedStringKey.backgroundColor, at: 0, effectiveRange: nil) as? Color else {
        XCTAssert(false, "No text backgroud-color found.")
        return
      }
      XCTAssertTrue(color.hexString == "#9999ff".uppercased())

      guard let _ = s!.attribute(NSAttributedStringKey.paragraphStyle, at: 0, effectiveRange: nil) as? NSParagraphStyle else {
        XCTAssert(false, "No NSParagraphStyle found.")
        return
      }
    }

    do {
      let html = "<html 1234 </body>"
      let s = NSAttributedString(html: html)
      XCTAssertNotNil(s)
      XCTAssertTrue(s!.string.isEmpty)
    }

  }

}

