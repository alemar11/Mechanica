//
//  StoryboardTests.swift
//  Mechanica
//
//  Copyright © 2016-2017 Tinrobots.
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

extension Storyboard: StoryboardEnumerable {

  public enum StoryboardName : String {
    #if os(iOS)
    case iOS    = "iOS_StoryboardDemo"
    #elseif os(tvOS)
    case tvOS   = "tvOS_StoryboardDemo"
    #elseif os(macOS)
    case macOS  = "macOS_StoryboardDemo"
    #endif
  }

}

#if os(iOS)
  
  import UIKit
  class iOS_StoryboardDemo_ViewController_1: UIViewController {}
  
#elseif os(tvOS)
  
  import UIKit
  class tvOS_StoryboardDemo_ViewController_1: UIViewController {}
  
#elseif os(macOS)
  
  import Cocoa
  class macOS_StoryboardDemo_ViewController_1: NSViewController {}
  class macOS_StoryboardDemo_WindowController_1: NSWindowController {}
  
#endif

class StoryboardTests: XCTestCase {

  lazy var unitTestBundle: Bundle =  { return Bundle(for: type(of: self)) }()

  func test_instantiate() {

    #if os(iOS)

      let iOS_storyboard = Storyboard.storyboard(forKey: .iOS, bundle: unitTestBundle)
      XCTAssertNotNil(iOS_storyboard)

      do {
        let iOS_ViewController_1 = iOS_storyboard.instantiateViewController() as iOS_StoryboardDemo_ViewController_1
        XCTAssertNotNil(iOS_ViewController_1)
      }
      do {
        let iOS_ViewController_1: iOS_StoryboardDemo_ViewController_1 = iOS_storyboard.instantiateViewController()
        XCTAssertNotNil(iOS_ViewController_1)
      }

    #elseif os(tvOS)

      let tvOS_storyboard = Storyboard.storyboard(forKey: .tvOS, bundle: unitTestBundle)
      XCTAssertNotNil(tvOS_storyboard)

      do {
        let tvOS_ViewController_1 = tvOS_storyboard.instantiateViewController() as tvOS_StoryboardDemo_ViewController_1
        XCTAssertNotNil(tvOS_ViewController_1)
      }
      do {
        let tvOS_ViewController_1: tvOS_StoryboardDemo_ViewController_1 = tvOS_storyboard.instantiateViewController()
        XCTAssertNotNil(tvOS_ViewController_1)
      }

    #elseif os(macOS)

      let macOS_storyboard = Storyboard.storyboard(forKey: .macOS, bundle: unitTestBundle)
      XCTAssertNotNil(macOS_storyboard)

      do {
        let macOS_ViewController_1 = macOS_storyboard.instantiateViewController() as macOS_StoryboardDemo_ViewController_1
        XCTAssertNotNil(macOS_ViewController_1)
      }
      do {
        let macOS_ViewController_1: macOS_StoryboardDemo_ViewController_1 = macOS_storyboard.instantiateViewController()
        XCTAssertNotNil(macOS_ViewController_1)
      }
      do {
        let macOS_WindowController_1: macOS_StoryboardDemo_WindowController_1 = macOS_storyboard.instantiateWindowController()
        XCTAssertNotNil(macOS_WindowController_1)
      }

    #endif

    XCTAssert(Storyboard.mainStoryboard == nil)
  }

}
