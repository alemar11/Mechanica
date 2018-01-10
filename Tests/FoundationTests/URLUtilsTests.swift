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

extension URLUtilsTests {
  static var allTests = [
    ("testQueryParameters", testQueryParameters),
    ("testDeletingLastPathComponents", testDeletingLastPathComponents),
    ("testIsDirectoryOrFile", testIsDirectoryOrFile),
    ("testIsParent", testIsParent),
    ]
}

class URLUtilsTests: XCTestCase {
  
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
  
  func testDeletingLastPathComponents() {
    do {
      var url = URL(string: "http://tinrobots.org/services/test/demo")!
      url.deleteLastPathComponents(0)
      XCTAssertEqual(url, URL(string: "http://tinrobots.org/services/test/demo")!)
      url.deleteLastPathComponents(2)
      XCTAssertEqual(url, URL(string: "http://tinrobots.org/services/")!)
      url.deleteLastPathComponents(3)
      XCTAssertEqual(url, URL(string: "http://tinrobots.org/../../")!)
    }
    
    do {
      var url = URL(string: "http://tinrobots.org")!
      url.deleteLastPathComponents(0)
      XCTAssertEqual(url, URL(string: "http://tinrobots.org")!)
      url.deleteLastPathComponents(2)
      XCTAssertEqual(url, URL(string: "http://tinrobots.org")!)
    }
  }
  
  func testIsParent() {
    let url = URL(string: "/path/to/folder")!
    XCTAssertTrue(url.isParent(of: URL(string: "/path/to/folder/child")!))
    XCTAssertFalse(url.isParent(of: URL(string: "/path/folder/child")!))
    XCTAssertFalse(url.isParent(of: URL(string: "/")!))
    XCTAssertFalse(url.isParent(of: URL(string: ".")!))
  }

  func testIsDirectoryOrFile() throws {
    // Given
    let folderPath = "/tmp/org.tinrobots.Mechanica-\(UUID().uuidString)"

    // When, Then
    let url = URL(fileURLWithPath: folderPath)
    XCTAssertFalse(url.isDirectory)
    XCTAssertFalse(url.isFile)

    if !FileManager.default.fileExists(atPath: folderPath) {
      try FileManager.default.createDirectory(atPath: folderPath, withIntermediateDirectories: false, attributes: nil)
    }

    XCTAssertTrue(url.isDirectory)
    XCTAssertFalse(url.isFile)

    // When, Then
    let filePath = folderPath + "/" + "TestFile.txt"
    let url2 = URL(fileURLWithPath: filePath)
    XCTAssertFalse(url2.isDirectory)
    XCTAssertFalse(url.isFile)

    XCTAssertTrue(FileManager.default.createFile(atPath: filePath, contents: Data(), attributes: nil))
    XCTAssertTrue(url2.isFile)
    XCTAssertFalse(url2.isDirectory)

    /// destroy the tmp folder
    try FileManager.default.deleteFileOrDirectory(atPath: folderPath)
    XCTAssertFalse(FileManager.default.fileExists(atPath: folderPath))
  }

}
