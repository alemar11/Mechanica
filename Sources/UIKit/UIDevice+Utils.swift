#if canImport(UIKit) && (os(iOS) || os(tvOS))

import UIKit

extension UIDevice {
  // MARK: - Device Interface Type

  /// **Mechanica**
  ///
  /// Returns `true` if the interface is designed for iPhone or iPod.
  public var hasPhoneInterface: Bool {
    return userInterfaceIdiom == .phone
  }

  /// **Mechanica**
  ///
  /// Returns `true` if the interface is designed for iPad.
  public var hasPadInterface: Bool {
    return userInterfaceIdiom == .pad
  }

  /// **Mechanica**
  ///
  /// Returns `true` if the interface is designed for Apple TV.
  public var hasTVInterface: Bool {
    return userInterfaceIdiom == .tv
  }

  /// **Mechanica**
  ///
  /// Returns `true` if the interface is designed for Apple CarPlay.
  public var hasCarPlayInterface: Bool {
    return userInterfaceIdiom == .carPlay
  }
}

#endif
