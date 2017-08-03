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
    do {
      // Given
      let stack = CoreDataStack(type: .sqlite)
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
        stack.mainContext.setMetaDataObject("Test", with: "testKey", for: firstPersistentStore){ error in
          XCTAssertNil(error)
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
    
    do {
      // Given
      let stack = CoreDataStack(type: .inMemory)
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
        stack.mainContext.setMetaDataObject("Test", with: "testKey", for: firstPersistentStore){ error in
          XCTAssertNil(error)
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
    }  else {
      XCTAssertNotNil(stack)
    }
  }
  
  func testSaveAndWait() {
    // Given, When
    let stack = CoreDataStack(type: .sqlite)
    if let stack = stack {
      let context = stack.mainContext
      
      // Then

      XCTAssertNoThrow(
        try context.performSaveAndWait {
          let person = Person(context: context)
          person.firstName = "T"
          person.lastName = "R"
        }
      )

      XCTAssertNoThrow(
        try context.performSaveAndWait {})

      XCTAssertNoThrow(
        try context.performSaveAndWait {
          let person = Person(context: context)
          person.firstName = "Tin"
          person.lastName = "Robots"
        }
      )

      XCTAssertThrowsError(
        try context.performSaveAndWait {
          let person = Person(context: context)
          person.firstName = "Tin"
          person.lastName = "Robots"
        }
      ) { (error) in
        print(error)
      }

      XCTAssertNoThrow(
        try context.performSaveAndWait {
          let person = Person(context: context)
          person.firstName = "Tin_"
          person.lastName = "Robots"
        }
      )

      XCTAssertNoThrow(
        try context.performSaveAndWait {
          let person = Person(context: context)
          person.firstName = "Tin"
          person.lastName = "Robots_"
        }
      )

    } else {
      XCTAssertNotNil(stack)
    }
  }
  
  func testSave() {
    // Given, When
    let stack = CoreDataStack(type: .sqlite)
    if let stack = stack {
      let context = stack.mainContext.newBackgroundContext()

      // Then

      let saveExpectation1 = expectation(description: "Save 1")
      context.performSave(after: {
        let person = Person(context: context)
        person.firstName = "T"
        person.lastName = "R"
      }){ error in
        XCTAssertNil(error)
        saveExpectation1.fulfill()
      }

      wait(for: [saveExpectation1], timeout: 10)

      let saveExpectation2 = expectation(description: "Save 2")
      context.performSave(after: {
        let person = Person(context: context)
        person.firstName = "Tin"
        person.lastName = "Robots"
      }){ error in
        XCTAssertNil(error)
        saveExpectation2.fulfill()
      }

      wait(for: [saveExpectation2], timeout: 10)

      let saveExpectation3 = expectation(description: "Save 3")
      context.performSave(after: {
        let person = Person(context: context)
        person.firstName = "Tin"
        person.lastName = "Robots"
      }){ error in
        XCTAssertNotNil(error)
        saveExpectation3.fulfill()
      }

      wait(for: [saveExpectation3], timeout: 10)

      let saveExpectation4 = expectation(description: "Save 4")
      context.performSave(after: {
        let person = Person(context: context)
        person.firstName = "Tin_"
        person.lastName = "Robots"
      }){ error in
        XCTAssertNil(error)
        saveExpectation4.fulfill()
      }

      wait(for: [saveExpectation4], timeout: 10)

      let saveExpectation5 = expectation(description: "Save 5")
      context.performSave(after: {
        let person = Person(context: context)
        person.firstName = "Tin"
        person.lastName = "Robots_"
      }){ error in
        XCTAssertNil(error)
        saveExpectation5.fulfill()
      }

      wait(for: [saveExpectation5], timeout: 10)


    } else {
      XCTAssertNotNil(stack)
    }
  }
  
}

