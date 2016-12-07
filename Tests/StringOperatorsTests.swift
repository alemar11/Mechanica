//
//  StringOperatorsTests.swift
//  Mechanica
//
//  Created by Alessandro Marzoli on 01/12/16.
//  Copyright © 2016 Tinrobots. All rights reserved.
//

import XCTest
@testable import Mechanica

class StringOperatorsTests: XCTestCase {

  func test_multiply() {
    XCTAssert("a"*2 == "aa")
    XCTAssert("aA"*2 == "aAaA")
    XCTAssert("Hello World "+"!"*2 == "Hello World !!")
    XCTAssert("🇮🇹"*3 == "🇮🇹🇮🇹🇮🇹")
  }


}
