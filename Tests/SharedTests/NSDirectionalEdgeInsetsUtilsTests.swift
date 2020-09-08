#if canImport(UIKit) || canImport(AppKit)

import XCTest
#if canImport(UIKit)
import UIKit
#else
import AppKit
#endif
@testable import Mechanica

@available(macOS 10.15, *)
final class NSDirectionalEdgeInsetsUtilsTests: XCTestCase {

  func testHorizontal() {
    let inset = NSDirectionalEdgeInsets(top: 70.0, leading: 15.0, bottom: 5.0, trailing: 10.0)
    XCTAssertEqual(inset.horizontal, 25.0)
  }

  func testVertical() {
    let inset = NSDirectionalEdgeInsets(top: 20.0, leading: 10.0, bottom: 5.0, trailing: 10.0)
    XCTAssertEqual(inset.vertical, 25.0)
  }

  func testInitInset() {
    let inset = NSDirectionalEdgeInsets(inset: 15.5)
    XCTAssertEqual(inset.top, 15.5)
    XCTAssertEqual(inset.bottom, 15.5)
    XCTAssertEqual(inset.trailing, 15.5)
    XCTAssertEqual(inset.leading, 15.5)
  }

  func testInitVerticalHorizontal() {
    let inset = NSDirectionalEdgeInsets(horizontal: 20.0, vertical: 20.0)
    XCTAssertEqual(inset.top, 10.0)
    XCTAssertEqual(inset.bottom, 10.0)
    XCTAssertEqual(inset.trailing, 10.0)
    XCTAssertEqual(inset.leading, 10.0)
  }

}

#endif
