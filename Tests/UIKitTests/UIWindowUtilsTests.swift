#if os(iOS) || os(tvOS)

import XCTest
@testable import Mechanica

  final class UIWindowUtilsTests: XCTestCase {

    func testTopViewController() {
      // we can't test presented view controller

      let window = UIWindow()
      XCTAssertNil(window.topMostViewController)

      let navigationController = UINavigationController()
      window.rootViewController = navigationController
      XCTAssertTrue(window.topMostViewController == navigationController)

      let viewController = UIViewController()
      navigationController.show(viewController, sender: nil)
      XCTAssertTrue(window.topMostViewController == viewController)

      let tabBarController = UITabBarController()
      window.rootViewController = tabBarController
      XCTAssertTrue(window.topMostViewController == tabBarController)

      let viewControllerTab1 = UIViewController()
      viewControllerTab1.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
      let viewControllerTab2 = UIViewController()
      viewControllerTab2.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
      tabBarController.viewControllers = [viewControllerTab1, viewControllerTab2]
      tabBarController.selectedIndex = 0

      XCTAssertTrue(window.topMostViewController == viewControllerTab1)
      XCTAssertTrue(window.topMostViewController != viewControllerTab2)
      XCTAssertTrue(tabBarController.selectedViewController == viewControllerTab1)

    }

  }

#endif
