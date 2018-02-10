//
// Mechanica
//
// Copyright © 2016-2018 Tinrobots.
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

import XCTest
@testable import Mechanica

#if os(iOS) || os(tvOS) || os(watchOS)

class UIWiewUtilsTests: XCTestCase {

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

    view.usesAutoLayout = true
    XCTAssertFalse(view.translatesAutoresizingMaskIntoConstraints)

    view.usesAutoLayout = false
    XCTAssertTrue(view.translatesAutoresizingMaskIntoConstraints)
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
