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

class ImageUtilsTests: XCTestCase {
  
  func testHasAlpha() {
    let url = URL(string:"https://raw.githubusercontent.com/tinrobots/Mechanica/test-resources/pic.png")!
    let url2 = URL(string: "https://raw.githubusercontent.com/tinrobots/Mechanica/test-resources/pic_no_alpha.jpeg")!
    
    let image: Image
    let imageNoAlpha: Image
    
    #if os(macOS)
      image = NSImage(contentsOf: url)!
      imageNoAlpha = NSImage(contentsOf: url2)!
    #elseif os(iOS) || os(tvOS) || os(watchOS)
      let data = try! Data(contentsOf: url)
      let data2 = try! Data(contentsOf: url2)
      image = Image(data: data)!
      imageNoAlpha = Image(data: data2)!
    #endif
    
    XCTAssertTrue(image.hasAlpha)
    XCTAssertFalse(imageNoAlpha.hasAlpha)
  }
  
}
