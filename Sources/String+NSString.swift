//
//  String+NSString.swift
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

extension String {

  /// **Mechanica**
  ///
  /// Returns the last path component of the receiver.
  /// - Note: This method only works with file paths (not, for example, string representations of URLs).
  var lastPathComponent: String {
    return (self as NSString).lastPathComponent
  }

  /// **Mechanica**
  ///
  /// Return the path extension, if any, of the string as interpreted as a path.
  /// - Note: This method only works with file paths (not, for example, string representations of URLs).
  var pathExtension: String {
    return (self as NSString).pathExtension
  }

  /// **Mechanica**
  ///
  /// Returns a `new` string made by deleting the last path component from the receiver, along with any final path separator.
  /// - Note: This method only works with file paths (not, for example, string representations of URLs).
  var deletingLastPathComponent: String {
    return (self as NSString).deletingLastPathComponent
  }

  /// **Mechanica**
  ///
  /// Returns a `new` string made by deleting the extension (if any, and only the last) from the receiver.
  var deletingPathExtension: String {
    return (self as NSString).deletingPathExtension
  }

  /// **Mechanica**
  ///
  /// Returns the file-system path components of the receiver.
  var pathComponents: [String] {
    return (self as NSString).pathComponents
  }

  /// **Mechanica**
  ///
  /// Returns a new string made by appending to the receiver a given string.
  func appendingPathComponent(_ path: String) -> String {
    let nsString = self as NSString
    return nsString.appendingPathComponent(path)
  }

  /// **Mechanica**
  ///
  /// Returns a new string made by appending to the receiver an extension separator followed by a given extension.
  func appendingPathExtension(_ ext: String) -> String? {
    let nsString = self as NSString
    return nsString.appendingPathExtension(ext)
  }

}
