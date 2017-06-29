//
//  NSAttributedStringOperatorsTests.swift
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

class NSAttributedStringOperatorsTests: XCTestCase {
    
  func testAddition() {
   
    /// addition between NSAttributedStrings
    do {
      let s1 = NSAttributedString(string: "Hello World")
      let s2 = NSAttributedString(string: "!!")
      let s3 = NSAttributedString(string: "🤖")
      
      let s4 = s1 + s2 + s3
      XCTAssertTrue(s4.string == "Hello World!!🤖")
      XCTAssertFalse(s4 is NSMutableAttributedString)
    }
    
    /// addition between NSAttributedString and String
    do {
      let s1 = NSAttributedString(string: "Hello World")
      let s2 = "!!"
      let s3 = "🤖"
      
      let s4 = s1 + s2 + s3
      XCTAssertTrue(s4.string == "Hello World!!🤖")
      XCTAssertFalse(s4 is NSMutableAttributedString)
    }
    
    /// addition between String and NSAttributedString
    do {
      let s1 = "Hello World"
      let s2 = NSAttributedString(string: "!!")
      let s3 = NSAttributedString(string: "🤖")
      
      let s4 = s1 + s2 + s3
      XCTAssertTrue(s4.string == "Hello World!!🤖")
      XCTAssertFalse(s4 is NSMutableAttributedString)
    }
  }
  
}
