//
//  NSManagedObjectContext+Utils.swift
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

extension NSManagedObjectContext {
  
  /// **Mechanica**
  ///
  /// Result of void representing `success` or an instance of `Error`.
  public enum SaveResult {
    /// A success case
    case success
    /// A failure case with an associated `Error` instance.
    case failure(Swift.Error)
  }
  
  /// **Mechanica**
  ///
  /// The persistent stores associated with the receiver.
  private var stores: [NSPersistentStore] {
    guard let psc = persistentStoreCoordinator else { fatalError("Persistent Store Coordinator missing.") }
    let stores = psc.persistentStores
    return stores
  }
  
  /// **Mechanica**
  ///
  /// Returns a dictionary that contains the metadata currently stored or to-be-stored in a given persistent store.
  public func metaData(for store: NSPersistentStore) -> [String: Any] {
    guard let psc = persistentStoreCoordinator else { fatalError("Must have Persistent Store Coordinator.") }
    return psc.metadata(for: store)
  }
  
  /// **Mechanica**
  ///
  /// Adds an `object` to the store's metadata and saves it asynchronously.
  ///
  /// - Parameters:
  ///   - object: Object to be added to the medata dictionary.
  ///   - key: Object key
  ///   - store: NSPersistentStore where is stored the metadata.
  public func setMetaDataObject(_ object: AnyObject?, with key: String, for store: NSPersistentStore) {
    performSave {
      guard let psc = self.persistentStoreCoordinator else { fatalError("Persistent Store Coordinator missing.") }
      var md = psc.metadata(for: store)
      md[key] = object
      psc.setMetadata(md, for: store)
    }
  }
  
  /// **Mechanica**
  ///
  /// Returns the entity with the specified name from the managed object model associated with the specified managed object context’s persistent store coordinator.
  public func entity(forEntityName name: String) -> NSEntityDescription {
    guard let psc = persistentStoreCoordinator else { fatalError("Persistent Store Coordinator missing.") }
    guard let entity = psc.managedObjectModel.entitiesByName[name] else { fatalError("Entity \(name) not found.") }
    //guard let entity = NSEntityDescription.entity(forEntityName: name, in: self) else { fatalError("Entity \(name) not found") }
    return entity
  }
  
  /// **Mechanica**
  ///
  /// - Returns: a `new` background `NSManagedObjectContext`.
  /// - Parameters:
  ///   - asChildContext: Specifies if this new context is a child context of the current context (default *false*).
  public func newBackgroundContext(asChildContext isChildContext: Bool = false) -> NSManagedObjectContext {
    let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
    if (isChildContext) {
      context.parent = self
    } else {
      context.persistentStoreCoordinator = persistentStoreCoordinator
    }
    return context
  }
  
//  /// **Mechanica**
//  ///
//  /// Asynchronously attempts to commit unsaved changes or rollbacks if any error occurs.
//  /// - Parameters:
//  ///   - isRollBackEnabled: Enables rollback if any error occurs (default true).
//  public func performSave(orRollBack isRollBackEnabled: Bool = true) {
//    perform {
//      [unowned self] in
//      _ = self.saveChanges(andEnableRollBack: isRollBackEnabled)
//    }
//  }
  
  /// **Mechanica**
  ///
  /// Asynchronously performs changes and then saves them or rollbacks if any error occurs.
  /// - Parameters:
  ///   - isRollBackEnabled: Enables rollback if any error occurs (default true).
  ///   - changes: Changes to be applied in the current context.
  public func performSave(orRollBack isRollBackEnabled: Bool = true, afterApplyingChanges changes: ( () -> () )? = nil) {
    perform {
      [unowned self] in
      changes?()
      _ = self.saveChanges(andEnableRollBack: isRollBackEnabled)
    }
  }
  
//  /// **Mechanica**
//  ///
//  /// Synchronously attempts to commit unsaved changes or rollbacks if any error occurs.
//  /// - Parameters:
//  ///   - isRollBackEnabled: Enables rollback if any error occurs (default true).
//  public func performSaveAndWait(orRollBack isRollBackEnabled: Bool = true) -> SaveResult {
//    var result = SaveResult.success
//    performAndWait {
//      [unowned self] in
//      result = self.saveChanges(andEnableRollBack: isRollBackEnabled)
//    }
//    return result
//  }
  
  /// **Mechanica**
  ///
  /// Synchronously performs changes and then saves them or rollbacks if any error occurs.
  /// - Returns: a success case if the save succeeds, otherwise a failure case with an associated `Error` instance.
  @discardableResult
  public func performSaveAndWait(orRollBack isRollBackEnabled: Bool = true, afterApplyingChanges changes: ( () -> () )? = nil ) -> SaveResult {
    var result = SaveResult.success
    performAndWait {
      [unowned self] in
      changes?()
      result = self.saveChanges(andEnableRollBack: isRollBackEnabled)
    }
    return result
  }
  
  //    /// **Mechanica**
  //    ///
  //    /// Attempts to commit unsaved changes to registered objects to the receiver’s parent store or rollbacks if any error occurs.
  //    ///
  //    /// The rollback operation removes everything from the undo stack, discards all insertions and deletions, and restores updated objects to their last committed values.
  //    /// - Returns: a success case if the save succeeds, otherwise a failure case with an associated `Error` instance.
  //    @discardableResult
  //    public func saveChangesOrRollback() -> SaveResult {
  //        do {
  //            try saveIfNeeded()
  //            return SaveResult.success
  //        } catch {
  //            rollback()
  //            //print("Failure to save context: \(error).\n A rollback has been performed.")
  //            return SaveResult.failure(error)
  //        }
  //    }
  //
  //    /// **Mechanica**
  //    ///
  //    /// Attempts to commit unsaved changes to registered objects to the receiver’s parent store.
  //    /// - Returns: a success case if the save succeeds, otherwise a failure case with an associated `Error` instance.
  //    @discardableResult
  //    public func saveChanges() -> SaveResult {
  //        do {
  //            try saveIfNeeded()
  //            return SaveResult.success
  //        } catch {
  //            return SaveResult.failure(error)
  //        }
  //    }
  
  /// **Mechanica**
  ///
  /// Attempts to commit unsaved changes to registered objects to the receiver’s parent store or rollbacks if any error occurs.
  ///
  /// The rollback operation removes everything from the undo stack, discards all insertions and deletions, and restores updated objects to their last committed values.
  /// - Parameters:
  ///   - isRollBackEnabled: Enables rollback if any error occurs (default true).
  /// - Returns: a success case if the save succeeds, otherwise a failure case with an associated `Error` instance.
  @discardableResult
  private func saveChanges(andEnableRollBack isRollBackEnabled: Bool = true) -> SaveResult {
    do {
      try saveIfNeeded()
      return SaveResult.success
    } catch {
      if (isRollBackEnabled) { rollback() }
      //print("Failure to save context: \(error).\n A rollback has been performed.")
      return SaveResult.failure(error)
    }
    
  }
  
  /// Saves the `NSManagedObjectContext` if changes are present.
  private func saveIfNeeded() throws {
    guard hasChanges else { return }
    try save()
  }
  
}


