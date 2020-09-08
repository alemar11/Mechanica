import XCTest
@testable import Mechanica

extension OperatorsTests {
  static var allTests = [ ("testPercent", testPercent) ]
}

final class OperatorsTests: XCTestCase {

  func testPercent() {
    do {
      let value1 = 20.0%
      XCTAssertTrue(value1 == 0.2)

      let value2 = 11.1%
      XCTAssertTrue(value2 == 0.111)

      let value3 = Double(0)%
      XCTAssertTrue(value3 == 0)

      let value4 = Double(100)%
      XCTAssertTrue(value4 == 1)
    }

    do {
      let value1 = Float(20)%
      XCTAssertTrue(value1 == 0.2)

      let value2 = Float(11.1)%
      XCTAssertTrue(value2 == 0.111)

      let value3 = Float(0)%
      XCTAssertTrue(value3 == 0)

      let value4 = Float(100)%
      XCTAssertTrue(value4 == 1)
    }

  }

}
