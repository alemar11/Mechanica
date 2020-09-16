postfix operator %

/// **Mechanica**
///
/// 'Float' percent operator.
public postfix func % (value: Float) -> Float {
  return value / 100
}

/// **Mechanica**
///
/// 'Double' percent operator.
public postfix func % (value: Double) -> Double {
  return value / 100
}

infix operator ???: NilCoalescingPrecedence

/// **Mechanica**
///
/// Optional-string-coalescing operator.
///
/// The ??? operator takes any `optional` on its left side and a `default` string value on the right, returning a string.
/// If the optional value is non-nil, it unwraps it and returns its string description, otherwise it returns the default value.
public func ??? <T>(optional: T?, defaultValue: @autoclosure () -> String) -> String {
  // https://oleb.net/blog/2016/12/optionals-string-interpolation
  return optional.map { String(describing: $0) } ?? defaultValue()
}
