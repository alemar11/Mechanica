//
//  UserDefaultsUtilsTests.swift
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
@testable import Mechanica

private let namespace = "org.tinrobots.test"

extension UserDefaults {
  enum TestKey {
    static let string1      = Key<String>("string1", namespace: "tin.robots")
    static let number1      = Key<NSNumber>("number1")
    static let array1       = Key<[Bool]>("array1")
    static let dictionary1  = Key<[String: Int]>("dictionary1")
    static let date1        = Key<Date>("date1")
    static let data1        = Key<Data>("data1")
    static let int1         = Key<Int>("int1")
    static let double1      = Key<Double>("double1")
    static let float1       = Key<Float>("flaot1")
    static let bool1        = Key<Bool>("bool1")
    static let url1         = Key<URL>("url1")
  }
}

class UserDefaultsUtilsTests: XCTestCase {

  let userDefaults = UserDefaults.standard

  override func setUp() {
    super.setUp()
    userDefaults.removeAll()
  }

  func testRemoveAll() {
    userDefaults.removeAll()
    XCTAssertNil(userDefaults[UserDefaults.TestKey.string1])
    XCTAssertNil(userDefaults[UserDefaults.TestKey.number1])
    XCTAssertNil(userDefaults.array(forKey: UserDefaults.TestKey.array1))
    XCTAssertNil(userDefaults.dictionary(forKey: UserDefaults.TestKey.dictionary1))
    XCTAssertNil(userDefaults[UserDefaults.TestKey.dictionary1])
    XCTAssertNil(userDefaults[UserDefaults.TestKey.date1])
    XCTAssertNil(userDefaults[UserDefaults.TestKey.data1])
    XCTAssertNil(userDefaults[UserDefaults.TestKey.int1])
    XCTAssertNil(userDefaults[UserDefaults.TestKey.double1])
    XCTAssertNil(userDefaults[UserDefaults.TestKey.float1])
    XCTAssertNil(userDefaults[UserDefaults.TestKey.bool1])
    XCTAssertNil(userDefaults[UserDefaults.TestKey.url1])
  }

  //  MARK: - String

  func testString() {
    let value = "myString"
    let value2 = "myString2"
    let key = Key<String>("myString")
    let key2 = Key<String>("myString", namespace: "myNamespace")
    userDefaults.set(string: value, forKey: key)
    userDefaults.set(string: value, forKey: key2)
    XCTAssertTrue(userDefaults.string(forKey: key) == value)
    XCTAssertTrue(userDefaults[key] == value)
    userDefaults[key] = value2
    XCTAssertNotEqual(userDefaults[key], userDefaults[key2])
    userDefaults[key2] = value2
    XCTAssertEqual(userDefaults[key], userDefaults[key])
    XCTAssertTrue(userDefaults.string(forKey: key) == value2)
    XCTAssertTrue(userDefaults[key] == value2)
    XCTAssertTrue(userDefaults.hasKey(key))
    userDefaults.set(string: nil, forKey: key)
    XCTAssertFalse(userDefaults.hasKey(key))
  }

  // MARK: - Object

  func testObject() {
    do {
      let x = UInt32(10)
      let y = UInt32(20)
      let key =  Key<UInt32>("myObject")
      userDefaults.set(object: x, forKey: key)
      XCTAssertTrue(userDefaults.hasKey(key))
      XCTAssert(userDefaults.object(forKey: key) == x)
      userDefaults.set(object: y, forKey: key)
      XCTAssert(userDefaults.object(forKey: key) == y)
    }

    do {
      let x = "10" as NSString
      let y = "20" as NSString
      let key =  Key<Any>("myObject")
      userDefaults.set(object: x, forKey: key)
      let k = userDefaults[key] as? NSString
      XCTAssertEqual(x,k)
      userDefaults[key] = y
      XCTAssertTrue(userDefaults.hasKey(key))
    }

  }

  // MARK: - Array

