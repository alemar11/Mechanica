//
//  NSObjectProtocolSwizzlingTests.swift
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

class NSObjectSwizzlingTests: XCTestCase {

  override func setUp() {
    super.setUp()
    Test.swizzle([
      ( #selector(Test.methodOne), #selector(Test.methodTwo) ),
      ( #selector(Test.methodThree), #selector(Test.methodFour) ),
      ( #selector(Test.methodFive), #selector(Test.methodSix) )
      ])
  }

  func test_swizzlingExtension() {
    let test = Test()
    XCTAssertTrue(test.methodOne() == 11)
    XCTAssertTrue(test.methodTwo() == 1)
    XCTAssertTrue(test.methodThree() == "three!!")
    XCTAssertTrue(test.methodFour() == "three")
    XCTAssertTrue(test.methodFive(string: "five") == "--five--")
    XCTAssertTrue(test.methodSix(string: "six") == "..six..")
  }

}
