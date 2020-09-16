// TODO: add tests
#if canImport(UIKit) || canImport(AppKit)

#if canImport(UIKit)
import UIKit
#else
import AppKit
#endif

// MARK: - Properties

@available(macOS 10.15, *)
extension NSDirectionalEdgeInsets {
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
    return trailing + leading
  }
}

// MARK: - Methods

@available(macOS 10.15, *)
extension NSDirectionalEdgeInsets {
  /// **Mechanica**
  ///
  /// Creates an `UIEdgeInsets` with the same inset value applied to all (top, bottom, right, left)
  public init(inset: CGFloat) {
    self.init(top: inset, leading: inset, bottom: inset, trailing: inset)
  }

  /// **Mechanica**
  ///
  /// Creates an `NSDirectionalEdgeInsets` with the horizontal value equally divided and applied to right and left and the vertical value equally divided and applied to top and bottom.
  ///
  /// - Parameter horizontal: Inset to be applied to right and left.
  /// - Parameter vertical: Inset to be applied to top and bottom.
  public init(horizontal: CGFloat, vertical: CGFloat) {
    self.init(top: vertical / 2, leading: horizontal / 2, bottom: vertical / 2, trailing: horizontal / 2)
  }
}

#endif
