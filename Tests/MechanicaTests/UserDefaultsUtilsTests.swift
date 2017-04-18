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

  lazy var unitTestBundle: Bundle =  { return Bundle(for: type(of: self)) }()

  let userDefaults = UserDefaults.standard

  override func setUp() {
    super.setUp()
    userDefaults.removeAll()
  }

  func test_removeAll() {
    userDefaults.removeAll()
    XCTAssertNil(userDefaults[UserDefaults.TestKey.string1])
    XCTAssertNil(userDefaults[UserDefaults.TestKey.number1])
    XCTAssertNil(userDefaults.array(forKey: UserDefaults.TestKey.array1))
    XCTAssertNil(userDefaults.dictionary(forKey: UserDefaults.TestKey.dictionary1))
    XCTAssertNil(userDefaults[UserDefaults.TestKey.date1])
    XCTAssertNil(userDefaults[UserDefaults.TestKey.data1])
    XCTAssertNil(userDefaults[UserDefaults.TestKey.int1])
    XCTAssertNil(userDefaults[UserDefaults.TestKey.double1])
    XCTAssertNil(userDefaults[UserDefaults.TestKey.float1])
    XCTAssertNil(userDefaults[UserDefaults.TestKey.bool1])
    XCTAssertNil(userDefaults[UserDefaults.TestKey.url1])
  }

  //  MARK: - String

  func test_string() {
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

  func test_object() {
    do {
      let red = Color.red.rgb32Bit
      let yellow = Color.yellow.rgb32Bit
      let key =  Key<UInt32>("myColor")
      userDefaults.set(object: red, forKey: key)
      XCTAssertTrue(userDefaults.hasKey(key))
      XCTAssert(userDefaults.object(forKey: key) == red)
      userDefaults.set(object: yellow, forKey: key)
      XCTAssert(userDefaults.object(forKey: key) == yellow)
    }

    do {
      let red = Color.red.rgb32Bit
      let yellow = Color.yellow.rgb32Bit
      let key =  Key<Any>("myColor")
      userDefaults.set(object: red, forKey: key)
      let color = userDefaults[key] as? UInt32
      XCTAssertEqual(red,color)
      userDefaults[key] = yellow
      XCTAssertTrue(userDefaults.hasKey(key))
    }

  }

  // MARK: - Array

  func test_array() {

    do {
      let value =  ["one","two"]
      let value2 = ["three", "four"]
      let key = Key<[String]>("myArray")
      userDefaults.set(array:value, forKey: key)
      XCTAssertNotNil(userDefaults.array(forKey: key)!)
      XCTAssertTrue(userDefaults.array(forKey: key)! == value)
      userDefaults.set(array:value2, forKey: key)
      XCTAssertNotNil(userDefaults.array(forKey: key)!)
      XCTAssertTrue(userDefaults.array(forKey: key)! == value2)
      XCTAssertTrue(userDefaults.hasKey(key))
      userDefaults.set(array: nil, forKey: key)
      XCTAssertFalse(userDefaults.hasKey(key))
    }

    do {
      let person1 = Person(firstname: "name1", surname: "surname1")
      let person2 = Person(firstname: "name2", surname: "surname2")
      let person3 = Person(firstname: "name3", surname: "surname3")
      let person4 = Person(firstname: "name4", surname: "surname4")

      let value = [person1, person2]
      let value2 = [person3, person4]
      let valueData = value.map{ NSKeyedArchiver.archivedData(withRootObject:$0) }
      let valueData2 = value2.map{ NSKeyedArchiver.archivedData(withRootObject:$0) }
      let key = Key<[Data]>("myArray")

      userDefaults.set(array:valueData, forKey: key)
      XCTAssertNotNil(userDefaults.array(forKey: key)!)
      XCTAssertTrue(userDefaults.array(forKey: key)! == valueData)
      let data = userDefaults.array(forKey: key)!
      let persons = data.flatMap{NSKeyedUnarchiver.unarchiveObject(with: $0) as? Person}
      XCTAssertTrue(value[0] == persons[0])
      XCTAssertTrue(value[1] == persons[1])

      userDefaults.set(array: valueData2, forKey: key)
      XCTAssertNotNil(userDefaults.array(forKey: key)!)
      XCTAssertTrue(userDefaults.array(forKey: key)! == valueData2)
      let data2 = userDefaults.array(forKey: key)!
      let persons2 = data2.flatMap{NSKeyedUnarchiver.unarchiveObject(with: $0) as? Person}
      XCTAssertTrue(value2[0] == persons2[0])
      XCTAssertTrue(value2[1] == persons2[1])

      XCTAssertTrue(userDefaults.hasKey(key))
      userDefaults.set(array: nil, forKey: key)
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

  func test_dictionary() {
    let value:  [String : Any] = ["1":1, "2":"two"]
    let value2: [String : Any] = ["3":3, "4":"four"]
    let key = Key<[String: Any]>("myDicationary")
    userDefaults.set(dictionary: value, forKey: key)

    do {
      let dictionary = userDefaults.dictionary(forKey: key)
      XCTAssertNotNil(dictionary)
      let val1 = dictionary!["1"] as? Int
      let val2 = dictionary!["2"] as? String
      XCTAssertNotNil(val1)
      XCTAssertNotNil(val2)
      XCTAssertTrue(val1! == 1)
      XCTAssertTrue(val2! == "two")
    }

    userDefaults.set(dictionary: value2, forKey: key)
    do {
      let dictionary = userDefaults[key]
      XCTAssertNotNil(dictionary)
      let val1 = dictionary!["3"] as? Int
      let val2 = dictionary!["4"] as? String
      XCTAssertNotNil(val1)
      XCTAssertNotNil(val2)
      XCTAssertTrue(val1! == 3)
      XCTAssertTrue(val2! == "four")
    }

    XCTAssertTrue(userDefaults.hasKey(key))
    userDefaults[key] = nil
    XCTAssertFalse(userDefaults.hasKey(key))

  }

  // MARK: - Date

  func test_date() {
    let value = Date()
    let value2 = Date(timeInterval: 10, since: value)
    let key = Key<Date>("myDate")
    userDefaults.set(date: value, forKey: key)
    XCTAssertTrue(userDefaults.date(forKey: key) == value)
    XCTAssertTrue(userDefaults[key] == value)
    userDefaults[key] = value2
    XCTAssertTrue(userDefaults.date(forKey: key) == value2)
    XCTAssertTrue(userDefaults[key] == value2)
    XCTAssertTrue(userDefaults.hasKey(key))
    userDefaults.set(date: nil, forKey: key)
    XCTAssertFalse(userDefaults.hasKey(key))
  }

  // MARK: - Data

  func test_data() {
    let value = Data(base64Encoded: "tin".base64Encoded!)
    let value2 = Data(base64Encoded: "robots".base64Encoded!)
    let key = Key<Data>("myData")
    userDefaults.set(data: value, forKey: key)
    XCTAssertTrue(userDefaults.data(forKey: key) == value)
    XCTAssertTrue(userDefaults[key] == value)
    userDefaults[key] = value2
    XCTAssertTrue(userDefaults.data(forKey: key) == value2)
    XCTAssertTrue(userDefaults[key] == value2)
    XCTAssertTrue(userDefaults.hasKey(key))
    userDefaults.set(data: nil, forKey: key)
    XCTAssertFalse(userDefaults.hasKey(key))
  }

  // MARK: - NSNumber

  func test_number() {
    let value = NSNumber(integerLiteral: 10)
    let value2 = NSNumber(value: 10.11)
    let key = Key<NSNumber>("myNumber")
    userDefaults.set(number: value, forKey: key)
    XCTAssertTrue(userDefaults.number(forKey: key) == value)
    XCTAssertTrue(userDefaults[key] == value)
    userDefaults[key] = value2
    XCTAssertTrue(userDefaults.number(forKey: key) == value2)
    XCTAssertTrue(userDefaults[key] == value2)
    XCTAssertTrue(userDefaults.hasKey(key))
    userDefaults.set(number: nil, forKey: key)
    XCTAssertFalse(userDefaults.hasKey(key))
  }

  // MARK: - Int

  func test_int() {
    let value = 10
    let value2 = 11
    let key = Key<Int>("myInt")
    let key2 = Key<Int>("myInt", namespace: "my namespace")
    userDefaults.set(integer: value, forKey: key)
    XCTAssertTrue(userDefaults.integer(forKey: key) == value)
    XCTAssertTrue(userDefaults[key] == value)
    userDefaults[key] = value2
    XCTAssertNotEqual(userDefaults[key], userDefaults[key2])
    userDefaults[key2] = value2
    XCTAssertEqual(userDefaults[key], userDefaults[key])
    XCTAssertTrue(userDefaults.integer(forKey: key) == value2)
    XCTAssertTrue(userDefaults[key] == value2)
    XCTAssertTrue(userDefaults.hasKey(key))
    userDefaults.set(integer: nil, forKey: key)
    XCTAssertFalse(userDefaults.hasKey(key))
  }

  // MARK: - Double

  func test_double() {
    let value = 10.10
    let value2 = 11.11
    let key = Key<Double>("myDouble")
    userDefaults.set(double: value, forKey: key)
    XCTAssertTrue(userDefaults.double(forKey: key) == value)
    XCTAssertTrue(userDefaults[key] == value)
    userDefaults[key] = value2
    XCTAssertTrue(userDefaults.double(forKey: key) == value2)
    XCTAssertTrue(userDefaults[key] == value2)
    XCTAssertTrue(userDefaults.hasKey(key))
    userDefaults.set(double: nil, forKey: key)
    XCTAssertFalse(userDefaults.hasKey(key))
  }

  // MARK: - Float

  func test_float() {
    let value = Float(10.10)
    let value2 = Float(11.11)
    let key = Key<Float>("myFloat")
    userDefaults.set(float: value, forKey: key)
    XCTAssertTrue(userDefaults.float(forKey: key) == value)
    XCTAssertTrue(userDefaults[key] == value)
    userDefaults[key] = value2
    XCTAssertTrue(userDefaults.float(forKey: key) == value2)
    XCTAssertTrue(userDefaults[key] == value2)
    XCTAssertTrue(userDefaults.hasKey(key))
    userDefaults.set(float: nil, forKey: key)
    XCTAssertFalse(userDefaults.hasKey(key))
  }

  // MARK: - Bool

  func test_boolean() {
    let value = true
    let value2 = false
    let key = Key<Bool>("myBool")
    userDefaults.set(bool: value, forKey: key)
    XCTAssertTrue(userDefaults.bool(forKey: key) == value)
    XCTAssertTrue(userDefaults[key] == value)
    userDefaults[key] = value2
    XCTAssertTrue(userDefaults.bool(forKey: key) == value2)
    XCTAssertTrue(userDefaults[key] == value2)
    XCTAssertTrue(userDefaults.hasKey(key))
    userDefaults.set(bool: nil, forKey: key)
    XCTAssertFalse(userDefaults.hasKey(key))
  }

  // MARK: - URL

  func test_url() {
    let value = URL(string: "tinrobot.com")
    let value2 = URL(string: "tinrobot.com/Mechanica")
    let key = Key<URL>("myURL")
    userDefaults.set(url: value, forKey: key)
    XCTAssertTrue(userDefaults.url(forKey: key) == value)
    XCTAssertTrue(userDefaults[key] == value)
    userDefaults[key] = value2
    XCTAssertTrue(userDefaults.url(forKey: key) == value2)
    XCTAssertTrue(userDefaults[key] == value2)
    XCTAssertTrue(userDefaults.hasKey(key))
    userDefaults.set(url: nil, forKey: key)
    XCTAssertFalse(userDefaults.hasKey(key))
  }

  // MARK: - NSCoding

  func test_archive() {
    let value = Person(firstname: "name1", surname: "surname1")
    let value2 = Person(firstname: "name2", surname: "surname2")
    let key = Key<Person>("myPerson")
    userDefaults.set(archivableValue: value, forKey: key)
    XCTAssertTrue(userDefaults.archivableValue(forKey: key)! == value)
    userDefaults.set(archivableValue: value2, forKey: key)
    XCTAssertTrue(userDefaults.archivableValue(forKey: key)! == value2)
    XCTAssertTrue(userDefaults.hasKey(key))
    userDefaults.set(archivableValue: nil, forKey: key)
    XCTAssertFalse(userDefaults.hasKey(key))
  }

}



class Person: NSObject, NSCoding {
  let surname: String
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

  static func ==(left: Person, right: Person) -> Bool {
    return left.firstname == right.firstname && left.surname == right.surname
  }
  
}


