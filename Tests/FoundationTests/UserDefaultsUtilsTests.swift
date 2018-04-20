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
    ("testOptionalDouble", testOptionalDouble),
    ("testOptionalFloat", testOptionalFloat),
    //("testOptionalBool", testOptionalBool),
    //("testRemoveAll", testRemoveAll),
    ("testCodableSetAndRemove", testCodableSetAndRemove),
    ("testCodableSetAndReset", testCodableSetAndReset),
    ("testCodableSetResetAndRemove", testCodableSetResetAndRemove)
  ]
}

final class UserDefaultsUtilsTests: XCTestCase {

  // TODO: add test for URL -> https://github.com/apple/swift-corelibs-foundation/blob/master/Foundation/UserDefaults.swift
  // on Linux will be set to nil
  // TODO: set a boolean it's not working on Linux (Swift 4.1)
  // TODO: set nil to remove an object is not working on Linux (Swift 4.1)

  func testOptionalInteger() {
    let userDefaults = UserDefaults.standard
    let key = "\(#function)\(#line)"
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
    let key = "\(#function)\(#line)"
    XCTAssertFalse(userDefaults.hasKey(key))

    userDefaults.set(Double(10), forKey: key)
    XCTAssertTrue(userDefaults.hasKey(key))
    XCTAssertNotNil(userDefaults.optionalDouble(forKey: key))
    XCTAssertEqual(userDefaults.optionalDouble(forKey: key), Double(10))

    #if !os(Linux)
    userDefaults.set(nil, forKey: key)
    XCTAssertEqual(userDefaults.optionalDouble(forKey: key), .none)
    #endif

    userDefaults.set("hello world", forKey: key)
    XCTAssertEqual(userDefaults.optionalDouble(forKey: key), .none)
  }

  func testOptionalFloat() {
    let userDefaults = UserDefaults.standard
    let key = "\(#function)\(#line)"
    XCTAssertFalse(userDefaults.hasKey(key))

    userDefaults.set(10.1, forKey: key)
    XCTAssertTrue(userDefaults.hasKey(key))
    XCTAssertNotNil(userDefaults.optionalFloat(forKey: key))
    XCTAssertEqual(userDefaults.optionalFloat(forKey: key), 10.1)

    #if !os(Linux)
    userDefaults.set(nil, forKey: key)
    XCTAssertEqual(userDefaults.optionalFloat(forKey: key), .none)
    #endif

    userDefaults.set("hello world", forKey: key)
    XCTAssertEqual(userDefaults.optionalFloat(forKey: key), .none)
  }

  func testOptionalBool() {
    let userDefaults = UserDefaults.standard
    let key = "\(#function)\(#line)"
    XCTAssertFalse(userDefaults.hasKey(key))

    userDefaults.set(true, forKey: key)
    // print(userDefaults.object(forKey: key)) // print nil on Linux (Swift 4.1 dev)
    // print(userDefaults.bool(forKey: key)) // prints false on Linux (Swift 4.1 dev)
    XCTAssertTrue(userDefaults.hasKey(key))
    XCTAssertNotNil(userDefaults.optionalBool(forKey: key))
    XCTAssertEqual(userDefaults.optionalBool(forKey: key), true)

    #if !os(Linux)
    userDefaults.set(nil, forKey: key)
    XCTAssertEqual(userDefaults.optionalBool(forKey: key), nil)
    #endif

    XCTAssertEqual(userDefaults.optionalFloat(forKey: key), .none)
    userDefaults.set("hello world", forKey: key)
    XCTAssertEqual(userDefaults.optionalBool(forKey: key), .none)
  }

  #if !os(Linux)

