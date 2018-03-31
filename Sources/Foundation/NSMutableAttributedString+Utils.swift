//
// Mechanica
//
// Copyright © 2016-2018 Tinrobots.
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

extension NSMutableAttributedString {

  #if !os(Linux)
  // Not implemented on Linux:
  //    "mutableCopy(with:) is not yet implemented"
  //    "append is not yet implemented"
  //    NSAttributedStringKey

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

  #endif

}
