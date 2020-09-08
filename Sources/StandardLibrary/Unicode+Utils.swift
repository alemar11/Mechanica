extension Unicode.Scalar {
  /// **Mechanica**
  ///
  /// Returns `true` if `self` is a regional indicator.
  public var isRegionalIndicator: Bool {
    // TODO: Swift 5 - https://github.com/apple/swift-evolution/blob/master/proposals/0211-unicode-scalar-properties.md
    // see https://github.com/apple/swift/blob/swift-5.0-branch/stdlib/public/core/UnicodeScalarProperties.swift
    return ("🇦"..."🇿").contains(self)
  }
}
