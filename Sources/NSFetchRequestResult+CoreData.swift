//
//  NSFetchRequestResult+CoreData.swift
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
import CoreData

extension NSFetchRequestResult where Self: NSManagedObject {

  /// **Mechanica**
  ///
  /// The NSEntityDescription object.
  @available(iOS 10, *)
  @available(tvOS 10, *)
  @available(watchOS 3, *)
  @available(OSX 10.12, *)
  public static var entity: NSEntityDescription { return entity() }

  /// **Mechanica**
  ///
  /// The entity name.
  @available(iOS 10, *)
  @available(tvOS 10, *)
  @available(watchOS 3, *)
  @available(OSX 10.12, *)
  public static var entityName: String { return entity.name! }

  /// **Mechanica**
  ///
  /// Creates a `new` NSFetchRequest for `self`.
  @available(iOS 10, *)
  @available(tvOS 10, *)
  @available(watchOS 3, *)
  @available(OSX 10.12, *)
  public static func fetchRequest() -> NSFetchRequest<Self> {
    //let fetchRequest = NSFetchRequest<Self>(entity: entity)
    let fetchRequest = NSFetchRequest<Self>(entityName: entityName)
    return fetchRequest
  }

  /// **Mechanica**
  ///
  /// Attempts to find an object matching a predicate or creates a new one and configures it.
  ///
  /// - Parameters:
  ///   - context: Searched context.
  ///   - predicate: Matching predicate.
  ///   - configuration: Configuration closure called only when creating a new object.
  /// - Returns: A matching object or a configured new one.
  @available(iOS 10, *)
  @available(tvOS 10, *)
  @available(watchOS 3, *)
  @available(OSX 10.12, *)
  public static func findOrCreate(in context: NSManagedObjectContext, where predicate: NSPredicate, with configuration: (Self) -> ()) -> Self {
    guard let object = findOrFetch(in: context, where: predicate) else {
      let newObject: Self = Self(context: context) //context.insertObject()
      configuration(newObject)
      return newObject
    }
    return object
  }

  /// **Mechanica**
  ///
  /// Tries to find an existing object in the context (memory) matching a predicate and if doesn’t find the object in the context, tries to load it using a fetch request (if multiple objects are found, returns the **first** one).
  ///
  /// - Parameters:
  ///   - context: Searched context.
  ///   - predicate: Matching predicate.
  /// - Returns: A matching object (if any).
  @available(iOS 10, *)
  @available(tvOS 10, *)
  @available(watchOS 3, *)
  @available(OSX 10.12, *)
  public static func findOrFetch(in context: NSManagedObjectContext, where predicate: NSPredicate) -> Self? {
    //first we should fetch an existing object in the context as a performance optimization
    guard let object = findMaterializedObject(in: context, where: predicate) else {
      //if it's not in memory, we should execute a fetch to see if it exists
      return fetch(in: context) { request in
        request.predicate = predicate
        request.returnsObjectsAsFaults = false
        request.fetchLimit = 1
        }.first
    }
    return object
  }

  /// **Mechanica**
  ///
  /// Performs a configurable fetch request in a context.
  @available(iOS 10, *)
  @available(tvOS 10, *)
  @available(watchOS 3, *)
  @available(OSX 10.12, *)
  public static func fetch(in context: NSManagedObjectContext, with configuration: (NSFetchRequest<Self>) -> () = { _ in }) -> [Self] {
    let request = NSFetchRequest<Self>(entityName: entityName)
    configuration(request)
    guard let result = try? context.fetch(request) else { fatalError("Fetched objects have wrong type.") }
    return result
  }

  /// **Mechanica**
  ///
  /// Specifies objects (matching a given predicate) that should be removed from its persistent store when changes are committed.
  /// If objects have not yet been saved to a persistent store, they are simply removed from the context.
  /// - note: `NSBatchDeleteRequest` would be more efficient but requires a context with an `NSPersistentStoreCoordinator` directly connected (no child context).
  @available(iOS 10, *)
  @available(tvOS 10, *)
  @available(watchOS 3, *)
  @available(OSX 10.12, *)
  private static func deleteAll(in context: NSManagedObjectContext, where predicate: NSPredicate) {
    fetch(in: context) { request in
      request.includesPropertyValues = false
      request.includesSubentities = false
      request.predicate = predicate
      }.lazy.forEach(context.delete(_:))
  }

