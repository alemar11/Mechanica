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

#if canImport(Dispatch)

import Dispatch

extension DispatchQueueUtilsTests {
  static var allTests = [
    ("testIsMainQueue", testIsMainQueue),
    ("testIsCurrent", testIsCurrent),
    ]
}

final class DispatchQueueUtilsTests: XCTestCase {

  func testIsMainQueue() {
    // Given, When
    let expect = expectation(description: "testIsMainQueue")
    let group = DispatchGroup()

    // Then
    DispatchQueue.main.async(group: group) {
      XCTAssertTrue(DispatchQueue.isMainQueue)
    }
    
    DispatchQueue.global().async(group: group) {
      XCTAssertFalse(DispatchQueue.isMainQueue)
    }
    
    group.notify(queue: .main) {
      expect.fulfill()
    }

    waitForExpectations(timeout: 0.5, handler: nil)
  }

  func testIsCurrent() {
    // Given, When
    let expect = expectation(description: "testIsCurrent")
    let group = DispatchGroup()
    let queue = DispatchQueue.global()

    // Then
    queue.async(group: group) {
      XCTAssertTrue(DispatchQueue.isCurrent(queue))
    }
    DispatchQueue.main.async(group: group) {
      XCTAssertTrue(DispatchQueue.isCurrent(DispatchQueue.main))
      XCTAssertFalse(DispatchQueue.isCurrent(queue))
    }

    group.notify(queue: .main) {
      expect.fulfill()
    }

    waitForExpectations(timeout: 0.5, handler: nil)
  }

}

#endif
