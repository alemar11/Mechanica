import XCTest
@testable import Mechanica

#if os(macOS)

  final class NSImageUtilsTests: XCTestCase {

    func testImageNamed() {
      let bundle = Bundle(for: NSImageUtilsTests.self)

      let image = NSImage.imageNamed(name: "glasses", in: bundle)
      let notExistingImage = NSImage.imageNamed(name: "not-existing-glasses", in: bundle)

      if !ProcessInfo.isRunningSwiftPackageTests {
        // TODO: - see https://bugs.swift.org/browse/SR-2866
        XCTAssertNotNil(image)
        XCTAssertNil(notExistingImage)
        XCTAssertEqual(image!.name(), NSImage.Name("glasses"))
      }

    }

    func testCGImage() throws {
      let data = Resource.glasses.data
      let image = NSImage(data: data)
      let cgImage = image?.cgImage

      XCTAssertNotNil(cgImage)
      XCTAssertEqual(cgImage!.width, 483)
      XCTAssertEqual(cgImage!.height, 221)
    }

  }

#endif
