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

class UserDefaultsKeyTests: XCTestCase {

  let userDefaults = UserDefaults.standard

  override func setUp() {
    super.setUp()
    userDefaults.removeAll()
  }

  func testOptionalInt() {
    let key = "intKey"
    userDefaults.set(10, forKey: key)
    XCTAssertNotNil(userDefaults.integer(forKey: key))
    XCTAssertEqual(userDefaults.integer(forKey: key), 10)
    userDefaults.set(nil, forKey: key)
    XCTAssertEqual(userDefaults.integer(forKey: key), 0)
    XCTAssertEqual(userDefaults.optionalInteger(forKey: key), .none)
  }

  func testOptionalDouble() {
    let key = "doubleKey"
    userDefaults.set(Double(10), forKey: key)
    XCTAssertNotNil(userDefaults.double(forKey: key))
    XCTAssertEqual(userDefaults.double(forKey: key), Double(10))
    userDefaults.set(nil, forKey: key)
    XCTAssertEqual(userDefaults.double(forKey: key), Double(0))
    XCTAssertEqual(userDefaults.optionalInteger(forKey: key), .none)
  }

  func testOptionalFloat() {
    let key = "floatKey"
    userDefaults.set(10.1, forKey: key)
    XCTAssertNotNil(userDefaults.float(forKey: key))
    XCTAssertEqual(userDefaults.float(forKey: key), 10.1)
    userDefaults.set(nil, forKey: key)
    XCTAssertEqual(userDefaults.float(forKey: key), 0.0)
    XCTAssertEqual(userDefaults.optionalInteger(forKey: key), .none)
  }

  func testOptionalBool() {
    let key = "floatKey"
    userDefaults.set(true, forKey: key)
    XCTAssertNotNil(userDefaults.bool(forKey: key))
    XCTAssertEqual(userDefaults.bool(forKey: key), true)
    userDefaults.set(nil, forKey: key)
    XCTAssertEqual(userDefaults.bool(forKey: key), false)
    XCTAssertEqual(userDefaults.optionalBool(forKey: key), .none)
  }

  func testRemoveAll() {
    let key = "intKey"
    userDefaults.set(10, forKey: key)
    XCTAssertNotNil(userDefaults.value(forKey: key))
    let key2 = "doubleKey"
    userDefaults.set(Double(10), forKey: key2)
    XCTAssertNotNil(userDefaults.value(forKey: key2))
    let key3 = "doubleKey"
    userDefaults.set(10.0, forKey: key3)
    XCTAssertNotNil(userDefaults.value(forKey: key3))
    userDefaults.removeAll()
    XCTAssertNil(userDefaults.value(forKey: key))
    XCTAssertNil(userDefaults.value(forKey: key2))
    XCTAssertNil(userDefaults.value(forKey: key3))
  }

}
