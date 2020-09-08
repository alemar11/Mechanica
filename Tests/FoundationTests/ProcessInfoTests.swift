import XCTest
@testable import Mechanica

extension ProcessInfoTests {
  static var allTests = [
    ("testSystemStartingDate", testSystemStartingDate),
    ("testIsSanboxed", testIsSanboxed),
    ("testIsRunningUnitTests", testIsRunningUnitTests),
    ("testIsRunningXcodeUnitTests", testIsRunningXcodeUnitTests),
    ("testIsRunningSwiftPackageTests", testIsRunningSwiftPackageTests)
  ]
}

final class ProcessInfoTests: XCTestCase {

  func testSystemStartingDate() {
    let date = ProcessInfo.systemStartingDate
    XCTAssertTrue(date < Date())
    XCTAssertTrue(date.timeIntervalSinceNow < 60*5)
  }

  func testIsSanboxed() {
    #if os(macOS)
      XCTAssertFalse(ProcessInfo.isSandboxed)
    #endif
  }

  func testIsRunningUnitTests() {
    XCTAssertTrue(ProcessInfo.isRunningUnitTests)
  }

  func testIsRunningXcodeUnitTests() {
    #if os(Linux)
      XCTAssertFalse(ProcessInfo.isRunningXcodeUnitTests)
    #else
      if ProcessInfo.processInfo.arguments.filter({ $0.contains("MechanicaPackageTests") }).isEmpty {
        XCTAssertTrue(ProcessInfo.isRunningXcodeUnitTests)
      } else {
        XCTAssertFalse(ProcessInfo.isRunningXcodeUnitTests)
      }
    #endif
  }

  func testIsRunningSwiftPackageTests() {
    #if os(Linux)
      XCTAssertTrue(ProcessInfo.isRunningSwiftPackageTests)
    #else
      if ProcessInfo.processInfo.arguments.filter({ $0.contains("MechanicaPackageTests") }).isEmpty {
        XCTAssertFalse(ProcessInfo.isRunningSwiftPackageTests)
      } else {
        XCTAssertTrue(ProcessInfo.isRunningSwiftPackageTests)
      }
    #endif
  }

}
