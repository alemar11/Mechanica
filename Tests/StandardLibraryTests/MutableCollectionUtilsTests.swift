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

extension MutableCollectionUtilsTests {
  static var allTests = [
    ("testShuffle", testShuffle),
    ("testShuffled", testShuffled)
  ]
}

final class MutableCollectionUtilsTests: XCTestCase {

  func testShuffle() {
    do {
      // Given
      var elements = ["a"]
      let copy = elements
      // When
      elements.shuffle()
      // Then
      XCTAssertEqual(elements.count, copy.count)
      XCTAssertEqual(elements.sorted(), copy.sorted())
    }

    do {
      // Given
      var elements = [1, 2, 3, 1]
      let copy = elements
      // When
      elements.shuffle()
      // Then
      XCTAssertEqual(elements.count, copy.count)
      XCTAssertEqual(elements.sorted(), copy.sorted())
    }

    do {
      // Given
      var elements: [Any] = [1, "robots", 3, 1.11]
      let copy = elements
      // When
      elements.shuffle()
      // Then
      XCTAssertEqual(elements.count, copy.count)
      let beforeShuffle = NSArray(array: copy)
      let afterShuffle = NSArray(array: elements)
      let unexeptectedElements = afterShuffle.filter { !beforeShuffle.contains($0) }
      XCTAssertEqual(unexeptectedElements.count, 0)
    }
  }

  func testShuffled() {
    do {
      // Given, When
      let elements = ["a"]
      let shuffled =  elements.shuffled()

      // Then
      XCTAssertEqual(elements.count, shuffled.count)
      XCTAssertEqual(elements.sorted(), shuffled.sorted())
    }

    do {
      // Given, When
      let elements = [1, 2, 3, 1]
      let shuffled = elements.shuffled()

      // Then
      XCTAssertEqual(elements.count, shuffled.count)
      XCTAssertEqual(elements.sorted(), shuffled.sorted())
    }

    do {
      // Given, When
      let elements: [Any] = [1, "robots", 3, 1.11]
      let shuffled = elements.shuffled()

      // Then
      XCTAssertEqual(elements.count, shuffled.count)
      let beforeShuffle = NSArray(array: elements)
      let afterShuffle = NSArray(array: shuffled)
      let unexeptectedElements = afterShuffle.filter { !beforeShuffle.contains($0) }
      XCTAssertEqual(unexeptectedElements.count, 0)
    }
  }

}
