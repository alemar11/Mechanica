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

class AssociatedValueSupportingTests: XCTestCase {

  // MARK:- Associated Objects

  func testValueAssociation() {

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
      Mechanica.setAssociatedValue(value, forObject: demo, usingKey: &key)
      XCTAssert(Mechanica.getAssociatedValue(forObject: demo, usingKey: &key) == value)
    }

    do {
      let demo  = Demo(var1: "demo", var2: 1)
      var key   = UInt8(1)
      let value = UInt32(100_000_000)
      Mechanica.setAssociatedValue(value, forObject: demo, usingKey: &key)
      XCTAssert(Mechanica.getAssociatedValue(forObject: demo, usingKey: &key) == value)
      Mechanica.removeAssociatedValue(forObject: demo, usingKey: &key)
      XCTAssert(Mechanica.getAssociatedValue(forObject: demo, usingKey: &key) == nil)
    }

    do {
      let demo  = Demo(var1: "demo", var2: 1)
      var key   = UInt8(1)
      let value = "value"
      Mechanica.setAssociatedValue(value, forObject: demo, usingKey: &key)
      XCTAssert(Mechanica.getAssociatedValue(forObject: demo, usingKey: &key) == value)
      Mechanica.removeAssociatedValue(forObject: demo, usingKey: &key)
      XCTAssert(Mechanica.getAssociatedValue(forObject: demo, usingKey: &key) == nil)
    }

    do {
      let demo  = Demo(var1: "demo", var2: 1)
      var key   = Demo(var1: "key", var2: 2)
      let value = Demo(var1: "value", var2: 3)
      Mechanica.setAssociatedValue(value, forObject: demo, usingKey: &key)
      XCTAssert(Mechanica.getAssociatedValue(forObject: demo, usingKey: &key) === value)
      Mechanica.removeAssociatedValue(forObject: demo, usingKey: &key)
      XCTAssert(Mechanica.getAssociatedValue(forObject: demo, usingKey: &key) == nil)
    }

    do {
      struct DemoStruct { var var1: String }
      let demo = Demo(var1: "demo", var2: 1)
      var key = DemoStruct(var1: "key").var1
      let value = Demo(var1: "value", var2: 3)
      Mechanica.setAssociatedValue(value, forObject: demo, usingKey: &key)
      XCTAssert(Mechanica.getAssociatedValue(forObject: demo, usingKey: &key) === value)
      Mechanica.removeAssociatedValue(forObject: demo, usingKey: &key)
      XCTAssert(Mechanica.getAssociatedValue(forObject: demo, usingKey: &key) == nil)
    }

  }

  // MARK:- ValueAssociable Protocol

  func testAssociatedValueSupportingClass() {

    class Demo: AssociatedValueSupporting {
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
      demo.setAssociatedValue(value, forKey: &key)
      XCTAssert(demo.getAssociatedValue(forKey: &key) == value )
    }

    do {
      let demo  = Demo(var1: "demo", var2: 1)
      var key   = UInt8(1)
      let value = UInt32(100_000_000)
      demo.setAssociatedValue(value, forKey: &key)
      XCTAssert(demo.getAssociatedValue(forKey: &key) == value )
      demo.removeAssociatedValue(forKey: &key)
      XCTAssert(demo.getAssociatedValue(forKey: &key) == nil)
    }

    do {
      let demo  = Demo(var1: "demo", var2: 1)
      var key   = UInt8(1)
      let value = "value"
      demo.setAssociatedValue(value, forKey: &key)
      XCTAssert(demo.getAssociatedValue(forKey: &key) == value )
      demo.removeAssociatedValue(forKey: &key)
      XCTAssert(demo.getAssociatedValue(forKey: &key) == nil)
    }

    do {
      let demo  = Demo(var1: "demo", var2: 1)
      var key   = Demo(var1: "key", var2: 2)
      let value = Demo(var1: "value", var2: 3)
      demo.setAssociatedValue(value, forKey: &key)
      XCTAssert(demo.getAssociatedValue(forKey: &key) === value )
      demo.removeAssociatedValue(forKey: &key)
      XCTAssert(demo.getAssociatedValue(forKey: &key) == nil)
    }

    do {
      struct DemoStruct { var var1: String }
      let demo = Demo(var1: "demo", var2: 1)
      var key = DemoStruct(var1: "key").var1
      let value = Demo(var1: "value", var2: 3)
      demo.setAssociatedValue(value, forKey: &key)
      XCTAssert(demo.getAssociatedValue(forKey: &key) === value )
      demo.removeAssociatedValue(forKey: &key)
      XCTAssert(demo.getAssociatedValue(forKey: &key) == nil)
    }

  }

  func testAssociatedValueSupportingNSObject() {

    class Demo: NSObject {
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
      demo.setAssociatedValue(value, forKey: &key)
      XCTAssert(demo.getAssociatedValue(forKey: &key) == value )
    }

    do {
      let demo  = Demo(var1: "demo", var2: 1)
      var key   = UInt8(1)
      var key2   = UInt8(2)
      let value = "value"
      let value2 = "value2"
      demo.setAssociatedValue(value, forKey: &key)
      demo.setAssociatedValue(value2, forKey: &key2)
      demo.removeAllAssociatedValues()
      XCTAssert(demo.getAssociatedValue(forKey: &key) == nil )
      XCTAssert(demo.getAssociatedValue(forKey: &key2) == nil )
    }

    do {
      let demo  = Demo(var1: "demo", var2: 1)
      var key   = UInt8(1)
      let value = UInt32(100_000_000)
      demo.setAssociatedValue(value, forKey: &key)
      XCTAssert(demo.getAssociatedValue(forKey: &key) == value )
      demo.removeAssociatedValue(forKey: &key)
      XCTAssert(demo.getAssociatedValue(forKey: &key) == nil)
    }

    do {
      let demo  = Demo(var1: "demo", var2: 1)
      var key   = UInt8(1)
      let value = "value"
      demo.setAssociatedValue(value, forKey: &key)
      XCTAssert(demo.getAssociatedValue(forKey: &key) == value )
      demo.removeAssociatedValue(forKey: &key)
      XCTAssert(demo.getAssociatedValue(forKey: &key) == nil)
    }

    do {
      let demo  = Demo(var1: "demo", var2: 1)
      var key   = Demo(var1: "key", var2: 2)
      let value = Demo(var1: "value", var2: 3)
      demo.setAssociatedValue(value, forKey: &key)
      XCTAssert(demo.getAssociatedValue(forKey: &key) === value )
      demo.removeAssociatedValue(forKey: &key)
      XCTAssert(demo.getAssociatedValue(forKey: &key) == nil)
    }

    do {
      struct DemoStruct { var var1: String }
      let demo = Demo(var1: "demo", var2: 1)
      var key = DemoStruct(var1: "key").var1
      let value = Demo(var1: "value", var2: 3)
      demo.setAssociatedValue(value, forKey: &key)
      XCTAssert(demo.getAssociatedValue(forKey: &key) === value )
      demo.removeAssociatedValue(forKey: &key)
      XCTAssert(demo.getAssociatedValue(forKey: &key) == nil)
    }

  }

}
