//
//  FileManagerUtilsTests.swift
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

class FileManagerUtilsTests: XCTestCase {

  func test_clearOrDestroyDirectory() {

    let directoryURL = FileManager.documentDirectory

    let containerURL                = directoryURL.appendingPathComponent("org.tinrobots.tests", isDirectory: true)

    let baseDemoURL                 = containerURL.appendingPathComponent("demo", isDirectory: true)          // org.tinrobots.tests/demo/
    let fakeBaseDirectoryURL        = containerURL.appendingPathComponent("fakeDemo", isDirectory: true)      // org.tinrobots.tests/fakeDemo/
    let fakeBaseDirectorAsFileyURL  = containerURL.appendingPathComponent("fakeDemoFile", isDirectory: false) // org.tinrobots.tests/fakeDemoFile

    let testURL                     = baseDemoURL.appendingPathComponent("test", isDirectory: true)           // org.tinrobots.tests/demo/test/
    let testFileURL                 = testURL.appendingPathComponent("file", isDirectory: false)              // org.tinrobots.tests/demo/test/file

    // creation
    do {
      try FileManager.default.createDirectory(at: testURL, withIntermediateDirectories: true, attributes: nil)
      XCTAssertTrue(FileManager.default.fileExists(atPath: containerURL.path))
      FileManager.default.createFile(atPath: testFileURL.path, contents: Data(), attributes: nil)
      FileManager.default.createFile(atPath: fakeBaseDirectorAsFileyURL.path, contents: Data(), attributes: nil)
    } catch {
      XCTAssertTrue(false, error.localizedDescription)
    }

    // cleaning
    do {
      try FileManager.clearDirectory(atPath: baseDemoURL.path)
      try FileManager.clearDirectory(atPath: fakeBaseDirectoryURL.path)
      try FileManager.clearDirectory(atPath: fakeBaseDirectorAsFileyURL.path)
      XCTAssertTrue(FileManager.default.fileExists(atPath: baseDemoURL.path), "The directory at path \(baseDemoURL.path) should exists.")
      XCTAssertTrue(try FileManager.default.contentsOfDirectory(atPath: baseDemoURL.path).count == 0, "The directory at path \(baseDemoURL.path) should be empty.")
      XCTAssertTrue(FileManager.default.fileExists(atPath: fakeBaseDirectorAsFileyURL.path), "The file at path \(fakeBaseDirectorAsFileyURL.path) should exists")
      XCTAssertTrue(!FileManager.default.fileExists(atPath: testURL.path), "The directory at path \(testURL.path) shouldn't exists")
      try FileManager.default.destroyFileOrDirectory(atPath: containerURL.path)
    } catch {
      XCTAssertTrue(false, error.localizedDescription)
    }

  }

}
