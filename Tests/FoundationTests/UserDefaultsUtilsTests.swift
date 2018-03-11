//
// Mechanica
//
// Copyright © 2016-2018 Tinrobots.
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

extension UserDefaultsUtilsTests {
  @available(iOS 11, tvOS 11, watchOS 4, macOS 10.13, *)
  static var allTests = [
    ("testOptionalInteger", testOptionalInteger),
    //("testOptionalDouble", testOptionalDouble),
    //("testOptionalFloat", testOptionalFloat),
    //("testOptionalBool", testOptionalBool),
    ////("testRemoveAll", testRemoveAll),
    //("testCodable", testCodable)
  ]
}

class UserDefaultsUtilsTests: XCTestCase {
  
  //TODO: add test for URL --> https://github.com/apple/swift-corelibs-foundation/blob/master/Foundation/UserDefaults.swift
  //on Linux will be set to nil
  
  //  let userDefaults = UserDefaults.standard
  //
  //  override func setUp() {
  //    super.setUp()
  //    userDefaults.removeAll()
  //  }
  
  func testOptionalInteger() {
    let userDefaults = UserDefaults.standard
    let key = UUID().uuidString
    XCTAssertFalse(userDefaults.hasKey(key))
    
    userDefaults.set(10, forKey: key)
    XCTAssertTrue(userDefaults.hasKey(key))
    XCTAssertNotNil(userDefaults.optionalInteger(forKey: key))
    XCTAssertEqual(userDefaults.optionalInteger(forKey: key), 10)

    #if !os(Linux)
    userDefaults.set(nil, forKey: key)
    XCTAssertEqual(userDefaults.optionalInteger(forKey: key), .none)
    #endif

    userDefaults.set(10, forKey: key)
    userDefaults.removeObject(forKey: key)
    XCTAssertEqual(userDefaults.optionalInteger(forKey: key), .none)

    userDefaults.set("hello world", forKey: key)
    XCTAssertEqual(userDefaults.optionalInteger(forKey: key), .none)
  }
  
  func testOptionalDouble() {
    let userDefaults = UserDefaults.standard
    let key = UUID().uuidString
    XCTAssertFalse(userDefaults.hasKey(key))
    
    userDefaults.set(Double(10), forKey: key)
    XCTAssertTrue(userDefaults.hasKey(key))
    XCTAssertNotNil(userDefaults.optionalDouble(forKey: key))
    XCTAssertEqual(userDefaults.optionalDouble(forKey: key), Double(10))
    
    userDefaults.set(nil, forKey: key)
    XCTAssertEqual(userDefaults.optionalDouble(forKey: key), .none)
  }
  
  func testOptionalFloat() {
    let userDefaults = UserDefaults.standard
    let key = UUID().uuidString
    XCTAssertFalse(userDefaults.hasKey(key))
    
    userDefaults.set(10.1, forKey: key)
    XCTAssertTrue(userDefaults.hasKey(key))
    XCTAssertNotNil(userDefaults.optionalFloat(forKey: key))
    XCTAssertEqual(userDefaults.optionalFloat(forKey: key), 10.1)
    
    userDefaults.set(nil, forKey: key)
    XCTAssertEqual(userDefaults.optionalFloat(forKey: key), .none)
  }
  
  func testOptionalBool() {
    let userDefaults = UserDefaults.standard
    let key = UUID().uuidString
    XCTAssertFalse(userDefaults.hasKey(key))
    
    userDefaults.set(true, forKey: key)
    XCTAssertTrue(userDefaults.hasKey(key))
    XCTAssertNotNil(userDefaults.optionalBool(forKey: key))
    XCTAssertEqual(userDefaults.optionalBool(forKey: key), true)
    
    userDefaults.set(nil, forKey: key)
    XCTAssertEqual(userDefaults.optionalBool(forKey: key), nil)
    XCTAssertEqual(userDefaults.optionalFloat(forKey: key), .none)
  }
  
  #if !os(Linux)
  
