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

extension NSMutableAttributedString {

  /// **Mechanica**
  ///
  /// Removes all the attributes from `self`.
  public func removeAllAttributes() {
    setAttributes([:], range: NSRange(location: 0, length: string.length))
  }

  /// **Mechanica**
  ///
  /// Returns a `new` NSMutableAttributedString removing all the attributes.
  public func removingAllAttributes() -> NSMutableAttributedString {
    return NSMutableAttributedString(string: string)
  }

  #if os(iOS) || os(macOS)

  /// **Mechanica**
  ///
  /// Adds the **bold** attribute to a given `range` (or to entire NSMutableAttributedString is nil).
  public func setBoldFont(in range: NSRange? = nil) {
    addAttributes([.font: Font.boldSystemFont(ofSize: Font.systemFontSize)], range: range.hasValue ? range! : string.nsRange)
  }

  #endif

  /// **Mechanica**
  ///
  /// Adds the **underline** attribute to a given `range` (or to entire NSMutableAttributedString is nil).
  public func setUnderline(in range: NSRange? = nil, style: NSUnderlineStyle = .styleSingle) {
    addAttributes([.underlineStyle: style.rawValue], range: range.hasValue ? range! : string.nsRange)
  }

  /// **Mechanica**
  ///
  /// Adds the **strikethrough** attribute to a given `range` (or to entire NSMutableAttributedString is nil).
  public func setStrikethrough(in range: NSRange? = nil, style: NSUnderlineStyle = .styleSingle) {
    let attributes = [NSAttributedStringKey.strikethroughStyle: NSNumber(value: style.rawValue as Int)]
    addAttributes(attributes, range: range.hasValue ? range! : string.nsRange)
  }

  /// **Mechanica**
  ///
  /// Adds the **foregroundColor** attribute to a given `range` (or to entire NSMutableAttributedString is nil).
  public func setColorForeground(_ color: Color, in range: NSRange? = nil) {
    addAttributes([NSAttributedStringKey.foregroundColor: color], range: range.hasValue ? range! : string.nsRange)
  }

  /// **Mechanica**
  ///
  /// Adds the **backgroundColor** attribute to a given `range` (or to entire NSMutableAttributedString is nil).
  public func setColorBackground(_ color: Color, in range: NSRange? = nil) {
    addAttributes([NSAttributedStringKey.backgroundColor: color], range: range.hasValue ? range! : string.nsRange)
  }

  #if os(iOS)

  /// **Mechanica**
  ///
  /// Adds the **systemFontSize** attribute to a given `range` (or to entire NSMutableAttributedString is nil).
  public func setItalicFont(in range: NSRange? = nil) {
    addAttributes([.font: Font.italicSystemFont(ofSize: Font.systemFontSize)], range: range.hasValue ? range! : string.nsRange)
  }

  #endif

}
