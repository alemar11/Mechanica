//
//  NSManagedObject+Deletable.swift
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

// MARK: - Local Deletion

fileprivate let markedForDeletionKey = "markedForDeletionAsOf"
/// Objects marked for local deletion more than this time (in seconds) ago will get permanently deleted.
fileprivate let timeBeforePermanentlyDeletingObjects = TimeInterval(120)

/// **Mechanica**
///
/// Objects adopting the `DelayedDeletable` support *two-step* deletion.
public protocol DelayedDeletable: class {
  /// **Mechanica**
  ///
  /// Protocol `DelayedDeletable`.
  ///
  /// Checks whether or not the managed object’s ``markedForDeletion` property has unsaved changes.
  var hasChangedForDelayedDeletion: Bool { get }
  
  /// **Mechanica**
  ///
  /// Protocol `DelayedDeletable`.
  ///
  /// This object can be deleted starting from this particular date.
  var markedForDeletionAsOf: Date? { get set }
  
  /// **Mechanica**
  ///
  /// Protocol `DelayedDeletable`.
  ///
  /// Marks an object to be deleted at a later point in time.
  func markForLocalDeletion()
  
}

// MARK: - DelayedDeletable Extension

extension DelayedDeletable {
  
  /// **Mechanica**
  ///
  /// Protocol `DelayedDeletable`.
  ///
  /// Predicate to filter for objects that haven’t a deletion date.
  public static var notMarkedForLocalDeletionPredicate: NSPredicate {
    return NSPredicate(format: "%K == NULL", markedForDeletionKey)
  }
  
}

extension DelayedDeletable where Self: NSManagedObject {
  
  public final var hasChangedForDelayedDeletion: Bool {
    return changedValue(forKey: markedForDeletionKey) as? Date != nil
  }
  
  public final func markForLocalDeletion() {
    guard isFault || markedForDeletionAsOf == nil else { return }
    markedForDeletionAsOf = Date()
  }
  
  //}
  //
  //extension NSFetchRequestResult where Self: NSManagedObject {
  
  //TODO: work in progress
  fileprivate static func batchDeleteObjectsMarkedForDeletion(inManagedObjectContext moc: NSManagedObjectContext) {
    guard let _ = moc.persistentStoreCoordinator else { fatalError("Persistent Store Coordinator missing. A NSBatchDeleteRequest instance operates directly on one or more persistent stores.") }
    let request = fetchRequest()
    let cutOff = Date(timeIntervalSinceNow: -timeBeforePermanentlyDeletingObjects)
    request.predicate = NSPredicate(format: "%K < %@", markedForDeletionKey, [cutOff])
    let batchRequest = NSBatchDeleteRequest(fetchRequest: request)
    batchRequest.resultType = .resultTypeStatusOnly
    try! moc.execute(batchRequest)
  }
  
}

// MARK: - Remote Deletion

fileprivate let markedForRemoteDeletionKey = "isMarkedForRemoteDeletion"

/// **Mechanica**
///
/// Objects adopting the `RemoteDeletable` support remote deletion.
public protocol RemoteDeletable: class {
  
  /// **Mechanica**
  ///
  /// Protocol `RemoteDeletable`.
  ///
  /// Checks whether or not the managed object’s `markedForRemoteDeletion` property has unsaved changes.
  var hasChangedForRemoteDeletion: Bool { get }
  
  /// **Mechanica**
  ///
  /// Protocol `RemoteDeletable`.
  ///
  /// Returns `true` if the object is marked to be deleted remotely.
  var isMarkedForRemoteDeletion: Bool { get set }
  
  /// **Mechanica**
  ///
  /// Protocol `RemoteDeletable`.
  ///
  /// Marks an object to be deleted remotely, on the backend (i.e. Cloud Kit).
  func markForRemoteDeletion()
  
}

// MARK: - RemoteDeletable Extension

extension RemoteDeletable {
  
  /// **Mechanica**
  ///
  /// Protocol `RemoteDeletable`.
  ///
  /// Predicate to filter for objects that aren’t marked for remote deletion.
  public static var notMarkedForRemoteDeletionPredicate: NSPredicate {
    return NSPredicate(format: "%K == false", markedForRemoteDeletionKey)
  }
  
  /// **Mechanica**
  ///
  /// Protocol `RemoteDeletable`.
  ///
  /// Predicate to filter for objects that are marked for remote deletion.
  public static var markedForRemoteDeletionPredicate: NSPredicate {
    return NSCompoundPredicate(notPredicateWithSubpredicate: notMarkedForRemoteDeletionPredicate)
  }
  
  /// **Mechanica**
  ///
  /// Protocol `RemoteDeletable`.
  ///
  /// Marks an object to be deleted remotely.
  public final func markForRemoteDeletion() {
    isMarkedForRemoteDeletion = true
  }
  
}


extension RemoteDeletable where Self: NSManagedObject {
  
  public final var hasChangedForRemoteDeletion: Bool {
    return changedValue(forKey: markedForRemoteDeletionKey) as? Bool == true
  }
  
}


extension RemoteDeletable where Self: DelayedDeletable {
  
  public static var notMarkedForDeletionPredicate: NSPredicate {
    return NSCompoundPredicate(andPredicateWithSubpredicates: [notMarkedForLocalDeletionPredicate, notMarkedForRemoteDeletionPredicate])
  }
  
}

