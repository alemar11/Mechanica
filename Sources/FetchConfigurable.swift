//
//  FetchConfigurable.swift
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

/// Objects adopting the `FetchConfigurable` support a variety of fetching helper functionalities.
public protocol FetchConfigurable: class {

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

}

// MARK: - Predicates and SortDescriptors

extension FetchConfigurable {
  public static var defaultSortDescriptors: [NSSortDescriptor] { return [] }
  public static var defaultPredicate: NSPredicate { return NSPredicate(value: true) }
}


// MARK: - NSManagedObject

extension FetchConfigurable where Self: NSManagedObject {

  /// **Mechanica**
  ///
  /// Fetch Request with the `defaultPredicate` and the default `defaultSortDescriptors`.
  public static var sortedFetchRequest: NSFetchRequest<Self> {
    let request = Self.fetchRequest() as! NSFetchRequest<Self>
    request.sortDescriptors = defaultSortDescriptors
    request.predicate       = defaultPredicate
    return request
  }

  /// **Mechanica**
  ///
  /// Creates a `new` sorted fetch request using `sortedFetchRequest` *AND* `predicate`.
  public static func sortedFetchRequest(with predicate: NSPredicate) -> NSFetchRequest<Self> {
    let request = sortedFetchRequest
    guard let existingPredicate = request.predicate else { fatalError("Must have a predicate.") }
    request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [existingPredicate, predicate])
    return request
  }

  /// **Mechanica**
  ///
  /// Creates a `new` predicate using the `defaultPredicate` *AND* a `predicate` by substituting the values in an argument list into a format string.
  public static func predicate(format: String, _ args: CVarArg...) -> NSPredicate {
    let p = withVaList(args) { NSPredicate(format: format, arguments: $0) }
    return predicate(p)
  }

  /// **Mechanica**
  ///
  /// Creates a `new` predicate using the `defaultPredicate` *AND* a given `predicate`.
  public static func predicate(_ predicate: NSPredicate) -> NSPredicate {
    return NSCompoundPredicate(andPredicateWithSubpredicates: [defaultPredicate, predicate])
  }

}
