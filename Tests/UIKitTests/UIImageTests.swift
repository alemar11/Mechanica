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

#if os(iOS) || os(tvOS)

import XCTest
@testable import Mechanica

final class UIImageTests: XCTestCase {

  func testInitWithColorAndSize() {
    let scale = UIScreen.main.scale

    XCTAssertEqual(UIImage(color: .red)?.size, CGSize(width: 1*scale, height: 1*scale))
    XCTAssertEqual(UIImage(color: .red, size: CGSize(width: 50, height: 50))?.size, CGSize(width: 50*scale, height: 50*scale))
    XCTAssertNil(UIImage(color: .red, size: CGSize(width: 0, height: 0)))
    XCTAssertEqual(UIImage(color: .red, size: CGSize(width: 11.3, height: 3.11))?.size, CGSize(width: (11.3*scale).ceiled(to: 0), height: (3.11*scale).ceiled(to: 0)))
    XCTAssertEqual(UIImage(color: .red, scale: 1.0)?.size, CGSize(width: 1, height: 1))
    XCTAssertEqual(UIImage(color: .red, scale: 3.0)?.size, CGSize(width: 3, height: 3))
    XCTAssertEqual(UIImage(color: .red, scale: 4.0)?.size, CGSize(width: 4, height: 4))
    XCTAssertEqual(UIImage(color: .red, size: CGSize(width: 11.3, height: 3.11), scale: 4.0)?.size, CGSize(width: (11.3*4.0).ceiled(to: 0), height: (3.11*4.0).ceiled(to: 0)))
  }

  func testScale() {
    let image = robotImage.copy() as! Image
    let size = CGSize(width: 50, height: 70)
    let scaled = image.scaled(to: size)
    XCTAssertEqual(scaled.size, size)
  }

  func testAspectScaleToFill() {
    let image = robotImage.copy() as! Image
    let size = CGSize(width: 50, height: 70)
    let scaled = image.aspectScaled(toFit: size)
    XCTAssertEqual(scaled.size, size)
  }

  func testAspectScaleToFit() {
    do {
    let image = robotImage.copy() as! Image
    let size = CGSize(width: 50, height: 70)
    let scaled = image.aspectScaled(toFill: size)
    XCTAssertEqual(scaled.size, size)
    }

    do {
      let image = picImage.copy() as! Image
      let size = CGSize(width: 50, height: 70)
      let scaled = image.aspectScaled(toFill: size)
      XCTAssertEqual(scaled.size, size)
    }
  }

  func testRounding() {
    do {
      let image = robotImage.copy() as! Image
      let circle = image.roundedIntoCircle()
      XCTAssertEqual(circle.size, image.size)

      let rounded = image.rounded(withCornerRadius: 10, divideRadiusByImageScale: true)
      XCTAssertEqual(rounded.size, image.size)
    }

    do {
      let image = picImage.copy() as! Image /// 483 x 221
      let circle = image.roundedIntoCircle()
      XCTAssertEqual(circle.size.height, image.size.height)
      XCTAssertEqual(circle.size.width, image.size.height)

      let rounded = image.rounded(withCornerRadius: 10, divideRadiusByImageScale: true)
      XCTAssertEqual(rounded.size, image.size)
    }
  }

  private lazy var robotImage: Image = {
    let url =  resources().appendingPathComponent("robot.png")
    let data = try! Data(contentsOf: url)
    let image = Image(data: data)!
    return image
  }()

  private lazy var picImage: Image = {
    let url =  resources().appendingPathComponent("pic.png")
    let data = try! Data(contentsOf: url)
    let image = Image(data: data)!
    return image
  }()

  private func resources() -> URL {
    var resources = URL(fileURLWithPath: #file, isDirectory: false).deletingLastPathComponents(2)
    resources.appendPathComponent("Resources")
    return resources
  }

}

#endif
