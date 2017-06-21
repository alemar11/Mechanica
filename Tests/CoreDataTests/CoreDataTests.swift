//
//  CoreDataTests.swift
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

import XCTest
import CoreData
@testable import Mechanica

enum EntityKey {
  static let car = "Car"
  static let person = "Person"
}

class CoreDataTests: XCTestCase {

  func setupInMemoryManagedObjectContext() throws -> NSManagedObjectContext {
    let managedObjectModel = DemoModelVersion.currentVersion.managedObjectModel()
    let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
    try persistentStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
    let managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
    managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
    return managedObjectContext
  }

  func testManagedObjectContextSetup() {

    // Given, When
    let context = XCTAssertNoThrows(try setupInMemoryManagedObjectContext())

    // Then
    guard let c = context else {
      XCTAssertNotNil(context)
      return
    }
       XCTAssertTrue(context!.persistentStores.count == 1)

    let persistentStore = context!.persistentStores.first
    let metaData = context!.metaData(for: persistentStore!)
    print((metaData["NSStoreModelVersionHashes"] as? [String: Any])?["Car"])
    print(metaData["NSStoreType"]) //InMemory

    //test set metaData, todo

    XCTAssertNotNil(context!.entity(forEntityName: "Car"))
    XCTAssertNotNil(context!.entity(forEntityName: "Person"))
    print(description)
  }

}
