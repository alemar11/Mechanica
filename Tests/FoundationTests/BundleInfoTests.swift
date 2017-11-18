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

class BundleInfoTests: XCTestCase {
  
  static var allTests = [("testBundle", testBundle)]

  func testBundle() {
    // TODO: add Linux specific tests
    
    #if !os(Linux)
      
    // Given, When
    let bundle = Mechanica.bundle
    // Then
    if ProcessInfo.isRunningXcodeUnitTests {
      XCTAssertTrue(bundle.version != nil)
      XCTAssertTrue(bundle.shortVersionString != nil)
      XCTAssertTrue(bundle.displayName == nil)
      XCTAssertTrue(bundle.executableFileName == "Mechanica")

    } else if ProcessInfo.isRunningSwiftPackageTests {
      XCTAssertTrue(bundle.version == nil)
      XCTAssertTrue(bundle.shortVersionString == nil)
      XCTAssertTrue(bundle.displayName == nil)
      XCTAssertTrue(bundle.executableFileName == "MechanicaPackageTests")

    } else {
      XCTFail("Missing ProcessInfo details.")
    }
    
    #endif
    
  }

}
