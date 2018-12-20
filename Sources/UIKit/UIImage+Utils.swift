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

#if canImport(UIKit) && (os(iOS) || os(tvOS) || watchOS)

import UIKit

extension UIImage {

  /// **Mechanica**
  ///
  /// Returns an image with a background `color`, `size` and `scale`.
  /// - Parameters:
  ///   - color: The background UIColor.
  ///   - size: The image size (default is 1x1).
  ///   - scaleFactor: The scale factor to apply; if you specify a value of 0.0, the scale factor is set to the scale factor of the device’s main screen.
  /// - Note: The size of the rectangle is beeing rounded from UIKit.
  public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1), scale scaleFactor: CGFloat = 0.0) {
    let rect = CGRect(origin: .zero, size: size)

    let format = UIGraphicsImageRendererFormat()
    format.scale = scaleFactor
    let renderer = UIGraphicsImageRenderer(size: size, format: format)
    let image = renderer.image { (context) in
      color.setFill()
      context.fill(rect)
    }
    guard let cgImage = image.cgImage else { return nil }

    self.init(cgImage: cgImage)

    /// left only for reference
    /*
     UIGraphicsBeginImageContextWithOptions(size, false, scale)
     defer { UIGraphicsEndImageContext() }
     color.setFill()
     UIRectFill(rect)

     guard let cgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else { return nil }

     self.init(cgImage: cgImage)
     */
  }

}

// MARK: - Scaling

extension UIImage {

  /// **Mechanica**
  ///
  /// Returns a new version of the image scaled to the specified size.
  ///
  /// - Parameters:
  ///   - size: The size to use when scaling the new image.
  ///   - scale scaleFactor: The display scale of the image renderer context (defaults to the scale of the main screen).
  ///
  /// - Returns: A `new` scaled UIImage.
  /// - Note: The opaqueness is the same of the initial images.
  public func scaled(to size: CGSize, scale scaleFactor: CGFloat = 0.0) -> UIImage {
    return scaled(to: size, opaque: isOpaque, scale: scale)
  }

  /// **Mechanica**
  ///
  /// Returns a new version of the image scaled to the specified size.
  ///
  /// - Parameters:
  ///   - size: The size to use when scaling the new image.
  ///   - scale scaleFactor: The display scale of the image renderer context (defaults to the scale of the main screen).
  ///   - opaque: Specifying `false` means that the image will include an alpha channel.
  ///
  /// - Returns: A `new` scaled UIImage.
  public func scaled(to size: CGSize, opaque: Bool = false, scale scaleFactor: CGFloat = 0.0) -> UIImage {
    assert(size.width > 0 && size.height > 0, "An image with zero width or height cannot be scaled properly.")

    UIGraphicsBeginImageContextWithOptions(size, opaque, scaleFactor)
    draw(in: CGRect(origin: .zero, size: size))

    let scaledImage = UIGraphicsGetImageFromCurrentImageContext() ?? self
    UIGraphicsEndImageContext()

    return scaledImage
  }

  /// **Mechanica**
  ///
  /// Returns a new version of the image scaled from the center while maintaining the aspect ratio to fit within
  /// a specified size.
  ///
  /// - Parameters:
  ///   - size: The size to use when scaling the new image.
  ///   - scaleFactor: The display scale of the image renderer context (defaults to the scale of the main screen).
  ///
  /// - Returns: A new image object.
  public func aspectScaled(toFit size: CGSize, scale scaleFactor: CGFloat = 0.0) -> UIImage {
    assert(size.width > 0 && size.height > 0, "You cannot safely scale an image to a zero width or height")

    let imageAspectRatio = self.size.width / self.size.height
    let canvasAspectRatio = size.width / size.height

    var resizeFactor: CGFloat

    if imageAspectRatio > canvasAspectRatio {
      resizeFactor = size.width / self.size.width
    } else {
      resizeFactor = size.height / self.size.height
    }

    let scaledSize = CGSize(width: self.size.width * resizeFactor, height: self.size.height * resizeFactor)
    let origin = CGPoint(x: (size.width - scaledSize.width) / 2.0, y: (size.height - scaledSize.height) / 2.0)

    let format = UIGraphicsImageRendererFormat()
    format.scale = scaleFactor
    let renderer = UIGraphicsImageRenderer(size: size, format: format)
    let scaledImage = renderer.image { _ in
      draw(in: CGRect(origin: origin, size: scaledSize))
    }

    return scaledImage
  }

