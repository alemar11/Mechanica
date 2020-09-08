// File System Basics: https://developer.apple.com/library/content/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/FileSystemOverview/FileSystemOverview.html
// Migrating an App to a Sandbox: https://developer.apple.com/library/content/documentation/Security/Conceptual/AppSandboxDesignGuide/MigratingALegacyApp/MigratingAnAppToASandbox.html

#if canImport(Foundation)

// TODO: checking a file existance ahead of an operation is not recommended

import Foundation

extension FileManager {
  /// **Mechanica**
  ///
  /// Cleans all contents in a directory `path`.
  ///
  /// - Parameter path: **directory** path (if it's not a directory path, nothing is done).
  /// - Throws:  throws an error in cases of failure.
  public final func cleanDirectory(atPath path: String) throws {
//    #if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
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

  /// **Mechanica**
  ///
  /// Creates and returns always a `new` directory in Library/Caches in the user's home directory for discardable cache files.
  public final func newCachesSubDirectory(in domain: FileManager.SearchPathDomainMask = .userDomainMask, withName name: String = UUID().uuidString) throws -> URL {
    let cachesDirectoryURL = try url(for: .cachesDirectory, in: domain, appropriateFor: nil, create: true)
    let subdirectoryURL = cachesDirectoryURL.appendingPathComponent(name)

    if !fileExists(atPath: subdirectoryURL.path) {
      try createDirectory(at: subdirectoryURL, withIntermediateDirectories: false, attributes: nil)
    }

    return subdirectoryURL
  }
}

#endif
