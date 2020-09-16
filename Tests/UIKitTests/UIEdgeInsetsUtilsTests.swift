#if canImport(UIKit)

import XCTest
import UIKit
@testable import Mechanica

final class UIEdgeInsetsUtilsTests: XCTestCase {

  func testHorizontal() {
    let inset = UIEdgeInsets(top: 70.0, left: 15.0, bottom: 5.0, right: 10.0)
    XCTAssertEqual(inset.horizontal, 25.0)
  }

  func testVertical() {
    let inset = UIEdgeInsets(top: 20.0, left: 10.0, bottom: 5.0, right: 10.0)
    XCTAssertEqual(inset.vertical, 25.0)
  }

  func testInitInset() {
    let inset = UIEdgeInsets(inset: 15.5)
    XCTAssertEqual(inset.top, 15.5)
    XCTAssertEqual(inset.bottom, 15.5)
    XCTAssertEqual(inset.right, 15.5)
    XCTAssertEqual(inset.left, 15.5)
  }

  func testInitVerticalHorizontal() {
    let inset = UIEdgeInsets(horizontal: 20.0, vertical: 20.0)
    XCTAssertEqual(inset.top, 10.0)
    XCTAssertEqual(inset.bottom, 10.0)
    XCTAssertEqual(inset.right, 10.0)
    XCTAssertEqual(inset.left, 10.0)
  }

}

#endif
