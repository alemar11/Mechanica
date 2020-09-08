import XCTest
@testable import Mechanica

extension NSAttributedStringUtilsTests {
  static var allTests = [
    ("testAddition", testAddition)
  ]
}

final class NSAttributedStringUtilsTests: XCTestCase {
  
  #if !os(Linux)
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
      guard let font = s!.attribute(NSAttributedString.Key.font, at: 0, effectiveRange: nil) as? Font else {
        XCTAssert(false, "No Avenir-Roman font name found.")
        return
      }
      XCTAssertTrue(font.familyName == "Avenir")
      XCTAssertTrue(font.fontName == "Avenir-Roman")
      XCTAssertTrue(font.pointSize == 15.00)
      
      guard let color = s!.attribute(NSAttributedString.Key.backgroundColor, at: 0, effectiveRange: nil) as? Color else {
        XCTAssert(false, "No text backgroud-color found.")
        return
      }
      XCTAssertTrue(color.hexString == "#9999ff".uppercased())
      
      guard let _ = s!.attribute(NSAttributedString.Key.paragraphStyle, at: 0, effectiveRange: nil) as? NSParagraphStyle else {
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
  #endif
  
  func testAddition() {
    
    /// addition between NSAttributedStrings
    do {
      let s1 = NSAttributedString(string: "Hello World")
      let s2 = NSAttributedString(string: "!!")
      let s3 = NSAttributedString(string: "🤖")
      
      let s4 = s1 + s2 + s3 // NSAttributedString + NSAttributedString + NSAttributedString
      XCTAssertTrue(s4.string == "Hello World!!🤖")
      XCTAssertFalse(s4 is NSMutableAttributedString)
    }
    
    /// addition between NSAttributedString and String
    do {
      let s1 = NSAttributedString(string: "Hello World")
      let s2 = "!!"
      let s3 = "🤖"
      
      let s4 = s1 + s2 + s3 // NSAttributedString + String + String
      XCTAssertTrue(s4.string == "Hello World!!🤖")
      XCTAssertFalse(s4 is NSMutableAttributedString)
    }
    
    /// addition between String and NSAttributedString
    do {
      let s1 = "Hello World"
      let s2 = NSAttributedString(string: "!!")
      let s3 = NSAttributedString(string: "🤖")
      
      let s4 = s1 + s2 + s3 // String + NSAttributedString + NSAttributedString
      XCTAssertTrue(s4.string == "Hello World!!🤖")
      XCTAssertFalse(s4 is NSMutableAttributedString)
    }
    
    do {
      let s1 = "Hello World"
      let s2 = NSAttributedString(string: "!!")
      
      let s3 = s1 + s2 // String + NSAttributedString
      XCTAssertTrue(s3.string == "Hello World!!")
      XCTAssertFalse(s3 is NSMutableAttributedString)
    }
    
  }
  
}