  func testRemoveAll() {
    let userDefaults = UserDefaults.standard
    let key = "\(#function)\(#line)"
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

  func testCodableSetAndRemove() {
    let value = UserDefaultsUtilsTests.Person(firstname: "name1", surname: "surname1", url: URL(string: "http:www.tinrobots.org")!)

    let userDefaults = UserDefaults.standard
    let key = "\(#function)\(#line)"

    XCTAssertNoThrow(try userDefaults.set(codableValue: value, forKey: key))
    XCTAssertNoThrow(try userDefaults.set(codableValue: Optional<UserDefaultsUtilsTests.Person>.none, forKey: key))
    XCTAssertFalse(userDefaults.hasKey(key), "UserDefaults shouldn't have the key \(key) in: \(userDefaults.dictionaryRepresentation().keys).")
  }

  func testCodableSetAndReset() {
    let value = UserDefaultsUtilsTests.Person(firstname: "name1", surname: "surname1", url: URL(string: "http:www.tinrobots.org")!)
    let value2 = UserDefaultsUtilsTests.Person(firstname: "name2", surname: "surname2", url: URL(string:"http:www.tinrobots2.org")!)

    let userDefaults = UserDefaults.standard
    let key = "\(#function)\(#line)"

    XCTAssertNoThrow(try userDefaults.set(codableValue: value, forKey: key))
    XCTAssertTrue(userDefaults.hasKey(key))
    XCTAssertNoThrow(try userDefaults.set(codableValue: value2, forKey: key))
    XCTAssertTrue(userDefaults.hasKey(key))
    XCTAssertEqual(userDefaults.codableValue(forKey: key), value2)
  }

  func testCodableSetResetAndRemove() {
    let value = UserDefaultsUtilsTests.Person(firstname: "name1", surname: "surname1", url: URL(string: "http:www.tinrobots.org")!)
    let value2 = UserDefaultsUtilsTests.Person(firstname: "name2", surname: "surname2", url: URL(string: "http:www.tinrobots2.org")!)

    let userDefaults = UserDefaults.standard
    let key = "\(#function)\(#line)"

    XCTAssertNoThrow(try userDefaults.set(codableValue: value, forKey: key))
    XCTAssertTrue(userDefaults.hasKey(key))
    XCTAssertNoThrow(try userDefaults.set(codableValue: value2, forKey: key))
    XCTAssertTrue(userDefaults.hasKey(key))
    XCTAssertEqual(userDefaults.codableValue(forKey: key), value2)

    XCTAssertNoThrow(try userDefaults.set(codableValue: Optional<UserDefaultsUtilsTests.Person>.none, forKey: key))
    XCTAssertFalse(userDefaults.hasKey(key), "UserDefaults shouldn't have the key \(key) in: \(userDefaults.dictionaryRepresentation().keys).")
  }

  #if !os(Linux)

  func testCodableWithCodingSetAndReset() {
    let value = UserDefaultsUtilsTests.CodingPerson(firstname: "name1", surname: "surname1", url: URL(string: "http:www.tinrobots.org")!)
    let value2 = UserDefaultsUtilsTests.CodingPerson(firstname: "name2", surname: "surname2", url: URL(string: "http:www.tinrobots2.org")!)

    let userDefaults = UserDefaults.standard
    userDefaults.removeAll()
    let key = "\(#function)\(#line)"

    XCTAssertNoThrow(try userDefaults.set(codableValue: value, forKey: key))
    XCTAssertTrue(userDefaults.hasKey(key))
    XCTAssertNoThrow(try userDefaults.set(codableValue: value2, forKey: key))
    XCTAssertTrue(userDefaults.hasKey(key))
    let person2: CodingPerson? = userDefaults.codableValue(forKey: key)
    
    XCTAssertEqual(person2, value2)
  }

  func testCodableWithCodingSetAndRemove() {
    let value = UserDefaultsUtilsTests.CodingPerson(firstname: "name1", surname: "surname1", url: URL(string: "http:www.tinrobots2.org")!)
    let userDefaults = UserDefaults.standard

    userDefaults.removeAll()
    let key = "\(#function)\(#line)"

    XCTAssertNoThrow(try userDefaults.set(codableValue: value, forKey: key))
    XCTAssertNoThrow(try userDefaults.set(codableValue: Optional<UserDefaultsUtilsTests.Person>.none, forKey: key))
    XCTAssertFalse(userDefaults.hasKey(key), "UserDefaults shouldn't have the key \(key) in: \(userDefaults.dictionaryRepresentation().keys).")
  }

  func testCodableWithSecureCodingSetAndReset() {
    let value = UserDefaultsUtilsTests.SecureCodingPerson(firstname: "name1", surname: "surname1", url: URL(string: "http:www.tinrobots.org")!)
    let value2 = UserDefaultsUtilsTests.SecureCodingPerson(firstname: "name2", surname: "surname2", url: URL(string: "http:www.tinrobots2.org")!)

    let userDefaults = UserDefaults.standard
    userDefaults.removeAll()
    let key = "\(#function)\(#line)"

    XCTAssertNoThrow(try userDefaults.set(codableValue: value, forKey: key))
    XCTAssertTrue(userDefaults.hasKey(key))
    XCTAssertNoThrow(try userDefaults.set(codableValue: value2, forKey: key))
    XCTAssertTrue(userDefaults.hasKey(key))
    let person2: UserDefaultsUtilsTests.SecureCodingPerson? = userDefaults.codableValue(forKey: key)
    XCTAssertEqual(person2, value2)
  }

  func testCodableWithSecureCodingSetAndRemove() {
    let value = UserDefaultsUtilsTests.SecureCodingPerson(firstname: "name1", surname: "surname1", url: URL(string: "http:www.tinrobots.org")!)
    let userDefaults = UserDefaults.standard

    userDefaults.removeAll()
    let key = "\(#function)\(#line)"

    XCTAssertNoThrow(try userDefaults.set(codableValue: value, forKey: key))
    XCTAssertNoThrow(try userDefaults.set(codableValue: Optional<UserDefaultsUtilsTests.Person>.none, forKey: key))
    XCTAssertFalse(userDefaults.hasKey(key), "UserDefaults shouldn't have the key \(key) in: \(userDefaults.dictionaryRepresentation().keys).")
  }

  #endif

}

// MARK: - Fixtures

extension UserDefaultsUtilsTests {

