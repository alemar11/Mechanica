#if canImport(AVAsset)

import XCTest
import AVAsset
@testable import Mechanica

class AVAssetUtils: XCTestCase {

  func testThumbnailFromVideoURL() throws {
    let url = URL(string: "http://www.webestools.com/page/media/videoTag/BigBuckBunny.mp4")!
    let asset = AVAsset(url: url)
    let image = try asset.thumbnail(fromTime: 61)

    XCTAssertEqual(image.size.width, 720)
    XCTAssertEqual(image.size.height, 404)
  }

}

#endif
