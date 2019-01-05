//
// Mechanica
//
// Copyright © 2016-2019 Tinrobots.
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

#if canImport(Foundation)
import Foundation

extension URL {

  /// **Mechanica**
  ///
  /// Returns a Dictionary containing the query parameters (is any).
  public var queryParameters: [String: String]? {
    guard
      let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
      let queryItems = components.queryItems,
      queryItems.count > 0
      else {
        return nil
    }

    var parameters = [String: String]()
    for item in queryItems {
      parameters[item.name] = item.value
    }

    return parameters
  }

  /// Removes a specified number of path components from `self`.
  ///
  /// - Parameter numberOfPathComponents: components to be removed.
  ///
  /// This function may either remove a path component or append /...
  /// If the URL has an empty path (e.g., http://www.example.com), then this function will return the URL unchanged.
  public mutating func deleteLastPathComponents(_ numberOfPathComponents: Int) {
    self = deletingLastPathComponents(numberOfPathComponents)
  }

  /// **Mechanica**
  ///
  /// - Parameter numberOfPathComponents: components to be removed.
  /// - Returns: Returns a URL constructed by removing a specified number of path components.
  ///
  /// This function may either remove a path component or append /...
  /// If the URL has an empty path (e.g., http://www.example.com), then this function will return the URL unchanged.
  public func deletingLastPathComponents(_ numberOfPathComponents: Int) -> URL {
    var copy = self

    for _ in 0..<numberOfPathComponents {
      copy.deleteLastPathComponent()
    }

    return copy
  }

  /// **Mechanica**
  ///
  /// Returns true if the URL is a directory.
  var isDirectory: Bool {
    //    #if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
    //      guard let resourceMap = try? self.resourceValues(forKeys: [.isDirectoryKey]) else { return false }
    //      return resourceMap.isDirectory ?? false
    //    #elseif os(Linux)
    var result = Stat()
    stat(path, &result)
    return result.isDirectory
    //    #endif
  }

  /// **Mechanica**
  ///
  /// Returns true if the URL is a regular file.
  var isFile: Bool {
    var result = Stat()
    stat(path, &result)
    return result.isFile
  }

  /// **Mechanica**
  ///
  /// Tests if a `URL` is a child node of a parent.
  ///
  /// - Parameter child: The URL to test.
  /// - Returns: True if the argument is a child of this instance.
  func isParent(of child: URL) -> Bool {
    return child.path.hasPrefix(path)
  }

}
#endif
