//
// Mechanica
//
// Copyright © 2016-2018 Tinrobots.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#if os(iOS) || os(tvOS)

import XCTest
import UIKit
@testable import Mechanica

let scale = Int(UIScreen.main.scale.rounded())
let squareSize = CGSize(width: 50, height: 50)
let horizontalRectangularSize = CGSize(width: 60, height: 30)
let verticalRectangularSize = CGSize(width: 30, height: 60)

final class UIImageUtilsTests: XCTestCase {
  
  func testInitWithColorAndSize() {
    let scale = UIScreen.main.scale
    
    XCTAssertEqual(UIImage(color: .red)?.size, CGSize(width: 1*scale, height: 1*scale))
    XCTAssertEqual(UIImage(color: .red, size: CGSize(width: 50, height: 50))?.size, CGSize(width: 50*scale, height: 50*scale))
    XCTAssertNil(UIImage(color: .red, size: CGSize(width: 0, height: 0)))
    XCTAssertEqual(UIImage(color: .red, size: CGSize(width: 11.3, height: 3.11))?.size, CGSize(width: (11.3*scale).ceiled(to: 0), height: (3.11*scale).ceiled(to: 0)))
    XCTAssertEqual(UIImage(color: .red, scale: 1.0)?.size, CGSize(width: 1, height: 1))
    XCTAssertEqual(UIImage(color: .red, scale: 3.0)?.size, CGSize(width: 3, height: 3))
    XCTAssertEqual(UIImage(color: .red, scale: 4.0)?.size, CGSize(width: 4, height: 4))
    XCTAssertEqual(UIImage(color: .red, size: CGSize(width: 11.3, height: 3.11), scale: 4.0)?.size, CGSize(width: (11.3*4.0).ceiled(to: 0), height: (3.11*4.0).ceiled(to: 0)))
  }

  func testAspectScaledToFitSquareSize() {
    executeImageAspectScaledToFitSizeTest(squareSize)
  }

  func testAspectScaledToFitHorizontalRectangularSize() {
    executeImageAspectScaledToFitSizeTest(horizontalRectangularSize)
  }

  func testAspectScaledToFitVerticalRectangularSize() {
    executeImageAspectScaledToFitSizeTest(verticalRectangularSize)
  }

  func testAspectScaledToFillSquareSize() {
    executeImageAspectScaledToFillSizeTest(squareSize)
  }

  func testAspectScaledToFillHorizontalRectangularSize() {
    executeImageAspectScaledToFillSizeTest(horizontalRectangularSize)
  }

  func testAspectScaledToFillVerticalRectangularSize() {
    executeImageAspectScaledToFillSizeTest(verticalRectangularSize)
  }

  func testScale() {
    let image = Image(data: Resource.robot.data)!.copy() as! Image
    let size = CGSize(width: 50, height: 70)
    let scaled = image.scaled(to: size)
    XCTAssertEqual(scaled.size, size)
  }
  
//  func testAspectScaleToFill() {
//    let image = Image(data: Resource.robot.data)!.copy() as! Image
//    let size = CGSize(width: 50, height: 70)
//    let scaled = image.aspectScaled(toFit: size)
//    XCTAssertEqual(scaled.size, size)
//  }

//  func testAspectScaleToFit() {
//    do {
//      let image = Image(data: Resource.robot.data)!.copy() as! Image
//      let size = CGSize(width: 50, height: 70)
//      let scaled = image.aspectScaled(toFill: size)
//      XCTAssertEqual(scaled.size, size)
//    }
//
//    do {
//      let image = Image(data: Resource.glasses.data)!.copy() as! Image
//      let size = CGSize(width: 50, height: 70)
//      let scaled = image.aspectScaled(toFill: size)
//      XCTAssertEqual(scaled.size, size)
//    }
//  }

  func testRounding() {
    do {
      let image = Image(data: Resource.robot.data)!.copy() as! Image
      let circle = image.roundedIntoCircle()
      XCTAssertEqual(circle.size, image.size)
      
      let rounded = image.rounded(withCornerRadius: 10, divideRadiusByImageScale: true)
      XCTAssertEqual(rounded.size, image.size)
    }
    
    do {
      let image = Image(data: Resource.glasses.data)!.copy() as! Image /// 483 x 221
      let circle = image.roundedIntoCircle()
      XCTAssertEqual(circle.size.height, image.size.height)
      XCTAssertEqual(circle.size.width, image.size.height)
      
      let rounded = image.rounded(withCornerRadius: 10, divideRadiusByImageScale: true)
      XCTAssertEqual(rounded.size, image.size)
    }
  }

  private func executeImageAspectScaledToFitSizeTest(_ size: CGSize) {
    // Given
    let w = Int(size.width.rounded())
    let h = Int(size.height.rounded())

    let appleData = Resource.apple.data
    let appleScaledToFitData = Resource.scaledToFit(name: "apple-aspect.scaled.to.fit-\(w)x\(h)-@\(scale)x.png").data

    // When
    let apple = UIImage(data: appleData, scale: UIScreen.main.scale)!
    let scaledAppleImage = apple.aspectScaled(toFit: size)

    // Then
    let expectedAppleImage = UIImage(data: appleScaledToFitData, scale: CGFloat(scale))!
    XCTAssertEqual(scaledAppleImage.scale, CGFloat(scale), "The image scale (\(scaledAppleImage.scale)) should be equal to screen scale (\(scale)).")
    XCTAssertTrue(scaledAppleImage.isEqualToImage(expectedAppleImage, withinTolerance: 4), "The scaled apple image pixels do not match")
  }

