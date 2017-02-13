//
//  NSManagedObjectConfigurable.swift
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

/// Objects adopting the `ManagedObjectConfigurable` support a variety of Core Data helper functionalities.
public protocol ManagedObjectConfigurable: class {

//  /// **Mechanica**
//  ///
//  /// Protocol `ManagedObjectConfigurable`.
//  ///
//  /// Entity name.
//  static var entityName: String { get }

  /// **Mechanica**
  ///
  /// Protocol `ManagedObjectConfigurable`.
  ///
  /// Default sort descriptors.
  static var defaultSortDescriptors: [NSSortDescriptor] { get }

  /// **Mechanica**
  ///
  /// Protocol `ManagedObjectConfigurable`.
  ///
  /// Default predicate.
  static var defaultPredicate: NSPredicate { get }

  /// **Mechanica**
  ///
  /// Protocol `ManagedObjectConfigurable`.
  ///
  /// ManagedObject context.
  var managedObjectContext: NSManagedObjectContext? { get }

}

// MARK: - Predicates and SortDescriptors

extension ManagedObjectConfigurable {

//  public static var entityName: String { return String(describing: self) }

  public static var defaultPredicate: NSPredicate { return NSPredicate(value: true) }

  public static var defaultSortDescriptors: [NSSortDescriptor] { return [] }

//  /// **Mechanica**
//  ///
//  /// Fetch Request with the `defaultPredicate` and the default `defaultSortDescriptors`.
//  public static var sortedFetchRequest: NSFetchRequest<NSFetchRequestResult> {
//    let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
//    request.sortDescriptors = defaultSortDescriptors
//    request.predicate = defaultPredicate
//    return request
//  }
//
//  /// **Mechanica**
//  ///
//  /// Creates a `new` sorted fetch request using `sortedFetchRequest` *AND* `predicate`.
//  public static func makeSortedFetchRequestWithPredicate(_ predicate: NSPredicate) -> NSFetchRequest<NSFetchRequestResult> {
//    let request = sortedFetchRequest
//    guard let existingPredicate = request.predicate else { fatalError("Must have a predicate.") }
//    request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [existingPredicate, predicate])
//    return request
//  }
//
//  /// **Mechanica**
//  ///
//  /// Creates a `new` sorted fetch request using `sortedFetchRequest` and `predicate` by substituting the values in an argument list into a format string.
//  public static func makeSortedFetchRequestWithPredicate(format: String, args: CVarArg...) -> NSFetchRequest<NSFetchRequestResult> {
//    let predicate = withVaList(args) { NSPredicate(format: format, arguments: $0) }
//    return makeSortedFetchRequestWithPredicate(predicate)
//  }
//
//  /// **Mechanica**
//  ///
//  /// Creates a `new` predicate using the `defaultPredicate` *AND* a `predicate` by substituting the values in an argument list into a format string.
//  public static func makeDefaultPredicateWithPreficate(format: String, args: CVarArg...) -> NSPredicate {
//    let predicate = withVaList(args) { NSPredicate(format: format, arguments: $0) }
//    return makeDefaultPredicateWithPredicate(predicate)
//  }
//
//  /// **Mechanica**
//  ///
//  /// Creates a `new` predicate using the `defaultPredicate` *AND* a given `predicate`.
//  public static func makeDefaultPredicateWithPredicate(_ predicate: NSPredicate) -> NSPredicate {
//    return NSCompoundPredicate(andPredicateWithSubpredicates: [defaultPredicate, predicate])
//  }

}

// MARK: - Fetch

