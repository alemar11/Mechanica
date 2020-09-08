extension Bool {
  /// **Mechanica**
  ///
  /// Returns 1 if true, or 0 if false.
  public var int: Int {
    return self ? 1 : 0
  }

  /// **Mechanica**
  ///
  /// Returns a `new` Bool with the inverted value of `self`.
  public var toggled: Bool {
    return !self
  }

  /// **Mechanica**
  ///
  /// Creates a string representing the given value in the binary base.
  ///
  /// Example:
  ///
  ///     true.binaryString -> "1"
  ///
  public var binaryString: String {
    return self ? "1" : "0"
  }
}
