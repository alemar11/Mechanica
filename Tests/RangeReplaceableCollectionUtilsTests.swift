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

  func test_removeFirst() {
    var all = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10] // 11 elements
    /// removes the first even Int
    let removedElement = all.removeFirst { (x) -> Bool in return (x.isEven) }
    XCTAssertNotNil(removedElement)
    XCTAssertTrue(removedElement! == 0)
    XCTAssertTrue(all.count == 10)
    XCTAssertTrue(all == [1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
  }

  func test_removingFirst() {
    let all = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10] // 11 elements
    let newAll = all.removingFirst { (x) -> Bool in return (x.isEven)}
    XCTAssertTrue(newAll.count == 10)
    XCTAssertTrue(newAll == [1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
    XCTAssertTrue(all.count == 11)
  }

  func test_removeLast() {
    var all = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10] // 11 elements
    /// removes the first even Int
    let removedElement = all.removeLast { (x) -> Bool in return (x.isEven) }
    XCTAssertNotNil(removedElement)
    XCTAssertTrue(removedElement! == 10)
    XCTAssertTrue(all.count == 10)
    XCTAssertTrue(all == [0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
  }

  func test_removingLast() {
    let all = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10] // 11 elements
    let newAll = all.removingLast { (x) -> Bool in return (x.isEven)}
    XCTAssertTrue(newAll.count == 10)
    XCTAssertTrue(newAll == [0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
    XCTAssertTrue(all.count == 11)

  }

  func test_removeAll() {
    var all = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10] // 11 elements
    /// removes the first even Int
    let removedElements = all.removeAll { (x) -> Bool in return (x.isEven) }
    XCTAssertNotNil(removedElements)
    XCTAssertTrue(removedElements == [0, 2, 4, 6, 8, 10])
    XCTAssertTrue(all.count == 5)
    XCTAssertTrue(all == [1, 3, 5, 7, 9])
  }

  func test_removingAll() {
    let all = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10] // 11 elements
    let newAll = all.removingAll { (x) -> Bool in return (x.isEven)}
    XCTAssertTrue(newAll == [1, 3, 5, 7, 9])
    XCTAssertTrue(all.count == 11)
  }


  func testPerformanceExample() {
    var array = [Int]()
    for i in stride(from: 0, to: 1_000_000, by: 1) {
      array.append(i)
    }
    self.measure {
      for _ in 1...10{
        let _ = array.removingLast(where: {$0 == 23})
      }
    }
  }

}
