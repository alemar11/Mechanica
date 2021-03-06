#if canImport(UIKit)

import UIKit

// MARK: - Properties

extension UIEdgeInsets {
  /// **Mechanica**
  ///
  /// Returns the vertical insets (composed by top + bottom).
  public var vertical: CGFloat {
    return top + bottom
  }

  /// **Mechanica**
  ///
  /// Returns the horizontal insets (composed by  left + right).
  public var horizontal: CGFloat {
    return left + right
  }
}

// MARK: - Methods

extension UIEdgeInsets {
  /// **Mechanica**
  ///
  /// Creates an `UIEdgeInsets` with the same inset value applied to all (top, bottom, right, left)
  public init(inset: CGFloat) {
    self.init(top: inset, left: inset, bottom: inset, right: inset)
  }

  /// **Mechanica**
  ///
  /// Creates an `UIEdgeInsets` with the horizontal value equally divided and applied to right and left and the vertical value equally divided and applied to top and bottom.
  ///
  /// - Parameter horizontal: Inset to be applied to right and left.
  /// - Parameter vertical: Inset to be applied to top and bottom.
  public init(horizontal: CGFloat, vertical: CGFloat) {
    self.init(top: vertical / 2, left: horizontal / 2, bottom: vertical / 2, right: horizontal / 2)
  }
}

#endif