//extension ManagedObjectConfigurable where Self: NSManagedObject {
//
//  /// **Mechanica**
//  ///
//  /// Creates a `new` NSFetchRequest for `Self`.
//  public static func fetchRequest() -> NSFetchRequest<Self> {
//    return NSFetchRequest<Self>(entityName: entityName);
//  }
//
//  /// **Mechanica**
//  ///
//  /// Attempts to find an object matching a predicate or creates a new one and configures it.
//  ///
//  /// - Parameters:
//  ///   - moc: Searched context.
//  ///   - predicate: Matching predicate.
//  ///   - configure: Configuration closure called only when creating a new object.
//  /// - Returns: A matching object or a configured new one.
//  public static func findOrCreateObject(inManagedObjectContext moc: NSManagedObjectContext, matchingPredicate predicate: NSPredicate, configure: (Self) -> ()) -> Self {
//    guard let object = findOrFetchFirstObject(inManagedObjectContext: moc, matchingPredicate: predicate) else {
//      let newObject: Self = Self(context: moc) //moc.insertObject()
//      configure(newObject)
//      return newObject
//    }
//    return object
//  }
//
//  /// **Mechanica**
//  ///
//  /// Tries to find an existing object in the context (memory) matching a predicate and if doesn’t find the object in the context, tries to load it using a fetch request.
//  ///
//  /// - Parameters:
//  ///   - moc: Searched context.
//  ///   - predicate: Matching predicate.
//  /// - Returns: A matching object (if any).
//  public static func findOrFetchFirstObject(inManagedObjectContext moc: NSManagedObjectContext, matchingPredicate predicate: NSPredicate) -> Self? {
//    //first we should fetch an existing object in the context as a performance optimization
//    guard let object = findMaterializedObject(inManagedObjectContext: moc, matchingPredicate: predicate) else {
//      //if it's not in memory, we should execute a fetch to see if it exists
//      return fetch(inManagedObjectContext: moc) { request in
//        request.predicate = predicate
//        request.returnsObjectsAsFaults = false
//        request.fetchLimit = 1
//        }.first
//    }
//    return object
//  }
//
//  /// **Mechanica**
//  ///
//  /// Performs a configurable fetch request in a context.
//  public static func fetch(inManagedObjectContext moc: NSManagedObjectContext, withRequestConfiguration configuration: (NSFetchRequest<Self>) -> () = { _ in }) -> [Self] {
//    let request = fetchRequest() as! NSFetchRequest<Self> //NSFetchRequest<Self>(entityName: Self.entityName)
//    configuration(request)
//    guard let result = try? moc.fetch(request) else { fatalError("Fetched objects have wrong type.") }
//    return result
//  }
//
//  /// **Mechanica**
//  ///
//  /// Counts the results of a configurable fetch request in a context.
//  public static func count(inManagedObjectContext moc: NSManagedObjectContext, withRequestConfiguration configuration: (NSFetchRequest<Self>) -> () = { _ in }) -> Int {
//    let request = fetchRequest() as! NSFetchRequest<Self> //NSFetchRequest<Self>(entityName: Self.entityName)
//    configuration(request)
//    do {
//      let result = try moc.count(for: request)
//      guard result != NSNotFound else { fatalError("Failed to execute count fetch request.") }
//      return result
//    } catch let error {
//      fatalError("Failed to execute fetch request: \(error).")
//    }
//  }
//
//  /// **Mechanica**
//  ///
//  /// Iterates over the context’s registeredObjects set (which contains all managed objects the context currently knows about) until it finds one that is not a fault matching a given predicate.
//  /// Faulted objects are not considered to to prevent Core Data to make a round trip to the persistent store.
//  public static func findMaterializedObject(inManagedObjectContext moc: NSManagedObjectContext, matchingPredicate predicate: NSPredicate) -> Self? {
//    for object in moc.registeredObjects where !object.isFault {
//      guard let result = object as? Self, predicate.evaluate(with: result) else { continue }
//      return result
//    }
//    return nil
//  }
//
//}

// MARK: - Cache

//extension ManagedObjectConfigurable where Self: NSManagedObject {
//
//  /// **Mechanica**
//  ///
//  /// Tries to retrieve an object from the cache; if there’s nothing in the cache executes the fetch request and caches the result (if a single object is found).
//  /// - Parameters:
//  ///   - moc: Searched context.
//  ///   - cacheKey: Cache key.
//  ///   - configure: Configurable fetch request.
//  /// - Returns: A cached object (if any).
//  public static func fetchCachedObject(inManagedObjectContext moc: NSManagedObjectContext, forKey cacheKey: String, configure: @escaping (NSFetchRequest<Self>) -> ()) -> Self? {
//    guard let cached = moc.cachedObject(for: cacheKey) as? Self else {
//      let result = fetchSingleObject(inManagedObjectContext: moc, configure: configure)
//      moc.setCachedObject(result, for: cacheKey)
//      return result
//    }
//    return cached
//  }
//
//  /// Executes a fetch request where only a single object is expected as result.
//  private static func fetchSingleObject(inManagedObjectContext moc: NSManagedObjectContext, configure: @escaping (NSFetchRequest<Self>) -> ()) -> Self? {
//    let result = fetch(inManagedObjectContext: moc) { request in
//      configure(request)
//      request.fetchLimit = 2
//    }
//    switch result.count {
//    case 0: return nil
//    case 1: return result[0]
//    default: fatalError("Returned multiple objects, expected max 1.")
//    }
//  }
//
//}


