//
//  NSPredicateOperatorsTests.swift
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

class NSPredicateOperatorsTests: XCTestCase {


  func testOperators() {

    final class TestClass: NSObject {
      @objc let id: Int
      @objc let text: String

      init(id: Int, text: String) {
        self.id = id
        self.text = text
      }

      override var description: String {
        return ("\(id),\(text)")
      }
    }

    let tests = [
      TestClass(id:1, text: "one"),
      TestClass(id:2, text: "two"),
      TestClass(id:3, text: "three"),
      TestClass(id:4, text: "four"),
      TestClass(id:5, text: "five"),
      TestClass(id:6, text: "six"),
      TestClass(id:7, text: "seven"),
      TestClass(id:8, text: "eight"),
      TestClass(id:9, text: "nine"),
      TestClass(id:10, text: "ten")
    ]

    let textEqualToOne_predicate = NSPredicate(format: "text = %@", "one");
    let idGreaterThan5_predicate = NSPredicate(format: "id > 5")
    let textsStartWithF_predicate = NSPredicate(format: "text BEGINSWITH[cd] 'f'")
    let textEndsWithE_predicate = NSPredicate(format: "text ENDSWITH[cd] 'e'")

    do {
      let result = (tests as NSArray).filtered(using: textEqualToOne_predicate)
      XCTAssert(result.count == 1)
    }

    do {
      let result = (tests as NSArray).filtered(using: idGreaterThan5_predicate)
      XCTAssert(result.count == 5)
    }

    do {
      let result = (tests as NSArray).filtered(using: textsStartWithF_predicate)
      XCTAssert(result.count == 2)
    }

    do {
      let result = (tests as NSArray).filtered(using: textEndsWithE_predicate)
      XCTAssert(result.count == 4)
    }

    /// ! Operator
    do {
      let result = (tests as NSArray).filtered(using: !textEqualToOne_predicate)
      XCTAssert(result.count == 9)
    }

    do {
      let result = (tests as NSArray).filtered(using: !idGreaterThan5_predicate)
      XCTAssert(result.count == 5)
    }

    do {
      let result = (tests as NSArray).filtered(using: !textsStartWithF_predicate)
      XCTAssert(result.count == 8)
    }


    /// && Operator

    do {
      let result = (tests as NSArray).filtered(using: !textsStartWithF_predicate && idGreaterThan5_predicate)
      XCTAssert(result.count == 5)
    }

    do {
      let result = (tests as NSArray).filtered(using: !textsStartWithF_predicate && !idGreaterThan5_predicate)
      XCTAssert(result.count == 3)
    }

    do {
      let result = (tests as NSArray).filtered(using: textsStartWithF_predicate && textEndsWithE_predicate)
      XCTAssert(result.count == 1)
    }

    do {
      let result = (tests as NSArray).filtered(using: textEqualToOne_predicate && idGreaterThan5_predicate)
      XCTAssert(result.count == 0)
    }

    /// || Operator

    do {
      let result = (tests as NSArray).filtered(using: !textsStartWithF_predicate || idGreaterThan5_predicate)
      XCTAssert(result.count == 8)
    }

    do {
      let result = (tests as NSArray).filtered(using: textsStartWithF_predicate || !idGreaterThan5_predicate)
      XCTAssert(result.count == 5)
    }

    do {
      let result = (tests as NSArray).filtered(using: textEqualToOne_predicate || textEndsWithE_predicate)
      XCTAssert(result.count == 4)
    }

    do {
      let result = (tests as NSArray).filtered(using: !textEqualToOne_predicate || textEndsWithE_predicate)
      XCTAssert(result.count == 10)
    }

  }

}
