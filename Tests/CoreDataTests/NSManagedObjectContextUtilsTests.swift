//
//  NSManagedObjectContextUtilsTests.swift
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

class NSManagedObjectContextUtilsTests: XCTestCase {

  func testSinglePersistentStore() {
    // Given, When
    let stack = CoreDataStack()
    if let stack = stack {
      // Then
      XCTAssertTrue(stack.mainContext.persistentStores.count == 1)
      XCTAssertNotNil(stack.mainContext.persistentStores.first)
    } else {
      XCTAssertNotNil(stack)
    }
  }

  func testMetaData() {
    // Given
    let stack = CoreDataStack()
    if let stack = stack {

      // When
      guard let firstPersistentStore = stack.mainContext.persistentStores.first else {
        XCTAssertNotNil(stack.mainContext.persistentStores.first)
        return
      }
      // Then
      let metaData = stack.mainContext.metaData(for: firstPersistentStore)
      XCTAssertNotNil((metaData["NSStoreModelVersionHashes"] as? [String: Any])?[EntityKey.car])
      XCTAssertNotNil((metaData["NSStoreModelVersionHashes"] as? [String: Any])?[EntityKey.person])
      XCTAssertNotNil(metaData["NSStoreType"] as? String)

      let addMetaDataExpectation = expectation(description: "Add MetaData Expectation") 
      stack.mainContext.setMetaDataObject("Test", with: "testKey", for: firstPersistentStore){
        addMetaDataExpectation.fulfill()
      }
      waitForExpectations(timeout: 5.0, handler: nil)
      let updatedMetaData = stack.mainContext.metaData(for: firstPersistentStore)
      XCTAssertNotNil(updatedMetaData["testKey"])
      XCTAssertEqual(updatedMetaData["testKey"] as? String, "Test")
    } else {
      XCTAssertNotNil(stack)
    }

  }

  func testEntityDescription() {
    // Given, When
    let stack = CoreDataStack()
    if let stack = stack {
      // Then
      XCTAssertNotNil(stack.mainContext.entity(forEntityName: EntityKey.car))
      XCTAssertNotNil(stack.mainContext.entity(forEntityName: EntityKey.person))
    } else {
      XCTAssertNotNil(stack)
    }
  }

  func testNewBackgroundContext() {
    // Given, When
    let stack = CoreDataStack()
    if let stack = stack {
      // Then
      let backgroundContext = stack.mainContext.newBackgroundContext(asChildContext: true)
      XCTAssertEqual(backgroundContext.concurrencyType,.privateQueueConcurrencyType)
      XCTAssertEqual(backgroundContext.parent,stack.mainContext)

      let backgroundContext2 = stack.mainContext.newBackgroundContext()
      XCTAssertEqual(backgroundContext2.concurrencyType,.privateQueueConcurrencyType)
      XCTAssertNotEqual(backgroundContext2.parent,stack.mainContext)
    }
  }

}
