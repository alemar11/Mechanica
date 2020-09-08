#if os(iOS) || os(tvOS)

import XCTest
@testable import Mechanica

final class UIButtonUtilsTests: XCTestCase {

  func testSetBackgroundColor() {
    // Given
    let size = CGSize(width: 200, height: 50)
    let rect = CGRect(origin: .zero, size: size)
    let button = UIButton(frame: rect)
    XCTAssertNil(button.backgroundImage(for: .normal))
    XCTAssertNil(button.backgroundImage(for: .highlighted))

    // When
    button.setBackgroundColor(.red, for: .normal)

    // Then
    XCTAssertNotNil(button.backgroundImage(for: .normal))
    XCTAssertNotNil(button.backgroundImage(for: .highlighted))
  }

}

#endif
