#if os(iOS) || os(tvOS)

import XCTest
import UIKit
@testable import Mechanica

class UIGestureRecognizerUtilsTests: XCTestCase {

    func testCancel() {
      let recognizer = UITapGestureRecognizer()
      recognizer.cancel()
      XCTAssertTrue(recognizer.isEnabled)
    }

}

#endif
