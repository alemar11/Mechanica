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

class NSPredicateUtilsTests: XCTestCase {
  
  static var allTests = [
    //("testPredicateComposition", testPredicateComposition),
    //("testOperators", testOperators),
     ("test3", test3)
  ]
  
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
  
//  func testOperators() {
//
//    final class TestClass: NSObject {
//      @objc let id: Int
//      @objc let text: String
//
//      init(id: Int, text: String) {
//        self.id = id
//        self.text = text
//      }
//
//      override var description: String {
//        return ("\(id),\(text)")
//      }
//    }
//
//    let tests = [
//      TestClass(id:1, text: "one"),
//      TestClass(id:2, text: "two"),
//      TestClass(id:3, text: "three"),
//      TestClass(id:4, text: "four"),
//      TestClass(id:5, text: "five"),
//      TestClass(id:6, text: "six"),
//      TestClass(id:7, text: "seven"),
//      TestClass(id:8, text: "eight"),
//      TestClass(id:9, text: "nine"),
//      TestClass(id:10, text: "ten")
//    ]
//
//    let textEqualToOne_predicate: NSPredicate
//    #if os(Linux)
//      textEqualToOne_predicate = NSPredicate(format: "text = %@", "one" as! CVarArg);
//    #else
//      textEqualToOne_predicate = NSPredicate(format: "text = %@", "one");
//    #endif
//    let idGreaterThan5_predicate = NSPredicate(format: "id > 5")
//    let textsStartWithF_predicate = NSPredicate(format: "text BEGINSWITH[cd] 'f'")
//    let textEndsWithE_predicate = NSPredicate(format: "text ENDSWITH[cd] 'e'")
//
//    do {
//      //let result = NSArray(array: tests).filtered(using: textEqualToOne_predicate)
//      let result = tests.filter { textEqualToOne_predicate.evaluate(with: $0) }
//      XCTAssert(result.count == 1)
//    }
//
//    do {
//      let result = NSArray(array: tests).filtered(using: idGreaterThan5_predicate)
//      XCTAssert(result.count == 5)
//    }
//
//    do {
//      let result = NSArray(array: tests).filtered(using: textsStartWithF_predicate)
//      XCTAssert(result.count == 2)
//    }
//
//    do {
//      let result = NSArray(array: tests).filtered(using: textEndsWithE_predicate)
//      XCTAssert(result.count == 4)
//    }
//
//    /// ! Operator
//    do {
//      let result = NSArray(array: tests).filtered(using: !textEqualToOne_predicate)
//      XCTAssert(result.count == 9)
//    }
//
//    do {
//      let result = NSArray(array: tests).filtered(using: !idGreaterThan5_predicate)
//      XCTAssert(result.count == 5)
//    }
//
//    do {
//      let result = NSArray(array: tests).filtered(using: !textsStartWithF_predicate)
//      XCTAssert(result.count == 8)
//    }
//
//
//    /// && Operator
//
//    do {
//      let result = NSArray(array: tests).filtered(using: !textsStartWithF_predicate && idGreaterThan5_predicate)
//      XCTAssert(result.count == 5)
//    }
//
//    do {
//      let result = NSArray(array: tests).filtered(using: !textsStartWithF_predicate && !idGreaterThan5_predicate)
//      XCTAssert(result.count == 3)
//    }
//
//    do {
//      let result = NSArray(array: tests).filtered(using: textsStartWithF_predicate && textEndsWithE_predicate)
//      XCTAssert(result.count == 1)
//    }
//
//    do {
//      let result = NSArray(array: tests).filtered(using: textEqualToOne_predicate && idGreaterThan5_predicate)
//      XCTAssert(result.count == 0)
//    }
//
//    /// || Operator
//
//    do {
//      let result = NSArray(array: tests).filtered(using: !textsStartWithF_predicate || idGreaterThan5_predicate)
//      XCTAssert(result.count == 8)
//    }
//
//    do {
//      let result = NSArray(array: tests).filtered(using: textsStartWithF_predicate || !idGreaterThan5_predicate)
//      XCTAssert(result.count == 5)
//    }
//
//    do {
//      let result = NSArray(array: tests).filtered(using: textEqualToOne_predicate || textEndsWithE_predicate)
//      XCTAssert(result.count == 4)
//    }
//
//    do {
//      let result = NSArray(array: tests).filtered(using: !textEqualToOne_predicate || textEndsWithE_predicate)
//      XCTAssert(result.count == 10)
//    }
//
//  }

  class Name : NSObject {
    let first: String
    let last: String

    init(first: String, last: String) {
      self.first = first
      self.last = last

      super.init()
    }

    override var description: String {
      return "\(last), \(first)"
    }
  }

  class Contact : NSObject {
    let name: Name
    let email: String
    let phone: String

    init(name: Name, email: String, phone: String) {
      self.name = name
      self.email = email
      self.phone = phone

      super.init()
    }

    override var description: String {
      return "\(name), \(email), \(phone)"
    }
  }
  
  func test3() {
    let contacts = NSArray(array:[
      Contact(name: Name(first: "Donald", last: "Robot"), email: "donald@test.com", phone: "555-555-5555"),
      Contact(name: Name(first: "Melania", last: "Robot"), email: "melania@test.com", phone: "555-555-5556"),
      Contact(name: Name(first: "Mike", last: "Pence"), email: "mike@tinrobots.org", phone: "555-555-5557"),
      Contact(name: Name(first: "Karen", last: "Pence"), email: "karen@tinrobots.org", phone: "555-555-5558")
      ])
    
    let emailPredicate = NSPredicate(format: "email contains 'tinrobots.org'")
    let whContacts = contacts.filtered(using: emailPredicate)
    //print(whContacts)
    
    let lastNamePredicate = NSPredicate(format: "%K = %@", "name.last" as! CVarArg, "Robot" as! CVarArg)
    let trumpContacts = contacts.filtered(using: lastNamePredicate)
    //print(trumpContacts)
    
  }
}
