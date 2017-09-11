//
// Mechanica
//
// Copyright © 2016-2017 Tinrobots.
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
@testable import Mechanica

class UserDefaultsUtilsTests: XCTestCase {

  let userDefaults = UserDefaults.standard

  override func setUp() {
    super.setUp()
    
    userDefaults.removeAll()
  }

  func testOptionalInt() {
    let key = "intKey"
    XCTAssertTrue(!userDefaults.hasKey(key))
    
    userDefaults.set(10, forKey: key)
    XCTAssertTrue(userDefaults.hasKey(key))
    XCTAssertNotNil(userDefaults.optionalInteger(forKey: key))
    XCTAssertEqual(userDefaults.optionalInteger(forKey: key), 10)
    
    userDefaults.set(nil, forKey: key)
    XCTAssertEqual(userDefaults.optionalInteger(forKey: key), .none)
  }

  func testOptionalDouble() {
    let key = "doubleKey"
    XCTAssertTrue(!userDefaults.hasKey(key))
    
    userDefaults.set(Double(10), forKey: key)
    XCTAssertTrue(userDefaults.hasKey(key))
    XCTAssertNotNil(userDefaults.optionalDouble(forKey: key))
    XCTAssertEqual(userDefaults.optionalDouble(forKey: key), Double(10))
    
    userDefaults.set(nil, forKey: key)
    XCTAssertEqual(userDefaults.optionalInteger(forKey: key), .none)
  }

  func testOptionalFloat() {
    let key = "floatKey"
    XCTAssertTrue(!userDefaults.hasKey(key))
    
    userDefaults.set(10.1, forKey: key)
    XCTAssertTrue(userDefaults.hasKey(key))
    XCTAssertNotNil(userDefaults.optionalFloat(forKey: key))
    XCTAssertEqual(userDefaults.optionalFloat(forKey: key), 10.1)
    
    userDefaults.set(nil, forKey: key)
    XCTAssertEqual(userDefaults.optionalInteger(forKey: key), .none)
  }
  
  func testOptionalBool() {
    let key = "boolKey"
    XCTAssertTrue(!userDefaults.hasKey(key))
    
    userDefaults.set(true, forKey: key)
    XCTAssertTrue(userDefaults.hasKey(key))
    XCTAssertNotNil(userDefaults.optionalBool(forKey: key))
    XCTAssertEqual(userDefaults.optionalBool(forKey: key), true)
    
    userDefaults.set(nil, forKey: key)
    XCTAssertEqual(userDefaults.optionalBool(forKey: key), nil)
    XCTAssertEqual(userDefaults.optionalFloat(forKey: key), .none)
  }

  func testRemoveAll() {
    let key = "intKey"
    XCTAssertTrue(!userDefaults.hasKey(key))
    
    userDefaults.set(10, forKey: key)
    XCTAssertNotNil(userDefaults.value(forKey: key))
    
    let key2 = "doubleKey"
    XCTAssertTrue(!userDefaults.hasKey(key2))
    
    userDefaults.set(Double(10), forKey: key2)
    XCTAssertNotNil(userDefaults.value(forKey: key2))
    
    let key3 = "doubleKey"
    XCTAssertTrue(userDefaults.hasKey(key3))
    
    userDefaults.set(10.0, forKey: key3)
    XCTAssertNotNil(userDefaults.value(forKey: key3))
    
    userDefaults.removeAll()
    
    XCTAssertNil(userDefaults.value(forKey: key))
    XCTAssertNil(userDefaults.value(forKey: key2))
    XCTAssertNil(userDefaults.value(forKey: key3))
  }
  
