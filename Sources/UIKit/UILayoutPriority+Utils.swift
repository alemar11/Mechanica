#if canImport(UIKit) && (os(iOS) || os(tvOS))

import UIKit

extension UILayoutPriority {
  /// **Mechanica**
  ///
  /// - Parameters:
  ///   - lhs: the UILayoutPriority to increase.
  ///   - rhs: the increasing amount.
  /// - Returns: a `new` increased UILayoutPriority.
  ///
  /// Example:
  ///
  ///     label.setContentHuggingPriority(.defaultLow + 1, for: .horizontal)
  ///
  static func + (lhs: UILayoutPriority, rhs: Float) -> UILayoutPriority {
    return UILayoutPriority(lhs.rawValue + rhs)
  }

  /// **Mechanica**
  ///
  /// - Parameters:
  ///   - lhs: the UILayoutPriority to increase.
  ///   - rhs: the decreasing amount.
  /// - Returns: a `new` decreased UILayoutPriority.
  ///
  /// Example:
  ///
  ///     view.setContentCompressionResistancePriority(.defaultHigh - 1, for: .vertical)
  ///
  static func - (lhs: UILayoutPriority, rhs: Float) -> UILayoutPriority {
    return UILayoutPriority(lhs.rawValue - rhs)
  }
}

#endif
