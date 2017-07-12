//
//  NSPredicateUtilsTests.swift
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

class NSPredicateUtilsTests: XCTestCase {
    
  func testPredicateComposition() {
    do {
      let predicate = NSPredicate(format: "X = 10").andPredicate(NSPredicate(format: "Y = 30"))
      XCTAssertTrue(predicate == NSPredicate(format: "X = 10 AND Y = 30"))
    }
    do {
      let predicate = NSPredicate(format: "Z = 20").orPredicate(NSPredicate(format: "K = 40"))
      XCTAssertTrue(predicate == NSPredicate(format: "Z = 20 OR K = 40"))
    }
    do {
      let predicate1 = NSPredicate(format: "X = 10").andPredicate(NSPredicate(format: "Y = 30")) // X = 10 AND Y = 30
      let predicate2 = NSPredicate(format: "Z = 20").orPredicate(NSPredicate(format: "K = 40"))  // Z = 20 OR K = 40
      let predicate3 = predicate1.andPredicate(predicate2)
      XCTAssertTrue(predicate3.description == "(X == 10 AND Y == 30) AND (Z == 20 OR K == 40)")
    }
    do {
      let predicate1 = NSPredicate(format: "X = 10").andPredicate(NSPredicate(format: "Y = 30")) // X = 10 AND Y = 30
      let predicate2 = NSPredicate(format: "Z = 20").orPredicate(NSPredicate(format: "K = 40"))  // Z = 20 OR K = 40
      let predicate3 = predicate1.orPredicate(predicate2)
      XCTAssertTrue(predicate3.description == "(X == 10 AND Y == 30) OR (Z == 20 OR K == 40)")
    }
    do {
      let predicate1 = NSPredicate(format: "X = 10 AND V = 11").andPredicate(NSPredicate(format: "Y = 30 OR W = 5"))
      let predicate2 = NSPredicate(format: "Z = 20").orPredicate(NSPredicate(format: "K = 40 AND C = 11"))
      let predicate3 = predicate1.orPredicate(predicate2)
      XCTAssertTrue(predicate3.description == "((X == 10 AND V == 11) AND (Y == 30 OR W == 5)) OR (Z == 20 OR (K == 40 AND C == 11))")
    }
  }
    
}
