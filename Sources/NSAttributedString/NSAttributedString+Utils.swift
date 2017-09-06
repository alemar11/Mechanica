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

#if os(iOS) || os(tvOS) || os(watchOS)
  import UIKit
#elseif os(macOS)
  import Cocoa
#endif

// MARK: - Attributes

extension NSAttributedString {

  #if os(iOS) || os(macOS)

  /// **Mechanica**
  ///
  /// Returns a `new` NSAttributedString adding the bold attribute.
  public func bold(range: NSRange? = nil) -> NSAttributedString {
    guard let attributedString = self.mutableCopy() as? NSMutableAttributedString else { return self }

    attributedString.addAttributes([.font: Font.boldSystemFont(ofSize: Font.systemFontSize)], range: range.hasValue ? range! : string.nsRange)

    return attributedString
  }

  #endif

  /// **Mechanica**
  ///
  /// Returns a `new` NSAttributedString adding the underline attribute.
  public func underline(range: NSRange? = nil, style: NSUnderlineStyle = .styleSingle) -> NSAttributedString {
    guard let attributedString = self.mutableCopy() as? NSMutableAttributedString else { return self }

    attributedString.addAttributes([.underlineStyle: style.rawValue], range: range.hasValue ? range! : string.nsRange)

    return attributedString
  }

  /// **Mechanica**
  ///
  /// Returns a `new` NSAttributedString adding the strikethrough attribute.
  public func strikethrough(range: NSRange? = nil, style: NSUnderlineStyle = .styleSingle) -> NSAttributedString {
    guard let attributedString = self.mutableCopy() as? NSMutableAttributedString else { return self }

    let attributes = [NSAttributedStringKey.strikethroughStyle: NSNumber(value: style.rawValue as Int)]
    attributedString.addAttributes(attributes, range: range.hasValue ? range! : string.nsRange)

    return attributedString
  }

  #if os(iOS)

  /// **Mechanica**
  ///
  /// Returns a `new` NSAttributedString adding the italic attribute.
  public func italic(range: NSRange? = nil) -> NSAttributedString {
    guard let attributedString = self.mutableCopy() as? NSMutableAttributedString else { return self }

    attributedString.addAttributes([.font: Font.italicSystemFont(ofSize: Font.systemFontSize)], range: range.hasValue ? range! : string.nsRange)

    return attributedString
  }

  #endif

}

// MARK: - Initializers

extension NSAttributedString {

  /// **Mechanica**
  ///
  /// Initializes and returns a `new` NSAttributedString object from the `html` contained in the given string.
  /// - Parameters:
  ///   - html: an HTML string.
  ///   - allowLossyConversion: If flag is *true* and the receiver can’t be converted without losing some information, some characters may be removed or altered in conversion.
  /// For example, in converting a character from NSUnicodeStringEncoding to NSASCIIStringEncoding, the character ‘Á’ becomes ‘A’, losing the accent..
  /// - Note: The HTML import mechanism is meant for implementing something like markdown (that is, text styles, colors, and so on), not for general HTML import.
  /// [Apple Documentation](https://developer.apple.com/reference/foundation/nsattributedstring/1524613-init)
  /// - Warning: Using the HTML importer (NSHTMLTextDocumentType) is only possible on the main thread.
  public convenience init?(html: String, allowLossyConversion: Bool = false) {
    guard let data = html.data(using: .utf8, allowLossyConversion: allowLossyConversion) else { return nil }

    try? self.init(data: data,
                   options: [.documentType: NSAttributedString.DocumentType.html],
                   documentAttributes: nil)
  }

}
