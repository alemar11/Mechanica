//
//  NSManagedObjectUtilsTests.swift
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

class NSManagedObjectUtilsTests: XCTestCase {

  static var stack: CoreDataStack {
    get {
      let stack = CoreDataStack(type: .inMemory)
      XCTAssertNotNil(stack)
      return stack!
    }
  }

  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }

  func testRefresh() {
    // Given
    let mainContext = NSManagedObjectUtilsTests.stack.mainContext

    do {
      // When
      let person = Person(context: mainContext)
      mainContext.performAndWait {
        person.firstName = "Myname"
        person.lastName = "MyLastName"
        try! mainContext.save()
      }
      // Then
      person.firstName = "NewName"
      person.refresh()
      XCTAssertTrue(!person.isFault)
    }

    do {
      // When
      let person = Person(context: mainContext)
      //mainContext.insert(person)
      mainContext.performAndWait {
        person.firstName = "Myname2"
        person.lastName = "MyLastName2"
        try! mainContext.save()
      }
      // Then
      person.firstName = "NewName2"
      person.refresh(mergeChanges: false)
      XCTAssertTrue(person.isFault)
      XCTAssertTrue(person.firstName == "Myname2")
    }

  }


  func testChangedAndCommittedValue() {
    let carNumberPlate = #keyPath(Car.numberPlate)
    let carModel = #keyPath(Car.model)

    // Given
    let mainContext = NSManagedObjectUtilsTests.stack.mainContext
    // https://cocoacasts.com/how-to-observe-a-managed-object-context/
    // http://mentalfaculty.tumblr.com/post/65682908577/how-does-core-data-save
    do {
      // When
      let car = Car(context: mainContext)
      let person = Person(context: mainContext)
      XCTAssertNil(car.changedValue(forKey:  carNumberPlate))
      XCTAssertNil(car.changedValue(forKey:  carModel))
      car.model = "MyModel"
      car.numberPlate = "123456"
      person.firstName = "Alessandro"
      person.lastName = "Marzoli"
      car.owner = person
      // Then
      print(car.changedValues())
      print(car.committedValues(forKeys: nil))
      XCTAssertNotNil(car.changedValue(forKey: carNumberPlate) as? String)
      XCTAssertNotNil(car.changedValue(forKey: carModel) as? String)
      XCTAssertEqual(car.changedValue(forKey: carNumberPlate) as! String, "123456")
      XCTAssertNil(car.committedValue(forKey: carNumberPlate))
      XCTAssertNil(car.committedValue(forKey: carModel))

      // When
      try! mainContext.save()
      XCTAssertNotNil(car.committedValue(forKey: carNumberPlate))
      XCTAssertNotNil(car.committedValue(forKey: carModel))
      XCTAssertEqual(car.committedValue(forKey: carNumberPlate) as! String, "123456")
      XCTAssertEqual(car.committedValue(forKey: carModel) as! String, "MyModel")
      // Then
      XCTAssertNil(car.changedValue(forKey: carNumberPlate))
      XCTAssertNil(car.changedValue(forKey: carModel))

      // When
      car.numberPlate = "101"
      // Then
      XCTAssertEqual(car.changedValue(forKey: carNumberPlate) as! String, "101")
      XCTAssertNotNil(car.committedValue(forKey: carNumberPlate))

      // When
      car.numberPlate = "202"
      // Then
      XCTAssertNotNil(car.changedValue(forKey: carNumberPlate))
      XCTAssertNotNil(car.committedValue(forKey: carNumberPlate))
      XCTAssertEqual(car.changedValue(forKey: carNumberPlate) as! String, "202")
      XCTAssertEqual(car.committedValue(forKey: carNumberPlate) as! String, "123456")

      // When
      try! mainContext.save()
      // Then
      XCTAssertNil(car.changedValue(forKey: carNumberPlate))
      XCTAssertNotNil(car.committedValue(forKey: carNumberPlate))

      let request = NSFetchRequest<Car>(entityName: "Car")
      request.predicate = NSPredicate(format: "model=%@ AND numberPlate=%@", "MyModel", "202")
      request.fetchBatchSize = 1
      if let fetchedCar = try! mainContext.fetch(request).first {
        XCTAssertNotNil(car.committedValue(forKey: carNumberPlate))
        XCTAssertNil(car.changedValue(forKey: carNumberPlate))
        fetchedCar.numberPlate = "999"
        XCTAssertNil(car.changedValue(forKey: carModel))
        XCTAssertNotNil(car.changedValue(forKey: carNumberPlate))
        XCTAssertNotNil(car.committedValue(forKey: carNumberPlate))
        XCTAssertNotNil(car.committedValue(forKey: carModel))
        XCTAssertEqual(car.committedValue(forKey: carNumberPlate) as! String, "202")
      } else {
        XCTFail("No cars found for request: \(request.description)")
      }
    }
  }

}


