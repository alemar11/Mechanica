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

extension SequenceUtilsTests {
  static var allTests = [
    ("testHasSome", testHasSome),
    ("testHasAll", testHasAll),
    ("testContains", testContains),
    ("testContatinsObjectIdentical", testContatinsObjectIdentical),
    ("testCount", testCount),
    ("testGroupedBy", testGroupedBy),
    ("testFrequencies", testFrequencies),
    ("testShuffled", testShuffled),
    ("testUniqueElements", testUniqueElements)
  ]
}

class SequenceUtilsTests: XCTestCase {

  private struct Demo {
    let value1: String
    let value2: Int
  }

  private class DemoObject {
    let value1: String
    let value2: Int

    init(value1: String, value2: Int) {
      self.value1 = value1
      self.value2 = value2
    }
  }

  private let list = [Demo(value1: "demo1",value2: 1),
                      Demo(value1: "demo2",value2: 2),
                      Demo(value1: "demo3",value2: 3),
                      Demo(value1: "demo4",value2: 1),
                      Demo(value1: "demo5",value2: 2),
                      Demo(value1: "demo6",value2: 3)]


  private let list2 = [Demo(value1: "demo1",value2: 1),
                       Demo(value1: "demo1",value2: 1),
                       Demo(value1: "demo1",value2: 1),
                       Demo(value1: "demo1",value2: 1),
                       Demo(value1: "demo1",value2: 1),
                       Demo(value1: "demo1",value2: 1)]

  private let list3 = ["a": 0, "b": 1, "c": 2, "d": 3, "e": 4, "f": 5, "g": 6, "h": 7, "i": 8, "l": 9, "m": 10]

  func testHasSome() {

    XCTAssertTrue(list.hasSomeElements(where: {$0.value1 == "demo5"}))
    XCTAssertTrue(list.hasSomeElements(where: {$0.value2 == 1}))
    XCTAssertTrue(list2.hasSomeElements(where: {$0.value1 == "demo1"}))
    XCTAssertFalse(list.hasSomeElements(where: {$0.value1 == "demo11"}))
    XCTAssertFalse(list.hasSomeElements(where: { $0.value1 == "demo1" && $0.value2 == 4}))
  }

  func testHasAll() {
    XCTAssertTrue(list2.hasAllElements{$0.value1 == "demo1"})
    XCTAssertFalse(list2.hasAllElements{$0.value1 == "demo11"})
    XCTAssertFalse(list.hasAllElements{$0.value1 == "demo12"})
  }

  func testContains() {
    let array1 = [1, 2, 3, 4, 5]
    let array2 = [1, 8, 0]
    let array3 = [1,5, 4]
    let array4 = [1, 4, 0, 8, 5, 9]
    let emptyArray =  [Int]()

    XCTAssertTrue(emptyArray.contains(emptyArray))
    XCTAssertFalse(emptyArray.contains(array1))
    XCTAssertTrue(array1.contains(emptyArray))
    XCTAssertFalse(array1.contains(array2))
    XCTAssertTrue(array1.contains(array3))
    XCTAssertTrue(array1.contains(array1))
    XCTAssertFalse(array3.contains(array1))
    XCTAssertTrue(array4.contains(array2))
    XCTAssertTrue(array4.contains(array3))
    XCTAssertFalse(array2.contains(array4))
    XCTAssertFalse(array3.contains(array4))
  }

  // MARK: - AnyObject

  func testContatinsObjectIdentical() {
    // Given, When
    var list = [DemoObject(value1: "demo1",value2: 1),
                DemoObject(value1: "demo2",value2: 2),
                DemoObject(value1: "demo3",value2: 3),
                DemoObject(value1: "demo4",value2: 1),
                DemoObject(value1: "demo5",value2: 2),
                DemoObject(value1: "demo6",value2: 3)]

    let demoObject = DemoObject(value1: "demo1",value2: 1)
    // Then
    XCTAssertFalse(list.containsObjectIdentical(to: demoObject))
    // When
    list.append(demoObject)
    // Then
    XCTAssertTrue(list.containsObjectIdentical(to: demoObject))
    // When
    list.append(demoObject)
    // Then
    XCTAssertTrue(list.containsObjectIdentical(to: demoObject))
  }

