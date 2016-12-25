//
//  NibTests.swift
//  Mechanica
//
//  Copyright © 2016 Tinrobots.
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

extension Nib: NibKeyCodable {

  public enum NibName : String {
    case iOS    = "iOS_NibDemo"
    case tvOS   = "tvOS_NibDemo"
    case macOS  = "macOS_NibDemo"
  }

}

#if os(iOS)
  extension UILongPressGestureRecognizer: NibLoadable {}
#elseif os(tvOS)
  extension UIRotationGestureRecognizer: NibLoadable {}
#elseif os(macOS)
  @available(OSX 10.12.2, *)
  extension NSTouchBar : NibLoadable {}
#endif

class NibTests: XCTestCase {

  func test_instantiate() {

    #if os(iOS)

      let nib = Nib.nib(forKey: .iOS, bundle: Bundle(for: type(of: self)))
      XCTAssertNotNil(nib)
      do {
        let view1 = nib.instantiate() as iOS_NibDemo_View_1
        XCTAssertNotNil(view1)
      }
      do {
        let view1: iOS_NibDemo_View_1 = nib.instantiate()
        XCTAssertNotNil(view1)
      }
      do {
        let view2 = nib.instantiate() as iOS_NibDemo_View_2
        XCTAssertNotNil(view2)
      }
      do {
        let view2: iOS_NibDemo_View_2 = nib.instantiate()
        XCTAssertNotNil(view2)
      }
      do {
        let gesture = nib.instantiate() as UILongPressGestureRecognizer
        XCTAssertNotNil(gesture)
      }
      do {
        let gesture: UILongPressGestureRecognizer = nib.instantiate()
        XCTAssertNotNil(gesture)
      }

    #elseif os(tvOS)

      let nib = Nib.nib(forKey: .iOS, bundle: Bundle(for: type(of: self)))
      XCTAssertNotNil(nib)
      do {
        let view1 = nib.instantiate() as tvOS_NibDemo_View_1
        XCTAssertNotNil(view1)
      }
      do {
        let view1: tvOS_NibDemo_View_1 = nib.instantiate()
        XCTAssertNotNil(view1)
      }
      do {
        let view2 = nib.instantiate() as tvOS_NibDemo_View_2
        XCTAssertNotNil(view2)
      }
      do {
        let view2: tvOS_NibDemo_View_2 = nib.instantiate()
        XCTAssertNotNil(view2)
      }
      do {
        let gesture = nib.instantiate() as UIRotationGestureRecognizer
        XCTAssertNotNil(gesture)
      }
      do {
        let gesture: UIRotationGestureRecognizer = nib.instantiate()
        XCTAssertNotNil(gesture)
      }

    #elseif os(macOS)

      let nib = Nib.nib(forKey: .macOS, bundle: Bundle(for: type(of: self)))
      XCTAssertNotNil(nib)
      do {
        let view1 = nib.instantiate() as macOS_NibDemo_View_1
        XCTAssertNotNil(view1)
      }
      do {
        let view1: macOS_NibDemo_View_1 = nib.instantiate()
        XCTAssertNotNil(view1)
      }
      do {
        let view2 = nib.instantiate() as macOS_NibDemo_View_2
        XCTAssertNotNil(view2)
      }
      do {
        let view2: macOS_NibDemo_View_2 = nib.instantiate()
        XCTAssertNotNil(view2)
      }
      do{
        if #available(OSX 10.12.2, *) {
          let touchBar = nib.instantiate() as NSTouchBar
          XCTAssertNotNil(touchBar)
        }
      }
      do{
        if #available(OSX 10.12.2, *) {
          let touchBar: NSTouchBar = nib.instantiate()
          XCTAssertNotNil(touchBar)
        }
      }

    #endif

  }

}
