#if os(iOS) || os(tvOS) || os(watchOS)

import XCTest
@testable import Mechanica

final class UIWiewUtilsTests: XCTestCase {

  func testCornerRadius() {
    let view = UIView()
    view.cornerRadius = 5.0

    XCTAssertEqual(view.layer.cornerRadius, view.cornerRadius)
  }

  func testBorderWidth() {
    let view = UIView()
    view.borderWidth = 5.0

    XCTAssertEqual(view.layer.borderWidth, view.borderWidth)
  }

  func testBorderColor() {
    let view = UIView()
    view.borderColor = .red

    XCTAssertNotNil(view.borderColor)

    let layerColor = view.layer.borderColor
    XCTAssertEqual(layerColor, UIColor.red.cgColor)

    view.borderColor = nil
    XCTAssertNil(view.borderColor)
    XCTAssertNil(view.layer.borderColor)
  }

  func testShadowRadius() {
    let view = UIView()

    view.shadowRadius = 15.0
    XCTAssertEqual(view.layer.shadowRadius, view.shadowRadius)
  }

  func testShadowOpacity() {
    let view = UIView()

    view.shadowOpacity = 0.7
    XCTAssertEqual(view.layer.shadowOpacity, view.shadowOpacity)
  }

  func testShadowOffset() {
    let view = UIView()

    view.shadowOffset = CGSize(width: 12.3, height: 45.6)
    XCTAssertEqual(view.layer.shadowOffset, view.shadowOffset)
  }

  func testShadowColor() {
    let view = UIView()
    view.shadowColor = .red
    XCTAssertNotNil(view.shadowColor)

    let layerShadowColor = view.layer.shadowColor
    XCTAssertEqual(layerShadowColor, UIColor.red.cgColor)

    view.shadowColor = nil
    XCTAssertNil(view.shadowColor)
    XCTAssertNil(view.layer.shadowColor)
  }

  #if os(iOS) || os(tvOS)

  func testUseAutolayout() {
    let view = UIView()
    let view2 = UIView()

    view.usesAutoLayout = true
    XCTAssertFalse(view.translatesAutoresizingMaskIntoConstraints)

    view.usesAutoLayout = false
    XCTAssertTrue(view.translatesAutoresizingMaskIntoConstraints)

    view2.translatesAutoresizingMaskIntoConstraints = false
    XCTAssertTrue(view2.usesAutoLayout)
  }

  func testScreenshot() {
    let view1 = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 50)))
    view1.backgroundColor = .red
    let view2 = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 50, height: 25)))
    view2.backgroundColor = .green
    view1.addSubview(view2)
    let screenshot = view1.screenshot()

    XCTAssertTrue(screenshot.size.width == 100)
    XCTAssertTrue(screenshot.size.height == 50)
    XCTAssertFalse(screenshot.size.width == 50)
    XCTAssertFalse(screenshot.size.height == 100)
  }

  #endif

}

#endif