  func testArray() {

    do {
      // Given
      let value =  ["one","two"]
      let value2 = ["three", "four"]
      let key = Key<[String]>("myArray")
      // When
      userDefaults[key] = value
      // Then
      if let defaultValue = userDefaults[key] {
        XCTAssertTrue(defaultValue == value)
      } else {
        XCTAssertNotNil(userDefaults[key])
      }
      // When
      userDefaults[key] = value2
      // Then
      if let defaultValue = userDefaults[key] {
        XCTAssertTrue(defaultValue == value2)
      } else {
        XCTAssertNotNil(userDefaults[key])
      }
      XCTAssertTrue(userDefaults.hasKey(key))
      // When
      userDefaults[key] = nil
      // Then
      XCTAssertFalse(userDefaults.hasKey(key))
    }

    do {
      // Given
      let value =  [1, 2]
      let value2 = [3, 4]
      let key = Key<[Int]>("myArray")
      // When
      userDefaults[key] = value
      // Then
      if let defaultValue = userDefaults[key] {
        XCTAssertTrue(defaultValue == value)
      } else {
        XCTAssertNotNil(userDefaults[key])
      }
      // When
      userDefaults[key] = value2
      // Then
      if let defaultValue = userDefaults[key] {
        XCTAssertTrue(defaultValue == value2)
      } else {
        XCTAssertNotNil(userDefaults[key])
      }
      XCTAssertTrue(userDefaults.hasKey(key))
      // When
      userDefaults[key] = nil
      // Then
      XCTAssertFalse(userDefaults.hasKey(key))
    }

    do {
      // Given
      let value =  [1.1, 2.2]
      let value2 = [3.3, 4.4]
      let key = Key<[Double]>("myArray")
      // When
      userDefaults[key] = value
      // Then
      if let defaultValue = userDefaults[key] {
        XCTAssertTrue(defaultValue == value)
      } else {
        XCTAssertNotNil(userDefaults[key])
      }
      // When
      userDefaults[key] = value2
      // Then
      if let defaultValue = userDefaults[key] {
        XCTAssertTrue(defaultValue == value2)
      } else {
        XCTAssertNotNil(userDefaults[key])
      }
      XCTAssertTrue(userDefaults.hasKey(key))
      // When
      userDefaults[key] = nil
      // Then
      XCTAssertFalse(userDefaults.hasKey(key))
    }

    do {
      // Given
      let value =  [Float(1), Float(2)]
      let value2 = [Float(3), Float(4)]
      let key = Key<[Float]>("myArray")
      // When
      userDefaults[key] = value
      // Then
      if let defaultValue = userDefaults[key] {
        XCTAssertTrue(defaultValue == value)
      } else {
        XCTAssertNotNil(userDefaults[key])
      }
      // When
      userDefaults[key] = value2
      // Then
      if let defaultValue = userDefaults[key] {
        XCTAssertTrue(defaultValue == value2)
      } else {
        XCTAssertNotNil(userDefaults[key])
      }
      XCTAssertTrue(userDefaults.hasKey(key))
      // When
      userDefaults[key] = nil
      // Then
      XCTAssertFalse(userDefaults.hasKey(key))
    }

    do {
      // Given
      let value =  [true, false]
      let value2 = [true, true]
      let key = Key<[Bool]>("myArray")
      // When
      userDefaults[key] = value
      // Then
      if let defaultValue = userDefaults[key] {
        XCTAssertTrue(defaultValue == value)
      } else {
        XCTAssertNotNil(userDefaults[key])
      }
      // When
      userDefaults[key] = value2
      // Then
      if let defaultValue = userDefaults[key] {
        XCTAssertTrue(defaultValue == value2)
      } else {
        XCTAssertNotNil(userDefaults[key])
      }
      XCTAssertTrue(userDefaults.hasKey(key))
      // When
      userDefaults[key] = nil
      // Then
      XCTAssertFalse(userDefaults.hasKey(key))
    }

    do {
      // Given
      let value =  [Date(timeInterval: 10, since: Date()), Date(timeInterval: 20, since: Date())]
      let value2 = [Date(timeInterval: 30, since: Date()), Date(timeInterval: -20, since: Date())]
      let key = Key<[Date]>("myArray")
      // When
      userDefaults[key] = value
      // Then
      if let defaultValue = userDefaults[key] {
        XCTAssertTrue(defaultValue == value)
      } else {
        XCTAssertNotNil(userDefaults[key])
      }
      // When
      userDefaults[key] = value2
      // Then
      if let defaultValue = userDefaults[key] {
        XCTAssertTrue(defaultValue == value2)
      } else {
        XCTAssertNotNil(userDefaults[key])
      }
      XCTAssertTrue(userDefaults.hasKey(key))
      // When
      userDefaults[key] = nil
      // Then
      XCTAssertFalse(userDefaults.hasKey(key))
    }

    do {
      // Given
      let person1 = Person(firstname: "name1", surname: "surname1")
      let person2 = Person(firstname: "name2", surname: "surname2")
      let person3 = Person(firstname: "name3", surname: "surname3")
      let person4 = Person(firstname: "name4", surname: "surname4")

      let value = [person1, person2]
      let value2 = [person3, person4]
      let valueData = value.map{ NSKeyedArchiver.archivedData(withRootObject:$0) }
      let valueData2 = value2.map{ NSKeyedArchiver.archivedData(withRootObject:$0) }
      let key = Key<[Data]>("myArray")
      // When
      userDefaults.set(array: valueData, forKey: key)
      // Then
      XCTAssertNotNil(userDefaults.array(forKey: key)!)
      XCTAssertTrue(userDefaults.array(forKey: key)! == valueData)
      // When
      let data = userDefaults.array(forKey: key)!
      // Then
      let persons = data.flatMap{NSKeyedUnarchiver.unarchiveObject(with: $0) as? Person}
      XCTAssertTrue(value[0] == persons[0])
      XCTAssertTrue(value[1] == persons[1])
      // When
      userDefaults.set(array: valueData2, forKey: key)
      // Then
      XCTAssertNotNil(userDefaults.array(forKey: key)!)
      XCTAssertTrue(userDefaults.array(forKey: key)! == valueData2)
      let data2 = userDefaults.array(forKey: key)!
      let persons2 = data2.flatMap{NSKeyedUnarchiver.unarchiveObject(with: $0) as? Person}
      XCTAssertTrue(value2[0] == persons2[0])
      XCTAssertTrue(value2[1] == persons2[1])
      XCTAssertTrue(userDefaults.hasKey(key))
      // When
      userDefaults.set(array: nil, forKey: key)
      // Then
      XCTAssertFalse(userDefaults.hasKey(key))
    }

    do {
      let value: [Any] =  ["one", 2]
      let value2: [Any] = ["three", 4]
      let key = Key<[Any]>("myArray")
      userDefaults.set(array:value, forKey: key)
      XCTAssertNotNil(userDefaults.array(forKey: key)!)
      let results = userDefaults[key]!
      XCTAssertTrue(results[0] as! String == value[0] as! String)
      XCTAssertTrue(results[1] as! Int == value[1] as! Int)
      userDefaults[key] = value2

      let result = userDefaults.array(forKey: key)
      XCTAssertNotNil(result)
      let i = result![1] as! Int
      XCTAssertTrue(i == 4)

      XCTAssertTrue(userDefaults.hasKey(key))
      userDefaults.set(array: nil, forKey: key)
      XCTAssertFalse(userDefaults.hasKey(key))
    }

  }

