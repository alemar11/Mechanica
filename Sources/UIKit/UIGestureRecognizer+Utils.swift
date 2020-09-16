#if canImport(UIKit) && (os(iOS) || os(tvOS))

import UIKit

extension UIGestureRecognizer {
  /// **Mechanica**
  ///
  /// The gesture recognizer transitions to a cancelled state.
  public func cancel() {
    isEnabled = false
    isEnabled = true
  }
}

#endif
