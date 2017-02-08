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

