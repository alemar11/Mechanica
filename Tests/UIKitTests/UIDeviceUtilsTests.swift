#if os(iOS) || os(tvOS)

import XCTest
@testable import Mechanica

final class UIDeviceUtilsTests: XCTestCase {

  func testDeviceInterface() {
    #if os(iOS)
      XCTAssertTrue(UIDevice.current.hasPadInterface || UIDevice.current.hasPhoneInterface)
      XCTAssertFalse(UIDevice.current.hasTVInterface)
    #elseif os(tvOS)
      XCTAssertTrue(UIDevice.current.hasTVInterface)
      XCTAssertFalse(UIDevice.current.hasPadInterface || UIDevice.current.hasPhoneInterface)
    #endif

    XCTAssertFalse(UIDevice.current.hasCarPlayInterface)
  }

}

#endif
