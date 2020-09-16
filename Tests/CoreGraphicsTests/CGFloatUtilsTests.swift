import XCTest
@testable import Mechanica

#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)

final class CGFloatUtilsTests: XCTestCase {
  
  func testDegreesToRadians() {
    XCTAssertEqual(CGFloat(180).degreesToRadians, CGFloat.pi)
    XCTAssertEqual(CGFloat(45).degreesToRadians, CGFloat.pi/4)
  }
  
  func testRadiansToDegrees() {
    XCTAssertEqual(CGFloat.pi.radiansToDegrees, 180)
    XCTAssertEqual((CGFloat.pi/4).radiansToDegrees, 45)
  }
  
  func testShortestAngle() {
    XCTAssertEqual(CGFloat.shortestAngleInRadians(from: .pi, to: .pi * 2), .pi)
    
    #if (arch(i386) || arch(arm))
    XCTAssertEqual(CGFloat.shortestAngleInRadians(from: 0, to: .pi * (3/2)).rounded(), (-CGFloat.pi/2).rounded())
    XCTAssertEqual(CGFloat.shortestAngleInRadians(from: 0, to: -.pi * 2).rounded(), 0)
    XCTAssertEqual(CGFloat.shortestAngleInRadians(from: 0, to: -CGFloat.pi).rounded(to: 4), (CGFloat.pi).rounded(to: 4))
    #else
    XCTAssertEqual(CGFloat.shortestAngleInRadians(from: 0, to: .pi * (3/2)), -.pi/2)
    XCTAssertEqual(CGFloat.shortestAngleInRadians(from: 0, to: -.pi * 2), 0)
    XCTAssertEqual(CGFloat.shortestAngleInRadians(from: 0, to: -.pi), .pi)
    #endif
    
    XCTAssertEqual(CGFloat.shortestAngleInRadians(from: .pi * (1/4), to: .pi * (3/2)), -.pi * (3/4))
    XCTAssertEqual(CGFloat.shortestAngleInRadians(from: CGFloat(350).degreesToRadians, to: CGFloat(15).degreesToRadians).rounded(), CGFloat(25).degreesToRadians.rounded()) // from 350° to 15° = 25°
    XCTAssertEqual(CGFloat.shortestAngleInRadians(from: CGFloat(250).degreesToRadians, to: CGFloat(190).degreesToRadians).rounded(), CGFloat(-60).degreesToRadians.rounded()) // from 250° to 190° = 60°
    XCTAssertEqual(CGFloat.shortestAngleInRadians(from: CGFloat(190).degreesToRadians, to: CGFloat(250).degreesToRadians).rounded(), CGFloat(60).degreesToRadians.rounded())
  }
  
}

#endif
