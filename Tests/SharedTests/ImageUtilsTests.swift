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

  func testBase64EncodedString() {
    let robot = "data:image/png;base64,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"

    XCTAssertNotNil(Image(base64Encoded: robot))

    let emoji = "data:image/png;base64,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"

    XCTAssertNotNil(Image(base64Encoded: emoji))


    let broken = "data:image/png;base64,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"

    XCTAssertNil(Image(base64Encoded: broken))

    XCTAssertNil(Image(base64Encoded: "this is a random string"))

  }

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