  // MARK: - Dictionary

  func testDictionary() {

    do {
      let value:  [String : Any] = ["1":1, "2":"two"]
      let key = Key<[String: Any]>("myDicationary")
      userDefaults.set(dictionary: value, forKey: key)
      let dictionary = userDefaults.dictionary(forKey: key)
      XCTAssertNotNil(dictionary)
      let val1 = dictionary!["1"] as? Int
      let val2 = dictionary!["2"] as? String
      XCTAssertNotNil(val1)
      XCTAssertNotNil(val2)
      XCTAssertTrue(val1! == 1)
      XCTAssertTrue(val2! == "two")
      XCTAssertTrue(userDefaults.hasKey(key))
      userDefaults[key] = nil
      XCTAssertFalse(userDefaults.hasKey(key))
    }

    do {
      let value:  [String : Any] = ["3":3, "4":"four"]
      let key = Key<[String: Any]>("myDicationary")
      userDefaults.set(dictionary: value, forKey: key)
      let dictionary = userDefaults[key]
      XCTAssertNotNil(dictionary)
      let val1 = dictionary!["3"] as? Int
      let val2 = dictionary!["4"] as? String
      XCTAssertNotNil(val1)
      XCTAssertNotNil(val2)
      XCTAssertTrue(val1! == 3)
      XCTAssertTrue(val2! == "four")
      XCTAssertTrue(userDefaults.hasKey(key))
      userDefaults[key] = nil
      XCTAssertFalse(userDefaults.hasKey(key))
    }

    do {
      let value = ["3":3, "4":4]
      let key = Key<[String: Int]>("myDicationary")
      userDefaults.set(dictionary: value, forKey: key)
      let dictionary = userDefaults[key]
      XCTAssertNotNil(dictionary)
      let val1 = dictionary!["3"]
      let val2 = dictionary!["4"]
      XCTAssertNotNil(val1)
      XCTAssertNotNil(val2)
      XCTAssertTrue(val1! == 3)
      XCTAssertTrue(val2! == 4)
      XCTAssertTrue(userDefaults.hasKey(key))
      userDefaults[key] = nil
      XCTAssertFalse(userDefaults.hasKey(key))
    }

  }

