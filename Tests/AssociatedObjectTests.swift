//
//  AssociatedObjectTests.swift
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

class AssociatedObjectTests: XCTestCase {
  
  func test_valueAssociation() {
  
    class Demo {
      let var1: String
      let var2: Int
      init(var1: String, var2: Int) {
        self.var1 = var1
        self.var2 = var2
      }
    }
    
    do {
      let demo  = Demo(var1: "demo", var2: 1)
      var key   = UInt8(1)
      let value = "value"
      setAssociatedValue(value, forObject: demo, usingKey: &key)
      XCTAssert(getAssociatedValue(forObject: demo, usingKey: &key) == value)
    }
    
    do {
      let demo  = Demo(var1: "demo", var2: 1)
      var key   = UInt8(1)
      let value = UInt32(100_000_000)
      setAssociatedValue(value, forObject: demo, usingKey: &key)
      XCTAssert(getAssociatedValue(forObject: demo, usingKey: &key) == value)
      clearAssociatedValue(forObject: demo, usingKey: &key)
      XCTAssert(getAssociatedValue(forObject: demo, usingKey: &key) == nil)
    }
    
    do {
      let demo  = Demo(var1: "demo", var2: 1)
      var key   = UInt8(1)
      let value = "value"
      setAssociatedValue(value, forObject: demo, usingKey: &key)
      XCTAssert(getAssociatedValue(forObject: demo, usingKey: &key) == value)
      clearAssociatedValue(forObject: demo, usingKey: &key)
      XCTAssert(getAssociatedValue(forObject: demo, usingKey: &key) == nil)
    }
    
    do {
      let demo  = Demo(var1: "demo", var2: 1)
      var key   = Demo(var1: "key", var2: 2)
      let value = Demo(var1: "value", var2: 3)
      setAssociatedValue(value, forObject: demo, usingKey: &key)
      XCTAssert(getAssociatedValue(forObject: demo, usingKey: &key) === value)
      clearAssociatedValue(forObject: demo, usingKey: &key)
      XCTAssert(getAssociatedValue(forObject: demo, usingKey: &key) == nil)
    }
    
    do {
      struct DemoStruct { var var1: String }
      let demo = Demo(var1: "demo", var2: 1)
      var key = DemoStruct(var1: "key").var1
      let value = Demo(var1: "value", var2: 3)
      setAssociatedValue(value, forObject: demo, usingKey: &key)
      XCTAssert(getAssociatedValue(forObject: demo, usingKey: &key) === value)
      clearAssociatedValue(forObject: demo, usingKey: &key)
      XCTAssert(getAssociatedValue(forObject: demo, usingKey: &key) == nil)
    }
    
  }
  
}