  class Person: Codable, Equatable {

    let surname: String
    let firstname: String
    let url: URL

    required init(firstname: String, surname: String, url: URL) {
      self.firstname = firstname
      self.surname = surname
      self.url = url
    }

    static func == (left: Person, right: Person) -> Bool {
      return left.firstname == right.firstname && left.surname == right.surname && left.url == right.url
    }

  }

  #if !os(Linux)

  @objc(CodingPerson)
  class CodingPerson: NSObject, NSCoding, Codable {

    @objc
    let surname: String

    @objc
    let firstname: String

    @objc
    let url: URL

    required init(firstname: String, surname: String, url: URL) {
      self.firstname = firstname
      self.surname = surname
      self.url = url
    }

    required init?(coder aDecoder: NSCoder) {
      firstname = aDecoder.decodeObject(forKey: #keyPath(CodingPerson.firstname)) as! String
      surname = aDecoder.decodeObject(forKey: #keyPath(CodingPerson.surname)) as! String
      url = aDecoder.decodeObject(forKey: #keyPath(CodingPerson.url)) as! URL
    }

    func encode(with aCoder: NSCoder) {
      aCoder.encode(firstname, forKey: #keyPath(CodingPerson.firstname))
      aCoder.encode(surname, forKey: #keyPath(CodingPerson.surname))
      aCoder.encode(url, forKey: #keyPath(CodingPerson.url))
    }

    override func isEqual(_ object: Any?) -> Bool {
      if let rhs = object as? CodingPerson {
        return surname == rhs.surname && firstname == rhs.firstname && rhs.url == url
      }
      return false
    }

  }

  @objc(SecureCodingPerson)
  class SecureCodingPerson: NSObject, NSSecureCoding, Codable {

    static var supportsSecureCoding = true

    @objc
    let surname: String

    @objc
    let firstname: String

    @objc
    let url: URL

    required init(firstname: String, surname: String, url: URL) {
      self.firstname = firstname
      self.surname = surname
      self.url = url
    }

    required init?(coder aDecoder: NSCoder) {
      guard
        let firstnameDecoded = aDecoder.decodeObject(of: NSString.self, forKey: (#keyPath(SecureCodingPerson.firstname))),
        let surnameDecoded = aDecoder.decodeObject(of: NSString.self, forKey: (#keyPath(SecureCodingPerson.surname))),
        let urlDecoded = aDecoder.decodeObject(of: NSURL.self, forKey: (#keyPath(SecureCodingPerson.url)))
        else {
          return nil
      }

      self.firstname = firstnameDecoded as String
      self.surname = surnameDecoded as String
      self.url = urlDecoded as URL
    }

    func encode(with aCoder: NSCoder) {
      aCoder.encode(firstname, forKey: #keyPath(SecureCodingPerson.firstname))
      aCoder.encode(surname, forKey: #keyPath(SecureCodingPerson.surname))
    }

    override func isEqual(_ object: Any?) -> Bool {
      if let rhs = object as? SecureCodingPerson {
        return surname == rhs.surname && firstname == rhs.firstname && rhs.url == url
      }
      return false
    }

  }

  #endif

}
