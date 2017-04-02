//
//  NSMutableAttributedStringOperatorsTests.swift
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

class NSMutableAttributedStringOperatorsTests: XCTestCase {
  
  func test_addition() {
    
    /// addition between NSMutableAttributedStrings
    do {
      let s1 = NSMutableAttributedString(string: "Hello")
      let s2 = NSMutableAttributedString(string: " ")
      let s3 = NSMutableAttributedString(string: "World")
      
      let s4 = s1 + s2 + s3
      XCTAssertTrue(s4.string == "Hello World")
    }
    
    do {
      let s1 = NSMutableAttributedString(string: "Hello", attributes: [NSForegroundColorAttributeName: Color.red])
      let s2 = NSMutableAttributedString(string: " ")
      let s3 = NSMutableAttributedString(string: "World", attributes: [NSBackgroundColorAttributeName: Color.yellow])
      
      let s4 = s1 + s2 + s3
      let firstCharAttributes = s4.attributes(at: 0, longestEffectiveRange: nil, in: NSMakeRange(0, 0))
      let lastCharAttributes = s4.attributes(at: 10, longestEffectiveRange: nil, in: NSMakeRange(9, 10))
      let redColor = firstCharAttributes[NSForegroundColorAttributeName] as? Color
      let yellowColor = lastCharAttributes[NSBackgroundColorAttributeName] as? Color
      XCTAssertTrue(s1 !== s4)
      XCTAssertNotNil(redColor)
      XCTAssertNotNil(yellowColor)
      XCTAssertTrue(redColor! == .red)
      XCTAssertTrue(yellowColor! == .yellow)
      XCTAssertTrue(s4.string == "Hello World")
    }
    
    /// addition between NSMutableAttributedStrings and NSAttributedString
    do {
      let s1 = NSMutableAttributedString(string: "Hello", attributes: [NSForegroundColorAttributeName: Color.red])
      let s2 = NSMutableAttributedString(string: " ")
      let s3 = NSAttributedString(string: "World", attributes: [NSBackgroundColorAttributeName: Color.yellow])
      
      let s4 = s1 + s2 + s3
      let firstCharAttributes = s4.attributes(at: 0, longestEffectiveRange: nil, in: NSMakeRange(0, 0))
      let lastCharAttributes = s4.attributes(at: 10, longestEffectiveRange: nil, in: NSMakeRange(9, 10))
      let redColor = firstCharAttributes[NSForegroundColorAttributeName] as? Color
      let yellowColor = lastCharAttributes[NSBackgroundColorAttributeName] as? Color
      XCTAssertTrue(s1 !== s4)
      XCTAssertNotNil(redColor)
      XCTAssertNotNil(yellowColor)
      XCTAssertTrue(redColor! == .red)
      XCTAssertTrue(yellowColor! == .yellow)
      XCTAssertTrue(s4.string == "Hello World")
    }
    
    /// addition between NSAttributedStrings and NSMutableAttributedString
    do {
      let s1 = NSAttributedString(string: "Hello", attributes: [NSForegroundColorAttributeName: Color.red])
      let s2 = NSMutableAttributedString(string: " ")
      let s3 = NSAttributedString(string: "World", attributes: [NSBackgroundColorAttributeName: Color.yellow])
      
      let s4 = s1 + s2 + s3
      let firstCharAttributes = s4.attributes(at: 0, longestEffectiveRange: nil, in: NSMakeRange(0, 0))
      let lastCharAttributes = s4.attributes(at: 10, longestEffectiveRange: nil, in: NSMakeRange(9, 10))
      let redColor = firstCharAttributes[NSForegroundColorAttributeName] as? Color
      let yellowColor = lastCharAttributes[NSBackgroundColorAttributeName] as? Color
      XCTAssertTrue(s1 !== s4)
      XCTAssertNotNil(redColor)
      XCTAssertNotNil(yellowColor)
      XCTAssertTrue(redColor! == .red)
      XCTAssertTrue(yellowColor! == .yellow)
      XCTAssertTrue(s4.string == "Hello World")
    }
    
    /// addition between NSAttributedString, String and NSMutableAttributedString
    do {
      let s1 = NSAttributedString(string: "Hello", attributes: [NSForegroundColorAttributeName: Color.red])
      let s2 = " "
      let s3 = NSMutableAttributedString(string: "World", attributes: [NSBackgroundColorAttributeName: Color.yellow])
      
      let s4 = s1 + s2 + s3
      let firstCharAttributes = s4.attributes(at: 0, longestEffectiveRange: nil, in: NSMakeRange(0, 0))
      let lastCharAttributes = s4.attributes(at: 10, longestEffectiveRange: nil, in: NSMakeRange(9, 10))
      let redColor = firstCharAttributes[NSForegroundColorAttributeName] as? Color
      let yellowColor = lastCharAttributes[NSBackgroundColorAttributeName] as? Color
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
      let s3 = NSMutableAttributedString(string: "World", attributes: [NSBackgroundColorAttributeName: Color.yellow])
      
      let s4 = s1 + s2 + s3
      let firstCharAttributes = s4.attributes(at: 0, longestEffectiveRange: nil, in: NSMakeRange(0, 0))
      let lastCharAttributes = s4.attributes(at: 10, longestEffectiveRange: nil, in: NSMakeRange(9, 10))
      let yellowColor = lastCharAttributes[NSBackgroundColorAttributeName] as? Color
      XCTAssertTrue(firstCharAttributes.isEmpty)
      XCTAssertNotNil(yellowColor)
      XCTAssertTrue(yellowColor! == .yellow)
      XCTAssertTrue(s4.string == "Hello World")
    }
    
  }
  
  func test_compoundAddition() {
    do {
      let s = NSMutableAttributedString(string: "Hello", attributes: [NSForegroundColorAttributeName: Color.red])
      s += " "
      s += NSAttributedString(string: "World", attributes: [NSBackgroundColorAttributeName: Color.yellow])
      
      let firstCharAttributes = s.attributes(at: 0, longestEffectiveRange: nil, in: NSMakeRange(0, 0))
      let lastCharAttributes = s.attributes(at: 10, longestEffectiveRange: nil, in: NSMakeRange(9, 10))
      let redColor = firstCharAttributes[NSForegroundColorAttributeName] as? Color
      let yellowColor = lastCharAttributes[NSBackgroundColorAttributeName] as? Color
      XCTAssertNotNil(redColor)
      XCTAssertNotNil(yellowColor)
      XCTAssertTrue(redColor! == .red)
      XCTAssertTrue(yellowColor! == .yellow)
      XCTAssertTrue(s.string == "Hello World")
    }
    
    do {
      let s = NSMutableAttributedString(string: "Hello", attributes: [NSForegroundColorAttributeName: Color.red])
      s += NSMutableAttributedString(string: " ")
      s += NSAttributedString(string: "World", attributes: [NSBackgroundColorAttributeName: Color.yellow])
      
      let firstCharAttributes = s.attributes(at: 0, longestEffectiveRange: nil, in: NSMakeRange(0, 0))
      let lastCharAttributes = s.attributes(at: 10, longestEffectiveRange: nil, in: NSMakeRange(9, 10))
      let redColor = firstCharAttributes[NSForegroundColorAttributeName] as? Color
      let yellowColor = lastCharAttributes[NSBackgroundColorAttributeName] as? Color
      XCTAssertNotNil(redColor)
      XCTAssertNotNil(yellowColor)
      XCTAssertTrue(redColor! == .red)
      XCTAssertTrue(yellowColor! == .yellow)
      XCTAssertTrue(s.string == "Hello World")
    }
  }
  
}


