import XCTest
@testable import Mechanica

extension StatUtilsTests {
  static var allTests = [
    ("testIsDirectory", testIsDirectory),
    ("testIsFile", testIsFile),
    ("testIsLink", testIsLink)
  ]
}

final class StatUtilsTests: XCTestCase {

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
