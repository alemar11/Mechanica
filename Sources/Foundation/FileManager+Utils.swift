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

// File System Basics: https://developer.apple.com/library/content/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/FileSystemOverview/FileSystemOverview.html
// Migrating an App to a Sandbox: https://developer.apple.com/library/content/documentation/Security/Conceptual/AppSandboxDesignGuide/MigratingALegacyApp/MigratingAnAppToASandbox.html

import Foundation
#if os(Linux)
  import Glibc
#else
  import Darwin
#endif

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
      // these lines works on macOS, iOS, tvOS, watchOS
      guard fileExists(atPath: path) == true else { return }
      var res: stat = stat()
      stat(path, &res)
      guard res.isDirectory == true else { return }
//    #endif

    let contents = try contentsOfDirectory(atPath: path)
    
    for file in contents {
      let path = URL(fileURLWithPath: path).appendingPathComponent(file).path
      try removeItem(atPath: path)
    }
  }
  
  #if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
  
  /// **Mechanica**
  ///
  /// Returns the container directory associated with the specified security application group Identifier.
  public final func containerDirectory(for groupIdentifier: String) -> URL? {
    return containerURL(forSecurityApplicationGroupIdentifier: groupIdentifier)
  }
  
  #endif
  
  /// **Mechanica**
  ///
  /// Destroys a file or a directory at a given `path`; throws an error in cases of failure.
  ///
  /// - Parameter path: directory or file path.
  public final func destroyFileOrDirectory(atPath path: String) throws {
    guard fileExists(atPath: path) == true else { return }
    
    try removeItem(atPath: path)
  }
  
}

fileprivate extension stat {
  
  // https://github.com/nsomar/FileUtils
  
  fileprivate var isExecutable: Bool {
    #if os(Linux)
      return UInt32(S_IEXEC) == st_mode
    #else
      return S_IEXEC == st_mode
    #endif
  }
  
  fileprivate var isLink: Bool {
    //return S_IFLNK == st_mode
     return S_ISLNK(Int(st_mode))
  }
  
  fileprivate var isDirectory: Bool {
    //return S_IFDIR == st_mode || 16877 == st_mode || 16893 == st_mode
    return S_ISDIR(Int(st_mode))
  }
  
  fileprivate var isFile: Bool {
    //return !isExecutable && !isLink && !isDirectory
    return S_ISREG(Int(st_mode))
  }
  
}

extension stat: Equatable {
  public static func ==(lhs: stat, rhs: stat) -> Bool {
    return lhs.st_dev ==  rhs.st_dev && lhs.st_ino == rhs.st_ino
  }

}


public let S_IFMT : Int = 0o170000    // [XSI] type of file mask
public let S_IFIFO: Int = 0o010000    // [XSI] named pipe (fifo)
public let S_IFCHR: Int = 0o020000    // [XSI] character special
public let S_IFDIR: Int = 0o040000    // [XSI] directory
public let S_IFBLK: Int = 0o060000    // [XSI] block special
public let S_IFREG: Int = 0o100000    // [XSI] regular
public let S_IFLNK: Int = 0o120000    // [XSI] symbolic link
public let S_IFSOCK:Int = 0o140000    // [XSI] socket

public func S_ISBLK(_ m: Int) -> Bool {
  return (((m) & S_IFMT) == S_IFBLK)  /* block special */
}

public func S_ISCHR(_ m: Int) -> Bool {
  return (((m) & S_IFMT) == S_IFCHR)  /* char special */
}

public func S_ISDIR(_ m: Int) -> Bool {
  return (((m) & S_IFMT) == S_IFDIR)  /* directory */
}

public func S_ISFIFO(_ m: Int) -> Bool {
  return (((m) & S_IFMT) == S_IFIFO)  /* fifo or socket */
}

public func S_ISREG(_ m: Int) -> Bool {
  return (((m) & S_IFMT) == S_IFREG)  /* regular file */
}

public func S_ISLNK(_ m: Int) -> Bool {
  return (((m) & S_IFMT) == S_IFLNK)  /* symbolic link */
}

public func S_ISSOCK(_ m: Int) -> Bool {
  return (((m) & S_IFMT) == S_IFSOCK)  /* socket */
}

