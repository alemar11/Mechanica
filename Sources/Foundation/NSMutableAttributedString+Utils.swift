#if canImport(Foundation)

import Foundation

extension NSMutableAttributedString {
  // MARK: - Attributes

  /// **Mechanica**
  ///
  /// Removes all the attributes from `self`.
  public func removeAllAttributes() {
    setAttributes([:], range: NSRange(location: 0, length: string.count))
  }

  /// **Mechanica**
  ///
  /// Returns a `new` NSMutableAttributedString removing all the attributes.
  public func removingAllAttributes() -> NSMutableAttributedString {
    return NSMutableAttributedString(string: string)
  }

  // MARK: - Operators

  /// **Mechanica**
  ///
  /// Returns a `new` NSMutableAttributedString appending the right NSMutableAttributedString to the left NSMutableAttributedString.
  public static func + (lhs: NSMutableAttributedString, rhs: NSMutableAttributedString) -> NSMutableAttributedString {
    // swiftlint:disable force_cast
    let leftMutableAttributedString = lhs.mutableCopy() as! NSMutableAttributedString
    let rightMutableAttributedString = rhs.mutableCopy() as! NSMutableAttributedString
    // swiftlint:enable force_cast
    leftMutableAttributedString.append(rightMutableAttributedString)
    return leftMutableAttributedString
  }

  /// **Mechanica**
  ///
  /// Returns a `new` NSMutableAttributedString appending the right NSAttributedString to the left NSMutableAttributedString.
  public static func + (lhs: NSMutableAttributedString, rhs: NSAttributedString) -> NSMutableAttributedString {
    // swiftlint:disable:next force_cast
    let leftMutableAttributedString = lhs.mutableCopy() as! NSMutableAttributedString
    // swiftlint:enable force_cast
    leftMutableAttributedString.append(rhs)
    return leftMutableAttributedString
  }

  /// **Mechanica**
  ///
  /// Returns a `new` NSMutableAttributedString appending the right NSMutableAttributedString to the left NSAttributedString.
  public static func + (lhs: NSAttributedString, rhs: NSMutableAttributedString) -> NSMutableAttributedString {
    let mutableAttributedString = NSMutableAttributedString(attributedString: lhs)
    return mutableAttributedString + rhs
  }

  /// **Mechanica**
  ///
  /// Returns a `new` NSMutableAttributedString appending the right String to the left NSMutableAttributedString.
  public static func + (lhs: NSMutableAttributedString, rhs: String) -> NSMutableAttributedString {
    // swiftlint:disable:next force_cast
    let leftMutableAttributedString = lhs.mutableCopy() as! NSMutableAttributedString
    let rightMutableAttributedString = NSMutableAttributedString(string: rhs)
    return leftMutableAttributedString + rightMutableAttributedString
  }

  /// **Mechanica**
  ///
  /// Returns a `new` NSMutableAttributedString appending the right NSMutableAttributedString to the left String.
  public static func + (lhs: String, rhs: NSMutableAttributedString) -> NSMutableAttributedString {
    let leftMutableAttributedString = NSMutableAttributedString(string: lhs)
    // swiftlint:disable:next force_cast
    let rightMutableAttributedString = rhs.mutableCopy() as! NSMutableAttributedString
    return leftMutableAttributedString + rightMutableAttributedString
  }

  /// **Mechanica**
  ///
  /// Appends the right NSMutableAttributedString to the left NSMutableAttributedString.
  public static func += (lhs: NSMutableAttributedString, rhs: NSMutableAttributedString) {
    lhs.append(rhs)
  }

  /// **Mechanica**
  ///
  /// Appends the right NSAttributedString to the left NSMutableAttributedString.
  public static func += (lhs: NSMutableAttributedString, rhs: NSAttributedString) {
    lhs.append(rhs)
  }

  /// **Mechanica**
  ///
  /// Appends the right String to the left NSMutableAttributedString.
  public static func += (lhs: NSMutableAttributedString, rhs: String) {
    lhs.append(NSAttributedString(string: rhs))
  }
}

#endif