  /// **Mechanica**
  ///
  /// Removes all entities from within the specified `NSManagedObjectContext` excluding a given list of entities.
  ///
  /// - parameter context: The `NSManagedObjectContext` to remove the Entities from.
  /// - parameter objects: An Array of `NSManagedObjects` belonging to the `NSManagedObjectContext` to exclude from deletion.
  /// - note: `NSBatchDeleteRequest` would be more efficient but requires a context with an `NSPersistentStoreCoordinator` directly connected (no child context).
  @available(iOS 10, *)
  @available(tvOS 10, *)
  @available(watchOS 3, *)
  @available(OSX 10.12, *)
  private static func deleteAll(in context: NSManagedObjectContext, except objects: [Self]) {
    let predicate = NSPredicate(format: "NOT (self IN %@)", objects)
    deleteAll(in: context, where: predicate )
  }

  /// **Mechanica**
  ///
  /// Counts the results of a configurable fetch request in a context.
  @available(iOS 10, *)
  @available(tvOS 10, *)
  @available(watchOS 3, *)
  @available(OSX 10.12, *)
  public static func count(in context: NSManagedObjectContext, for configuration: (NSFetchRequest<Self>) -> () = { _ in }) -> Int {
    let request = NSFetchRequest<Self>(entityName: entityName)
    configuration(request)
    do {
      let result = try context.count(for: request)
      guard result != NSNotFound else { fatalError("Failed to execute count fetch request.") }
      return result
    } catch let error {
      fatalError("Failed to execute fetch request: \(error).")
    }
  }

  /// **Mechanica**
  ///
  /// Iterates over the context’s registeredObjects set (which contains all managed objects the context currently knows about) until it finds one that is not a fault matching a given predicate.
  /// Faulted objects are not considered to to prevent Core Data to make a round trip to the persistent store.
  public static func findMaterializedObject(in context: NSManagedObjectContext, where predicate: NSPredicate) -> Self? {
    for object in context.registeredObjects where !object.isFault {
      guard let result = object as? Self, predicate.evaluate(with: result) else { continue }
      return result
    }
    return nil
  }

  /// **Mechanica**
  ///
  /// Executes a fetch request where only a single object is expected as result, otherwhile a fatal error occurs.
  @available(iOS 10, *)
  @available(tvOS 10, *)
  @available(watchOS 3, *)
  @available(OSX 10.12, *)
  public static func fetchSingleObject(in context: NSManagedObjectContext, with configuration: @escaping (NSFetchRequest<Self>) -> ()) -> Self? {
    let result = fetch(in: context) { request in
      configuration(request)
      request.fetchLimit = 2
    }
    switch result.count {
    case 0: return nil
    case 1: return result[0]
    default: fatalError("Returned multiple objects, expected max 1.")
    }
  }

}

// MARK: - Cache

extension NSFetchRequestResult where Self: NSManagedObject {

  /// **Mechanica**
  ///
  /// Tries to retrieve an object from the cache; if there’s nothing in the cache executes the fetch request and caches the result (if a single object is found).
  /// - Parameters:
  ///   - context: Searched context.
  ///   - cacheKey: Cache key.
  ///   - configuration: Configurable fetch request.
  /// - Returns: A cached object (if any).
  @available(iOS 10, *)
  @available(tvOS 10, *)
  @available(watchOS 3, *)
  @available(OSX 10.12, *)
  public static func fetchCachedObject(in context: NSManagedObjectContext, forKey cacheKey: String, with configuration: @escaping (NSFetchRequest<Self>) -> ()) -> Self? {
    guard let cached = context.cachedObject(forKey: cacheKey) as? Self else {
      let result = fetchSingleObject(in: context, with: configuration)
      context.setCachedObject(result, forKey: cacheKey)
      return result
    }
    return cached
  }

}
