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
    static let string1      = Key<String>(value:"string1")
    static let object1      = Key<Color>(value:"object1")
    static let number1      = Key<NSNumber>(value:"number1")
    static let array1       = Key<[Bool]>(value:"array1")
    static let dictionary1  = Key<[String: Int]>(value:"dictionary1")
    static let date1        = Key<Date>(value:"date1")
    static let data1        = Key<Data>(value:"data1")
    static let int1         = Key<Int>(value:"int1")
    static let double1      = Key<Double>(value:"double1")
    static let float1       = Key<Float>(value:"flaot1")
    static let bool1        = Key<Bool>(value:"bool1")
    static let url1         = Key<URL>(value:"url1")
  }
}

class UserDefaultsUtilsTests: XCTestCase {

  let userDefaults = UserDefaults.standard

  override func setUp() {
    super.setUp()
    userDefaults.removeAll()
  }


  func test_removeAll() {

    userDefaults.removeAll()
    XCTAssertNil(userDefaults[UserDefaults.TestKey.string1])
    XCTAssertNil(userDefaults.object(forKey: UserDefaults.TestKey.object1))
    XCTAssertNil(userDefaults[UserDefaults.TestKey.number1])
    XCTAssertNil(userDefaults.array(forKey: UserDefaults.TestKey.array1))
    XCTAssertNil(userDefaults.dictionary(forKey: UserDefaults.TestKey.dictionary1))
    XCTAssertNil(userDefaults[UserDefaults.TestKey.date1])
    XCTAssertNil(userDefaults[UserDefaults.TestKey.data1])
    XCTAssertEqual(userDefaults[UserDefaults.TestKey.int1], 0)
    XCTAssertEqual(userDefaults[UserDefaults.TestKey.double1], 0.0)
    XCTAssertEqual(userDefaults[UserDefaults.TestKey.float1], 0.0)
    XCTAssertFalse(userDefaults[UserDefaults.TestKey.bool1])
    XCTAssertNil(userDefaults[UserDefaults.TestKey.url1])

  }

  //http://stackoverflow.com/questions/19720611/attempt-to-set-a-non-property-list-object-as-an-nsuserdefaults
  func test_object() {
    let key =  Key<UInt32>(value: "color")
    let red = Color.red.rgb32Bit
    let yellow = Color.yellow.rgb32Bit
    userDefaults.set(red, forKey: key)
    XCTAssertTrue(userDefaults.hasKey(key))
    XCTAssert(userDefaults.object(forKey: key) == red)
    userDefaults.set(yellow, forKey: key)
    XCTAssert(userDefaults.object(forKey: key) == yellow)
  }

}


//  MARK: - String

// MARK: - Object

// MARK: - NSNumber

// MARK: - Array

// MARK: - Dictionary

// MARK: - Date

// MARK: - Data

// MARK: - Int

// MARK: - Double

// MARK: - Float

// MARK: - Bool

// MARK: - URL
