#if canImport(Foundation)

import Foundation

extension Locale {
  /// **Mechanica**
  ///
  /// UNIX representation of locale usually used for normalizing.
  public static var posix: Locale {
    return Locale(identifier: "en_US_POSIX")
  }
}

#endif
