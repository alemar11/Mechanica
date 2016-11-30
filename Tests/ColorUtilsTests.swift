//
//  ColorUtilsTests.swift
//  Mechanica
//
//  Copyright © 2016 Tinrobots.
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

class ColorUtilsTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func test_rgba() {
    do {
      let red = Color.red // 1.0, 0.0, 0.0
      XCTAssertNotNil(red.rgba)
      let (r,g,b,a) = red.rgba!
      XCTAssert(r == 255, "")
      XCTAssert(g == 0, "")
      XCTAssert(b == 0, "")
      XCTAssert(a == 255, "")
    }
    
    do {
      let black = Color.black // 0.0, 0.0, 0.0
      XCTAssertNotNil(black.rgba)
      let (r,g,b,a) = black.rgba!
      XCTAssert(r == 0, "")
      XCTAssert(g == 0, "")
      XCTAssert(b == 0, "")
      XCTAssert(a == 255, "")
    }
  }
  
  func test_color_components() {
    //orange (255,165,0)
    #if os(iOS) || os(tvOS) || os(watchOS)
      let orange = Color(red: 255/255, green: 165/255, blue: 0, alpha: 1)
    #elseif os(OSX)
      let orange = Color(calibratedRed: 255/255, green: 165/255, blue: 0, alpha: 1)
    #endif
    XCTAssertNotNil(orange.rgba)
    let (r,g,b,a) = orange.rgba!
    XCTAssert(r == 255, "")
    XCTAssert(g == 165, "")
    XCTAssert(b == 0, "")
    XCTAssert(a == 255, "")
  }
  
  func test_hex() {
    do {
      //purple (85,26,139) "#551a8b"
      let purple = Color(hexString: "#551a8b", alpha: 1)
      XCTAssertNotNil(purple)
      let (r,g,b,a) = purple!.rgba!
      XCTAssert(r == 85, "")
      XCTAssert(g == 26, "")
      XCTAssert(b == 139, "")
      XCTAssert(a == 255, "")
    }
    
    do {
      //purple (85,26,139) "#551a8b"
      let purple = Color(hexString: "#551A8B", alpha: 1)
      XCTAssertNotNil(purple)
      let (r,g,b,a) = purple!.rgba!
      XCTAssert(r == 85, "")
      XCTAssert(g == 26, "")
      XCTAssert(b == 139, "")
      XCTAssert(a == 255, "")
    }
    
    do {
      //green (0,128,0) "#008000"
      let green = Color(hexString: "#008000", alpha: 1)
      XCTAssertNotNil(green)
      let (r,g,b,a) = green!.rgba!
      XCTAssert(r == 0, "")
      XCTAssert(g == 128, "")
      XCTAssert(b == 0, "")
      XCTAssert(a == 255, "")
    }
    
    do {
      let aqua = Color(hexString: "#0ff", alpha: 1)
      XCTAssertNotNil(aqua)
      
      let black = Color(hexString: "#000", alpha: 1)
      XCTAssertNotNil(black)
      
      let blue = Color(hexString: "#00f", alpha: 1)
      XCTAssertNotNil(blue)
      
      let fuchsia = Color(hexString: "#f0f", alpha: 1)
      XCTAssertNotNil(fuchsia)
      
      let lime = Color(hexString: "0f0", alpha: 1)
      XCTAssertNotNil(lime)
      
      let red = Color(hexString: "f00", alpha: 1)
      XCTAssertNotNil(red)
      XCTAssert(red!.rgba! == Color.red.rgba!)
      
      let white = Color(hexString: "fff", alpha: 1)
      XCTAssertNotNil(white)
      XCTAssert(white!.rgba! == Color.white.rgba!)
      
      let yellow = Color(hexString: "ff0", alpha: 1)
      XCTAssertNotNil(yellow)
      XCTAssert(yellow!.rgba! == Color.yellow.rgba!)
    }
    
    do {
      let wrongColor = Color(hexString: "#551A8B1", alpha: 1)
      XCTAssertNil(wrongColor)
      let wrongColor2 = Color(hexString: "#551A8", alpha: 1)
      XCTAssertNil(wrongColor2)
      let wrongColor3 = Color(hexString: "#", alpha: 1)
      XCTAssertNil(wrongColor3)
      let wrongColor4 = Color(hexString: " #551A8B", alpha: 1)
      XCTAssertNil(wrongColor4)
      let wrongColor5 = Color(hexString: "ff  ", alpha: 1)
      XCTAssertNil(wrongColor5)
    }
    
  }
  
}
