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

@available(iOS 10, tvOS 10, watchOS 3, macOS 10.12, *)
class FileManagerUtilsTests: XCTestCase {

  func testClearOrDestroyDirectory() {

    // Given
    let directories = [FileManager.default.userDocumentDirectory,
                       FileManager.default.userLibraryDirectory,
                       FileManager.default.userCachesDirectory,
                       FileManager.default.userApplicationSupportDirectory,
                       FileManager.default.temporaryDirectory].flatMap {$0}

    XCTAssertTrue(directories.count == 5)

    // When
    directories.enumerated().forEach { arg in

      let (_, directoryURL) = arg
      let containerURL                = directoryURL.appendingPathComponent("org.tinrobots.tests", isDirectory: true)
      let baseDemoURL                 = containerURL.appendingPathComponent("demo", isDirectory: true)          // org.tinrobots.tests/demo/
      let fakeBaseDirectoryURL        = containerURL.appendingPathComponent("fakeDemo", isDirectory: true)      // org.tinrobots.tests/fakeDemo/
      let fakeBaseDirectoryAsFileyURL = containerURL.appendingPathComponent("fakeDemoFile", isDirectory: false) // org.tinrobots.tests/fakeDemoFile
      let testURL                     = baseDemoURL.appendingPathComponent("test", isDirectory: true)           // org.tinrobots.tests/demo/test/
      let testFileURL                 = testURL.appendingPathComponent("file", isDirectory: false)              // org.tinrobots.tests/demo/test/file

      // Then

      /// creation
      do {
        try FileManager.default.createDirectory(at: testURL, withIntermediateDirectories: true, attributes: nil)
        XCTAssertTrue(FileManager.default.fileExists(atPath: containerURL.path))

        XCTAssertFalse(FileManager.default.fileExists(atPath: testFileURL.path))
        XCTAssertTrue(FileManager.default.createFile(atPath: testFileURL.path, contents: Data(), attributes: nil))
        XCTAssertTrue(FileManager.default.fileExists(atPath: testFileURL.path))

        XCTAssertFalse(FileManager.default.fileExists(atPath: fakeBaseDirectoryAsFileyURL.path))
        XCTAssertTrue(FileManager.default.createFile(atPath: fakeBaseDirectoryAsFileyURL.path, contents: Data(), attributes: nil))
        XCTAssertTrue(FileManager.default.fileExists(atPath: fakeBaseDirectoryAsFileyURL.path))

      } catch {
        XCTFail(error.localizedDescription)
      }

      /// cleaning
      do {
        try FileManager.default.clearDirectory(atPath: baseDemoURL.path)
        try FileManager.default.clearDirectory(atPath: fakeBaseDirectoryURL.path)
        try FileManager.default.clearDirectory(atPath: fakeBaseDirectoryAsFileyURL.path)
        XCTAssertTrue(FileManager.default.fileExists(atPath: baseDemoURL.path), "The directory at path \(baseDemoURL.path) should exists.")
        XCTAssertTrue(try FileManager.default.contentsOfDirectory(atPath: baseDemoURL.path).count == 0, "The directory at path \(baseDemoURL.path) should be empty.")
        XCTAssertTrue(FileManager.default.fileExists(atPath: fakeBaseDirectoryAsFileyURL.path), "The file at path \(fakeBaseDirectoryAsFileyURL.path) should exists.")
        XCTAssertTrue(!FileManager.default.fileExists(atPath: testURL.path), "The directory at path \(testURL.path) shouldn't exists.")
        try FileManager.default.destroyFileOrDirectory(atPath: containerURL.path)
        XCTAssertNotNil(try? FileManager.default.destroyFileOrDirectory(atPath: containerURL.path))
      } catch {
        XCTFail(error.localizedDescription)
      }
    }

  }

  func testNewCachesSubdirectory() {
    // Given
    let newCacheDirectory = FileManager.default.makeNewUserCachesSubDirectory
    // When
    if let newCacheDirectory = newCacheDirectory {

    XCTAssertTrue(FileManager.default.fileExists(atPath: newCacheDirectory.path))

    // Then
    do {
      try FileManager.default.destroyFileOrDirectory(atPath: newCacheDirectory.path)
    } catch {
      XCTFail(error.localizedDescription)
    }
    } else {
      XCTAssertNotNil(newCacheDirectory)
    }
  }

}
