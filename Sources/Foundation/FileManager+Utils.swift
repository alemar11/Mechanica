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

// File System Basics: https://developer.apple.com/library/content/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/FileSystemOverview/FileSystemOverview.html
// Migrating an App to a Sandbox: https://developer.apple.com/library/content/documentation/Security/Conceptual/AppSandboxDesignGuide/MigratingALegacyApp/MigratingAnAppToASandbox.html

#if canImport(Foundation)
import Foundation

extension FileManager {

  /// **Mechanica**
  ///
  /// Cleans all contents in a directory `path`.
  ///
  /// - Parameter path: **directory** path (if it's not a directory path, nothing is done).
  /// - Throws:  throws an error in cases of failure.
  public final func cleanDirectory(atPath path: String) throws {

//    #if !os(Linux)
//      var isDirectory: ObjCBool = false
//      guard fileExists(atPath: path, isDirectory: &isDirectory) == true else { return }
//      guard isDirectory.boolValue == true else { return }
//    #else
      guard fileExists(atPath: path) == true else { return }

      var result = Stat()
      stat(path, &result)
      guard result.isDirectory == true else { return }

//    #endif

    let contents = try contentsOfDirectory(atPath: path)

    for file in contents {
      let path = URL(fileURLWithPath: path).appendingPathComponent(file).path
      try removeItem(atPath: path)
    }
  }

  /// **Mechanica**
  ///
  /// Delete a file or a directory at a given `path`.
  ///
  /// - Parameter path: directory or file path.
  /// - Throws:  throws an error in cases of failure.
  public final func deleteFileOrDirectory(atPath path: String) throws {
    guard fileExists(atPath: path) == true else { return }

    try removeItem(atPath: path)
  }

}
#endif
