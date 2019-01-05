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

final class NSObjectProtocolUtils: XCTestCase {

  static var allTests = [("testClassName", testClassName)]

  private class Demo: NSObject {}

// MARK: - Utilities

  func testClassName(){
    XCTAssertEqual(Demo.type, "Demo")
    XCTAssertEqual(Demo().type, "Demo")
  }

  // MARK: - Associated Values

  #if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
  func testAssociatedValue() {

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
  #endif
}

// MARK: - Method Swizzling

#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
class Test : NSObject {
  @objc dynamic func methodOne() -> Int { return 1 }
  @objc dynamic func methodThree() -> String { return "three" }
  @objc dynamic func methodFive(string: String) -> String { return ".." + string + ".." }
  override init(){}
}

extension Test {
  @objc func methodTwo() -> Int { return methodTwo() + 10 }
  @objc func methodFour() -> String { return methodFour() + "!!" }
  @objc func methodSix(string: String) -> String { return "--" + string + "--" }
}

final class NSObjectProtocolSwizzlingTests: XCTestCase {

  override func setUp() {
    super.setUp()
    Test.swizzle([
      ( #selector(Test.methodOne), #selector(Test.methodTwo) ),
      ( #selector(Test.methodThree), #selector(Test.methodFour) ),
      ( #selector(Test.methodFive), #selector(Test.methodSix) )
      ])
  }

  func testSwizzlingExtension() {
    let test = Test()
    XCTAssertTrue(test.methodOne() == 11)
    XCTAssertTrue(test.methodTwo() == 1)
    XCTAssertTrue(test.methodThree() == "three!!")
    XCTAssertTrue(test.methodFour() == "three")
    XCTAssertTrue(test.methodFive(string: "five") == "--five--")
    XCTAssertTrue(test.methodSix(string: "six") == "..six..")
  }

}
#endif

