//
//  RangeReplaceableCollectionUtilsTests.swift
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

class RangeReplaceableCollectionUtilsTests: XCTestCase {

  func testRemoveFirst() {
    var all = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10] // 11 elements

    /// removes the first even Int
    let removedElement = all.removeFirst { $0.isEven }
    XCTAssertNotNil(removedElement)
    XCTAssertTrue(removedElement! == 0)
    XCTAssertTrue(all.count == 10)
    XCTAssertTrue(all == [1, 2, 3, 4, 5, 6, 7, 8, 9, 10])

    let removedElement2 = all.removeFirst { $0 == 11 }
    XCTAssertNil(removedElement2)
    XCTAssertTrue(all.count == 10)
    XCTAssertTrue(all == [1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
  }

  func testRemovingFirst() {
    let all = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10] // 11 elements

    do {
      let newAll = all.removingFirst { $0.isEven }
      XCTAssertTrue(newAll.count == 10)
      XCTAssertTrue(newAll == [1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
      XCTAssertTrue(all.count == 11)
    }

    do {
      let newAll = all.removingFirst { $0 == 11 }
      XCTAssertTrue(newAll.count == 11)
      XCTAssertTrue(newAll == newAll)
    }

  }

  func testRemoveLast() {
    var all = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10] // 11 elements

    /// removes the first even Int
    let removedElement = all.removeLast { $0.isEven  }
    XCTAssertNotNil(removedElement)
    XCTAssertTrue(removedElement! == 10)
    XCTAssertTrue(all.count == 10)
    XCTAssertTrue(all == [0, 1, 2, 3, 4, 5, 6, 7, 8, 9])

    let removedElement2 = all.removeLast { $0 == 11 }
    XCTAssertNil(removedElement2)
    XCTAssertTrue(all.count == 10)
    XCTAssertTrue(all == [0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
  }

  func testRemovingLast() {
    let all = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10] // 11 elements

    do {
      let newAll = all.removingLast { $0.isEven }
      XCTAssertTrue(newAll.count == 10)
      XCTAssertTrue(newAll == [0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
      XCTAssertTrue(all.count == 11)
    }

    do {
      let newAll = all.removingLast { $0 == 11 }
      XCTAssertTrue(newAll.count == 11)
      XCTAssertTrue(newAll == newAll)
    }

  }

  func testRemoveAll() {
    var all = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10] // 11 elements

    /// removes the first even Int
    let removedElements = all.removeAll { $0.isEven  }
    XCTAssertNotNil(removedElements)
    XCTAssertTrue(removedElements == [0, 2, 4, 6, 8, 10])
    XCTAssertTrue(all.count == 5)
    XCTAssertTrue(all == [1, 3, 5, 7, 9])

    let removedElements2 = all.removeFirst { $0 == 11 }
    XCTAssertNil(removedElements2)
    XCTAssertTrue(all.count == 5)
    XCTAssertTrue(all == [1, 3, 5, 7, 9])
  }

  func testRemovingAll() {
    let all = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10] // 11 elements

    do {
      let newAll = all.removingAll { $0.isEven }
      XCTAssertTrue(newAll == [1, 3, 5, 7, 9])
      XCTAssertTrue(all.count == 11)
    }

    do {
      let newAll = all.removingAll { $0 == 11 }
      XCTAssertTrue(newAll.count == 11)
      XCTAssertTrue(newAll == newAll)
    }

  }


  // MARK - Equatable

  func testRemoveFirstOccurrence() {

    do {
      var array = ["a", "b", "c", "c", "d", "e", "f", "g", "a", "a"]
      let occurrence = array.removeFirstOccurrence(of: "a")
      XCTAssertTrue(occurrence == "a")
      XCTAssertTrue(array == ["b", "c", "c", "d", "e", "f", "g", "a", "a"])
      let occurrence2 = array.removeFirstOccurrence(of: "c")
      XCTAssertTrue(occurrence2 == "c")
      XCTAssertTrue(array == ["b", "c", "d", "e", "f", "g", "a", "a"])
    }

    do {
      var array = ["a", "b", "c", "c", "d", "e", "f", "g", "a", "a"]
      let occurrence = array.removeFirstOccurrence(of: "k")
      XCTAssertNil(occurrence)
      XCTAssertTrue(array == ["a", "b", "c", "c", "d", "e", "f", "g", "a", "a"])
      let occurrence2 = array.removeFirstOccurrence(of: "a")
      XCTAssertTrue(occurrence2 == "a")
      XCTAssertTrue(array == ["b", "c", "c", "d", "e", "f", "g", "a", "a"])
    }

    do {
      var array = [1, 2, 3, 4, 3, 1, 1, 5, 2, 6]
      let occurrence = array.removeFirstOccurrence(of: 3)
      XCTAssertTrue(occurrence == 3)
      XCTAssertTrue(array == [1, 2, 4, 3, 1, 1, 5, 2, 6])
      let occurrence2 = array.removeFirstOccurrence(of: 3)
      XCTAssertTrue(occurrence2 == 3)
      XCTAssertTrue(array == [1, 2, 4, 1, 1, 5, 2, 6])
    }

  }

  func testRemoveLastOccurrence() {

    do {
      var array = ["a", "b", "c", "c", "d", "e", "f", "g", "a", "a"]
      let occurrence = array.removeLastOccurrence(of: "a")
      XCTAssertTrue(occurrence == "a")
      XCTAssertTrue(array == ["a", "b", "c", "c", "d", "e", "f", "g", "a"])
      let occurrence2 = array.removeLastOccurrence(of: "c")
      XCTAssertTrue(occurrence2 == "c")
      XCTAssertTrue(array == ["a", "b", "c", "d", "e", "f", "g", "a"])
    }

    do {
      var array = ["a", "b", "c", "c", "d", "e", "f", "g", "a", "a"]
      let occurrence = array.removeLastOccurrence(of: "k")
      XCTAssertNil(occurrence)
      XCTAssertTrue(array == ["a", "b", "c", "c", "d", "e", "f", "g", "a", "a"])
      let occurrence2 = array.removeLastOccurrence(of: "a")
      XCTAssertTrue(occurrence2 == "a")
      XCTAssertTrue(array == ["a", "b", "c", "c", "d", "e", "f", "g", "a"])
    }

    do {
      var array = [1, 2, 3, 4, 3, 1, 1, 5, 2, 6]
      let occurrence = array.removeLastOccurrence(of: 3)
      XCTAssertTrue(occurrence == 3)
      XCTAssertTrue(array == [1, 2, 3, 4, 1, 1, 5, 2, 6])
      let occurrence2 = array.removeLastOccurrence(of: 3)
      XCTAssertTrue(occurrence2 == 3)
      XCTAssertTrue(array == [1, 2, 4, 1, 1, 5, 2, 6])
    }

  }

  //  func testRemovingLastPerformance() {
  //    var array = [Int]()
  //    for i in stride(from: 0, to: 1_000_000, by: 1) {
  //      array.append(i)
  //    }
  //    self.measure {
  //      for _ in 1...10{
  //        let _ = array.removingLast(where: {$0 == 23})
  //      }
  //    }
  //  }

}
