import XCTest
@testable import Mechanica

extension FileManagerUtilsTests {
  static var allTests = [
    ("testDestroyFileOrDirectory", testDestroyFileOrDirectory),
    ("testCleanDirectory", testCleanDirectory),
    ("testNewCachedSubDirectory", testNewCachedSubDirectory)
  ]
}

final class FileManagerUtilsTests: XCTestCase {

  func testNewCachedSubDirectory() throws {
    let url = try FileManager.default.newCachesSubDirectory(withName: "SubFolder")
    XCTAssertTrue(FileManager.default.fileExists(atPath: url.path))

    try FileManager.default.deleteFileOrDirectory(atPath: url.path)
  }

  func testDestroyFileOrDirectory() throws {
    // Given
    let tmpFolderPath = "/tmp/com.alessandromarzoli.Mechanica-\(UUID().uuidString)"
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
    let tmpFolderPath = "/tmp/com.alessandromarzoli.Mechanica-\(UUID().uuidString)"
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
