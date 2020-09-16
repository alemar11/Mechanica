import XCTest
@testable import Mechanica

#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)

final class CGRectUtilsTests: XCTestCase {

  func testInit() {
    let rect = CGRect(width: 100, height: 50)
    XCTAssertEqual(rect.origin, .zero)
    XCTAssertEqual(rect.size, CGSize(width: 100, height: 50))
  }

  func testCenter() {
    var rect = CGRect(width: 100, height: 50)
    XCTAssertEqual(rect.center, CGPoint(x: 50, y: 25))
    rect.center = CGPoint(x: 50, y: 25)
    XCTAssertEqual(rect.center, CGPoint(x: 50, y: 25))

    rect.center = .zero
    XCTAssertEqual(rect.center, .zero)
    XCTAssertEqual(rect.origin, CGPoint(x: -50, y: -25))

    rect.center = CGPoint(x: 100, y: 30)
    XCTAssertEqual(rect.origin, CGPoint(x: 50, y: 5))
  }

  func testRounded() {
    XCTAssertEqual(CGRect.zero.rounded(rule: .down), .zero)
    XCTAssertEqual(CGRect(x: 10, y: 11, width: 12, height: 13).rounded(rule: .down), CGRect(x: 10, y: 11, width: 12, height: 13))
    XCTAssertEqual(CGRect(x: 10.3, y: 11.5, width: 12.7, height: 13.0).rounded(rule: .down), CGRect(x: 10, y: 11, width: 12, height: 13))
    XCTAssertEqual(CGRect.zero.rounded(rule: .up), .zero)
    XCTAssertEqual(CGRect(x: 10, y: 11, width: 12, height: 13).rounded(rule: .up), CGRect(x: 10, y: 11, width: 12, height: 13))
    XCTAssertEqual(CGRect(x: 10.3, y: 11.5, width: 12.7, height: 13.0).rounded(rule: .up), CGRect(x: 11, y: 12, width: 13, height: 13))
  }

  func testArea() {
    XCTAssertEqual(CGRect.zero.area, 0)
    XCTAssertEqual(CGRect(width: 100, height: 50).area, 5000)
    XCTAssertEqual(CGRect(width: 100, height: 0).area, 0)
    XCTAssertEqual(CGRect(width: 100, height: 0.1).area, 10)
  }

}

#endif
