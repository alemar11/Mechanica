#if canImport(UIKit) && (os(iOS) || os(tvOS))

import UIKit

extension UIButton {
  /// **Mechanica**
  ///
  /// Sets the background `color` to use for the specified button `state`.
  ///
  /// - Parameters:
  ///   - color: The background color to use for the specified state.
  ///   - state: The state that uses the specified image (defaults to normal.
  public func setBackgroundColor(_ color: UIColor, for state: UIControl.State = .normal) {
    let colorImage = UIImage(color: color, size: CGSize(width: 1, height: 1))

    setBackgroundImage(colorImage, for: state)
  }
}

#endif
