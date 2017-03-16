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
  /// The persistent stores associated with the receiver.
  private final var stores: [NSPersistentStore] {
    guard let psc = persistentStoreCoordinator else { fatalError("Persistent Store Coordinator missing.") }
    let stores = psc.persistentStores
    return stores
  }
  
  /// **Mechanica**
  ///
  /// Returns a dictionary that contains the metadata currently stored or to-be-stored in a given persistent store.
  public final func metaData(for store: NSPersistentStore) -> [String: Any] {
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
  public final func setMetaDataObject(_ object: AnyObject?, with key: String, for store: NSPersistentStore) {
    performSave(after: {
      guard let psc = self.persistentStoreCoordinator else { fatalError("Persistent Store Coordinator missing.") }
      var md = psc.metadata(for: store)
      md[key] = object
      psc.setMetadata(md, for: store)
      
    })
  }
  
  /// **Mechanica**
  ///
  /// Returns the entity with the specified name from the managed object model associated with the specified managed object context’s persistent store coordinator.
  public final func entity(forEntityName name: String) -> NSEntityDescription {
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
  public final func newBackgroundContext(asChildContext isChildContext: Bool = false) -> NSManagedObjectContext {
    let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
    if (isChildContext) {
      context.parent = self
    } else {
      context.persistentStoreCoordinator = persistentStoreCoordinator
    }
    return context
  }
  
}

// MARK: - Save

extension NSManagedObjectContext {
  
  /// **Mechanica**
  ///
  /// Asynchronously performs changes and then saves them or **rollbacks** if any error occurs.
  /// - Parameters:
  ///   - changes: Changes to be applied in the current context before the saving operation.
  public final func performSave(after changes: @escaping () -> ()) {
    perform {
      [unowned unownoedSelf = self] in
      changes()
      try? unownoedSelf.saveOrRollBack()
    }
  }
  
  /// **Mechanica**
  ///
  /// Synchronously performs changes and then saves them or **rollbacks** if any error occurs.
  /// - Throws: throws an error in cases of a saving operation failure.
  public final func performSaveAndWait(after changes: @escaping () -> ()) throws {
    var saveError: Error? = nil
    performAndWait {
      [unowned unownoedSelf = self] in
      changes()
      do {
        try unownoedSelf.saveOrRollBack()
      } catch {
        saveError = error
      }
    }
    if let error = saveError { throw error }
  }
  
  
  /// Saves the `NSManagedObjectContext` if changes are present or **rollbacks** if any error occurs.
  private final func saveOrRollBack() throws {
    guard hasChanges else { return }
    do {
      try save()
    } catch {
      rollback()
      assert(false, error.localizedDescription)
      throw error
    }
  }
  
}