  @available(iOS 11, tvOS 11, watchOS 4, OSX 10.13, *)
  func testCodable() {
    do {
      // Given
      let value = UserDefaultsUtilsTests.Person(firstname: "name1", surname: "surname1")
      let value2 = UserDefaultsUtilsTests.Person(firstname: "name2", surname: "surname2")
      let key = "personKey"
      //  When
      XCTAssertNoThrow(try userDefaults.set(codableValue: value, forKey: key))
      //  Then
      let codedValue: UserDefaultsUtilsTests.Person? = userDefaults.codableValue(forKey: key)
      if let codedValue = codedValue {
        XCTAssertTrue(codedValue == value)
      } else {
        XCTAssertNotNil(codedValue)
      }
      
      //  When
      XCTAssertNoThrow(try userDefaults.set(codableValue: value2, forKey: key))
      //  Then
      XCTAssertTrue(userDefaults.hasKey(key))
      let codedValue2: UserDefaultsUtilsTests.Person? = userDefaults.codableValue(forKey: key)
      if let codedValue2 = codedValue2 {
        XCTAssertTrue(codedValue2 == value2)
      } else {
        XCTAssertNotNil(codedValue2)
      }
      
      // When
      let nilValue: UserDefaultsUtilsTests.Person? = nil
      XCTAssertNoThrow(try userDefaults.set(codableValue: nilValue, forKey: key))
      // Then
      XCTAssertFalse(userDefaults.hasKey(key))
      // When
      XCTAssertNoThrow(try userDefaults.set(codableValue: value, forKey: key))
      XCTAssertNoThrow(try userDefaults.set(codableValue: nilValue, forKey: key))
      // Then
      XCTAssertFalse(userDefaults.hasKey(key))
    }

    do {
      // Given
      let value = UserDefaultsUtilsTests.SecurePerson(firstname: "name1", surname: "surname1")
      let value2 = UserDefaultsUtilsTests.SecurePerson(firstname: "name2", surname: "surname2")
      let key = "personKey"
      //  When
      XCTAssertNoThrow(try userDefaults.set(codableValue: value, forKey: key))
      //  Then
      let codedValue: UserDefaultsUtilsTests.SecurePerson? = userDefaults.codableValue(forKey: key)
      if let codedValue = codedValue {
        XCTAssertTrue(codedValue == value)
      } else {
        XCTAssertNotNil(codedValue)
      }

      //  When
      XCTAssertNoThrow(try userDefaults.set(codableValue: value2, forKey: key))
      //  Then
      XCTAssertTrue(userDefaults.hasKey(key))
      let codedValue2: UserDefaultsUtilsTests.SecurePerson? = userDefaults.codableValue(forKey: key)
      if let codedValue2 = codedValue2 {
        XCTAssertTrue(codedValue2 == value2)
      } else {
        XCTAssertNotNil(codedValue2)
      }

      // When
      let nilValue: UserDefaultsUtilsTests.SecurePerson? = nil
      XCTAssertNoThrow(try userDefaults.set(codableValue: nilValue, forKey: key))
      // Then
      XCTAssertFalse(userDefaults.hasKey(key))
      // When
      XCTAssertNoThrow(try userDefaults.set(codableValue: value, forKey: key))
      XCTAssertNoThrow(try userDefaults.set(codableValue: nilValue, forKey: key))
      // Then
      XCTAssertFalse(userDefaults.hasKey(key))
    }
  }

}

// MARK: - UserDefaultsUtilsTests Namespace

extension UserDefaultsUtilsTests {
  
  @objc(Person)
  class Person: NSObject, NSCoding, Codable {
    
    @objc
    let surname: String
    
    @objc
    let firstname: String
    
    required init(firstname:String, surname:String) {
      self.firstname = firstname
      self.surname = surname
    }
    
    required init?(coder aDecoder: NSCoder) {
      firstname = aDecoder.decodeObject(forKey: #keyPath(Person.firstname)) as! String
      surname = aDecoder.decodeObject(forKey: #keyPath(Person.surname)) as! String
    }
    
    func encode(with aCoder: NSCoder) {
      aCoder.encode(firstname, forKey: #keyPath(Person.firstname))
      aCoder.encode(surname, forKey: #keyPath(Person.surname))
    }
    
    static func == (left: Person, right: Person) -> Bool {
      return left.firstname == right.firstname && left.surname == right.surname
    }
    
  }
  
  @objc(SecurePerson)
  class SecurePerson: NSObject, NSSecureCoding, Codable {
    
    static var supportsSecureCoding = true
    
    @objc
    let surname: String
    
    @objc
    let firstname: String
    
    required init(firstname:String, surname:String) {
      self.firstname = firstname
      self.surname = surname
    }
    
    required init?(coder aDecoder: NSCoder) {
      guard
        let firstnameDecoded = aDecoder.decodeObject(of: NSString.self, forKey: (#keyPath(SecurePerson.firstname))),
        let surnameDecoded = aDecoder.decodeObject(of: NSString.self, forKey: (#keyPath(SecurePerson.surname)))
        else {
          return nil
      }
      
      self.firstname = firstnameDecoded as String
      self.surname = surnameDecoded as String
    }
    
    func encode(with aCoder: NSCoder) {
      aCoder.encode(firstname, forKey: #keyPath(SecurePerson.firstname))
      aCoder.encode(surname, forKey: #keyPath(SecurePerson.surname))
    }
    
    static func == (left: SecurePerson, right: SecurePerson) -> Bool {
      return left.firstname == right.firstname && left.surname == right.surname
    }
    
  }
  
}