  func testRemoveAll() {
    let userDefaults = UserDefaults.standard
    let key = UUID().uuidString
    XCTAssertFalse(userDefaults.hasKey(key))
    
    userDefaults.set(10, forKey: key)
    #if !os(Linux)
    XCTAssertNotNil(userDefaults.value(forKey: key))
    #endif
    XCTAssertNotNil(userDefaults.integer(forKey: key))
    
    let key2 = UUID().uuidString
    XCTAssertFalse(userDefaults.hasKey(key2))
    
    userDefaults.set(Double(10), forKey: key2)
    #if !os(Linux)
    XCTAssertNotNil(userDefaults.value(forKey: key2))
    #endif
    XCTAssertNotNil(userDefaults.double(forKey: key))
    
    let key3 = UUID().uuidString
    XCTAssertFalse(userDefaults.hasKey(key3))
    
    userDefaults.set(10.0, forKey: key3)
    #if !os(Linux)
    XCTAssertNotNil(userDefaults.value(forKey: key3))
    #endif
    XCTAssertNotNil(userDefaults.double(forKey: key3))
    
    userDefaults.removeAll()
    
    #if !os(Linux)
    XCTAssertNil(userDefaults.value(forKey: key))
    XCTAssertNil(userDefaults.value(forKey: key2))
    XCTAssertNil(userDefaults.value(forKey: key3))
    #endif
    
    XCTAssertNil(userDefaults.optionalInteger(forKey: key))
    XCTAssertNil(userDefaults.optionalDouble(forKey: key2))
    XCTAssertNil(userDefaults.optionalDouble(forKey: key3))
    
    XCTAssertFalse(userDefaults.hasKey(key))
    XCTAssertFalse(userDefaults.hasKey(key2))
    XCTAssertFalse(userDefaults.hasKey(key3))
  }
  
  #endif
  
  @available(iOS 11, tvOS 11, watchOS 4, macOS 10.13, *)
  func testCodable() {
    let userDefaults = UserDefaults.standard
    do {
      // Given
      let value = UserDefaultsUtilsTests.Person(firstname: "name1", surname: "surname1")
      let value2 = UserDefaultsUtilsTests.Person(firstname: "name2", surname: "surname2")
      let key = "PersonKey"
      //  When
      XCTAssertNoThrow(try userDefaults.set(codableValue: value, forKey: key))
      XCTAssertTrue(userDefaults.hasKey(key))
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
    
    
    #if !os(Linux)
    
    do {
      // Given
      let value = UserDefaultsUtilsTests.CodingPerson(firstname: "name1", surname: "surname1")
      let value2 = UserDefaultsUtilsTests.CodingPerson(firstname: "name2", surname: "surname2")
      let key = "CodingPersonKey"
      //  When
      XCTAssertNoThrow(try userDefaults.set(codableValue: value, forKey: key))
      //  Then
      let codedValue: UserDefaultsUtilsTests.CodingPerson? = userDefaults.codableValue(forKey: key)
      if let codedValue = codedValue {
        XCTAssertTrue(codedValue == value)
      } else {
        XCTAssertNotNil(codedValue)
      }
      
      //  When
      XCTAssertNoThrow(try userDefaults.set(codableValue: value2, forKey: key))
      //  Then
      XCTAssertTrue(userDefaults.hasKey(key))
      let codedValue2: UserDefaultsUtilsTests.CodingPerson? = userDefaults.codableValue(forKey: key)
      if let codedValue2 = codedValue2 {
        XCTAssertTrue(codedValue2 == value2)
      } else {
        XCTAssertNotNil(codedValue2)
      }
      
      // When
      let nilValue: UserDefaultsUtilsTests.CodingPerson? = nil
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
      let value = UserDefaultsUtilsTests.SecureCodingCodingPerson(firstname: "name1", surname: "surname1")
      let value2 = UserDefaultsUtilsTests.SecureCodingCodingPerson(firstname: "name2", surname: "surname2")
      let key = "SecureCodingPersonKey"
      //  When
      XCTAssertNoThrow(try userDefaults.set(codableValue: value, forKey: key))
      //  Then
      let codedValue: UserDefaultsUtilsTests.SecureCodingCodingPerson? = userDefaults.codableValue(forKey: key)
      if let codedValue = codedValue {
        XCTAssertTrue(codedValue == value)
      } else {
        XCTAssertNotNil(codedValue)
      }
      
      //  When
      XCTAssertNoThrow(try userDefaults.set(codableValue: value2, forKey: key))
      //  Then
      XCTAssertTrue(userDefaults.hasKey(key))
      let codedValue2: UserDefaultsUtilsTests.SecureCodingCodingPerson? = userDefaults.codableValue(forKey: key)
      if let codedValue2 = codedValue2 {
        XCTAssertTrue(codedValue2 == value2)
      } else {
        XCTAssertNotNil(codedValue2)
      }
      
      // When
      let nilValue: UserDefaultsUtilsTests.SecureCodingCodingPerson? = nil
      XCTAssertNoThrow(try userDefaults.set(codableValue: nilValue, forKey: key))
      // Then
      XCTAssertFalse(userDefaults.hasKey(key))
      // When
      XCTAssertNoThrow(try userDefaults.set(codableValue: value, forKey: key))
      XCTAssertNoThrow(try userDefaults.set(codableValue: nilValue, forKey: key))
      // Then
      XCTAssertFalse(userDefaults.hasKey(key))
    }
    #endif
  }
  
}

// MARK: - Fixtures

extension UserDefaultsUtilsTests {
  
