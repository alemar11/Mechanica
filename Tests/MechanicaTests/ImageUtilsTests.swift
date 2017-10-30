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
    
    let image = NSImage(contentsOf: URL(string: "https://qph.ec.quoracdn.net/main-qimg-968f41225522207012dd378705832939")!)!
    XCTAssertTrue(image.hasAlpha)
  }
  
}

extension NSImage {
  class func imageNamed(name: String, inBundle bundle: Bundle?) -> NSImage? {
    var image = NSImage(named: NSImage.Name(rawValue: name))
    
    if let image = image { return image }
    
    image = bundle?.image(forResource: NSImage.Name(rawValue: name))
    
    if let image = image {
      image.setName(NSImage.Name(rawValue: name))
      return image
    }
    
    return nil
  }
}
