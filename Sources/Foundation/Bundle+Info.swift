//  Core Foundation Keys: https://developer.apple.com/library/content/documentation/General/Reference/InfoPlistKeyReference/Articles/CoreFoundationKeys.html

#if canImport(Foundation)

import Foundation

extension Bundle {
  #if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)

  /// **Mechanica**
  ///
  /// Returns the app identifier (`bundleIdenfier` or its `executable` file name).
  public var appIdentifier: String? {
    if let identifier = bundleIdentifier, !identifier.isBlank { //i.e. org.tinrobots.App
      return identifier
    } else if let identifier = executableFileName, !identifier.isBlank { //i.e. AppExecutableName
      return identifier
    }
    return nil
  }

  /// **Mechanica**
  ///
  /// Returns the user-visible name of the `Bundle`; used by Siri and visible on the Home screen in iOS.
  public final var displayName: String? {
    return infoDictionary?["CFBundleDisplayName"] as? String
  }

  /// **Mechanica**
  ///
  /// Returns the receiver's executable file name.
  public final var executableFileName: String? {
    return executableURL?.lastPathComponent
  }

  /// **Mechanica**
  ///
  /// Returns the release-version-number string for the `Bundle`.
  public final var shortVersionString: String? {
    return infoDictionary?["CFBundleShortVersionString"] as? String
  }

  /// **Mechanica**
  ///
  /// Returns the build-version-number string for the `Bundle`.
  public final var version: String? {
    return infoDictionary?["CFBundleVersion"] as? String
  }

  /// Returns all the defines URL schemes.
  /// - Note: The URL scheme is a useful little feature in iOS that allows unrelated applications to communicate with each other in a controlled way.
  /// One application can use a custom URL scheme registered by another to pass control to it, supplying arguments as required.
  public var urlSchemes: [String] {
    guard let infoDictionary = self.infoDictionary,
      let urlTypes = infoDictionary["CFBundleURLTypes"] as? [AnyObject],
      let urlType = urlTypes.first as? [String: AnyObject],
      let urlSchemes = urlType["CFBundleURLSchemes"] as? [String] else {
        return []
    }
    return urlSchemes
  }

  #endif

  #if os(iOS) || os(tvOS) || os(watchOS)
  /// **Mechanica**
  ///
  /// Returns true if the app is running through TestFlight.
  /// - Note: For an application installed through TestFlight, the receipt file is named StoreKit\sandboxReceipt vs the usual StoreKit\receipt
  public var isAppRunningThroughTestFlight: Bool {
    // TODO: is it still a valid approach in 2020?
    return appStoreReceiptURL?.path.contains("sandboxReceipt") == true
  }
  #endif
}

#endif
