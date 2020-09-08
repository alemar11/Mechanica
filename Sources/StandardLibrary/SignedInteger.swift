// MARK: Properties

extension SignedInteger {
  /// **Mechanica**
  ///
  /// Determines if self is positive (equivalent to `self > 0`).
  public var isPositive: Bool {
    return self > 0
  }

  /// **Mechanica**
  ///
  /// Determines if self is negative (equivalent to `self < 0`).
  public var isNegative: Bool {
    return self < 0
  }
}
