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
