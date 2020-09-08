extension Optional {
  /// **Mechanica**
  ///
  /// Returns `true` if `self` has a value.
  public var hasValue: Bool {
    switch self {
    case .none:
      return false
    case .some:
      return true
    }
  }

  /// **Mechanica**
  ///
  /// Returns the value of the Optional or the `default` parameter.
  /// - param: The value to return if the optional is empty.
  ///
  /// Example:
  ///
  ///     optional.or(anotheValue)
  ///
  func or(_ default: Wrapped) -> Wrapped {
    return self ?? `default`
  }

  /// **Mechanica**
  ///
  /// Returns the unwrapped value of the optional *or* the result of the expression `else`.
  ///
  /// Example:
  ///
  ///     optional.or(else: print("hello world"))
  ///
  func or(else: @autoclosure () -> Wrapped) -> Wrapped {
    return self ?? `else`()
  }

  /// **Mechanica**
  ///
  /// Returns the unwrapped value of the optional *or* the result of calling the closure `else`.
  ///
  /// Example:
  ///
  ///     optional.or(else: {
  ///       ...
  ///     })
  ///
  func or(else: () -> Wrapped) -> Wrapped {
    return self ?? `else`()
  }

  /// **Mechanica**
  ///
  /// Returns the unwrapped contents of the optional if it is not empty, otherwise throws an exception.
  ///
  /// - Parameter exception: The exception to be thrown if the unwrapped contents is empty.
  /// - Returns: The unwrapped contents.
  /// - Throws: If the unwrapped contents is empty, an exception is thrown.
  ///
  /// Example:
  ///
  ///     try optional.or(throw: YourError)
  ///
  func or(throw exception: Error) throws -> Wrapped {
    guard let unwrapped = self else { throw exception }
    return unwrapped
  }
}

extension Optional where Wrapped: Collection {
  /// **Mechanica**
  ///
  /// Returns true if `self` is nil or empty.
  var isNilOrEmpty: Bool {
    return self?.isEmpty ?? true
  }
}

extension Optional where Wrapped == String {
  /// **Mechanica**
  ///
  /// Returns true if `self` is nil or empty.
  var isNilOrEmpty: Bool {
    return self?.isEmpty ?? true
  }

  /// **Mechanica**
  ///
  /// Returns true if `self` is nil or blank (a string that is either empty or contains only space/newline characters).
  var isNilOrBlank: Bool {
    return self?.isBlank ?? true
  }
}