  private func executeImageAspectScaledToFillSizeTest(_ size: CGSize) {
    // Given
    let w = Int(size.width.rounded())
    let h = Int(size.height.rounded())

    let appleData = Resource.apple.data
    let appleScaledToFillData = Resource.scaledToFill(name: "apple-aspect.scaled.to.fill-\(w)x\(h)-@\(scale)x.png").data

    // When
    let apple = UIImage(data: appleData, scale: UIScreen.main.scale)!
    let scaledAppleImage = apple.aspectScaled(toFill: size)

    // Then
    let expectedAppleImage = UIImage(data: appleScaledToFillData, scale: CGFloat(scale))!
    XCTAssertEqual(scaledAppleImage.scale, CGFloat(scale), "The image scale (\(scaledAppleImage.scale)) should be equal to screen scale (\(scale)).")
    XCTAssertTrue(scaledAppleImage.isEqualToImage(expectedAppleImage, withinTolerance: 4), "The scaled apple image pixels do not match")
  }
  
}

#endif

#if !os(macOS)

import UIKit

extension UIImage {
  func isEqualToImage(_ image: UIImage, withinTolerance tolerance: UInt8 = 3) -> Bool {
    guard size.equalTo(image.size) else { return false }

    let image1 = imageWithPNGRepresentation().renderedImage()
    let image2 = image.imageWithPNGRepresentation().renderedImage()

    guard let rendered1 = image1, let rendered2 = image2 else {
      return false
    }

    let pixelData1 = rendered1.cgImage?.dataProvider?.data
    let pixelData2 = rendered2.cgImage?.dataProvider?.data

    guard let validPixelData1 = pixelData1, let validPixelData2 = pixelData2 else { return false }

    let data1 = Data(bytes: CFDataGetBytePtr(validPixelData1), count: CFDataGetLength(validPixelData1))
    let data2 = Data(bytes: CFDataGetBytePtr(validPixelData2), count: CFDataGetLength(validPixelData2))

    guard data1.count == data2.count else {
      return false
    }

    for index in 0..<data1.count {
      let byte1 = data1[index]
      let byte2 = data2[index]
      let delta = UInt8(abs(Int(byte1) - Int(byte2)))

      guard delta <= tolerance else { return false }
    }

    return true
  }

  public func renderedImage() -> UIImage? {
    // Do not attempt to render animated images
    guard images == nil else { return nil }

    // Do not attempt to render if not backed by a CGImage
    guard let image = cgImage?.copy() else { return nil }

    let width = image.width
    let height = image.height
    let bitsPerComponent = image.bitsPerComponent

    // Do not attempt to render if too large or has more than 8-bit components
    guard width * height <= 4096 * 4096 && bitsPerComponent <= 8 else { return nil }

    let bytesPerRow: Int = 0
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    var bitmapInfo = image.bitmapInfo

    // Fix alpha channel issues if necessary
    let alpha = (bitmapInfo.rawValue & CGBitmapInfo.alphaInfoMask.rawValue)

    if alpha == CGImageAlphaInfo.none.rawValue {
      bitmapInfo.remove(.alphaInfoMask)
      bitmapInfo = CGBitmapInfo(rawValue: bitmapInfo.rawValue | CGImageAlphaInfo.noneSkipFirst.rawValue)
    } else if !(alpha == CGImageAlphaInfo.noneSkipFirst.rawValue) || !(alpha == CGImageAlphaInfo.noneSkipLast.rawValue) {
      bitmapInfo.remove(.alphaInfoMask)
      bitmapInfo = CGBitmapInfo(rawValue: bitmapInfo.rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue)
    }

    // Render the image
    let context = CGContext(
      data: nil,
      width: width,
      height: height,
      bitsPerComponent: bitsPerComponent,
      bytesPerRow: bytesPerRow,
      space: colorSpace,
      bitmapInfo: bitmapInfo.rawValue
    )

    context?.draw(image, in: CGRect(x: 0.0, y: 0.0, width: CGFloat(width), height: CGFloat(height)))

    // Make sure the inflation was successful
    guard let renderedImage = context?.makeImage() else { return nil }

    return UIImage(cgImage: renderedImage, scale: self.scale, orientation: imageOrientation)
  }

  /**
   Modifies the underlying UIImage data to use a PNG representation.
   This is important in verifying pixel data between two images. If one has been exported out with PNG
   compression and another has not, the image data between the two images will never be equal. This helper
   method helps ensure comparisons will be valid.
   - returns: The PNG representation image.
   */
  func imageWithPNGRepresentation() -> UIImage {
    let data = UIImagePNGRepresentation(self)!
    let image = UIImage(data: data, scale: UIScreen.main.scale)!

    return image
  }
}

#endif
