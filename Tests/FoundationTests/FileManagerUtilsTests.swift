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

extension FileManagerUtilsTests {
  static var allTests = [
    ("testDestroyFileOrDirectory", testDestroyFileOrDirectory),
    ("testCleanDirectory", testCleanDirectory)
  ]
}

extension FileManager {

  #if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
  // TODO: - Not implemented on Linux: url(for:in:appropriateFor:create:)
  // https://github.com/apple/swift-corelibs-foundation/blob/master/Foundation/FileManager.swift

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

final class FileManagerUtilsTests: XCTestCase {

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
    XCTAssertTrue(FileManager.default.fileExists(atPath: tmpFolderPath), "The directory at path \(tmpFolderPath) should exists.")
    XCTAssertTrue(FileManager.default.fileExists(atPath: testFilePath), "The file at path \(testFilePath) should exists.")
    XCTAssertTrue(FileManager.default.fileExists(atPath: testFolderPath), "The directory at path \(testFolderPath) should exists.")

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
    XCTAssertTrue(FileManager.default.fileExists(atPath: tmpFolderPath), "The directory at path \(tmpFolderPath) should exists.")
    XCTAssertTrue(FileManager.default.fileExists(atPath: testFilePath), "The file at path \(testFilePath) should exists.")
    XCTAssertTrue(FileManager.default.fileExists(atPath: testFolderPath), "The directory at path \(testFolderPath) should exists.")

    try FileManager.default.cleanDirectory(atPath: tmpFolderPath)
    XCTAssertTrue(FileManager.default.fileExists(atPath: tmpFolderPath), "The directory at path \(tmpFolderPath) should exists.")
    XCTAssertFalse(FileManager.default.fileExists(atPath: testFilePath), "The file at path \(testFilePath) should not exists.")
    XCTAssertFalse(FileManager.default.fileExists(atPath: testFilePath), "The directory at path \(testFilePath) should not exists.")
    XCTAssertTrue(try FileManager.default.contentsOfDirectory(atPath: tmpFolderPath).count == 0, "The directory at path \(tmpFolderPath) should be empty.")

    // When
    let testFakeFilePath = tmpFolderPath + "/" + "TestFakeFile.txt"
    let testFakeFolderPath = tmpFolderPath + "/" + "TestFakeDirectory"
    try FileManager.default.cleanDirectory(atPath: testFakeFilePath)
    try FileManager.default.cleanDirectory(atPath: testFakeFolderPath)

    // Then
    XCTAssertFalse(FileManager.default.fileExists(atPath: testFakeFilePath), "The file at path \(testFakeFilePath) should not exists.")
    XCTAssertFalse(FileManager.default.fileExists(atPath: testFakeFolderPath), "The directory at path \(testFakeFolderPath) should not exists.")

    /// destroy the tmp folder
    try FileManager.default.deleteFileOrDirectory(atPath: tmpFolderPath)
    XCTAssertFalse(FileManager.default.fileExists(atPath: testFolderPath))
  }

}
