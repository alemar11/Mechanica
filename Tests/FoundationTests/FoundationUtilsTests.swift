import XCTest
@testable import Mechanica

extension FoundationUtilsTests {
  static var allTests = [("testTypeName", testTypeName)]
}

final class FoundationUtilsTests: XCTestCase {

  internal class Demo {}

  class Demo2: CustomStringConvertible, CustomDebugStringConvertible {
    var description: String { return "description-Demo2" }
    var debugDescription: String { return "debugDescription-Demo2" }
  }

  private class Demo3: Demo {}

  internal class Demo4: Demo {}

  class DemoNSObject: NSObject {}

  class DemoNSObject2: NSObject {
    override var description: String { return "description-DemoNSObject2" }
    override var debugDescription: String { return "debugDescription-DemoNSObject2" }
  }

  private class DemoNSObject3: NSObject {}

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

    XCTAssertEqual(typeName(of: Demo4()), "Demo4")
    XCTAssertEqual(typeName(of: Demo4.self), "Demo4")

    XCTAssertEqual(typeName(of: DemoNSObject()), "DemoNSObject")
    XCTAssertEqual(typeName(of: DemoNSObject.self), "DemoNSObject")

    XCTAssertEqual(typeName(of: DemoNSObject2()), "DemoNSObject2")
    XCTAssertEqual(typeName(of: DemoNSObject2.self), "DemoNSObject2")

    XCTAssertEqual(typeName(of: DemoNSObject3()), "DemoNSObject3")
    XCTAssertEqual(typeName(of: DemoNSObject3.self), "DemoNSObject3")

    XCTAssertEqual(typeName(of: DemoStruct()), "DemoStruct")
    XCTAssertEqual(typeName(of: DemoStruct.self), "DemoStruct")

    XCTAssertEqual(typeName(of: DemoStruct2()), "DemoStruct2")
    XCTAssertEqual(typeName(of: DemoStruct2.self), "DemoStruct2")

    XCTAssertEqual(typeName(of: DemoEnum.self), "DemoEnum")
    XCTAssertEqual(typeName(of: DemoEnum2.self), "DemoEnum2")
  }

  // MARK: - Objective-C Associated Values
  #if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
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
  #endif

}

