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

class DictionaryUtilsTests: XCTestCase {

  func testHasKey() {
    do {
      let dictionary: [String:Int] = [:]
      XCTAssertFalse(dictionary.hasKey(""))
      XCTAssertFalse(dictionary.hasKey("robot"))
    }
    do {
      let dictionary: [String:Int] = ["robot":1, "robot2":2]
      XCTAssertFalse(dictionary.hasKey(""))
      XCTAssertTrue(dictionary.hasKey("robot"))
    }
  }

  func testRemoveAll() {
    var dictionary = ["a": 0, "b": 1, "c": 2, "d": 3, "e": 4, "f": 5, "g": 6, "h": 7, "i": 8, "l": 9, "m": 10]

    do {
      let removed = dictionary.removeAll(forKeys: ["a", "b", "c"])
      if removed != nil {
        XCTAssertTrue(removed!.count == 3)
      } else {
        XCTAssertNotNil(dictionary)
      }
    }

    do {
      let removed = dictionary.removeAll(forKeys: ["a", "b", "c", "d"])
      if removed != nil {
        XCTAssertTrue(removed!.count == 1)
      } else {
        XCTAssertNotNil(dictionary)
      }
    }

    do {
      let removed = dictionary.removeAll(forKeys: ["k"])
      XCTAssertNil(removed)
    }

    do {
      let removed = dictionary.removeAll(forKeys: ["a", "b", "c", "d", "e", "f", "g", "h", "i", "l", "m"])
      XCTAssertNotNil(removed)
      XCTAssertNil(removed!["a"])
      XCTAssertNil(dictionary["a"])
      XCTAssertNotNil(removed!["l"])
      XCTAssertNil(dictionary["l"])
      XCTAssert(dictionary.isEmpty)
    }

  }

  func testRandom() {

    do {
      let dictionary = ["a": 0, "b": 1, "c": 2, "d": 3, "e": 4, "f": 5, "g": 6, "h": 7, "i": 8, "l": 9, "m": 10]

      for _ in 1...100 {
        let randomElement = dictionary.random()
        let randomValue = randomElement.value
        let dictionaryValue = dictionary[randomElement.key]
        if let dictionaryValue = dictionaryValue {
          XCTAssertTrue(randomValue == dictionaryValue)
        } else {
          XCTAssertNotNil(dictionaryValue)
        }

      }
    }

    do {
      let dictionary = ["a": 0]
      for _ in 1...100 {
        let randomElement = dictionary.random()
        XCTAssertTrue(randomElement.key == "a")
        XCTAssertTrue(randomElement.value == 0)
      }
    }

    do {
      let dictionary = ["a": 0, "b": 1, "c": 2]
      var foundFirst = false
      var foundSecond = false
      var foundThird = false

      repeat {
        let randomElement = dictionary.random()

        if randomElement.key == "a" {
          foundFirst = true

        } else if randomElement.key == "b" {
          foundSecond = true
        } else if randomElement.key == "c" {
          foundThird = true
        }

      } while foundFirst == false || foundSecond == false || foundThird == false
    }
  }

}
