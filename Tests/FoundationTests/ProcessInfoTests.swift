// 
// Mechanica
//
// Copyright © 2016-2018 Tinrobots.
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

extension ProcessInfoTests {
  static var allTests = [
    ("testSystemStartingDate", testSystemStartingDate),
    ("testIsSanboxed", testIsSanboxed),
    ("testIsRunningUnitTests", testIsRunningUnitTests),
    ("testIsRunningXcodeUnitTests", testIsRunningXcodeUnitTests),
    ("testIsRunningSwiftPackageTests", testIsRunningSwiftPackageTests)
  ]
}

class ProcessInfoTests: XCTestCase {

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
    print("\n\n========================")
    print(ProcessInfo.processInfo.environment)
    print("========================\n\n")
    #if os(Linux)
      XCTAssertFalse(ProcessInfo.isRunningXcodeUnitTests)
    #else

      if let name = ProcessInfo.processInfo.environment["XPC_SERVICE_NAME"], name.contains("Xcode", caseSensitive: true) {
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
      if let name = ProcessInfo.processInfo.environment["XPC_SERVICE_NAME"], name.contains("Xcode", caseSensitive: true) {
        XCTAssertFalse(ProcessInfo.isRunningSwiftPackageTests)
      } else {
        XCTAssertTrue(ProcessInfo.isRunningSwiftPackageTests)
      }
    #endif
  }

}
