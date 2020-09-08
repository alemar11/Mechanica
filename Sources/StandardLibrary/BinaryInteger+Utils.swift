extension BinaryInteger {
  /// **Mechanica**
  ///
  /// Determine if self is even (equivalent to `self % 2 == 0` or to `isMultiple(of: 2)`).
  public var isEven: Bool {
    return isMultiple(of: 2)
  }

  /// **Mechanica**
  ///
  /// Determine if self is odd (equivalent to `self % 2 != 0` or to `isMultiple(of: 2)` negated).
  public var isOdd: Bool {
    return !isEven
  }
}
