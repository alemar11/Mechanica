#if canImport(UIKit) && (os(iOS) || os(tvOS))

import UIKit

extension UIWindow {
  /// **Mechanica**
  ///
  /// Returns the topmost UIViewController.
  public var topMostViewController: UIViewController? {
    guard let topMostViewController = rootViewController else { return nil }

    func visibleViewController(from viewController: UIViewController?) -> UIViewController? {
      if let tabBarController = (viewController as? UITabBarController)?.selectedViewController {
        return visibleViewController(from: tabBarController)
      } else if let navigationController = (viewController as? UINavigationController)?.visibleViewController {
        return visibleViewController(from: navigationController)
      } else if let presentingViewController = viewController?.presentedViewController {
        return visibleViewController(from: presentingViewController)
      }
      return viewController
    }

    return visibleViewController(from: topMostViewController)
  }
}

#endif
