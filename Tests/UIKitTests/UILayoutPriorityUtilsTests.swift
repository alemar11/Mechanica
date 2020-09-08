#if os(iOS) || os(tvOS)

import XCTest
@testable import Mechanica

final class UILayoutPriorityUtilsTests: XCTestCase {

    func testIncreaseLayoutPriority() {
      XCTAssertTrue(UILayoutPriority.defaultLow + 1 == UILayoutPriority(UILayoutPriority.defaultLow.rawValue + 1))
    }

    func testDecreaseLayoutPriority() {
      XCTAssertTrue(UILayoutPriority.defaultLow - 1 == UILayoutPriority(UILayoutPriority.defaultLow.rawValue - 1))
    }

}

#endif
