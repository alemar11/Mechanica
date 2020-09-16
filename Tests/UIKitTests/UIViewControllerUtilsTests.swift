#if os(iOS) || os(tvOS)

import XCTest
@testable import Mechanica

final class UIViewControllerUtilsTests: XCTestCase {

  func testIsVisible() {
    let viewController = UIViewController()
    XCTAssertFalse(viewController.isVisible)
  }

}

#endif