  // MARK: - Date

  func testDate() {
    //  Given
    let value = Date()
    let value2 = Date(timeInterval: 10, since: value)
    let key = Key<Date>("myDate")
    // When
    userDefaults.set(date: value, forKey: key)
    // Then
    XCTAssertTrue(userDefaults.date(forKey: key) == value)
    XCTAssertTrue(userDefaults[key] == value)
    // When
    userDefaults[key] = value2
    // Then
    XCTAssertTrue(userDefaults.date(forKey: key) == value2)
    XCTAssertTrue(userDefaults[key] == value2)
    XCTAssertTrue(userDefaults.hasKey(key))
    // When
    userDefaults.set(date: nil, forKey: key)
    // Then
    XCTAssertFalse(userDefaults.hasKey(key))
    // When
    userDefaults.set(date: value, forKey: key)
    userDefaults[key] = nil
    // Then
    XCTAssertFalse(userDefaults.hasKey(key))
  }

  // MARK: - Data

  func testData() {
    //  Given
    let value = Data(base64Encoded: "tin".base64Encoded!)
    let value2 = Data(base64Encoded: "robots".base64Encoded!)
    let key = Key<Data>("myData")
    // When
    userDefaults.set(data: value, forKey: key)
    // Then
    XCTAssertTrue(userDefaults.data(forKey: key) == value)
    XCTAssertTrue(userDefaults[key] == value)
    // When
    userDefaults[key] = value2
    // Then
    XCTAssertTrue(userDefaults.data(forKey: key) == value2)
    XCTAssertTrue(userDefaults[key] == value2)
    XCTAssertTrue(userDefaults.hasKey(key))
    // When
    userDefaults.set(data: nil, forKey: key)
    // Then
    XCTAssertFalse(userDefaults.hasKey(key))
    // When
    userDefaults.set(data: value, forKey: key)
    userDefaults[key] = nil
    // Then
    XCTAssertFalse(userDefaults.hasKey(key))
  }

  // MARK: - NSNumber

  func testNumber() {
    //  Given
    let value = NSNumber(integerLiteral: 10)
    let value2 = NSNumber(value: 10.11)
    let key = Key<NSNumber>("myNumber")
    // When
    userDefaults.set(number: value, forKey: key)
    // Then
    XCTAssertTrue(userDefaults.number(forKey: key) == value)
    XCTAssertTrue(userDefaults[key] == value)
    // When
    userDefaults[key] = value2
    // Then
    XCTAssertTrue(userDefaults.number(forKey: key) == value2)
    XCTAssertTrue(userDefaults[key] == value2)
    XCTAssertTrue(userDefaults.hasKey(key))
    // When
    userDefaults.set(number: nil, forKey: key)
    // Then
    XCTAssertFalse(userDefaults.hasKey(key))
    // When
    userDefaults.set(number: value, forKey: key)
    userDefaults[key] = nil
    // Then
    XCTAssertFalse(userDefaults.hasKey(key))
  }

  // MARK: - Int

