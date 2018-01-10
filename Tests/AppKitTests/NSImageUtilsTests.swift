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

#if os(macOS)

  class NSImageUtilsTests: XCTestCase {

    func testImageNamed() {
      let bundle = Bundle(for: NSImageUtilsTests.self)
      let image = NSImage.imageNamed(name: "pic", in: bundle)

      if !ProcessInfo.isRunningSwiftPackageTests {
        // Not implemented (SPM): https://bugs.swift.org/browse/SR-2866
        XCTAssertNotNil(image)
        XCTAssertEqual(image!.name()?.rawValue, "pic")
      }
    }

    func testCGImage() throws {
      var resources = URL(fileURLWithPath: #file, isDirectory: false).deletingLastPathComponents(2)
      resources.appendPathComponent("Resources")

      let url = resources.appendingPathComponent("pic.png")
      let data = try Data(contentsOf: url)
      let image = NSImage(data: data)
      let cgImage = image?.cgImage

      XCTAssertNotNil(cgImage)
      XCTAssertEqual(cgImage!.width, 483)
      XCTAssertEqual(cgImage!.height, 221)
    }

  }

#endif
