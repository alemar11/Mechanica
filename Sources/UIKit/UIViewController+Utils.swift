#if canImport(UIKit) && (os(iOS) || os(tvOS))

import UIKit

extension UIViewController {
  /// **Mechanica**
  ///
  /// Returns `true` if the UIViewController is on the screen.
  public var isVisible: Bool {
    return isViewLoaded && view.window != nil
  }
}

#endif
