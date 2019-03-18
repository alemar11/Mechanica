//
// Mechanica
//
// Copyright © 2016-2019 Tinrobots.
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

extension NSPredicateUtilsTests {
  static var allTests = [
    ("testAlwaysTrueAndFalsePredicates", testAlwaysTrueAndFalsePredicates),
    ("testOperators", testOperators)
  ]
}

final class NSPredicateUtilsTests: XCTestCase {

  func testAlwaysTrueAndFalsePredicates() {
    XCTAssertEqual(NSPredicate.true.predicateFormat, "TRUEPREDICATE")
    XCTAssertEqual(NSPredicate.false.predicateFormat, "FALSEPREDICATE")
  }

  // TODO: - Not implemented on Linux:
  //    "NSPredicate.init(format:_:) is not yet implemented."
  // https://github.com/apple/swift-corelibs-foundation/blob/master/Foundation/NSPredicate.swift
  // Not implemented on Swift 5

  func testPredicateComposition() {
    do {
      let predicate = NSPredicate(format: "X = 10").and(NSPredicate(format: "Y = 30"))
      XCTAssertTrue(predicate == NSPredicate(format: "X = 10 AND Y = 30"))
    }
    do {
      let predicate = NSPredicate(format: "Z = 20").or(NSPredicate(format: "K = 40"))
      XCTAssertTrue(predicate == NSPredicate(format: "Z = 20 OR K = 40"))
    }
    do {
      let predicate1 = NSPredicate(format: "X = 10").and(NSPredicate(format: "Y = 30")) // X = 10 AND Y = 30
      let predicate2 = NSPredicate(format: "Z = 20").or(NSPredicate(format: "K = 40"))  // Z = 20 OR K = 40
      let predicate3 = predicate1.and(predicate2)
      XCTAssertTrue(predicate3.description == "(X == 10 AND Y == 30) AND (Z == 20 OR K == 40)")
    }
    do {
      let predicate1 = NSPredicate(format: "X = 10").and(NSPredicate(format: "Y = 30")) // X = 10 AND Y = 30
      let predicate2 = NSPredicate(format: "Z = 20").or(NSPredicate(format: "K = 40"))  // Z = 20 OR K = 40
      let predicate3 = predicate1.or(predicate2)
      XCTAssertTrue(predicate3.description == "(X == 10 AND Y == 30) OR (Z == 20 OR K == 40)")
    }
    do {
      let predicate1 = NSPredicate(format: "X = 10 AND V = 11").and(NSPredicate(format: "Y = 30 OR W = 5"))
      let predicate2 = NSPredicate(format: "Z = 20").or(NSPredicate(format: "K = 40 AND C = 11"))
      let predicate3 = predicate1.or(predicate2)
      XCTAssertTrue(predicate3.description == "((X == 10 AND V == 11) AND (Y == 30 OR W == 5)) OR (Z == 20 OR (K == 40 AND C == 11))")
    }
  }

  #if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
  // TODO: - Not implemented on Linux:
  //    "NSPredicate.init(format:_:) is not yet implemented."
  // https://github.com/apple/swift-corelibs-foundation/blob/master/Foundation/NSPredicate.swift
  // Not implemented on Swift 5

  func testOperatorsExcludingLinux() {

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

    let textEqualToOne = NSPredicate(format: "text = %@", "one");
    let idGreaterThanFive = NSPredicate(format: "id > 5")
    let textsStartWithF = NSPredicate(format: "text BEGINSWITH[cd] 'f'")
    let textEndsWithE = NSPredicate(format: "text ENDSWITH[cd] 'e'")

    XCTAssert(tests.filter { textEqualToOne.evaluate(with: $0) }.count == 1)
    XCTAssert(NSArray(array: tests).filtered(using: idGreaterThanFive).count == 5)
    XCTAssert(NSArray(array: tests).filtered(using: textsStartWithF).count == 2)
    XCTAssert(NSArray(array: tests).filtered(using: textEndsWithE).count == 4)

    /// ! Operator
    XCTAssert(NSArray(array: tests).filtered(using: !textEqualToOne).count == 9)
    XCTAssert(NSArray(array: tests).filtered(using: !idGreaterThanFive).count == 5)
    XCTAssert(NSArray(array: tests).filtered(using: !textsStartWithF).count == 8)

    /// && Operator
    XCTAssert(NSArray(array: tests).filtered(using: !textsStartWithF && idGreaterThanFive).count == 5)
    XCTAssert(NSArray(array: tests).filtered(using: !textsStartWithF && !idGreaterThanFive).count == 3)
    XCTAssert(NSArray(array: tests).filtered(using: textsStartWithF && textEndsWithE).count == 1)
    XCTAssert(NSArray(array: tests).filtered(using: textEqualToOne && idGreaterThanFive).count == 0)

    /// || Operator
    XCTAssert(NSArray(array: tests).filtered(using: !textsStartWithF || idGreaterThanFive).count == 8)
    XCTAssert(NSArray(array: tests).filtered(using: textsStartWithF || !idGreaterThanFive).count == 5)
    XCTAssert(NSArray(array: tests).filtered(using: textEqualToOne || textEndsWithE).count == 4)
    XCTAssert(NSArray(array: tests).filtered(using: !textEqualToOne || textEndsWithE).count == 10)
  }

  #endif


  func testOperators() {

    final class Name : NSObject {
      let first: String
      let last: String

      init(first: String, last: String) {
        self.first = first
        self.last = last
        super.init()
      }

    }

    final class Contact : NSObject {
      let name: Name
      let email: String
      let phone: String

      init(name: Name, email: String, phone: String) {
        self.name = name
        self.email = email
        self.phone = phone
        super.init()
      }

    }

    // Given
    let contacts = [
      Contact(name: Name(first: "Steve", last: "Jobs"), email: "jobs@apple.com", phone: "555-555-5555"),
      Contact(name: Name(first: "Tim", last: "Cook"), email: "cook@apple.com", phone: "555-555-5556"),
      Contact(name: Name(first: "Alessandro", last: "Marzoli"), email: "alessandro@tinrobots.org", phone: "555-555-5557"),
      Contact(name: Name(first: "Andrea", last: "Marzoli"), email: "andrea@tinrobots.org", phone: "555-555-5558")
    ]

    let nameEqualToAlessandro = NSPredicate { (contact, _) -> Bool in
      guard let contact = contact else { return false }
      guard contact is Contact else {
        XCTFail()
        fatalError()
      }

      return (contact as! Contact).name.first == "Alessandro"
    }

    let emailEqualToApple = NSPredicate { (contact, _) -> Bool in
      guard let contact = contact else { return false }
      guard contact is Contact else {
        XCTFail()
        fatalError()
      }

      return (contact as! Contact).email.hasSuffix("apple.com")
    }

    // When, Then
    let orPredicate = nameEqualToAlessandro || emailEqualToApple
    XCTAssert(contacts.filter { orPredicate.evaluate(with: $0) }.count == 3)

    let andPredicate = nameEqualToAlessandro && emailEqualToApple
    XCTAssert(contacts.filter { andPredicate.evaluate(with: $0) }.count == 0)

    let notWithAndPredicate = !nameEqualToAlessandro && emailEqualToApple
    XCTAssert(contacts.filter { notWithAndPredicate.evaluate(with: $0) }.count == 2)
  }

}
