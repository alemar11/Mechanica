//
//  NSPersistentStoreCoordinator+Utils.swift
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

import CoreData

extension NSPersistentStoreCoordinator {

  /// **Mechanica**
  ///
  /// Destroys a Persistent Store located at `url`.
  @available(iOS 10, *)
  @available(tvOS 10, *)
  @available(watchOS 3, *)
  @available(OSX 10.12, *)
  public static func destroyStore(as url: URL) {
    do {
      let persistentStoreCoordinator = self.init(managedObjectModel: NSManagedObjectModel())
      try persistentStoreCoordinator.destroyPersistentStore(at: url, ofType: NSSQLiteStoreType, options: nil)
    } catch {
      print("Failed to destroy persistent store at \(url).", error)
    }
  }

  /// **Mechanica**
  ///
  /// Replaces a Persistent Store located at `targetURL` with one at `sourceURL`.
  @available(iOS 10, *)
  @available(tvOS 10, *)
  @available(watchOS 3, *)
  @available(OSX 10.12, *)
  public static func replaceStore(at targetURL: URL, withStoreFrom sourceURL: URL) throws {
    let persistentStoreCoordinator = self.init(managedObjectModel: NSManagedObjectModel())
    try persistentStoreCoordinator.replacePersistentStore(at: targetURL, destinationOptions: nil, withPersistentStoreFrom: sourceURL, sourceOptions: nil, ofType: NSSQLiteStoreType)
  }

}
