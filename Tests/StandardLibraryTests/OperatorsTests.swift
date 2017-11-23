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

class OperatorsTests: XCTestCase {
  
  static var allTests = [ ("testPercent", testPercent) ]
  
  func testPercent() {
    do {
      let value1 = 20.0%
      XCTAssertTrue(value1 == 0.2)
      
      let value2 = 11.1%
      XCTAssertTrue(value2 == 0.111)
      
      let value3 = Double(0)%
      XCTAssertTrue(value3 == 0)
      
      let value4 = Double(100)%
      XCTAssertTrue(value4 == 1)
    }
    
    do {
      let value1 = Float(20)%
      XCTAssertTrue(value1 == 0.2)
      
      let value2 = Float(11.1)%
      XCTAssertTrue(value2 == 0.111)
      
      let value3 = Float(0)%
      XCTAssertTrue(value3 == 0)
      
      let value4 = Float(100)%
      XCTAssertTrue(value4 == 1)
    }
    
  }
  
}
