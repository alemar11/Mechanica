import XCTest
@testable import Mechanica

#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)

  final class CGSizeUtilsTests: XCTestCase {

    func testAspectFit() {
      XCTAssertEqual(CGSize(width: 100, height: 50).aspectFit(boundingSize: .zero), .zero)

      do {
        let size = CGSize(width: 100, height: 50).aspectFit(boundingSize: CGSize(width: 70, height: 30))
        #if (arch(i386) || arch(arm))
          XCTAssertEqual(size.width.rounded(.down), 60)
          XCTAssertEqual(size.height.rounded(.down), 30)
        #else
          XCTAssertEqual(size.width, 60)
          XCTAssertEqual(size.height, 30)
        #endif
      }

      do {
        let size = CGSize(width: 100, height: 50).aspectFit(boundingSize: CGSize(width: 90, height: 30))
        #if (arch(i386) || arch(arm))
          XCTAssertEqual(size.width.rounded(.down), 60)
          XCTAssertEqual(size.height.rounded(.down), 30)
        #else
          XCTAssertEqual(size.width, 60)
          XCTAssertEqual(size.height, 30)
        #endif
      }

      do {
        let size = CGSize(width: 100, height: 50).aspectFit(boundingSize: CGSize(width: 100, height: 50))
        #if (arch(i386) || arch(arm))
          XCTAssertEqual(size.width.rounded(.down), 100)
          XCTAssertEqual(size.height.rounded(.down), 50)
        #else
          XCTAssertEqual(size.width, 100)
          XCTAssertEqual(size.height, 50)
        #endif
      }

      do {
        let size = CGSize(width: 100, height: 50).aspectFit(boundingSize: CGSize(width: 150, height: 60))
        #if (arch(i386) || arch(arm))
          XCTAssertEqual(size.width.rounded(.down), 120)
          XCTAssertEqual(size.height.rounded(.down), 60)
        #else
          XCTAssertEqual(size.width, 120)
          XCTAssertEqual(size.height, 60)
        #endif
      }

    }

    func testAdd() {
       XCTAssertEqual(CGSize(width: 20, height: 20), CGSize(width: 10, height: 10) + CGSize(width: 10, height: 10))
       XCTAssertEqual(CGSize(width: 30, height: 20), CGSize(width: 10, height: 10) + CGSize(width: 20, height: 10))
       XCTAssertEqual(CGSize(width: 20, height: 20), CGSize(width: 20, height: 20) + CGSize.zero)
    }

    func testAddEqual() {
      var size = CGSize(width: 10, height: 10)

      size += CGSize(width: 10, height: 10)
      XCTAssertEqual(CGSize(width: 20, height: 20), size)
    }

    func testSubtract() {
      XCTAssertEqual(CGSize(width: 0, height: 0), CGSize(width: 10, height: 10) - CGSize(width: 10, height: 10))
       XCTAssertEqual(CGSize(width: -10, height: 0), CGSize(width: 10, height: 10) - CGSize(width: 20, height: 10))
    }

    func testSubtractEqual() {
      var size = CGSize(width: 10, height: 10)

      size -= CGSize(width: 10, height: 10)
      XCTAssertEqual(CGSize.zero, size)

    }

    func testMultiplyScalar() {
       XCTAssertEqual(CGSize(width: 20, height: 20), CGSize(width: 10, height: 10) * 2)
    }

    func testMultiplyScalarEqual() {
      var size = CGSize(width: 10, height: 10)
      size *= 2
      XCTAssertEqual(CGSize(width: 20, height: 20), size)
    }

  }

#endif
