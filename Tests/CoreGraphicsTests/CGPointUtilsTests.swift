import XCTest
@testable import Mechanica

#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)

  final class CGPointUtilsTests: XCTestCase {

    func testDistance() {
      // https://www.mathportal.org/calculators/analytic-geometry/distance-and-midpoint-calculator.php
      XCTAssertEqual(CGPoint(x: 1, y: 2).distance(to: CGPoint(x: 4, y: 5)), 4.2426, accuracy: 0.0001)
      XCTAssertEqual(CGPoint(x: 1, y: 0).distance(to: CGPoint(x: 4, y: 0)), 3, accuracy: 0)
      XCTAssertEqual(CGPoint(x: 0, y: 10).distance(to: CGPoint(x: 0, y: 11)), 1, accuracy: 0)
      XCTAssertEqual(CGPoint(x: 0, y: 0).distance(to: CGPoint(x: 0, y: 0)), 0, accuracy: 0)
      XCTAssertEqual(CGPoint(x: 100, y: 0).distance(to: CGPoint(x: 0, y: 0)), 100, accuracy: 0)
      XCTAssertEqual(CGPoint(x: 100, y: 0).distance(to: CGPoint(x: 0, y: 0)), 100, accuracy: 0)
      XCTAssertEqual(CGPoint(x: 14, y: 30).distance(to: CGPoint(x: 23, y: 21)), 12.7279, accuracy: 0.0001)
      XCTAssertEqual(CGPoint(x: 14, y: 30).distance(to: CGPoint(x: 23, y: 21)), 12.7279, accuracy: 0.0001)
      XCTAssertEqual(CGPoint(x: 12.12, y: 11.11).distance(to: CGPoint(x: 14.41, y: 13.31)), 3.1755, accuracy: 0.0001)
    }

    func testStraightLine() {
      XCTAssertTrue(CGPoint(x: 1, y: 2).isOnStraightLine(passingThrough: CGPoint(x:0, y:0), and: CGPoint(x:0, y:0)))
      XCTAssertTrue(CGPoint(x: 1, y: 2).isOnStraightLine(passingThrough: CGPoint(x:1, y:1), and: CGPoint(x:1, y:3)))
      XCTAssertFalse(CGPoint(x: 1, y: 2).isOnStraightLine(passingThrough: CGPoint(x:1, y:1), and: CGPoint(x:5, y:3)))
      XCTAssertTrue(CGPoint(x: 1, y: 2).isOnStraightLine(passingThrough: CGPoint(x:1, y:100), and: CGPoint(x:1, y:11.3)))
      XCTAssertTrue(CGPoint(x: 3, y: 2).isOnStraightLine(passingThrough: CGPoint(x:0, y:-10), and: CGPoint(x:1, y:-6))) // y=4x-10
      // Conversions between integer and floating-point numeric types must be made explicit
      XCTAssertTrue(CGPoint(x: 7, y: 3).isOnStraightLine(passingThrough: CGPoint(x:0, y:Double(Double(11)/Double(6))), and: CGPoint(x:10, y:3.5))) // y=(1/6)x+11/6
    }

    func testAdd() {
      XCTAssertEqual(CGPoint(x: 1, y: 2) + CGPoint(x: 0, y: 0), CGPoint(x: 1, y: 2))
      XCTAssertEqual(CGPoint(x: 1, y: 2) + CGPoint(x: 10, y: 11), CGPoint(x: 11, y: 13))
    }

    func testAddEqual() {
      var point1 = CGPoint(x: 1, y: 2)
      point1 += CGPoint(x: 0, y: 0)
      XCTAssertEqual(point1, CGPoint(x: 1, y: 2))

      var point2 = CGPoint(x: 1, y: 2)
      point2 += CGPoint(x: 10, y: 11)
      XCTAssertEqual(point2, CGPoint(x: 11, y: 13))
    }

    func testSubtract() {
      XCTAssertEqual(CGPoint(x: 1, y: 2) - CGPoint(x: 0, y: 0), CGPoint(x: 1, y: 2))
      XCTAssertEqual(CGPoint(x: 1, y: 2) - CGPoint(x: 10, y: 11), CGPoint(x: -9, y: -9))
    }

    func testSubtractEqual() {
      var point1 = CGPoint(x: 1, y: 2)
      point1 -= CGPoint(x: 0, y: 0)
      XCTAssertEqual(point1, CGPoint(x: 1, y: 2))

      var point2 = CGPoint(x: 1, y: 2)
      point2 -= CGPoint(x: 10, y: 11)
      XCTAssertEqual(point2, CGPoint(x: -9, y: -9))
    }

    func testMultiplyScalar() {
      XCTAssertEqual(CGPoint(x: 1, y: 2) * 0, .zero)
      XCTAssertEqual(CGPoint(x: 1, y: 2) * 1, CGPoint(x: 1, y: 2))
      XCTAssertEqual(CGPoint(x: 1, y: 2) * 1.5, CGPoint(x: 1.5, y: 3))
      XCTAssertEqual(CGPoint(x: 1, y: 2) * 3, CGPoint(x: 3, y: 6))
    }

    func testMultiplyScalarEqual() {
      var point1 = CGPoint(x: 1, y: 2)
      point1 *= 0
      XCTAssertEqual(point1, .zero)

      var point2 = CGPoint(x: 1, y: 2)
      point2 *= 1
      XCTAssertEqual(point2, CGPoint(x: 1, y: 2))

      var point3 = CGPoint(x: 1, y: 2)
      point3 *= 1.5
      XCTAssertEqual(point3, CGPoint(x: 1.5, y: 3))

      var point4 = CGPoint(x: 1, y: 2)
      point4 *= 3
      XCTAssertEqual(point4, CGPoint(x: 3, y: 6))
    }

  }

#endif
