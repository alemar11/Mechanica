//
//  FileManager+Utils.swift
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

// File System Basics: https://developer.apple.com/library/content/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/FileSystemOverview/FileSystemOverview.html
// Migrating an App to a Sandbox: https://developer.apple.com/library/content/documentation/Security/Conceptual/AppSandboxDesignGuide/MigratingALegacyApp/MigratingAnAppToASandbox.html

import Foundation

extension FileManager {

  // MARK: - URL

  /// **Mechanica**
  ///
  /// Returns the location of the document directory (*Documents/*).
  /// The contents of this directory can be made available to the user through file sharing; therefore, his directory should only contain files that you may wish to expose to the user.
  /// - Note: Use this directory to store user-generated content.
  ///
  /// The contents of *Documents* directory are **backed up by iTunes and iCloud**.
  public var documentDirectory: URL {
    // swiftlint:disable force_try
    return try! url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    // swiftlint:enable force_try
  }

  /// **Mechanica**
  ///
  /// Returns the location of the library directory (*Library/*).
  /// - Note: Use the Library subdirectories for any files you don’t want exposed to the user. Your app should not use these directories for user data files.
  ///
  /// You typically put files in one of several standard subdirectories. iOS apps commonly use the *Application Support* and *Caches subdirectories*; however, you can create custom subdirectories.
  ///
  /// The contents of the *Library* directory are **backed up by iTunes and iCloud** (with the exception of the *Caches subdirectory*).
  public var libraryDirectory: URL {
    // swiftlint:disable force_try
    return try! url(for: .libraryDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    // swiftlint:enable force_try
  }

  /// **Mechanica**
  ///
  /// Returns the location of discardable cache files (*Library/Caches/*).
  /// - Note: Put data cache files in the Library/Caches/ directory. Cache data can be used for any data that needs to persist longer than temporary data, but not as long as a support file.
  ///
  /// Generally speaking, the application does not require cache data to operate properly, but it can use cache data to improve performance.
  /// Examples of cache data include (but are not limited to) database cache files and transient, downloadable content.
  ///
  /// The contents of the *Library/Caches* are **not backed up by iTunes and iCloud**.
  ///
  /// Note that the system may delete the Caches/ directory to free up disk space, so your app must be able to re-create or download these files as needed.
  ///
  /// - Important: Sandboxed *macOS* apps have all their *Caches* directory located at a system-defined path (typically found at *~/Library/Containers/<bundle_id>*).
  public var cachesDirectory: URL {
    // swiftlint:disable force_try
    return try! url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    // swiftlint:enable force_try
  }

  /// **Mechanica**
  ///
  /// Returns the location of application support files (*Library/Application Support/*).
  /// - Note: Put app-created support files in the *Library/Application support/* directory.
  ///
  /// In general, this directory includes files that the app uses to run but that should remain hidden from the user.
  /// This directory can also include data files, configuration files, templates and modified versions of resources loaded from the app bundle.
  ///
  /// The contents of the *Library/Application Support/* are **backed up by iTunes and iCloud**.
  ///
  /// - Warning: On *macOS* all content in this directory should be placed in a **custom subdirectory** whose name is that of your app’s bundle identifier or your company.
  ///
  /// - Important: Sandboxed *macOS* apps have all their *Application Support* directory located at a system-defined path (typically found at *~/Library/Containers/<bundle_id>*).
  public var applicationSupportDirectory: URL {
    // swiftlint:disable force_try
    return try! url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    // swiftlint:enable force_try
  }

  /// **Mechanica**
  ///
  /// Creates and returns always a `new` directory in Library/Caches for discardable cache files.
  public var makeNewCachesSubDirectory: URL {
    let url = cachesDirectory.appendingPathComponent(UUID().uuidString)
    if (!fileExists(atPath: url.path)) {
      // swiftlint:disable force_try
      try! createDirectory(at: url, withIntermediateDirectories: false, attributes: nil)
      // swiftlint:enable force_try
    }
    return url
  }

  /// **Mechanica**
  ///
  /// Returns the container directory associated with the specified security application group Identifier.
  public final func containerDirectory(for groupIdentifier: String) -> URL? {
    return containerURL(forSecurityApplicationGroupIdentifier: groupIdentifier)
  }

  // MARK: - Delete

  /// **Mechanica**
  ///
  /// Clears all contents in a directory `path`; throws an error in cases of failure.
  ///
  /// - Parameter path: **directory** path (if it's not a directory path, nothing is done).
  public final func clearDirectory(atPath path: String) throws {
    var isDirectory: ObjCBool = false
    guard fileExists(atPath: path, isDirectory: &isDirectory) == true else { return }
    guard isDirectory.boolValue == true else { return }
    let contents = try contentsOfDirectory(atPath: path)
    for file in contents {
      let path = URL(fileURLWithPath: path).appendingPathComponent(file).path
      try removeItem(atPath: path)
    }
  }

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
