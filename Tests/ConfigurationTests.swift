//
//  ConfigurationTests.swift
//  Mechanica
//
//  Copyright © 2016 Tinrobots.
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

extension Configuration: BoolMappable {
  
  public enum BoolKey: String {
    case boolItem = "BoolItem"
    //case wrongBoolItem  = "DateItem"
  }
  
}

extension Configuration: StringMappable {
  
  public enum StringKey: String {
    case stringItem   = "StringItem"
    case stringItem3  = "DictionaryItem.DictionaryItem2.StringItem3"
    case stringItem4  = "DictionaryItem.DictionaryItem2.StringItem4"
    //case wrongStringItem  = "DictionaryItem11.StringItem4"
  }
  
}

extension Configuration: DateMappable {
  
  public enum DateKey: String {
    case dateItem   = "DateItem"
    case dateItem2  = "DictionaryItem.DateItem2"
  }
  
}

extension Configuration: NumberMappable {
  
  public enum NumberKey: String {
    case numberItem   = "NumberItem"
    case numberItem2  = "DictionaryItem.NumberItem2"
    case numberItem3  = "DictionaryItem.NumberItem3"
  }
  
}

extension Configuration: DataMappable {
  
  public enum DataKey: String {
    case dataItem = "DataItem"
  }
  
}

extension Configuration: URLMappable{
  
  public enum URLKey: String {
    case urlItem  = "URLItem"
    case urlItem2 = "URLItem2"
    case wrongURL = "WrongURLItem"
  }
  
}

extension Configuration: ArrayMappable {
  
  public enum ArrayKey: String {
    case arrayItem = "ArrayItem"
  }
  
}

extension Configuration: DictionaryMappable {
  
  public enum DictionaryKey: String {
    case dictionaryItem   = "DictionaryItem"
    case dictionaryItem2  = "DictionaryItem.DictionaryItem2"
  }
  
}

class ConfigurationTests: XCTestCase {
  
  private lazy var plistPath: String = {
    return Bundle(for: type(of: self)).path(forResource: "ConfigurationDemo", ofType: "plist")!
  }()
  
  func test_configuration() {
    
    guard let config = Configuration(plistPath: plistPath) else {
      XCTAssert(true, "Invalid plist file.")
      return
    }
    
    let config2 = config
    XCTAssert(config.propertyList === config2.propertyList)
    
    /// Bool
    XCTAssert(config.bool(forKey: .boolItem))
    
    /// String
    XCTAssert(config.string(forKey: .stringItem) == "Hello World")
    XCTAssert(config.string(forKey: .stringItem3) == "Hello World 3")
    XCTAssert(config.string(forKey: .stringItem4).isEmpty)
    
    /// NSNumber
    XCTAssert(config.number(forKey: .numberItem).intValue == 1)
    XCTAssert(config.number(forKey: .numberItem2).doubleValue == Double.pi)
    XCTAssert(config.number(forKey: .numberItem3).doubleValue == 11.145)
    XCTAssertTrue(config.date(forKey: .dateItem).timeIntervalSince1970 == Date(timeIntervalSince1970: 0).timeIntervalSince1970)
    
    /// Date
    let date = config.date(forKey: .dateItem2)
    let calendar = NSCalendar.current
    let components = calendar.dateComponents([.day,.month,.year], from: date)
    XCTAssertTrue(components.year == 2016)
    XCTAssertTrue(components.month == 11)
    XCTAssertTrue(components.day == 16)
    
    /// URL
    XCTAssert(config.url(forKey: .urlItem)?.absoluteString == "http://www.tinrobots.org")
    XCTAssert(config.url(forKey: .urlItem2)?.absoluteString == "tinrobots.org")
    XCTAssertNil(config.url(forKey: .wrongURL))
    
    /// Data
    XCTAssertNotNil(config.data(forKey: .dataItem))
    
    /// Array
    XCTAssert(config.array(forKey: .arrayItem).count == 3)
    
    /// Dictionary
    XCTAssertNotNil(config.dictionary(forKey: .dictionaryItem))
    XCTAssertNotNil(config.dictionary(forKey: .dictionaryItem2))
    
  }
  
  
  
}
