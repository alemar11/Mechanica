//
//  CollectionUtiilsTests.swift
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

class CollectionUtiilsTests: XCTestCase {
  
  // MARK - Equatable
  
  let array = [1, 1, 1, 2, 3, 4, 4, 5, 8]
  
  func testFirstIndex() {
    let index1 = array.firstIndex(of: 1)
    XCTAssertTrue(index1 == 0)
    let index2 = array.firstIndex(of: 8)
    XCTAssertTrue(index2 == 8)
    let index3 = array.firstIndex(of: 4)
    XCTAssertTrue(index3 == 5)
    let index4 = array.firstIndex(of: 11)
    XCTAssertTrue(index4 == nil)
  }
  
  func testLastIndex() {
    let index1 = array.lastIndex(of: 1)
    XCTAssertTrue(index1 == 2)
    let index2 = array.lastIndex(of: 8)
    XCTAssertTrue(index2 == 8)
    let index3 = array.lastIndex(of: 4)
    XCTAssertTrue(index3 == 6)
    let index4 = array.lastIndex(of: 11)
    XCTAssertTrue(index4 == nil)
  }
  
}
