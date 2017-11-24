//
// Mechanica
//
// Copyright © 2016-2017 Tinrobots.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Foundation

extension NSAttributedString {

  #if !os(Linux)
  // Not implemented on Linux: "mutableCopy(with:) is not yet implemented".

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

  // MARK: - Operators

  /// **Mechanica**
  ///
  /// Returns a `new` NSAttributedString appending the right NSAttributedString to the left NSAttributedString.
  static public func + (lhs: NSAttributedString, rhs: NSAttributedString) -> NSAttributedString {
    // swiftlint:disable force_cast
    let a = lhs.mutableCopy() as! NSMutableAttributedString
    return (a + rhs).copy() as! NSAttributedString
    // swiftlint:enable force_cast
  }

  /// **Mechanica**
  ///
  /// Returns a `new` NSAttributedString appending the right String to the left NSAttributedString.
  static func + (lhs: NSAttributedString, rhs: String) -> NSAttributedString {
    // swiftlint:disable force_cast
    let a = lhs.mutableCopy() as! NSMutableAttributedString
    return (a + rhs).copy() as! NSAttributedString
    // swiftlint:enable force_cast
  }

  /// **Mechanica**
  ///
  /// Returns a `new` NSAttributedString appending the right NSAttributedString to the left String.
  static public func + (lhs: String, rhs: NSAttributedString) -> NSAttributedString {
    let a = NSMutableAttributedString(string: lhs)
    // swiftlint:disable force_cast
    return (a + rhs).copy() as! NSAttributedString
    // swiftlint:enable force_cast
  }

  #endif

}
