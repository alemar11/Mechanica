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

class CollectionUtilsTests: XCTestCase {

  func testFirstIndex() {
    // Given
    let array = [1, 1, 1, 2, 3, 4, 4, 5, 8]

    // When, Then
    let index1 = array.firstIndex(of: 1)
    XCTAssertTrue(index1 == 0)
    let index2 = array.firstIndex(of: 8)
    XCTAssertTrue(index2 == 8)
    let index3 = array.firstIndex(of: 4)
    XCTAssertTrue(index3 == 5)
    let index4 = array.firstIndex(of: 11)
    XCTAssertTrue(index4 == nil)
  }

  func testLastIndex() {
    // Given
    let array = [1, 1, 1, 2, 3, 4, 4, 5, 8]

    // When, Then
    let index1 = array.lastIndex(of: 1)
    XCTAssertTrue(index1 == 2)
    let index2 = array.lastIndex(of: 8)
    XCTAssertTrue(index2 == 8)
    let index3 = array.lastIndex(of: 4)
    XCTAssertTrue(index3 == 6)
    let index4 = array.lastIndex(of: 11)
    XCTAssertTrue(index4 == nil)
  }

  func testRandom() {
    do {
      let collection = [1]
      for _ in 1...100 {
        XCTAssertTrue(collection.random() == 1)
      }
    }

    do {
      let collection = [1, 2]
      for _ in 1...100 {
        let value = collection.random()
        XCTAssertTrue(value == 1 || value == 2)
      }
    }

    do {
      let collection = Array(repeating: 3, count: 300)
      XCTAssertTrue(collection.random() == 3)
    }

    do {
      let collection = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
      for _ in 1...100 {
        let value = collection.random()
        XCTAssertTrue(collection.contains(value))
      }
    }

    do {
      let collection = ["a", "b", "c", "d", "e", "z", "1", "👻"]
      for _ in 1...100 {
        let value = collection.random()
        XCTAssertTrue(collection.contains(value))
      }
    }

    do {
      let dictionary = [1, 2, 3]
      var foundFirst = false
      var foundSecond = false
      var foundThird = false

      repeat {
        let randomElement = dictionary.random()

        if randomElement == 1 {
          foundFirst = true

        } else if randomElement == 2 {
          foundSecond = true

        } else if randomElement == 3 {
          foundThird = true
        }

      } while foundFirst == false || foundSecond == false || foundThird == false
    }
  }

  func testUniqueElement() {

    do {
      let array = [1, 2, 3, 4, 5, 3, 6, 1]
      let uniqueArray = array.uniqueElements
      XCTAssertTrue(uniqueArray.count == 6)
    }

    do {
      let array = [Int]()
      let uniqueArray = array.uniqueElements
      XCTAssertTrue(uniqueArray.count == 0)
    }

    do {
      let array = [1, 1, 1, 1, 1, 1, 1]
      let uniqueArray = array.uniqueElements
      XCTAssertTrue(uniqueArray.count == 1)
    }

  }

}


