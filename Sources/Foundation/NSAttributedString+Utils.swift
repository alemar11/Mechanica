#if canImport(Foundation)

import Foundation

extension NSAttributedString {
  #if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)

  // MARK: - Initializers

  /// **Mechanica**
  ///
  /// Initializes and returns a `new` NSAttributedString object from the `html` contained in the given string.
  /// - Parameters:
  ///   - html: an HTML string.
  ///   - allowLossyConversion: If it is *true* and the receiver can’t be converted without losing some information, some characters may be removed or altered in conversion.
  /// For example, in converting a character from NSUnicodeStringEncoding to NSASCIIStringEncoding, the character ‘Á’ becomes ‘A’, losing the accent.
  /// - Note: The HTML import mechanism is meant for implementing something like markdown (that is, text styles, colors, and so on), not for general HTML import.
  /// [Apple Documentation](https://developer.apple.com/reference/foundation/nsattributedstring/1524613-init)
  /// - Warning: Using the HTML importer (NSHTMLTextDocumentType) is only possible on the **main thread**.
  public convenience init?(html: String, allowLossyConversion: Bool = false) {
    guard let data = html.data(using: .utf8, allowLossyConversion: allowLossyConversion) else { return nil }

    try? self.init(data: data,
                   options: [.documentType: NSAttributedString.DocumentType.html],
                   documentAttributes: nil)
  }

  #endif

  // MARK: - Operators

  /// **Mechanica**
  ///
  /// Returns a `new` NSAttributedString appending the right NSAttributedString to the left NSAttributedString.
  static public func + (lhs: NSAttributedString, rhs: NSAttributedString) -> NSAttributedString {
    let attributedString = NSMutableAttributedString(attributedString: lhs)
    attributedString.append(rhs)
    return NSAttributedString(attributedString: attributedString)
  }

  /// **Mechanica**
  ///
  /// Returns a `new` NSAttributedString appending the right String to the left NSAttributedString.
  static func + (lhs: NSAttributedString, rhs: String) -> NSAttributedString {
    // swiftlint:disable force_cast
    let attributedString = lhs.mutableCopy() as! NSMutableAttributedString
    return (attributedString + rhs).copy() as! NSAttributedString
    // swiftlint:enable force_cast
  }

  /// **Mechanica**
  ///
  /// Returns a `new` NSAttributedString appending the right NSAttributedString to the left String.
  static public func + (lhs: String, rhs: NSAttributedString) -> NSAttributedString {
    let attributedString = NSMutableAttributedString(string: lhs)
    // swiftlint:disable:next force_cast
    return (attributedString + rhs).copy() as! NSAttributedString
  }

  //#endif
}

#endif