  func testCount() {
    XCTAssertEqual(list.count{ $0.value2 == 1 }, 2)
    XCTAssertEqual(list.count{ $0.value2 == 3 }, 2)
    XCTAssertEqual(list.count{ $0.value2 == 4 }, 0)
    XCTAssertEqual(list.count{ $0.value1 == "demo1" }, 1)
    XCTAssertEqual(list3.count { $0.0 == "a" }, 1)
    XCTAssertEqual(list3.count { $0.0 == "z" }, 0)
    XCTAssertEqual(list3.count { $0.0 == "a" &&  $0.1 == 0 }, 1)
    XCTAssertEqual(list3.count { $0.0 == "a" &&  $0.1 == 1 }, 0)
    XCTAssertEqual(list3.count { $0.1 % 2 == 0 }, 6)
    XCTAssertEqual(list3.count { $0.1 % 2 != 0 }, 5)
  }

  func testGroupedBy() {
    do {
      // Given
      let array = ["1", "1", "2", "3", "3", "1", "4"]
      // When
      let groupedDictionary = array.grouped(by: { return $0 } ) //[ "1" : ["1", "1", "1"], "2" : ["2"], "3" : ["3", "3"], "4" : ["4"] ]
      // Then
      XCTAssertNotNil(groupedDictionary)
      XCTAssertEqual(groupedDictionary.keys.count, 4)
      XCTAssertNotNil(groupedDictionary["1"])
      XCTAssertNotNil(groupedDictionary["1"]! == ["1", "1", "1"])
      XCTAssertNotNil(groupedDictionary["2"])
      XCTAssertNotNil(groupedDictionary["2"]! == ["2"])
      XCTAssertNotNil(groupedDictionary["3"])
      XCTAssertNotNil(groupedDictionary["3"]! == ["3", "3"])
      XCTAssertNotNil(groupedDictionary["4"])
      XCTAssertNotNil(groupedDictionary["4"]! == ["4"])

      let dictionary =  Dictionary(grouping: array, by: { return $0 })
      XCTAssert(groupedDictionary.keys == dictionary.keys)
      groupedDictionary.keys.forEach { key in
        XCTAssertTrue(groupedDictionary[key]! == dictionary[key]!)
      }
    }

    do {
      // Given
      let array = ["aaa", "aab", "1", "ccc", "ccb"]
      // When
      let groupedDictionary = array.grouped(by: { return $0.first! }) //[ "a" : ["aaa", "aab"], "1" : ["1"], "c" : ["ccc", "ccb"] ]
      // Then
      XCTAssertNotNil(groupedDictionary)
      XCTAssertTrue(groupedDictionary.keys.count == 3)
      XCTAssertNotNil(groupedDictionary["a"])
      XCTAssertTrue(groupedDictionary["a"]! == ["aaa", "aab"])
      XCTAssertNotNil(groupedDictionary["1"])
      XCTAssertTrue(groupedDictionary["1"]! == ["1"])
      XCTAssertNotNil(groupedDictionary["c"])
      XCTAssertTrue(groupedDictionary["c"]! == ["ccc", "ccb"])

      let dictionary =  Dictionary(grouping: array, by: { return $0.first! })
      XCTAssert(groupedDictionary.keys == dictionary.keys)
      groupedDictionary.keys.forEach { key in
        XCTAssertTrue(groupedDictionary[key]! == dictionary[key]!)
      }
    }

    do {
      // Given
      let array = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
      // When
      let groupedDictionary = array.grouped(by: { return ($0 % 2 == 0) ? "even" : "odd" })
      // Then
      XCTAssertNotNil(groupedDictionary)
      XCTAssertTrue(groupedDictionary.keys.count == 2)
      XCTAssertNotNil(groupedDictionary["even"])
      XCTAssertTrue(groupedDictionary["even"]! == [0, 2, 4, 6, 8, 10])
      XCTAssertNotNil(groupedDictionary["odd"])
      XCTAssertTrue(groupedDictionary["odd"]! == [1, 3, 5, 7, 9])

      enum Parity: CustomStringConvertible {
        case even, odd
        init(_ value: Int) {
          self = value % 2 == 0 ? .even : .odd
        }
        var description: String {
          return self == .even ? "even" : "odd"
        }
      }

      let dictionary = Dictionary(grouping: array , by: Parity.init )
      XCTAssert(groupedDictionary.keys.count == dictionary.keys.count)
      XCTAssert(groupedDictionary["even"]! == dictionary[Parity.even]!)
      XCTAssert(groupedDictionary["odd"]! == dictionary[Parity.odd]!)

      groupedDictionary.keys.forEach { key in
        let parityKey = key == "even" ? Parity.even : Parity.odd
        XCTAssertTrue(groupedDictionary[key]! == dictionary[parityKey]!)
      }
    }
  }

