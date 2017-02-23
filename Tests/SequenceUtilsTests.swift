//
//  SequenceUtilsTests.swift
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

  func test_findFirstOccurrence() {

    let occurrence1 = list.findFirstOccurence(where: {$0.value2 == 3})
    XCTAssertTrue(occurrence1 != nil)
    XCTAssertTrue(occurrence1!.value1 == "demo3")

    let occurrence2 = list.findFirstOccurence(where: {$0.value2 == 11})
    XCTAssertFalse(occurrence2 != nil)

  }

  func test_hasSomeOccurrences() {
    XCTAssertTrue(list.hasSomeOccurrences(where: {$0.value1 == "demo5"}))
    XCTAssertTrue(list.hasSomeOccurrences(where: {$0.value2 == 1}))
    XCTAssertTrue(list2.hasSomeOccurrences(where: {$0.value1 == "demo1"}))

    XCTAssertFalse(list.hasSomeOccurrences(where: {$0.value1 == "demo11"}))
    XCTAssertFalse(list.hasSomeOccurrences(where: { $0.value1 == "demo1" && $0.value2 == 4}))
  }

  func test_hasAllOccurrences() {
    XCTAssertTrue(list2.hasAllOccurrences{$0.value1 == "demo1"})
    XCTAssertFalse(list2.hasAllOccurrences{$0.value1 == "demo11"})
    XCTAssertFalse(list.hasAllOccurrences{$0.value1 == "demo12"})
  }

  // MARK: - AnyObject

  func test_contatinsObjectIdentical() {


    var list = [DemoObject(value1: "demo1",value2: 1),
                 DemoObject(value1: "demo2",value2: 2),
                 DemoObject(value1: "demo3",value2: 3),
                 DemoObject(value1: "demo4",value2: 1),
                 DemoObject(value1: "demo5",value2: 2),
                 DemoObject(value1: "demo6",value2: 3)]

    let demoObject = DemoObject(value1: "demo1",value2: 1)
    XCTAssertFalse(list.containsObjectIdentical(to: demoObject))
    list.append(demoObject)
    XCTAssertTrue(list.containsObjectIdentical(to: demoObject))

  }

  func test_groupedBy() {

    let array = ["1", "1", "2", "3", "3", "1", "4"]
    let groupedDictionary = array.grouped(by: { return $0 } ) //[ "1" : ["1", "1", "1"], "2" : ["2"], "3" : ["3", "3"], "4" : ["4"] ]
    XCTAssertNotNil(groupedDictionary)
    XCTAssertTrue(groupedDictionary.keys.count == 4)
    XCTAssertNotNil(groupedDictionary["1"])
    XCTAssertNotNil(groupedDictionary["1"]! == ["1", "1", "1"])
    XCTAssertNotNil(groupedDictionary["2"])
    XCTAssertNotNil(groupedDictionary["2"]! == ["2"])
    XCTAssertNotNil(groupedDictionary["3"])
    XCTAssertNotNil(groupedDictionary["3"]! == ["3", "3"])
    XCTAssertNotNil(groupedDictionary["4"])
    XCTAssertNotNil(groupedDictionary["4"]! == ["4"])

    let array2 = ["aaa", "aab", "1", "ccc", "ccb"]
    let groupedDictionary2 = array2.grouped(by: { return $0.first } ) //[ "a" : ["aaa", "aab"], "1" : ["1"], "c" : ["ccc", "ccb"] ]
    XCTAssertNotNil(groupedDictionary2)
    XCTAssertTrue(groupedDictionary2.keys.count == 3)
    XCTAssertNotNil(groupedDictionary2["a"])
    XCTAssertTrue(groupedDictionary2["a"]! == ["aaa", "aab"])
    XCTAssertNotNil(groupedDictionary2["1"])
    XCTAssertTrue(groupedDictionary2["1"]! == ["1"])
    XCTAssertNotNil(groupedDictionary2["c"])
    XCTAssertTrue(groupedDictionary2["c"]! == ["ccc", "ccb"])

    let array3 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    let groupedDictionary3 = array3.grouped(by: {return ($0 % 2 == 0) ? "even" : "odd"})
    XCTAssertNotNil(groupedDictionary3)
    XCTAssertTrue(groupedDictionary3.keys.count == 2)
    XCTAssertNotNil(groupedDictionary3["even"])
    XCTAssertTrue(groupedDictionary3["even"]! == [0, 2, 4, 6, 8, 10])
    XCTAssertNotNil(groupedDictionary3["odd"])
    XCTAssertTrue(groupedDictionary3["odd"]! == [1, 3, 5, 7, 9])

  }

}
