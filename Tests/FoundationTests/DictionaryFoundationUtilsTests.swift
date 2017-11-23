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

class DictionaryFoundationUtilsTests: XCTestCase {

  static var allTests = [
    ("testInitFromJSON", testInitFromJSON),
    ("testJSONString", testJSONString),
    ("testJSONData", testJSONData),
    ("testLowercaseAllKeys", testLowercaseAllKeys)
  ]

  func testInitFromJSON() {

    do {
      let string = "{\"foo\":\"bar\",\"val\":1}"
      let dictionary = Dictionary<String, Any>(json: string)
      XCTAssertNotNil(dictionary)

      let expectedDictionary: Dictionary<String, Any> = ["foo": "bar", "val": 1]
      let expectedDictionary2: Dictionary<String, Any> = ["foo": "bar", "val": Date()]
      XCTAssertTrue(NSDictionary(dictionary: dictionary!).isEqual(to: expectedDictionary)) //fails on linux
      print(NSDictionary(dictionary: dictionary!))
      print(expectedDictionary)
      XCTAssertFalse(NSDictionary(dictionary: dictionary!).isEqual(to: expectedDictionary2))
    }

    do {
      let string = "{\"foo\":\"bar\",\"val\":null}"
      let dictionary = Dictionary<String, Any?>(json: string)
      XCTAssertNotNil(dictionary)
      print(dictionary)
      XCTAssertTrue(dictionary!["val"]! == nil) //fails on linux
    }

    do {
      let invalidJSON = "tinrobots"
      let invalidDictionary = Dictionary<String, Any>(json: invalidJSON)
      XCTAssertNil(invalidDictionary)
    }

    do {
      let invalidJSON = "{\"foo\", \"bar\"}"
      let invalidDictionary = Dictionary<String, Any>(json: invalidJSON)
      XCTAssertNil(invalidDictionary)
    }

  }

  func testJSONString() {

    do {
      let string = "{\"foo\":\"bar\",\"val\":1}"
      let dictionary = Dictionary<String, Any>(json: string)
      XCTAssertNotNil(dictionary)
      let json = dictionary!.jsonString()
      XCTAssertTrue(( json == string) || (json == "{\"val\":1,\"foo\":\"bar\"}") )
      let jsonPretty = dictionary!.jsonString(prettify: true)
      XCTAssertTrue(( jsonPretty == "{\n  \"foo\" : \"bar\",\n  \"val\" : 1\n}")
        || (jsonPretty == "{\n  \"val\" : 1,\n  \"foo\" : \"bar\"\n}")
        || (jsonPretty == "{\n  \"val\": 1,\n  \"foo\": \"bar\"\n}")
        || (jsonPretty == "{\n  \"foo\": \"bar\",\n  \"val\": 1,\n}"))
    }

    do {
      let dictionary2: [String: Any?] = ["key1":"val1", "key2": nil]
      let jsonString = dictionary2.jsonString()
      XCTAssertNotNil(jsonString)
      XCTAssertTrue(jsonString == "{\"key2\":null,\"key1\":\"val1\"}" || jsonString == "{\"key1\":\"val1\",\"key2\":null}")
    }

  }

  func testJSONData() {

    do {
      let string = "{\"foo\":\"bar\",\"val\":1}"
      let dictionary = Dictionary<String, Any>(json: string)
      XCTAssertNotNil(dictionary)
      XCTAssertNotNil(dictionary!.jsonData())
      XCTAssertNotNil(dictionary!.jsonData(prettify: true))
    }

    do {
      let string = "{\"foo\"bar\",\"val\":1}"
      let dictionary = Dictionary<String, Any>(json: string)
      XCTAssertNil(dictionary)
    }

    do {
      let dictionary: [String: Any?] = ["key1":"val1", "key2": nil]
      XCTAssertNotNil(dictionary.jsonData())
    }

  }

  func testLowercaseAllKeys() {
    var dictionary = ["Key1":1, "key2":2, "kEY3":3]
    dictionary.lowercaseAllKeys()
    dictionary.keys.enumerated().forEach { (arg) in
      let (_, k) = arg
      XCTAssertTrue(k.isLowercased)
    }
  }

}
