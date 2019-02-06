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

extension CollectionUtilsTests {
  static var allTests = [
    ("testAtIndex", testAtIndex),
    ("testIndices", testIndices),
    ("testScan", testScan),
  ]
}

final class CollectionUtilsTests: XCTestCase {

  func testAtIndex() {
    let array: [Any] = [1, 2, "3", "4", 0]
    XCTAssertEqual(array.at(0)! as! Int, 1)
    XCTAssertEqual(array.at(1)! as! Int, 2)
    XCTAssertEqual(array.at(2)! as! String, "3")
    XCTAssertEqual(array.at(3)! as! String, "4")
    XCTAssertNil(array.at(5))
    XCTAssertNil(array.at(10))
    XCTAssertNil(array.at(100))
  }

  func testIndices() {
    do {
      let phrase = "tin robots"
      XCTAssertEqual(phrase.indices(of: "t"), [phrase.startIndex, phrase.index(phrase.startIndex, offsetBy: 8)])
      XCTAssertTrue(phrase.indices(of: "T").isEmpty)
    }

    do {
      let list = [1, 2, 1, 2, 3, 4, 5, 1]
      XCTAssertEqual(list.indices(of: 1), [0, 2, 7])
      XCTAssertTrue(list.indices(of: 0).isEmpty)
    }
  }

  func testScan() {
    var phrase = "tin robots"[...]
    XCTAssertEqual(phrase.scan(count: 4), "tin ")
    XCTAssertFalse(phrase.scan(prefix: "s"))
    XCTAssertTrue(phrase.scan(prefix: "r"))
    XCTAssertTrue(phrase.scan(prefix: "ob"))
    XCTAssertNil(phrase.scan({ $0 == Character("b") }))
    XCTAssertEqual(phrase.scan({ $0 == Character("o") }), Character("o"))

    var phrase2 = "🇮🇹🇮🇹🇮🇹"[...]
    XCTAssertEqual(phrase2.scan({ $0 == Character("🇮🇹") }), Character("🇮🇹"))

    var phrase3 = "tin robots"[...]
    var buffer: String = "" // = [Character]()
    phrase3.scan(upTo: { $0 == Character("o")}, into: &buffer)
    //print(phrase3)

//    do {
//      let scanner = Scanner(string: "tin robots")
//      var x: NSString?
//      let y = scanner.scanUpTo("obox", into: &x)
//      print(x)
//    }

    //print(buffer.reduce("") { $0 + String($1) })


    do {
      var phrase4 = "tin robots"[...]
      var buffer: String?
      phrase4.scan2(upTo: "obox", into: &buffer)

    }

    do {
      var list = [1, 2, 3, 4, 5][...]
      var buffer: [Int]? = []
      list.scan2(upTo: [3, 4], into: &buffer)

      XCTAssertEqual(list, [3, 4, 5])
      XCTAssertEqual(buffer, [1, 2])
    }

    do {
      var list = [1, 2, 3, 4, 5][...]
      var buffer: [Int]?
      list.scan2(upTo: [100, 1003], into: &buffer)

      XCTAssertEqual(list, [])
      XCTAssertEqual(buffer, [1, 2, 3, 4, 5])
    }

    do {
      var list = [Int]()[...]
      var buffer: [Int]?
      list.scan2(upTo: [3, 4], into: &buffer)

      XCTAssertEqual(list, [])
      XCTAssertEqual(buffer, nil)
    }

  }

}


