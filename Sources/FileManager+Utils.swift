//
//  FileManager+Utils.swift
//  Mechanica
//
//  Copyright © 2016 Tinrobots.
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

extension FileManager {
  
  /// **Mechanica**
  ///
  /// Returns the location of the document directory.
  public class var documentDirectory: URL {
    return try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
  }

  /// **Mechanica**
  ///
  /// Returns the location of discardable cache files (Library/Caches).
  public class var cachesDirectory: URL {
    return try! FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
  }
  
  /// **Mechanica**
  ///
  /// Returns always a `new` directory in Library/Caches for discardable cache files (temporary).
  public class var temporaryDirectory: URL {
    var url = FileManager.cachesDirectory
    url.appendPathComponent(UUID().uuidString)
    if (!FileManager.default.fileExists(atPath: url.absoluteString)){
      try! FileManager.default.createDirectory(at: url, withIntermediateDirectories: false, attributes: nil)
    }
    return url
  }
  
  /// **Mechanica**
  ///
  /// Returns the container directory associated with the specified security application group Identifier.
  public class func container(for groupIdentifier: String) -> URL? {
    return FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: groupIdentifier)
  }
  
}