  func testInt() {
    //  Given
    let value = 10
    let value2 = 11
    let key = Key<Int>("myInt")
    let key2 = Key<Int>("myInt", namespace: "my namespace")
    //  When
    userDefaults.set(integer: value, forKey: key)
    // Then
    XCTAssertTrue(userDefaults.integer(forKey: key) == value)
    XCTAssertTrue(userDefaults[key] == value)
    // When
    userDefaults[key] = value2
    // Then
    XCTAssertNotEqual(userDefaults[key], userDefaults[key2])
    // When
    userDefaults[key2] = value2
    // Then
    XCTAssertEqual(userDefaults[key], userDefaults[key])
    XCTAssertTrue(userDefaults.integer(forKey: key) == value2)
    XCTAssertTrue(userDefaults[key] == value2)
    XCTAssertTrue(userDefaults.hasKey(key))
    // When
    userDefaults.set(integer: nil, forKey: key)
    // Then
    XCTAssertFalse(userDefaults.hasKey(key))
    // When
    userDefaults.set(integer: value, forKey: key)
    userDefaults[key] = nil
    // Then
    XCTAssertFalse(userDefaults.hasKey(key))
  }

  // MARK: - Double

  func testDouble() {
    //  Given
    let value = 10.10
    let value2 = 11.11
    let key = Key<Double>("myDouble")
    // When
    userDefaults.set(double: value, forKey: key)
    // Then
    XCTAssertTrue(userDefaults.double(forKey: key) == value)
    XCTAssertTrue(userDefaults[key] == value)
    // When
    userDefaults[key] = value2
    // Then
    XCTAssertTrue(userDefaults.double(forKey: key) == value2)
    XCTAssertTrue(userDefaults[key] == value2)
    XCTAssertTrue(userDefaults.hasKey(key))
    // When
    userDefaults.set(double: nil, forKey: key)
    // Then
    XCTAssertFalse(userDefaults.hasKey(key))
    // When
    userDefaults.set(double: value, forKey: key)
    userDefaults[key] = nil
    // Then
    XCTAssertFalse(userDefaults.hasKey(key))
  }

  // MARK: - Float

  func testFloat() {
    //  Given
    let value = Float(10.10)
    let value2 = Float(11.11)
    let key = Key<Float>("myFloat")
    // When
    userDefaults.set(float: value, forKey: key)
    // Then
    XCTAssertTrue(userDefaults.float(forKey: key) == value)
    XCTAssertTrue(userDefaults[key] == value)
    // When
    userDefaults[key] = value2
    // Then
    XCTAssertTrue(userDefaults.float(forKey: key) == value2)
    XCTAssertTrue(userDefaults[key] == value2)
    XCTAssertTrue(userDefaults.hasKey(key))
    // When
    userDefaults.set(float: nil, forKey: key)
    // Then
    XCTAssertFalse(userDefaults.hasKey(key))
    // When
    userDefaults.set(float: value, forKey: key)
    userDefaults[key] = nil
    // Then
    XCTAssertFalse(userDefaults.hasKey(key))
  }

  // MARK: - Bool

  func testBoolean() {
    //  Given
    let value = true
    let value2 = false
    let key = Key<Bool>("myBool")
    // When
    userDefaults.set(bool: value, forKey: key)
    // Then
    XCTAssertTrue(userDefaults.bool(forKey: key) == value)
    XCTAssertTrue(userDefaults[key] == value)
    // When
    userDefaults[key] = value2
    // Then
    XCTAssertTrue(userDefaults.bool(forKey: key) == value2)
    XCTAssertTrue(userDefaults[key] == value2)
    XCTAssertTrue(userDefaults.hasKey(key))
    // When
    userDefaults.set(bool: nil, forKey: key)
    // Then
    XCTAssertFalse(userDefaults.hasKey(key))
    // When
    userDefaults.set(bool: value, forKey: key)
    userDefaults[key] = nil
    // Then
    XCTAssertFalse(userDefaults.hasKey(key))
  }

  // MARK: - URL

  func testURL() {
    // Given
    let value = URL(string: "tinrobot.com")
    let value2 = URL(string: "tinrobot.com/Mechanica")
    let key = Key<URL>("myURL")
    // When
    userDefaults.set(url: value, forKey: key)
    // Then
    XCTAssertTrue(userDefaults.url(forKey: key) == value)
    XCTAssertTrue(userDefaults[key] == value)
    // When
    userDefaults[key] = value2
    // Then
    XCTAssertTrue(userDefaults.url(forKey: key) == value2)
    XCTAssertTrue(userDefaults[key] == value2)
    XCTAssertTrue(userDefaults.hasKey(key))
    // When
    userDefaults.set(url: nil, forKey: key)
    // Then
    XCTAssertFalse(userDefaults.hasKey(key))
    // When
    userDefaults.set(url: value, forKey: key)
    userDefaults[key] = nil
    // Then
    XCTAssertFalse(userDefaults.hasKey(key))
  }

