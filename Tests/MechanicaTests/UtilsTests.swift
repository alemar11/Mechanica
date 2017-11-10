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

class AnyUtilsTests: XCTestCase {
  
  func testAppIdentifier() {
    XCTAssert(App.appIdentifier == "xctest")
  }

  private class Demo {}
  
  class Demo2: CustomStringConvertible, CustomDebugStringConvertible {
    var description: String { return "description-Demo2" }
    var debugDescription: String { return "debugDescription-Demo2" }
  }
  
  private class Demo3: Demo {}
  
  class DemoNSObject: NSObject {}
  
  class DemoNSObject2: NSObject {
    override var description: String { return "description-DemoNSObject2" }
    override var debugDescription: String { return "debugDescription-DemoNSObject2" }
  }
  
  struct DemoStruct {}
  
  struct DemoStruct2: CustomStringConvertible, CustomDebugStringConvertible {
    var description: String { return "description-DemoStruct2" }
    var debugDescription: String { return "debugDescription-DemoStruct2" }
  }
  
  enum DemoEnum {}
  
  enum DemoEnum2: CustomStringConvertible, CustomDebugStringConvertible {
    var description: String { return "description-DemoEnum2" }
    var debugDescription: String { return "debugDescription-DemoEnum2" }
  }
  
  func testTypeName() {
    
    XCTAssertEqual(typeName(of: Demo()), "Demo")
    XCTAssertEqual(typeName(of: Demo.self), "Demo")
    
    XCTAssertEqual(typeName(of: Demo2()), "Demo2")
    XCTAssertEqual(typeName(of: Demo2.self), "Demo2")
    
    XCTAssertEqual(typeName(of: Demo3()), "Demo3")
    XCTAssertEqual(typeName(of: Demo3.self), "Demo3")
    
    XCTAssertEqual(typeName(of: DemoNSObject()), "DemoNSObject")
    XCTAssertEqual(typeName(of: DemoNSObject.self), "DemoNSObject")
    
    XCTAssertEqual(typeName(of: DemoNSObject2()), "DemoNSObject2")
    XCTAssertEqual(typeName(of: DemoNSObject2.self), "DemoNSObject2")
    
    XCTAssertEqual(typeName(of: DemoStruct()), "DemoStruct")
    XCTAssertEqual(typeName(of: DemoStruct.self), "DemoStruct")
    
    XCTAssertEqual(typeName(of: DemoStruct2()), "DemoStruct2")
    XCTAssertEqual(typeName(of: DemoStruct2.self), "DemoStruct2")
    
    XCTAssertEqual(typeName(of: DemoEnum.self), "DemoEnum")
    XCTAssertEqual(typeName(of: DemoEnum2.self), "DemoEnum2")
    
  }
  
}

