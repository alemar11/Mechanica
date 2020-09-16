extension FloatingPoint {
  /// **Mechanica**
  ///
  /// Returns a `new` rounded `FloatingPoint` to specified number of decimal `places`.
  ///
  /// Example:
  ///
  ///     var piFloat = Float(3.141_592_653_589_793_238_46)
  ///
  ///     piFloat.rounded(to: 0) -> 3.0
  ///     piFloat.rounded(to: 7) -> 3.1415927
  ///
  ///     var piFloat80       = Float80(3.14159_26535_89793_23846)
  ///
  ///     piFloat80.rounded(to: 16, rule: .down) -> 3.141_592_653_589_793_2
  ///     piFloat80.rounded(to: 16, rule: .up) -> 3.141_592_653_589_793_3
  ///
  public func rounded(to decimalPlaces: Int, rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero) -> Self {
    guard decimalPlaces >= 0 else { return self }

    var divisor: Self = 1
    for _ in 0..<decimalPlaces { divisor *= 10 }

    return (self * divisor).rounded(rule) / divisor
  }

  /// **Mechanica**
  ///
  /// Rounds `self` to specified number of decimal `places`.
  ///
  /// Example:
  ///
  ///     var piFloat = Float(3.141_592_653_589_793_238_46)
  ///
  ///     piFloat.round(to: 3) -> piFloat is 3.142
  ///     piFloat.round(to: 7) -> piFloat is 3.1415927
  ///
  ///     var piFloat80       = Float80(3.14159_26535_89793_23846)
  ///
  ///     piFloat80.round(to: 16, rule: .down) -> piFloat80 is 3.141_592_653_589_793_2
  ///     piFloat80.round(to: 16, rule: .up) -> piFloat80 is 3.141_592_653_589_793_3
  ///
  public mutating func round(to decimalPlaces: Int, rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero) {
    self = rounded(to: decimalPlaces, rule: rule)
  }

  /// **Mechanica**
  ///
  /// Returns a `new` ceiled `FloatingPoint` to specified number of decimal `places`.
  ///
  /// Example:
  ///
  ///     var piFloat = Float(3.141_592_653_589_793_238_46)
  ///
  ///     piFloat.ceiled(to: 0) -> 4.0
  ///     piFloat.ceiled(to: 5) -> 3.1416
  ///
  public func ceiled(to decimalPlaces: Int) -> Self {
    guard decimalPlaces >= 0 else { return self }

    var divisor: Self = 1
    for _ in 0..<decimalPlaces { divisor *= 10 }

    return (self * divisor).rounded(.up) / divisor
  }

  /// **Mechanica**
  ///
  /// Ceils `self` to specified number of decimal `places`.
  ///
  /// Example:
  ///
  ///     var piFloat = Float(3.141_592_653_589_793_238_46)
  ///
  ///     piFloat.ceil(to: 0) -> piFloat is 4.0
  ///     piFloat.ceil(to: 5) -> piFloat is 3.1416
  ///
  public mutating func ceil(to decimalPlaces: Int) {
    self = ceiled(to: decimalPlaces)
  }

  /// **Mechanica**
  ///
  /// Returns a `new` floored `FloatingPoint` to specified number of decimal `places`.
  ///
  /// Example:
  ///
  ///     var piFloat = Float(3.141_592_653_589_793_238_46)
  ///
  ///     piFloat.floored(to: 0) -> 3.0
  ///     piFloat.floored(to: 5) -> 3.14159
  ///
  public func floored(to decimalPlaces: Int) -> Self {
    guard decimalPlaces >= 0 else { return self }

    var divisor: Self = 1
    for _ in 0..<decimalPlaces { divisor *= 10 }

    return (self * divisor).rounded(.down) / divisor
  }

  /// **Mechanica**
  ///
  /// Floors `self` to specified number of decimal `places`.
  ///
  /// Example:
  ///
  ///     var piFloat = Float(3.141_592_653_589_793_238_46)
  ///
  ///     piFloat.floor(to: 0) -> piFloat is 3.0
  ///     piFloat.floor(to: 5) -> piFloat is 3.14159
  ///
  public mutating func floor(to decimalPlaces: Int) {
    self = floored(to: decimalPlaces)
  }
}
