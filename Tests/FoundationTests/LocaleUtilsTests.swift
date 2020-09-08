import XCTest
@testable import Mechanica

extension LocaleUtilsTests {
  static var allTests = [("testPosix", testPosix)]
}

final class LocaleUtilsTests: XCTestCase {
  func testPosix() {
    let test: Locale = .posix
    XCTAssertEqual(test.identifier, "en_US_POSIX")
  }
}
