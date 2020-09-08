import XCTest
@testable import Mechanica

extension CollectionUtilsTests {
  static var allTests = [
    ("testAtIndex", testAtIndex),
    ("testIndices", testIndices),
    ("testScan", testScan),
  ]
}

final class CollectionUtilsTests: XCTestCase {

  func testAtIndex() {
    let array: [Any] = [1, 2, "3", "4", 0]
    XCTAssertEqual(array.at(0)! as! Int, 1)
    XCTAssertEqual(array.at(1)! as! Int, 2)
    XCTAssertEqual(array.at(2)! as! String, "3")
    XCTAssertEqual(array.at(3)! as! String, "4")
    XCTAssertNil(array.at(5))
    XCTAssertNil(array.at(10))
    XCTAssertNil(array.at(100))
  }

  func testIndices() {
    do {
      let phrase = "tin robots"
      XCTAssertEqual(phrase.indices(of: "t"), [phrase.startIndex, phrase.index(phrase.startIndex, offsetBy: 8)])
      XCTAssertTrue(phrase.indices(of: "T").isEmpty)
    }

    do {
      let list = [1, 2, 1, 2, 3, 4, 5, 1]
      XCTAssertEqual(list.indices(of: 1), [0, 2, 7])
      XCTAssertTrue(list.indices(of: 0).isEmpty)
    }
  }

  func testScan() {
    do {
      var phrase = "tin robots"[...]
      XCTAssertEqual(phrase.scan(count: 4), "tin ")
      XCTAssertFalse(phrase.scan(prefix: "s"))
      XCTAssertTrue(phrase.scan(prefix: "r"))
      XCTAssertTrue(phrase.scan(prefix: "ob"))
      phrase.scan { $0 == Character("b") } // "ots": no b here so phrase will be scanned completly until gets emptied

      phrase.scan { $0 == Character("o") }
      XCTAssertEqual(phrase, "")
    }

    do {
      var phrase = "tin robots"[...]
      XCTAssertTrue(phrase.scan(prefix: "tin"))
      XCTAssertEqual(phrase, " robots")
    }

    do {
      var phrase = "tin robots"[...]
      XCTAssertFalse(phrase.scan(prefix: "in"))
      XCTAssertEqual(phrase, "tin robots")
    }

    do {
      var phrase = "🇮🇹🇮🇹🇮🇹"[...]
      phrase.scan { $0 == Character("🇮🇹") }
      XCTAssertEqual(phrase, "🇮🇹🇮🇹🇮🇹")
    }

    do {
      var phrase = "abc"[...]
      phrase.scan { $0 == Character("a") }
      XCTAssertEqual(phrase, "abc")
    }

    do {
      var phrase = "tin robots"[...]
      var buffer = String()
      phrase.scan(upToCondition: { $0 == Character("o")}, into: &buffer)
      XCTAssertEqual(phrase, "obots")
      XCTAssertEqual(buffer, "tin r")
    }

    do {
      var phrase = "tin robots"[...]
      var buffer = String()
      phrase.scan(upToCollection: "obot", into: &buffer)
      XCTAssertEqual(phrase, "obots")
      XCTAssertEqual(buffer, "tin r")
    }

    do {
      var phrase = "tin robots"[...]
      var buffer = String()
      phrase.scan(upToCollection: "obox", into: &buffer)
      XCTAssertEqual(phrase, "")
      XCTAssertEqual(buffer, "tin robots")
    }

    do {
      var phrase = "tin robots"[...]
      phrase.scan(upToCollection: "obox")
      XCTAssertEqual(phrase, "")
    }

    do {
      var list = [1, 2, 3, 4, 5][...]
      var buffer = [Int]()
      list.scan(upToCollection: [3, 4], into: &buffer)

      XCTAssertEqual(list, [3, 4, 5])
      XCTAssertEqual(buffer, [1, 2])
    }

    do {
      var list = [1, 2, 3, 4, 5][...]
      var buffer = [Int]()
      list.scan(upToCollection: [3, 4], into: &buffer)

      XCTAssertEqual(list, [3, 4, 5])
      XCTAssertEqual(buffer, [1, 2])
    }

    do {
      var list = [1, 2, 3, 4, 5][...]
      var buffer = [Int]()
      list.scan(upToCollection: [100, 1003], into: &buffer)

      XCTAssertEqual(list, [])
      XCTAssertEqual(buffer, [1, 2, 3, 4, 5])
    }

    do {
      var list = [Int]()[...]
      var buffer = [Int]()
      list.scan(upToCollection: [3, 4], into: &buffer)

      XCTAssertEqual(list, [])
      XCTAssertEqual(buffer, [])
    }

  }

}


