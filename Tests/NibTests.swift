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
    case macOS  = "macOS_NibDemo"
  }
  
}

#if os(iOS)
  extension UILongPressGestureRecognizer: NibLoadable {}
#elseif os(macOS)
  @available(OSX 10.12.2, *)
  extension NSTouchBar : NibLoadable {}
#endif

class NibTests: XCTestCase {
  
  func test_instantiate() {
    
    #if os(iOS)
      let nib = Nib.nib(forKey: .iOS, bundle: Bundle(for: type(of: self)))
      XCTAssertNotNil(nib)
      let view1 = nib.instantiate() as iOS_NibDemo_View_1
      XCTAssertNotNil(view1)
      let view2 = nib.instantiate() as iOS_NibDemo_View_2
      XCTAssertNotNil(view2)
      let gesture = nib.instantiate() as UILongPressGestureRecognizer
      XCTAssertNotNil(gesture)
    #elseif os(macOS)
      let nib = Nib.nib(forKey: .macOS, bundle: Bundle(for: type(of: self)))
      XCTAssertNotNil(nib)
      let view1 = nib.instantiate() as macOS_NibDemo_View_1
      XCTAssertNotNil(view1)
      let view2 = nib.instantiate() as macOS_NibDemo_View_2
      XCTAssertNotNil(view2)
      if #available(OSX 10.12.2, *) {
        let touchBar = nib.instantiate() as NSTouchBar
        XCTAssertNotNil(touchBar)
      }
    #endif
    
  }
  
}
