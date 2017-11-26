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

class URLUtilsTests: XCTestCase {

  static var allTests = [
    ("testAddition", testAddition),
    ("testQueryParameters", testQueryParameters),
  ]

  func testAddition() {

    let url   = URL(fileURLWithPath: "")
    let url2  = URL(fileURLWithPath: "tinrobots")
    let url3  = URL(fileURLWithPath: "www.tinrobots.org/demo")
    let url4  = URL(fileURLWithPath: "http://www.tinrobots.org/demo")

    do {
      // Given, When
      let additionalPath = "test"
      let newURL = url + additionalPath
      let newURL2 = url2 + additionalPath
      let newURL3 = url3 + additionalPath
      let newURL4 = url4 + additionalPath
      // Then
      XCTAssertTrue(newURL.lastPathComponent == "test")
      XCTAssertTrue(newURL.pathExtension == "")
      XCTAssertTrue(newURL2.lastPathComponent == "test")
      XCTAssertTrue(newURL2.pathExtension == "")
      XCTAssertTrue(newURL3.lastPathComponent == "test")
      XCTAssertTrue(newURL3.pathExtension == "")
      XCTAssertTrue(newURL4.lastPathComponent == "test")
      XCTAssertTrue(newURL4.pathExtension == "")
    }

    do {
      // Given, When
      let additionalPath = "test.png"
      let newURL = url + additionalPath
      let newURL2 = url2 + additionalPath
      let newURL3 = url3 + additionalPath
      let newURL4 = url4 + additionalPath
      // Then
      XCTAssertTrue(newURL.lastPathComponent == "test.png")
      XCTAssertTrue(newURL.pathExtension == "png")
      XCTAssertTrue(newURL2.lastPathComponent == "test.png")
      XCTAssertTrue(newURL2.pathExtension == "png")
      XCTAssertTrue(newURL3.lastPathComponent == "test.png")
      XCTAssertTrue(newURL3.pathExtension == "png")
      XCTAssertTrue(newURL4.lastPathComponent == "test.png")
      XCTAssertTrue(newURL4.pathExtension == "png")
    }

    do {
      // Given, When
      let additionalPath = "/demo/test.png"
      let newURL = url + additionalPath
      let newURL2 = url2 + additionalPath
      let newURL3 = url3 + additionalPath
      let newURL4 = url4 + additionalPath
      // Then
      XCTAssertTrue(newURL.lastPathComponent == "test.png")
      XCTAssertTrue(newURL.pathExtension == "png")
      XCTAssertTrue(newURL2.lastPathComponent == "test.png")
      XCTAssertTrue(newURL2.pathExtension == "png")
      XCTAssertTrue(newURL3.lastPathComponent == "test.png")
      XCTAssertTrue(newURL3.pathExtension == "png")
      XCTAssertTrue(newURL4.lastPathComponent == "test.png")
      XCTAssertTrue(newURL4.pathExtension == "png")
    }
//
//    do {
//      // Given, When
//      let additionalPath = ""
//      let newURL = url + additionalPath
//      let newURL2 = url2 + additionalPath
//      let newURL3 = url3 + additionalPath
//      let newURL4 = url4 + additionalPath
//      // Then
//      XCTAssertTrue(newURL.lastPathComponent == url.lastPathComponent)
//      XCTAssertTrue(newURL.pathExtension == "")
//      XCTAssertTrue(newURL2.lastPathComponent == url2.lastPathComponent)
//      XCTAssertTrue(newURL2.pathExtension == "")
//      XCTAssertTrue(newURL3.lastPathComponent == url3.lastPathComponent)
//      XCTAssertTrue(newURL3.pathExtension == "")
//      XCTAssertTrue(newURL4.lastPathComponent == url3.lastPathComponent)
//      XCTAssertTrue(newURL4.pathExtension == "")
//    }

  }

  func testQueryParameters() {
    do {
      let url = URL(string: "http://tinrobots.org/services/test/demo?v=1.1&q=hello")

      if let queryParameters = url?.queryParameters {
        XCTAssertEqual(queryParameters["v"], Optional("1.1"))
        XCTAssertEqual(queryParameters["q"], Optional("hello"))
        XCTAssertEqual(queryParameters["other"], nil)
      }
    }

    do {
      let url = URL(string: "http://tinrobots.org/services/test/demo?")
      XCTAssertNil(url!.queryParameters)
    }
  }

}