  func testFrequencies() {
    do {
      // Given
      let array = [1, 2, 3, 4, 5, 3, 6, 1]
      // When
      let frequencies = array.frequencies
      // Then
      XCTAssertTrue(frequencies.count == 6)

      for tuple in frequencies {
        switch tuple {
        case (3, 2), (1, 2), (5, 1), (6, 1), (2, 1), (4, 1):
          continue
        default:
          XCTFail("This frequency \(tuple) should not be present.")
        }
      }
    }
  }

  func testShuffled() {
    do {
      // Given
      let elements = [2, 1, 3, 4, 7, 1, 5, 4, 4, 1]
      // When
      let shuffled = elements.shuffled()
      // Then
      XCTAssertEqual(elements.count, shuffled.count)
      XCTAssertEqual(elements.sorted(), shuffled.sorted())
    }

    do {
      // Given
      let elements: [Any] = ["robots", 1, 3.3333, 4, 7, 1, 5, 4, 4, 1]
      let copy = elements
      // When
      let shuffled = elements.shuffled()
      // Then
      XCTAssertEqual(elements.count, shuffled.count)
      let afterShuffle = NSArray(array: elements)
      let beforeShuffle = NSArray(array: copy)
      let unexeptectedElements = afterShuffle.filter { !beforeShuffle.contains($0) }
      XCTAssertEqual(unexeptectedElements.count, 0)
    }
  }


  struct Sample: Equatable {
    let value: String

    static func ==(lhs: Sample, rhs: Sample) -> Bool {
      return lhs.value == rhs.value
    }

  }

  func testUniqueElements() {

    do {
      let array = [2, 1, 3, 4, 7, 1, 5, 4, 4, 1]
      let uniqueElements = array.uniqueElements()
      XCTAssertEqual(uniqueElements.count, 6)
      XCTAssertEqual(uniqueElements, [2, 1, 3, 4, 7, 5])
    }

    do {
      let array = [1, 2, 3, 4, 5, 3, 6, 1]
      let uniqueElements = array.uniqueElements()
      XCTAssertEqual(uniqueElements.count, 6)
      XCTAssertEqual(uniqueElements, [1, 2, 3, 4, 5, 6])
    }

    do {
      let array = [Int]()
      let uniqueElements = array.uniqueElements()
      XCTAssertEqual(uniqueElements.count, 0)
      XCTAssertEqual(uniqueElements, [])
    }

    do {
      let array = [1, 1, 1, 1, 1, 1, 1]
      let uniqueElements = array.uniqueElements()
      XCTAssertEqual(uniqueElements.count, 1)
      XCTAssertEqual(uniqueElements, [1])
    }

    do {
      let array = [Sample(value: "1"), Sample(value: "1"), Sample(value: "1"), Sample(value: "3"), Sample(value: "2")]
      let uniqueElements = array.uniqueElements()
      XCTAssertEqual(uniqueElements.count, 3)
      XCTAssertEqual(uniqueElements, [Sample(value: "1"), Sample(value: "3"), Sample(value: "2")])
    }

  }

}
