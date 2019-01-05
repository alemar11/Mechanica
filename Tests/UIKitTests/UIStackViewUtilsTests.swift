//
// Mechanica
//
// Copyright © 2016-2019 Tinrobots.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

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