  class Person: Codable {
    
    let surname: String
    let firstname: String
    
    required init(firstname:String, surname:String) {
      self.firstname = firstname
      self.surname = surname
    }
    
    static func == (left: Person, right: Person) -> Bool {
      return left.firstname == right.firstname && left.surname == right.surname
    }
    
  }
  
  #if !os(Linux)
  
  @objc(CodingPerson)
  class CodingPerson: NSObject, NSCoding, Codable {
    
    @objc
    let surname: String
    
    @objc
    let firstname: String
    
    required init(firstname:String, surname:String) {
      self.firstname = firstname
      self.surname = surname
    }
    
    required init?(coder aDecoder: NSCoder) {
      firstname = aDecoder.decodeObject(forKey: #keyPath(CodingPerson.firstname)) as! String
      surname = aDecoder.decodeObject(forKey: #keyPath(CodingPerson.surname)) as! String
    }
    
    func encode(with aCoder: NSCoder) {
      aCoder.encode(firstname, forKey: #keyPath(CodingPerson.firstname))
      aCoder.encode(surname, forKey: #keyPath(CodingPerson.surname))
    }
    
    static func == (left: CodingPerson, right: CodingPerson) -> Bool {
      return left.firstname == right.firstname && left.surname == right.surname
    }
    
  }
  
  @objc(SecureCodingCodingPerson)
  class SecureCodingCodingPerson: NSObject, NSSecureCoding, Codable {
    
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
        let firstnameDecoded = aDecoder.decodeObject(of: NSString.self, forKey: (#keyPath(SecureCodingCodingPerson.firstname))),
        let surnameDecoded = aDecoder.decodeObject(of: NSString.self, forKey: (#keyPath(SecureCodingCodingPerson.surname)))
        else {
          return nil
      }
      
      self.firstname = firstnameDecoded as String
      self.surname = surnameDecoded as String
    }
    
    func encode(with aCoder: NSCoder) {
      aCoder.encode(firstname, forKey: #keyPath(SecureCodingCodingPerson.firstname))
      aCoder.encode(surname, forKey: #keyPath(SecureCodingCodingPerson.surname))
    }
    
    static func == (left: SecureCodingCodingPerson, right: SecureCodingCodingPerson) -> Bool {
      return left.firstname == right.firstname && left.surname == right.surname
    }
    
  }
  
  #endif
  
}
