#if canImport(Foundation)

import Foundation

extension Data {
  /// **Mechanica**
  ///
  /// Returns `self` as an array of bytes.
  public var bytes: [UInt8] {
    return [UInt8](self)
  }

  /// **Mechanica**
  ///
  /// Returns an hexadecimal string representation (in lowercase) of the content.
  public var hexEncodedString: String {
    // can be improved if needed: https://stackoverflow.com/questions/39075043/how-to-convert-data-to-hex-string-in-swift
    return reduce("") { $0 + String(format: "%02x", $1) }
  }
}

#endif
