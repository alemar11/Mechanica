import XCTest
@testable import Mechanica

extension DictionaryUtilsTests {
  static var allTests = [
    ("testHasKey", testHasKey),
    ("testRemoveAll", testRemoveAll)
  ]
}

final class DictionaryUtilsTests: XCTestCase {

  func testHasKey() {
    do {
      let dictionary: [String:Int] = [:]
      XCTAssertFalse(dictionary.hasKey(""))
      XCTAssertFalse(dictionary.hasKey("robot"))
    }
    do {
      let dictionary: [String:Int] = ["robot":1, "robot2":2]
      XCTAssertFalse(dictionary.hasKey(""))
      XCTAssertTrue(dictionary.hasKey("robot"))
    }
  }

  func testRemoveAll() {
    var dictionary = ["a": 0, "b": 1, "c": 2, "d": 3, "e": 4, "f": 5, "g": 6, "h": 7, "i": 8, "l": 9, "m": 10]

    do {
      let removed = dictionary.removeAll(forKeys: ["a", "b", "c"])
      if removed != nil {
        XCTAssertTrue(removed!.count == 3)
      } else {
        XCTAssertNotNil(dictionary)
      }
    }

    do {
      let removed = dictionary.removeAll(forKeys: ["a", "b", "c", "d"])
      if removed != nil {
        XCTAssertTrue(removed!.count == 1)
      } else {
        XCTAssertNotNil(dictionary)
      }
    }

    do {
      let removed = dictionary.removeAll(forKeys: ["k"])
      XCTAssertNil(removed)
    }

    do {
      let removed = dictionary.removeAll(forKeys: ["a", "b", "c", "d", "e", "f", "g", "h", "i", "l", "m"])
      XCTAssertNotNil(removed)
      XCTAssertNil(removed!["a"])
      XCTAssertNil(dictionary["a"])
      XCTAssertNotNil(removed!["l"])
      XCTAssertNil(dictionary["l"])
      XCTAssert(dictionary.isEmpty)
    }

  }

}
