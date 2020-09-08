#if canImport(UIKit) && (os(iOS) || os(tvOS))

import XCTest
import UIKit
@testable import Mechanica

final class UIStackViewUtilsTests: XCTestCase {

  func testAddBackgroundColor() {
    let stackView = UIStackView(frame: .zero)
    let color = UIColor.red
    let background = stackView.addBackgroundColor(color)

    XCTAssertEqual(background.backgroundColor, color)
    XCTAssertEqual(stackView.subviews, [background])
  }

  func testAddForegroundColor() {
    let stackView = UIStackView(frame: .zero)
    let color = UIColor.red
    let view1 = UIView(frame: .zero)
    let view2 = UIView(frame: .zero)
    let view3 = UIView(frame: .zero)

    stackView.addSubview(view1)
    stackView.addSubview(view2)
    stackView.addSubview(view3)

    let foreground = stackView.addForegroundColor(color)

    XCTAssertEqual(foreground.backgroundColor, color)
    XCTAssertEqual(stackView.subviews.count, 4)
    XCTAssertEqual(stackView.subviews.last, foreground)
  }

  func testUnarrangedSubviews() {
    let stackView = UIStackView(frame: .zero)
    let color = UIColor.red
    let radius = CGFloat(11.0)
    let index = 0
    let view = stackView.addUnarrangedView(color: color, cornerRadius: radius, at: index)

    XCTAssertEqual(stackView.subviews.first, view)
    XCTAssertEqual(view.backgroundColor, color)
    XCTAssertEqual(view.layer.cornerRadius, radius)
  }

}

#endif
