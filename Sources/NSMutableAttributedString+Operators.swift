//
//  NSMutableAttributedString+Operators.swift
//  Mechanica
//
//  Copyright © 2016-2017 Tinrobots.
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
#elseif os(OSX)
  import Cocoa
#endif

extension NSMutableAttributedString {
  
  static public func + (lhs: NSMutableAttributedString, rhs: NSMutableAttributedString) -> NSMutableAttributedString {
    let a = lhs.mutableCopy() as! NSMutableAttributedString
    let b = rhs.mutableCopy() as! NSMutableAttributedString
    a.append(b)
    return a
  }
  
  static public func + (lhs: NSMutableAttributedString, rhs: NSAttributedString) -> NSMutableAttributedString {
    let a = lhs.mutableCopy() as! NSMutableAttributedString
    a.append(rhs)
    return a
  }
  
  static public func + (lhs: NSAttributedString, rhs: NSMutableAttributedString) -> NSMutableAttributedString {
    let a = NSMutableAttributedString(attributedString: lhs)
    return a + rhs
  }
  
  static public func + (lhs: NSMutableAttributedString, rhs: String) -> NSMutableAttributedString {
    let a = lhs.mutableCopy() as! NSMutableAttributedString
    let b = NSMutableAttributedString(string: rhs)
    return a + b
  }
  
  static public func + (lhs: String, rhs: NSMutableAttributedString) -> NSMutableAttributedString {
    let a = NSMutableAttributedString(string: lhs)
    let b = rhs.mutableCopy() as! NSMutableAttributedString
    return a + b
  }
  
  static public func += (lhs: NSMutableAttributedString, rhs: NSAttributedString) {
    lhs.append(rhs)
  }
  
  static func += (lhs: NSMutableAttributedString, rhs: String) {
    lhs.append(NSAttributedString(string: rhs))
  }
  
}

extension NSAttributedString {
  
  //TODO: test copy method
  
  static public func + (lhs: NSAttributedString, rhs: NSAttributedString) -> NSAttributedString {
    let a = lhs.mutableCopy() as! NSMutableAttributedString
    return (a + rhs).copy() as! NSAttributedString
  }
  
  static func + (lhs: NSAttributedString, rhs: String) -> NSAttributedString {
    let a = lhs.mutableCopy() as! NSMutableAttributedString
    return (a + rhs).copy() as! NSAttributedString
  }
  
   static public func + (lhs: String, rhs: NSAttributedString) -> NSAttributedString {
    let a = lhs.mutableCopy() as! NSMutableAttributedString
    return (a + rhs).copy() as! NSAttributedString  }
  
}

extension NSAttributedString {
  
  /// **Mechanica**
  ///
  /// Initializes and returns a `new` NSAttributedString object from the `html` contained in the given string.
  /// - Parameters:
  ///   - html: an HTML string.
  /// - note: The HTML import mechanism is meant for implementing something like markdown (that is, text styles, colors, and so on), not for general HTML import.
  /// [Apple Doc](https://developer.apple.com/reference/foundation/nsattributedstring/1524613-init)
  /// - warning: Using the HTML importer (NSHTMLTextDocumentType) is only possible on the main thread.
  public convenience init?(html: String) {
    guard let data = html.data(using: String.Encoding.utf8, allowLossyConversion: false) else { return nil }
    try? self.init(data: data, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
  }
  
}
