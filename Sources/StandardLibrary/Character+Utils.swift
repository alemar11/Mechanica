extension Character {
  /// **Mechanica**
  ///
  /// Returns `true` if `self` is an emoji country flag.
  public var isEmojiCountryFlag: Bool {
    // TODO: https://github.com/apple/swift-evolution/blob/master/proposals/0211-unicode-scalar-properties.md (Swift 5)
    // see https://github.com/apple/swift/blob/swift-5.0-branch/stdlib/public/core/UnicodeScalarProperties.swift
    let scalars = unicodeScalars
    return scalars.count == 2 && scalars.first!.isRegionalIndicator && scalars.last!.isRegionalIndicator
  }
}
