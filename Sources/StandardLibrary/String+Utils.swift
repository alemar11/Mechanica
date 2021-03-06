extension String {
  /// Creates a string containing the given 'StaticString'.
  ///
  /// - Parameter staticString: The 'StaticString' to convert to a string.
  public init(staticString: StaticString) {
    self = staticString.withUTF8Buffer {
      String(decoding: $0, as: UTF8.self)
    }
  }

  /// **Mechanica**
  ///
  /// Returns a `new` string containing the first character of the `String`.
  public var first: String {
    let first = self[..<index(after: startIndex)]

    return String(first)
  }

  /// **Mechanica**
  ///
  /// Checks if all of the characters in a string are all the same.
  public var isHomogeneous: Bool {
    for char in dropFirst() where char != first {
      return false
    }
    return true
  }

  /// **Mechanica**
  ///
  /// Returns true if all the characters are lowercased.
  public var isLowercase: Bool {
    return self == lowercased()
  }

  /// **Mechanica**
  ///
  /// Returns true, if all characters are uppercased. Otherwise, false.
  public var isUppercase: Bool {
    return self == uppercased()
  }

  /// **Mechanica**
  ///
  /// Returns a `new` string containing the last character of the `String`.
  public var last: String {
    let last = self[index(before: endIndex)...]

    return String(last)
  }

  /// **Mechanica**
  ///
  /// Returns the length of the `String`.
  public var length: Int {
    return count
  }

  /// **Mechanica**
  ///
  ///  Returns a `new` String  with the center-padded version of `self` if it's shorter than `length` using a `token`. Padding characters are truncated if they can't be evenly divided by length.
  ///
  /// Example 1:
  ///
  ///     let string = "Hello World"
  ///     string.padding(length: 15) -> "  Hello World  "
  ///
  /// Example 2:
  ///
  ///     let string = "Hello World"
  ///     string.padding(length: 15, withToken: "*") -> "**Hello World**"
  ///
  /// - Parameters:
  ///   - length: The final length of your string. If the provided length is less than or equal to the original string, the original string is returned.
  ///   - token: The string used to pad the String (defaults to a white space).
  /// - Returns: The padded copy of the string.
  /// - Note: If the the sum-total of characters added is odd, the left side of the string will have one less instance of the token.
  public func padding(length: Int, with token: String = " ") -> String {
    guard count < length else { return self }

    let padLength = length - count
    let halfPadLength = Double(padLength) / 2
    let roundedStartingPadLength = Int(halfPadLength.rounded(.toNearestOrAwayFromZero))

    return paddingStart(length: length - roundedStartingPadLength, with: token).paddingEnd(length: length, with: token)
  }

  /// **Mechanica**
  ///
  /// Pads `self on the left and right sides if it's shorter than `length` using a `token`. Padding characters are truncated if they can't be evenly divided by length.
  ///
  /// Example 1:
  ///
  ///     let string = "Hello World"
  ///     string.pad(length: 15) -> "  Hello World  "
  ///
  /// Example 2:
  ///
  ///     let string = "Hello World"
  ///     string.pad(length: 15, withToken: "*") -> "**Hello World**"
  ///
  /// - Parameters:
  ///   - length: The final length of your string. If the provided length is less than or equal to the original string, the original string is returned.
  /// If the the sum-total of characters added is odd, the left side of the string will have one less instance of the token.
  ///   - token: The string used to pad the String (defaults to a white space).
  /// - Note: If the the sum-total of characters added is odd, the left side of the string will have one less instance of the token.
  public mutating func pad(length: Int, with token: String = " ") {
    self = padding(length: length, with: token)
  }

  /// **Mechanica**
  ///
  ///  Returns a `new` String  with the left-padded version of `self` if it's shorter than `length` using a `token`. Padding characters are truncated if they can't be evenly divided by length.
  ///
  /// Example 1:
  ///
  ///     let string = "Hello World"
  ///     string.paddingStart(length: 15) -> "    Hello World"
  ///
  /// Example 2:
  ///
  ///     let string = "Hello World"
  ///     string.paddingStart(length: 15, withToken: "*") -> "****Hello World"
  ///
  /// - Parameters:
  ///   - length: The final length of your string.
  ///   - token: The string used to pad the String (defaults to a white space).
  /// - Returns: The left-padded copy of the string.
  public func paddingStart(length: Int, with token: String = " ") -> String {
    guard count < length else { return self }

    let padLength = length - count
    if padLength < token.count {
      return token[token.startIndex..<token.index(token.startIndex, offsetBy: padLength)] + self
    } else {
      var padding = token
      while padding.count < padLength {
        padding.append(token)
      }
      return padding[padding.startIndex..<padding.index(padding.startIndex, offsetBy: padLength)] + self
    }
  }

  /// **Mechanica**
  ///
  /// Pads `self` on the left side if it's shorter than `length` using a `token`. Padding characters are truncated if they exceed length.
  ///
  /// Example 1:
  ///
  ///     let string = "Hello World"
  ///     string.padStart(length: 15) -> "    Hello World"
  ///
  /// Example 2:
  ///
  ///     let string = "Hello World"
  ///     string.padStart(length: 15, withToken: "*") -> "****Hello World"
  ///
  /// - Parameters:
  ///   - length: The final length of your string.
  ///   - token: The string used to pad the String (defaults to a white space).
  public mutating func padStart(length: Int, with token: String = " ") {
    self = paddingStart(length: length, with: token)
  }

  /// **Mechanica**
  ///
  ///  Returns a `new` String  with the right-padded version of `self` if it's shorter than `length` using a `token`. Padding characters are truncated if they can't be evenly divided by length.
  ///
  /// Example 1:
  ///
  ///     let string = "Hello World"
  ///     string.paddingEnd(length: 15) -> "Hello World    "
  ///
  /// Example 2:
  ///
  ///     let string = "Hello World"
  ///     string.paddingEnd(length: 15, withToken: "*", ) -> "Hello World****"
  ///
  /// - Parameters:
  ///   - length: The final length of your string.
  ///   - token: The string used to pad the String (defaults to a white space).
  /// - Returns: The right-padded copy of the string.
  public func paddingEnd(length: Int, with token: String = " ") -> String {
    guard count < length else { return self }

    let padLength = length - count
    if padLength < token.count {
      return self + token[token.startIndex..<token.index(token.startIndex, offsetBy: padLength)]
    } else {
      var padding = token
      while padding.count < padLength {
        padding.append(token)
      }
      return self + padding[padding.startIndex..<padding.index(padding.startIndex, offsetBy: padLength)]
    }
  }

  /// **Mechanica**
  ///
  /// Pads `self` on the right side if it's shorter than `length` using a `token`. Padding characters are truncated if they exceed length.
  ///
  /// Example 1:
  ///
  ///     let string = "Hello World"
  ///     string.padEnd(length: 15) -> "Hello World    "
  ///
  /// Example 2:
  ///
  ///     let string = "Hello World"
  ///     string.padEnd(length: 15, withToken: "*", ) -> "Hello World****"
  ///
  /// - Parameters:
  ///   - length: The final length of your string.
  ///   - token: The string used to pad the String (defaults to a white space).
  public mutating func padEnd(length: Int, with token: String = " ") {
    self = paddingEnd(length: length, with: token)
  }

  /// **Mechanica**
  ///
  ///  Returns a substring, up to maxLength in length, containing the initial elements of the `String`.
  ///
  ///  - Warning: If maxLength exceeds self.count, the result contains all the elements of self.
  ///  - parameter maxLength: The maximum number of elements to return. maxLength must be greater than or equal to zero.
  ///
  public func prefix(maxLength: Int) -> String {
    return String(prefix(maxLength))
  }

  /// **Mechanica**
  ///
  /// Returns a new `String` containing the characters of the String from the one at a given position to the end.
  ///
  /// Example:
  ///
  ///     "hello".droppingPrefix(upToPosition: 1) -> "ello"
  ///     "hello".droppingPrefix(upToPosition: 1) -> ""
  ///
  ///  - parameter upToPosition: position (included) up to which remove the prefix.
  public func droppingPrefix(upToPosition: Int = 1) -> String {
    guard upToPosition >= 0 && upToPosition <= length else { return "" }

    return String(dropFirst(upToPosition))
  }

  /// **Mechanica**
  ///
  ///  Returns a new `String` removing the spcified prefix (if the string has it).
  ///
  /// Example:
  ///
  ///     "hello".droppingPrefix("hel") -> "lo"
  ///
  ///  - parameter prefix: prefix to be removed.
  public func droppingPrefix(_ prefix: String) -> String {
    guard hasPrefix(prefix) else { return self }

    return droppingPrefix(upToPosition: prefix.length)
  }

  /// **Mechanica**
  ///
  ///  Returns a new `String` containing the characters of the String up to, but not including, the one at a given position.
  ///  - parameter fromPosition: position (included) from which remove the suffix
  ///
  /// Example:
  ///
  ///     "hello".droppingSuffix(fromPosition: 1) -> "hell"
  ///     "hello".droppingSuffix(fromPosition: 10) -> ""
  ///
  public func droppingSuffix(fromPosition: Int = 1) -> String {
    guard fromPosition >= 0 && fromPosition <= length else { return "" }

    return String(dropLast(fromPosition))
  }

  /// **Mechanica**
  ///
  /// Returns a new `String` removing the spcified suffix (if the string has it).
  ///
  /// Example:
  ///
  ///     "hello".droppingSuffix("0") -> "hell"
  ///
  ///  - parameter prefix: prefix to be removed.
  public func droppingSuffix(_ suffix: String) -> String {
    guard hasSuffix(suffix) else { return self }

    return droppingSuffix(fromPosition: suffix.length)
  }

  /// **Mechanica**
  ///
  /// Reverse `self`.
  public mutating func reverse() {
    self = String(reversed())
  }

  /// **Mechanica**
  ///
  ///  Returns a slice, up to maxLength in length, containing the final elements of `String`.
  ///
  ///  - Warning: If maxLength exceeds `String` character count, the result contains all the elements of `String`.
  ///  - parameter maxLength: The maximum number of elements to return. maxLength must be greater than or equal to zero.
  public func suffix(maxLength: Int) -> String {
    return String(suffix(maxLength))
  }

  /// **Mechanica**
  ///
  ///  Truncates the `String` to the given length (number of characters) and appends optional trailing string if longer.
  ///  The default trailing is the ellipsis (…).
  ///  - parameter length:   number of characters after which the `String` is truncated
  ///  - parameter trailing: optional trailing string
  ///
  public func truncate(at length: Int, withTrailing trailing: String? = "…") -> String {
    var truncated = self.prefix(maxLength: length)
    if 0..<self.length ~= length {
      if let trailing = trailing {
         truncated.append(trailing)
      }
    }

    return truncated
  }

  // MARK: - Subscript Methods

  /// **Mechanica**
  ///
  ///  Gets the character at the specified index as String.
  ///
  ///  - parameter index: index Position of the character to get
  ///
  ///  - Returns: Character as String or nil if the index is out of bounds
  ///
  /// Example:
  ///
  ///     let myString = "Hello world"
  ///     myString[0] -> "H"
  ///     myString[3] -> "l"
  ///     myString[10] -> "d"
  ///     myString[11] -> nil
  ///     myString[-1] -> nil
  ///
  public subscript (index: Int) -> Character? {
    guard 0..<count ~= index else { return nil }

    return Array(self)[index]
  }

  /// **Mechanica**
  ///
  ///   Returns a substring for the given range.
  ///
  /// - Parameter range: a `CountableRange` range.
  ///
  /// Example:
  ///
  ///     let myString = "Hello world"
  ///     myString[0..<0] -> ""
  ///     myString[0..<1] -> "Hello worl"
  ///     myString[0..<10] -> "Hello world"
  ///     myString[0..<11] -> nil
  ///     myString[11..<14] -> nil
  ///     myString[-1..<11] -> nil
  ///
  public subscript (range: CountableRange<Int>) -> Substring? {
    guard 0...count ~= range.lowerBound else { return nil }
    guard 0...count ~= range.upperBound else { return nil }

    let start = index(startIndex, offsetBy: range.lowerBound)
    let end = index(startIndex, offsetBy: range.upperBound)

    return self[start..<end]
  }

  /// **Mechanica**
  ///
  ///   Returns a substring for the given range.
  /// - Parameter range: a `CountableClosedRange` range.
  ///
  /// Example:
  ///
  ///     let myString = "Hello world"
  ///     myString[0...0]
  ///     myString[0...1]
  ///     myString[0...10]
  ///     myString[0...11]
  ///     myString[11...14]
  ///     myString[-1...11]
  ///
  public subscript (range: CountableClosedRange<Int>) -> Substring? {
    guard 0..<count ~= range.lowerBound else { return nil }
    guard 0..<count ~= range.upperBound else { return nil }

    let start = index(startIndex, offsetBy: range.lowerBound)
    let end = index(startIndex, offsetBy: range.upperBound)

    return self[start...end]
  }

  /// **Mechanica**
  ///
  ///   Returns a substring for the given range.
  /// - Parameter range: a `PartialRangeUpTo` range.
  ///
  /// Example:
  ///
  ///     let myString = "Hello world"
  ///     myString[0...0] -> "H"
  ///     myString[0...1] -> "He"
  ///     myString[0...10] -> "Hello world"
  ///     myString[0...11] -> nil
  ///     myString[11...14] -> nil
  ///     myString[-1...11] -> nil
  ///
  public subscript (range: PartialRangeUpTo<Int>) -> Substring? {
    guard 0...count ~= range.upperBound else { return nil }

    let end = index(startIndex, offsetBy: range.upperBound)

    return self[..<end]
  }

  /// **Mechanica**
  ///
  /// - Parameter range: a `PartialRangeThrough` range.
  /// Example:
  ///
  ///     let myString = "Hello world"
  ///     myString[..<0] -> ""
  ///     myString[..<1] -> "H"
  ///     myString[..<10] -> "Hello worl"
  ///     myString[..<11] -> "Hello world"
  ///     myString[..<14] -> nil
  ///     myString[..<(-1)] -> nil
  ///
  public subscript(range: PartialRangeThrough<Int>) -> Substring? {
    guard 0..<count ~= range.upperBound else { return nil }

    let end = index(startIndex, offsetBy: range.upperBound)
    return self[...end]
  }

  /// **Mechanica**
  ///
  ///   Returns a substring for the given range.
  /// - Parameter range: a `CountablePartialRangeFrom` range.
  /// Example:
  ///
  ///     let myString = "Hello world"
  ///     myString[0...] -> "Hello world"
  ///     myString[1...] -> "ello world"
  ///     myString[10...] -> "d"
  ///     myString[11...] -> nil
  ///     myString[14...] -> nil
  ///     myString[(-1)...] -> nil
  ///
  public subscript (range: CountablePartialRangeFrom<Int>) -> Substring? {
    guard 0..<count ~= range.lowerBound else { return nil }

    let start = index(startIndex, offsetBy: range.lowerBound)
    return self[start...]
  }

  // MARK: - Operators

  /// **Mechanica**
  ///
  ///   Returns a substring for the given range.
  /// Creates a `new` string representing the given string repeated the specified number of times.
  public static func * (lhs: String, rhs: Int) -> String {
    return String(repeating: lhs, count: rhs)
  }

  /// **Mechanica**
  ///
  ///   Returns a substring for the given range.
  /// Creates a `new` string representing the given string repeated the specified number of times.
  public static func * (lhs: Int, rhs: String) -> String {
    return String(repeating: rhs, count: lhs)
  }
}
