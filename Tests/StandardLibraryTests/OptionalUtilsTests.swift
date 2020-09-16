import XCTest
@testable import Mechanica

extension OptionalUtilsTests {
  static var allTests = [
    ("testHasValue", testHasValue),
    ("testOr", testOr),
    ("testOrWithAutoclosure", testOrWithAutoclosure),
    ("testOrWithClosure", testOrWithClosure),
    ("testOrThrowException", testOrThrowException),
    ("testCollectionIsNilOrEmpty", testCollectionIsNilOrEmpty),
    ("testStringIsNilOrEmpty", testStringIsNilOrEmpty),
    ("isNilOrBlank", testIsNilOrBlank),
    ]
}

final class OptionalUtilsTests: XCTestCase {

  func testHasValue() {
    var value: Any?
    XCTAssert(!value.hasValue)
    value = "tinrobots"
    XCTAssert(value.hasValue)
  }

  func testOr() {
    let value1: String? = "hello"
    XCTAssertEqual(value1.or("world"), "hello")

    let value2: String? = nil
    XCTAssertEqual(value2.or("world"), "world")
  }

  func testOrWithAutoclosure() {
    func runMe() -> String {
      return "world"
    }
    let value1: String? = "hello"
    XCTAssertEqual(value1.or(else: runMe()), "hello")

    let value2: String? = nil
    XCTAssertEqual(value2.or(else: runMe()), "world")
  }

  func testOrWithClosure() {
    let value1: String? = "hello"
    XCTAssertEqual(value1.or(else: { return "world" }), "hello")

    let value2: String? = nil
    XCTAssertEqual(value2.or(else: { return "world" }), "world")
  }

  func testOrThrowException() {
    enum DemoError: Error { case test }

    let value1: String? = "hello"
    XCTAssertNoThrow(try value1.or(throw: DemoError.test))

    let value2: String? = nil
    XCTAssertThrowsError(try value2.or(throw: DemoError.test))
  }

  func testCollectionIsNilOrEmpty() {
    do {
      let collection: [Int]? = [1, 2, 3]
      XCTAssertFalse(collection.isNilOrEmpty)
    }
    do {
      let collection: [Int]? = nil
      XCTAssertTrue(collection.isNilOrEmpty)
    }
    do {
      let collection: [Int]? = []
      XCTAssertTrue(collection.isNilOrEmpty)
    }
  }

  func testStringIsNilOrEmpty() {
    do {
      let text: String? = "mechanica"
      XCTAssertFalse(text.isNilOrEmpty)
    }
    do {
      let text: String? = " "
      XCTAssertFalse(text.isNilOrEmpty)
    }
    do {
      let text: String? = ""
      XCTAssertTrue(text.isNilOrEmpty)
    }
    do {
       let text: String? = nil
      XCTAssertTrue(text.isNilOrEmpty)
    }
  }

  func testIsNilOrBlank() {
    do {
      let text: String? = "mechanica"
      XCTAssertFalse(text.isNilOrBlank)
    }
    do {
      let text: String? = " "
      XCTAssertTrue(text.isNilOrBlank)
    }
    do {
      let text: String? = "  "
      XCTAssertTrue(text.isNilOrBlank)
    }
    do {
      let text: String? = ""
      XCTAssertTrue(text.isNilOrBlank)
    }
    do {
      let text: String? = nil
      XCTAssertTrue(text.isNilOrBlank)
    }
  }

}
