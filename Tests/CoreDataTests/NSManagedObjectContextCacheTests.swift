//
//  NSManagedObjectContextCacheTests.swift
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

class NSManagedObjectContextCacheTests: XCTestCase {
  
  func testManagedContextCachingSystem() {
    let stack = CoreDataStack()
    if let stack = stack {
      
      let mainContext = stack.mainContext
      
      // Given
      let person1 = Person(context: stack.mainContext)
      person1.firstName = "Tin"
      person1.lastName = "Robots"
      let car1 = Car(context: stack.mainContext)
      car1.maker = "Alessandro"
      car1.model = "Model 1"
      car1.owner = person1
      // When
      mainContext.setCachedManagedObject(person1, forKey: "TestKey")
      mainContext.setCachedManagedObject(car1, forKey: "TestKey2")
      // Then
      let cachedPerson1 = mainContext.cachedManagedObject(forKey: "TestKey")
      let cachedCar1 = mainContext.cachedManagedObject(forKey: "TestKey2")
      XCTAssertNotNil(cachedPerson1)
      XCTAssertNotNil(cachedCar1)
      XCTAssertEqual(person1, cachedPerson1)
      
      // Given
      let person2 = Person(context: stack.mainContext)
      person2.firstName = "Tin2"
      person2.lastName = "Robots2"
      // When
      mainContext.setCachedManagedObject(person2, forKey: "TestKey")
      // Then
      let cachedPerson2 = mainContext.cachedManagedObject(forKey: "TestKey")
      XCTAssertNotNil(cachedPerson2)
      XCTAssertNotEqual(person1, cachedPerson2)
      XCTAssertEqual(person2, cachedPerson2)
      
      // Given
      let backgroundContext = mainContext.newBackgroundContext()
      let person3 = Person(context: backgroundContext)
      person3.firstName = "Tin3"
      person3.lastName = "Robots3"
      // When
      backgroundContext.setCachedManagedObject(person3, forKey: "TestKey")
      // Then
      /// different contexts have different caches
      XCTAssertNotNil(backgroundContext.cachedManagedObject(forKey: "TestKey")) // person3
      XCTAssertNotNil(mainContext.cachedManagedObject(forKey: "TestKey")) // person2
      
      // Given
      let person4 = Person(context: stack.mainContext)
      person4.firstName = "Tin4"
      person4.lastName = "Robots4"
      // When
      backgroundContext.setCachedManagedObject(person4, forKey: "TestKey")
      backgroundContext.setCachedManagedObject(person4, forKey: "TestKey3")
      // Then
      /// caching an object in a different context should be impossible
      XCTAssertNil(backgroundContext.cachedManagedObject(forKey: "TestKey3"))
      XCTAssertEqual(person3, backgroundContext.cachedManagedObject(forKey: "TestKey")) // the previous cached object is not overwritten
      
      // Given
      let description = NSEntityDescription.entity(forEntityName: EntityKey.person, in: mainContext)
      XCTAssertNotNil(description)
      let person5 = Person(entity: description!, insertInto: nil)
      XCTAssertNil(person5.managedObjectContext)
      person5.firstName = "Tin5"
      person5.lastName = "Robots5"
      // When
      backgroundContext.setCachedManagedObject(person5, forKey: "TestKey")
      backgroundContext.setCachedManagedObject(person5, forKey: "TestKey3")
      // Then
      XCTAssertNil(backgroundContext.cachedManagedObject(forKey: "TestKey3"))
      XCTAssertEqual(person3, backgroundContext.cachedManagedObject(forKey: "TestKey")) // the previous cached object is not overwritten
      
      // Given, When
      mainContext.clearCachedManagedObjects()
      // Then
      XCTAssertNil(mainContext.cachedManagedObject(forKey: "TestKey"))
      XCTAssertNil(mainContext.cachedManagedObject(forKey: "TestKey2"))
      
      // Given, When
      backgroundContext.clearCachedManagedObjects()
      // Then
      XCTAssertNil(backgroundContext.cachedManagedObject(forKey: "TestKey"))
      
    } else {
      XCTAssertNotNil(stack)
    }
    
  }
}
