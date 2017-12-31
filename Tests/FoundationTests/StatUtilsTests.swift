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

extension StatUtilsTests {
  static var allTests = [
    ("testIsDirectory", testIsDirectory),
    ("testIsFile", testIsFile),
    ("testIsLink", testIsLink)
  ]
}

class StatUtilsTests: XCTestCase {

  func testIsDirectory() throws {
    let tmpPath = "/tmp"

    do {
      var result = Stat()
      stat(tmpPath, &result)
      XCTAssertTrue(result.isDirectory)
      XCTAssertFalse(result.isFile)
      XCTAssertFalse(result.isLink)
    }

    do {
      let folderPath = tmpPath + "/" + "test"
      try FileManager.default.createDirectory(atPath: folderPath, withIntermediateDirectories: false, attributes: nil)

      var result = Stat()
      stat(folderPath, &result)
      XCTAssertTrue(result.isDirectory)
      XCTAssertFalse(result.isFile)
      XCTAssertFalse(result.isLink)

      try FileManager.default.removeItem(atPath: folderPath)
    }

  }

  func testIsFile() throws {
    let tmpPath = "/tmp"
    let filePath = tmpPath + "/" + "file.txt"

    XCTAssertTrue(FileManager.default.createFile(atPath: filePath, contents: Data(), attributes: nil))

    var result = Stat()
    stat(filePath, &result)
    XCTAssertFalse(result.isDirectory)
    XCTAssertTrue(result.isFile)
    XCTAssertFalse(result.isLink)

    try FileManager.default.removeItem(atPath: filePath)

  }

  func testIsLink() throws {
    let tmpPath = "/tmp"
    let filePath = tmpPath + "/" + "file.txt"
    let linkPath = tmpPath + "/" + "link"

    XCTAssertTrue(FileManager.default.createFile(atPath: filePath, contents: Data(), attributes: nil))
    try FileManager.default.createSymbolicLink(atPath: linkPath, withDestinationPath: filePath)

    do {
      var result = Stat()
      // lstat() is identical to stat(), except that if pathname is a symbolic link, then it returns information about the link itself, not the file that it refers to.
      lstat(linkPath, &result)
      XCTAssertFalse(result.isDirectory)
      XCTAssertFalse(result.isFile)
      XCTAssertTrue(result.isLink)
    }

    do {
      var result = Stat()
      stat(linkPath, &result)
      XCTAssertFalse(result.isDirectory)
      XCTAssertTrue(result.isFile)
      XCTAssertFalse(result.isLink)
    }

    try FileManager.default.removeItem(atPath: linkPath)
    try FileManager.default.removeItem(atPath: filePath)
  }

}
