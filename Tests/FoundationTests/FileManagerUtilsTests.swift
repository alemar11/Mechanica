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

extension FileManager {

  #if !os(Linux)
  // Not implemented on Linux: url(for:in:appropriateFor:create:)

  /// **Mechanica**
  ///
  /// Creates and returns always a `new` directory in Library/Caches in the user's home directory for discardable cache files.
  fileprivate func newCachesSubDirectory(in domain: FileManager.SearchPathDomainMask = .userDomainMask, withName name: String = UUID().uuidString) throws -> URL {
    let cachesDirectoryURL = try self.url(for: .cachesDirectory, in: domain, appropriateFor: nil, create: true)
    let subdirectoryURL = cachesDirectoryURL.appendingPathComponent(name)

    if !fileExists(atPath: subdirectoryURL.path) {
      try createDirectory(at: subdirectoryURL, withIntermediateDirectories: false, attributes: nil)
    }

    return subdirectoryURL
  }

  #endif

}

@available(iOS 10, tvOS 10, watchOS 3, macOS 10.12, *)
class FileManagerUtilsTests: XCTestCase {

  static var allTests = [("testDestroyFileOrDirectory", testDestroyFileOrDirectory)]

  func testDestroyFileOrDirectory() throws {
    // Given
    let tmpFolderPath = "/tmp/org.tinrobots.Mechanica-\(UUID().uuidString)"
    if !FileManager.default.fileExists(atPath: tmpFolderPath) {
      try FileManager.default.createDirectory(atPath: tmpFolderPath, withIntermediateDirectories: false, attributes: nil)
    }

    // When
    let testFilePath = tmpFolderPath + "/" + "TestFile.txt"
    let testFolderPath = tmpFolderPath + "/" + "TestDirectory"
    XCTAssertTrue(FileManager.default.createFile(atPath: testFilePath, contents: Data(), attributes: nil))
    try FileManager.default.createDirectory(atPath: testFolderPath, withIntermediateDirectories: false, attributes: nil)

    // Then
    XCTAssertTrue(FileManager.default.fileExists(atPath: tmpFolderPath))
    XCTAssertTrue(FileManager.default.fileExists(atPath: testFilePath))
    XCTAssertTrue(FileManager.default.fileExists(atPath: testFolderPath))

    try FileManager.default.deleteFileOrDirectory(atPath: tmpFolderPath)
    XCTAssertFalse(FileManager.default.fileExists(atPath: tmpFolderPath))

  }

  func testCleanDirectory() throws {
    // Given
    let tmpFolderPath = "/tmp/org.tinrobots.Mechanica-\(UUID().uuidString)"
    if !FileManager.default.fileExists(atPath: tmpFolderPath) {
      try FileManager.default.createDirectory(atPath: tmpFolderPath, withIntermediateDirectories: false, attributes: nil)
    }

    // When
    let testFilePath = tmpFolderPath + "/" + "TestFile.txt"
    let testFolderPath = tmpFolderPath + "/" + "TestDirectory"
    XCTAssertTrue(FileManager.default.createFile(atPath: testFilePath, contents: Data(), attributes: nil))
    try FileManager.default.createDirectory(atPath: testFolderPath, withIntermediateDirectories: false, attributes: nil)

    // Then
    XCTAssertTrue(FileManager.default.fileExists(atPath: tmpFolderPath))
    XCTAssertTrue(FileManager.default.fileExists(atPath: testFilePath))
    XCTAssertTrue(FileManager.default.fileExists(atPath: testFolderPath))

    try FileManager.default.cleanDirectory(atPath: tmpFolderPath)
    XCTAssertTrue(FileManager.default.fileExists(atPath: tmpFolderPath))
    XCTAssertFalse(FileManager.default.fileExists(atPath: testFilePath))
    XCTAssertFalse(FileManager.default.fileExists(atPath: testFilePath))

    /// destroy the tmp folder
    try FileManager.default.deleteFileOrDirectory(atPath: tmpFolderPath)
    XCTAssertFalse(FileManager.default.fileExists(atPath: testFolderPath))
  }

  #if !os(Linux)

  func testCleanOrDestroyDirectory() throws {

    // Given
    let subdirectory1 = try FileManager.default.newCachesSubDirectory()
    let subdirectory2 = try FileManager.default.newCachesSubDirectory()

    XCTAssertTrue(subdirectory1 != subdirectory2)

    let directories = [subdirectory1, subdirectory2]

    // When
    try directories.enumerated().forEach { arg in

      let (_, directoryURL) = arg
      let containerURL                = directoryURL.appendingPathComponent("org.tinrobots.tests", isDirectory: true)
      let baseURL                     = containerURL.appendingPathComponent("demo", isDirectory: true)                  // org.tinrobots.tests/demo/
      let fakeBaseDirectoryURL        = containerURL.appendingPathComponent("fakeDemo", isDirectory: true)              // org.tinrobots.tests/fakeDemo/
      let fakeBaseDirectoryAsFileyURL = containerURL.appendingPathComponent("fakeDemoFile", isDirectory: false)         // org.tinrobots.tests/fakeDemoFile
      let testDirectoryURL            = baseURL.appendingPathComponent("test", isDirectory: true)                       // org.tinrobots.tests/demo/test/
      let testFileURL                 = testDirectoryURL.appendingPathComponent("file", isDirectory: false)             // org.tinrobots.tests/demo/test/file

      // Then

      /// creation
      try FileManager.default.createDirectory(at: testDirectoryURL, withIntermediateDirectories: true, attributes: nil)
      XCTAssertTrue(FileManager.default.fileExists(atPath: containerURL.path))

      XCTAssertFalse(FileManager.default.fileExists(atPath: testFileURL.path))
      XCTAssertTrue(FileManager.default.createFile(atPath: testFileURL.path, contents: Data(), attributes: nil))
      XCTAssertTrue(FileManager.default.fileExists(atPath: testFileURL.path))

      XCTAssertFalse(FileManager.default.fileExists(atPath: fakeBaseDirectoryAsFileyURL.path))
      XCTAssertTrue(FileManager.default.createFile(atPath: fakeBaseDirectoryAsFileyURL.path, contents: Data(), attributes: nil))
      XCTAssertTrue(FileManager.default.fileExists(atPath: fakeBaseDirectoryAsFileyURL.path))


      /// cleaning

      try FileManager.default.cleanDirectory(atPath: baseURL.path)
      try FileManager.default.cleanDirectory(atPath: fakeBaseDirectoryURL.path)
      try FileManager.default.cleanDirectory(atPath: fakeBaseDirectoryAsFileyURL.path)

      XCTAssertTrue(FileManager.default.fileExists(atPath: baseURL.path), "The directory at path \(baseURL.path) should exists.")
      XCTAssertTrue(try FileManager.default.contentsOfDirectory(atPath: baseURL.path).count == 0, "The directory at path \(baseURL.path) should be empty.")
      XCTAssertTrue(FileManager.default.fileExists(atPath: fakeBaseDirectoryAsFileyURL.path), "The file at path \(fakeBaseDirectoryAsFileyURL.path) should exists.")
      XCTAssertTrue(!FileManager.default.fileExists(atPath: testDirectoryURL.path), "The directory at path \(testDirectoryURL.path) shouldn't exists.")

      try FileManager.default.deleteFileOrDirectory(atPath: containerURL.path)
      XCTAssertNotNil(try? FileManager.default.deleteFileOrDirectory(atPath: containerURL.path))

    }

  }

  #endif

}