  /// **Mechanica**
  ///
  /// Returns a new version of the image scaled from the center while maintaining the aspect ratio to fill a
  /// specified size. Any pixels that fall outside the specified size are clipped.
  ///
  /// - Parameters:
  ///   - size: The size to use when scaling the new image.
  ///   - scaleFactor: The display scale of the image renderer context (defaults to the scale of the main screen).
  ///
  /// - returns: A new `UIImage` object.
  public func aspectScaled(toFill size: CGSize, scale scaleFactor: CGFloat = 0.0) -> UIImage {
    assert(size.width > 0 && size.height > 0, "An image with zero width or height cannot be scaled properly.")

    let imageAspectRatio = self.size.width / self.size.height
    let canvasAspectRatio = size.width / size.height

    var resizeFactor: CGFloat

    if imageAspectRatio > canvasAspectRatio {
      resizeFactor = size.height / self.size.height
    } else {
      resizeFactor = size.width / self.size.width
    }

    let scaledSize = CGSize(width: self.size.width * resizeFactor, height: self.size.height * resizeFactor)
    let origin = CGPoint(x: (size.width - scaledSize.width) / 2.0, y: (size.height - scaledSize.height) / 2.0)

    UIGraphicsBeginImageContextWithOptions(size, isOpaque, scaleFactor)
    draw(in: CGRect(origin: origin, size: scaledSize))

    let scaledImage = UIGraphicsGetImageFromCurrentImageContext() ?? self
    UIGraphicsEndImageContext()

    return scaledImage
  }
}

// MARK: - Rounding

extension UIImage {

  /// **Mechanica**
  ///
  /// Returns a new version of the image with the corners rounded to the specified radius.
  ///
  /// - parameter radius:                   The radius to use when rounding the new image.
  /// - parameter divideRadiusByImageScale: Whether to divide the radius by the image scale. Set to `true` when the
  ///                                       image has the same resolution for all screen scales such as @1x, @2x and
  ///                                       @3x (i.e. single image from web server). Set to `false` for images loaded
  ///                                       from an asset catalog with varying resolutions for each screen scale.
  ///                                       `false` by default.
  /// - parameter scaleFactor:                    The display scale of the image renderer context (defaults to the scale of the main screen).
  ///
  /// - returns: A new `UIImage` object.
  public func rounded(withCornerRadius radius: CGFloat, divideRadiusByImageScale: Bool = false, scale scaleFactor: CGFloat = 0.0) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(size, false, scaleFactor)

    let scaledRadius = divideRadiusByImageScale ? radius / scale : radius

    let clippingPath = UIBezierPath(roundedRect: CGRect(origin: CGPoint.zero, size: size), cornerRadius: scaledRadius)
    clippingPath.addClip()

    draw(in: CGRect(origin: CGPoint.zero, size: size))

    let roundedImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()

    return roundedImage
  }

  /// **Mechanica**
  ///
  /// Returns a new version of the image rounded into a circle.
  ///
  /// - parameter scaleFactor: The display scale of the image renderer context (defaults to the scale of the main screen).
  ///
  /// - returns: A new `UIImage` object.
  public func roundedIntoCircle(scale scaleFactor: CGFloat = 0.0) -> UIImage {
    let radius = min(size.width, size.height) / 2.0
    var squareImage = self

    if size.width != size.height {
      let squareDimension = min(size.width, size.height)
      let squareSize = CGSize(width: squareDimension, height: squareDimension)
      squareImage = aspectScaled(toFill: squareSize)
    }

    UIGraphicsBeginImageContextWithOptions(squareImage.size, false, scaleFactor)

    let clippingPath = UIBezierPath(
      roundedRect: CGRect(origin: CGPoint.zero, size: squareImage.size),
      cornerRadius: radius
    )

    clippingPath.addClip()

    squareImage.draw(in: CGRect(origin: CGPoint.zero, size: squareImage.size))

    let roundedImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()

    return roundedImage
  }

  /// **Mechanica**
  ///
  /// Returns a new decoded version of the image.
  ///
  /// It allows a bitmap representation to be decoded in the background rather than on the main thread.
  ///
  /// - Parameters:
  ///   - scale: The scale factor to assume when interpreting the image data (defaults to `self.scale`); the decoded image will have its size divided by this scale parameter.
  ///   - allowedMaxSize: The allowed max size, if the image is too large the decoding operation will return nil.
  /// - returns: A new decoded `UIImage` object.
  public func decoded(scale: CGFloat? = .none, allowedMaxSize: Int = 4096 * 4096) -> UIImage? {
    // Do not attempt to render animated images
    guard images == nil else { return nil }

    // Do not attempt to render if not backed by a CGImage
    guard let image = cgImage?.copy() else { return nil }

    let width = image.width
    let height = image.height
    let bitsPerComponent = image.bitsPerComponent

    // Do not attempt to render if too large or has more than 8-bit components
    guard width * height <= allowedMaxSize && bitsPerComponent <= 8 else { return nil } //TODO: remove this condition?

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
    guard let renderedImage = context?.makeImage() else {
      return nil
    }

    let imageScale = scale ?? self.scale
    return UIImage(cgImage: renderedImage, scale: imageScale, orientation: imageOrientation)
  }

}

#endif
