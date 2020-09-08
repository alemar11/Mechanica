import XCTest
@testable import Mechanica

final class BundleInfoTests: XCTestCase {

  func testBundle() {

    // Given, When
    let bundle = Mechanica.bundle
    // Then
    if ProcessInfo.isRunningXcodeUnitTests {
      XCTAssertNotNil(bundle.version)
      XCTAssertNotNil(bundle.shortVersionString)
      XCTAssertNil(bundle.displayName)
      XCTAssertEqual(bundle.executableFileName, "Mechanica")

    } else if ProcessInfo.isRunningSwiftPackageTests {
      XCTAssertNil(bundle.version)
      XCTAssertNil(bundle.shortVersionString)
      XCTAssertNil(bundle.displayName)
      XCTAssertEqual(bundle.executableFileName, "MechanicaPackageTests")

    } else {
      XCTFail("Missing ProcessInfo details.")
    }

  }

  func testAppIdentifier() {
    if ProcessInfo.isRunningSwiftPackageTests {
      XCTAssertEqual(Mechanica.bundle.appIdentifier, "MechanicaPackageTests")
    } else {
      XCTAssertEqual(Mechanica.bundle.appIdentifier, "org.tinrobots.Mechanica")
    }
    XCTAssertEqual(Bundle.main.appIdentifier, "com.apple.dt.xctest.tool")
  }

  func testUrlSchemes() {
    class TestBundle: Bundle {

      private var _infoDictionary: [String : Any]? = nil

      override var infoDictionary: [String : Any]? {
        set {
          _infoDictionary = newValue
        }
        get {
          return _infoDictionary
        }
      }
    }

    let testBundle = TestBundle()
    var testInfoDictionary = [String : Any]()

    var urlType = [String: Any]()
    urlType["CFBundleURLSchemes"] = ["url1" as Any, "url2" as Any]

    var urlTypes = [Any]()
    urlTypes.append(urlType)
    testInfoDictionary["CFBundleURLTypes"] = urlTypes
    testBundle.infoDictionary = testInfoDictionary


    XCTAssertEqual(testBundle.urlSchemes.count, 2)
    XCTAssertTrue(Bundle.main.urlSchemes.isEmpty)
  }

  #if os(iOS) || os(tvOS) || os(watchOS)
  func testIsAppRunningThroughTestFlight() {
    XCTAssertFalse(Bundle.main.isAppRunningThroughTestFlight)
  }
  #endif

}
