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
  
  // MARK: - URL
  
  /// **Mechanica**
  ///
  /// Returns the location of the document directory (*Documents*).
  public class var documentDirectory: URL {
    return try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
  }
  
  /// **Mechanica**
  ///
  /// Returns the location of discardable cache files (*Library/Caches*).
  public class var cachesDirectory: URL {
    return try! FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
  }
  
  /// **Mechanica**
  ///
  /// Returns the location of discardable cache files (*Library/Application Support*).
  public class var applicationSupportDirectory: URL {
    return try! FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
  }
  
  /// **Mechanica**
  ///
  /// Returns the location of the temporary directory (*tmp*).
  public class var temporaryDirectory: URL {
    return URL(fileURLWithPath: NSTemporaryDirectory())
  }
  
  /// **Mechanica**
  ///
  /// Returns always a `new` directory in Library/Caches for discardable cache files (temporary).
  public class var makeNewTemporaryCacheDirectory: URL {
    let url = FileManager.cachesDirectory.appendingPathComponent(UUID().uuidString)
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
  
  // MARK: - Delete
  
  func clearDirectoryAtPath(_ path: String) throws {
    let contents = try contentsOfDirectory(atPath: path)
    for file in contents {
      try removeItem(atPath: path.pathByAppendingPathComponent(file))
    }
  }
  
  public class func clearDirectoryAtPath(_ path: String) throws {
    try FileManager.default.clearDirectoryAtPath(path)
  }
  
  public class func clearTemporaryDirectory() throws {
    try FileManager.default.clearDirectoryAtPath(FileManager.temporaryDirectory.path)
  }
  
  public class func clearDocumentDirectory() throws {
    try FileManager.default.clearDirectoryAtPath(FileManager.documentDirectory.path)
  }
  
  public class func clearCachesDirectory() throws {
    try FileManager.default.clearDirectoryAtPath(FileManager.cachesDirectory.path)
  }
  
}

extension String {

  /// **Mechanica**
  ///
  /// - Parameters:
  ///   - pathComponent: The path component to add.
  ///   - isDirectory: If true, then a trailing / is added to the resulting path. (default false)
  /// - Returns: Returns a path constructed by appending the given path component to `self`. If you know in advance that the path component is a directory or not, then set *isDirectory* to true.
  public func pathByAppendingPathComponent(_ pathComponent: String, isDirectory: Bool = false) -> String {
    if (isDirectory){
      return URL(fileURLWithPath: self).appendingPathComponent(pathComponent, isDirectory: true).path
    } else {
       return URL(fileURLWithPath: self).appendingPathComponent(pathComponent).path
    }
  }
}
