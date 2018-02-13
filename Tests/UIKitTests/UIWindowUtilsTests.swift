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

  class UIWindowUtilsTests: XCTestCase {

    func testTopViewController() {
      // we can't test presented view controller

      let window = UIWindow()
      XCTAssertNil(window.topViewController)

      let navigationController = UINavigationController()
      window.rootViewController = navigationController
      XCTAssertTrue(window.topViewController == navigationController)

      let viewController = UIViewController()
      navigationController.show(viewController, sender: nil)
      XCTAssertTrue(window.topViewController == viewController)

      let tabBarController = UITabBarController()
      window.rootViewController = tabBarController
      XCTAssertTrue(window.topViewController == tabBarController)

      let viewControllerTab1 = UIViewController()
      viewControllerTab1.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
      let viewControllerTab2 = UIViewController()
      viewControllerTab2.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
      tabBarController.viewControllers = [viewControllerTab1, viewControllerTab2]
      tabBarController.selectedIndex = 0

      XCTAssertTrue(window.topViewController == viewControllerTab1)
      XCTAssertTrue(window.topViewController != viewControllerTab2)
      XCTAssertTrue(tabBarController.selectedViewController == viewControllerTab1)

    }

  }

#endif
