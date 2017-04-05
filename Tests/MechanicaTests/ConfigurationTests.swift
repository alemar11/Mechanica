//
//  ConfigurationTests.swift
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

fileprivate enum BoolKey {
  static let boolItem = KeyPath<Bool>(path: "BoolItem")
}

fileprivate enum StringKey {
  static let stringItem = KeyPath<String>(path: "StringItem")
  static let stringItem3 = KeyPath<String>(path: "DictionaryItem.DictionaryItem2.StringItem3")
  static let stringItem4 = KeyPath<String>(path: "DictionaryItem.DictionaryItem2.StringItem4")
}

fileprivate enum DateKey {
  static let dateItem = KeyPath<Date>(path: "DateItem")
  static let dateItem2 = KeyPath<Date>(path: "DictionaryItem.DateItem2")

}

fileprivate enum NumberKey {
  static let numberItem   =  KeyPath<NSNumber>(path: "NumberItem")
  static let numberItem2  =  KeyPath<NSNumber>(path: "DictionaryItem.NumberItem2")
  static let numberItem3  =  KeyPath<NSNumber>(path: "DictionaryItem.NumberItem3")
}

fileprivate enum DataKey {
  static let dataItem =  KeyPath<Data>(path: "DataItem")
}

fileprivate enum URLKey {
  static let urlItem  = KeyPath<URL>(path: "URLItem")
  static let urlItem2 = KeyPath<URL>(path: "URLItem2")
  static let wrongURL = KeyPath<URL>(path: "WrongURLItem")
}

fileprivate enum ArrayKey {
  static let arrayItem = KeyPath<[Any]>(path: "ArrayItem")
}

fileprivate enum DictionaryKey {
  static let dictionaryItem   = KeyPath<[String:Any]>(path: "DictionaryItem")
  static let dictionaryItem2  = KeyPath<[String:Any]>(path: "DictionaryItem.DictionaryItem2")
}

/// Demo configuration file (.plist)
class Configuration: PropertyListReadable {

  private(set) var propertyList: NSDictionary

  init?(plistPath: String) {
    guard let plist = NSDictionary(contentsOfFile: plistPath) else {
      assertionFailure("Could not read plist file or the plist file is an array.")
      return nil
    }
    propertyList = plist
  }

}


class ConfigurationTests: XCTestCase {

  lazy var unitTestBundle: Bundle =  { return Bundle(for: type(of: self)) }()

  func test_configuration() {

    guard let plistPath = unitTestBundle.path(forResource: "ConfigurationDemo", ofType: "plist") else {
      XCTFail("Invalid plist file.")
      return
    }

    guard let config = Configuration(plistPath: plistPath) else {
      XCTFail("Invalid plist file.")
      return
    }

    let config2 = config
    XCTAssert(config.propertyList === config2.propertyList)

    /// Bool
    XCTAssertTrue(config.bool(forKeyPath: BoolKey.boolItem)!)

    /// String
    XCTAssert(config.string(forKeyPath: StringKey.stringItem) == "Hello World")
    XCTAssert(config.string(forKeyPath: StringKey.stringItem3) == "Hello World 3")
    XCTAssert(config.string(forKeyPath: StringKey.stringItem4)!.isEmpty)

    /// NSNumber
    XCTAssert(config.number(forKeyPath: NumberKey.numberItem)?.intValue == 1)
    XCTAssert(config.number(forKeyPath: NumberKey.numberItem2)?.doubleValue == Double.pi)
    XCTAssert(config.number(forKeyPath: NumberKey.numberItem3)?.doubleValue == 11.145)

    /// Date
    XCTAssertTrue(config.date(forKeyPath: DateKey.dateItem)!.timeIntervalSince1970 == Date(timeIntervalSince1970: 0).timeIntervalSince1970)
    let date = config.date(forKeyPath: DateKey.dateItem2)!
    let calendar = NSCalendar.current
    let components = calendar.dateComponents([.day,.month,.year], from: date)
    XCTAssertTrue(components.year == 2016)
    XCTAssertTrue(components.month == 11)
    XCTAssertTrue(components.day == 16)

    /// URL
    XCTAssert(config.url(forKeyPath: URLKey.urlItem)?.absoluteString == "http://www.tinrobots.org")
    XCTAssert(config.url(forKeyPath: URLKey.urlItem2)?.absoluteString == "tinrobots.org")
    XCTAssertNil(config.url(forKeyPath: URLKey.wrongURL))

    /// Data
    XCTAssertNotNil(config.data(forKeyPath: DataKey.dataItem))

    /// Array
    XCTAssert(config.array(forKeyPath: ArrayKey.arrayItem)?.count == 3)

    /// Dictionary
    XCTAssertNotNil(config.dictionary(forKeyPath: DictionaryKey.dictionaryItem))
    XCTAssertNotNil(config.dictionary(forKeyPath: DictionaryKey.dictionaryItem2))

  }



}