  // MARK: - NSCoding

  func testNSCoding() {
    do {
      //  Given
      let value = UserDefaultsUtilsTests.Person(firstname: "name1", surname: "surname1")
      let key = Key<Data>("myPerson")
      let archivedValue = NSKeyedArchiver.archivedData(withRootObject: value)
      //  When
      userDefaults[key] = archivedValue
      //  Then
      if
        let data =  userDefaults[key],
        let unarchivedValue = NSKeyedUnarchiver.unarchiveObject(with: data) as? Person
      {
        XCTAssertTrue(unarchivedValue == value)
      } else {
        XCTAssertNotNil(userDefaults[key])
      }
    }
    do {
      //  Given
      let value = UserDefaultsUtilsTests.SecurePerson(firstname: "name1", surname: "surname1")
      let key = Key<Data>("myPerson")
      let archivedValue = NSKeyedArchiver.archivedData(withRootObject: value)
      //  When
      userDefaults[key] = archivedValue
      //  Then
      if
        let data =  userDefaults[key],
        let unarchivedValue = NSKeyedUnarchiver.unarchiveObject(with: data) as? SecurePerson
      {
        XCTAssertTrue(unarchivedValue == value)
      } else {
        XCTAssertNotNil(userDefaults[key])
      }
    }
  }

  @available(iOS 11, tvOS 11, watchOS 4, OSX 10.13, *)
  func testCodable() {
    do {
      // Given
      let value = UserDefaultsUtilsTests.Person(firstname: "name1", surname: "surname1")
      let value2 = UserDefaultsUtilsTests.Person(firstname: "name2", surname: "surname2")
      let key = Key<UserDefaultsUtilsTests.Person>("myPerson")
      //  When
      userDefaults.set(codableValue: value, forKey: key)
      //  Then
      if let codedValue = userDefaults.codableValue(forKey: key) {
        XCTAssertTrue(codedValue == value)
      } else {
        XCTAssertNotNil(userDefaults.codableValue(forKey: key))
      }
      //  When
      userDefaults[key] = value2
      //  Then
      XCTAssertTrue(userDefaults.hasKey(key))
      if let codedValue = userDefaults.codableValue(forKey: key) {
        XCTAssertTrue(codedValue == value2)
      } else {
        XCTAssertNotNil(userDefaults.codableValue(forKey: key))
      }
      if let codedValue = userDefaults[key] {
        XCTAssertTrue(codedValue == value2)
      } else {
        XCTAssertNotNil(userDefaults[key])
      }
      // When
      userDefaults.set(codableValue: nil, forKey: key)
      // Then
      XCTAssertFalse(userDefaults.hasKey(key))
      // When
      userDefaults.set(codableValue: value, forKey: key)
      userDefaults[key] = nil
      // Then
      XCTAssertFalse(userDefaults.hasKey(key))
    }
  }

}

// MARK: - UserDefaultsUtilsTests Namespace

extension UserDefaultsUtilsTests {

  @objc(ObjCPerson)
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

  @objc(ObjCSecurePerspn)
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
        let firstnameDecoded = aDecoder.decodeObject(of: NSString.self, forKey: (#keyPath(Person.firstname))), let surnameDecoded = aDecoder.decodeObject(of: NSString.self, forKey: (#keyPath(Person.surname)))
        else {
          return nil
      }

      self.firstname = firstnameDecoded as String
      self.surname = surnameDecoded as String
    }

    func encode(with aCoder: NSCoder) {
      aCoder.encode(firstname, forKey: #keyPath(Person.firstname))
      aCoder.encode(surname, forKey: #keyPath(Person.surname))
    }

    static func == (left: SecurePerson, right: SecurePerson) -> Bool {
      return left.firstname == right.firstname && left.surname == right.surname
    }
    
  }

}

