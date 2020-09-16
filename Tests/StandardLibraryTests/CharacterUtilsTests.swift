import XCTest
@testable import Mechanica

extension CharacterUtilsTests {
  static var allTests = [
    ("testIsEmojiCountryFlag", testIsEmojiCountryFlag)
  ]
}

final class CharacterUtilsTests: XCTestCase {

  func testIsEmojiCountryFlag() {
    XCTAssertTrue(Character("🇮🇹").isEmojiCountryFlag)
    XCTAssertTrue(Character("🇯🇵").isEmojiCountryFlag)
    XCTAssertTrue(Character("🇨🇦").isEmojiCountryFlag)
    XCTAssertTrue(Character("🇦🇶").isEmojiCountryFlag)
    XCTAssertFalse(Character("🏴").isEmojiCountryFlag)
    XCTAssertFalse(Character("🏁").isEmojiCountryFlag)
    XCTAssertFalse(Character("🏳️").isEmojiCountryFlag)
    #if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
    XCTAssertFalse(Character("🏳️‍🌈").isEmojiCountryFlag) // it crashes on Linux
    #endif

    XCTAssertFalse(Character("a").isEmojiCountryFlag)
    XCTAssertFalse(Character(".").isEmojiCountryFlag)
    XCTAssertFalse(Character("🚩").isEmojiCountryFlag)
    XCTAssertFalse(Character("\\").isEmojiCountryFlag)
    XCTAssertFalse(Character("😇").isEmojiCountryFlag)
  }

}
