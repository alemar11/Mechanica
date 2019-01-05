//
// Mechanica
//
// Copyright © 2016-2019 Tinrobots.
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

#if canImport(UIKit)
import UIKit
/// **Mechanica**
///
/// Alias for UIImage.
public typealias Image = UIKit.UIImage
#elseif canImport(AppKit)
import AppKit
/// **Mechanica**
///
/// Alias for NSImage.
public typealias Image = AppKit.NSImage
#endif

extension Image {

  /// **Mechanica**
  ///
  /// Initializes a `new` image object from a Base-64 encoded String.
  ///
  /// - parameter base64String: The string to parse.
  public convenience init?(base64Encoded base64String: String) {
    guard
      let url = URL(string: base64String),
      let data = try? Data(contentsOf: url)
      else {
        return nil
    }

    self.init(data: data)
  }

  /// **Mechanica**
  ///
  /// Checks if the image has alpha component.
  public var hasAlpha: Bool {
    #if canImport(UIKit)
    guard let alphaInfo = cgImage?.alphaInfo else { return false }

    #elseif canImport(AppKit)
    var imageRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    guard let imageRef = cgImage(forProposedRect: &imageRect, context: nil, hints: nil) else { return false }

    let alphaInfo = imageRef.alphaInfo
    #endif

    return (
      alphaInfo == .first ||
        alphaInfo == .last ||
        alphaInfo == .premultipliedFirst ||
        alphaInfo == .premultipliedLast
    )
  }

  /// **Mechanica**
  ///
  /// Returns whether the image is opaque.
  public var isOpaque: Bool { return !hasAlpha }

  /// **Mechanica**
  ///
  /// Convert the image to data.
  /// - Note: If the image has an alpha component, the PNG format will be used, otherwise the JPEG without compression.
  public var data: Data? {
    #if canImport(UIKit)
    return hasAlpha ? pngData() : jpegData(compressionQuality: 1.0)

    #elseif canImport(AppKit)
    guard let data = tiffRepresentation else { return nil }

    let imageFileType: NSBitmapImageRep.FileType = hasAlpha ? .png : .jpeg

    return NSBitmapImageRep(data: data)? .representation(using: imageFileType, properties: [:])
    #endif
  }

}

#if canImport(CoreGraphics)

extension Image {

  private struct AssociatedKey {
    static var isInflated = "\(associatedKeyPrefix).Shared.Image.isInflated"
  }

  /// **Mechanica**
  ///
  /// Returns whether the image is inflated.
  public var isInflated: Bool {
    get {
      if let inflated = objc_getAssociatedObject(self, &AssociatedKey.isInflated) as? Bool {
        return inflated
      }
      return false
    }
    set {
      objc_setAssociatedObject(self, &AssociatedKey.isInflated, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }

  /// **Mechanica**
  ///
  /// Inflates the underlying compressed image data to be backed by an uncompressed bitmap representation.
  ///
  /// It allows a bitmap representation to be constructed in the background rather than on the main thread.
  ///
  /// - Note: Inflating compressed image formats (such as PNG or JPEG) in a background queue can significantly improve drawing performance on the main thread.
  public func inflate() {
    guard !isInflated else { return }

    isInflated = true
    _ = cgImage?.dataProvider?.data
  }

  #if os(iOS) || os(tvOS) || os(macOS)

  /// **Mechanica**
  ///
  /// Creates a `new` image downsampling an image at given URL for display at smaller size.
  ///
  /// - Parameters:
  ///   - imageURL: The image URL to read from.
  ///   - pointSize: The size of the new image.
  ///   - scale: The scale factor to apply
  /// - Returns: A downsampled image.
  /// - SeeAlso: [Image and Graphics Best Practices](https://developer.apple.com/videos/play/wwdc2018/219/)
  public class func downsampledImage(at imageURL: URL, to pointSize: CGSize, scaleFactor: CGFloat) -> Image? {
    let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
    guard let imageSource = CGImageSourceCreateWithURL(imageURL as CFURL, imageSourceOptions) else { return nil }

    return downsampledImage(imageSource: imageSource, to: pointSize, scaleFactor: scaleFactor)
  }

  /// **Mechanica**
  ///
  /// Creates a `new` image downsampling an image with a given data for display at smaller size.
  ///
  /// - Parameters:
  ///   - imageData: The image data to read from.
  ///   - pointSize: The size of the new image.
  ///   - scale: The scale factor to apply
  /// - Returns: A downsampled image.
  /// - SeeAlso: [Image and Graphics Best Practices](https://developer.apple.com/videos/play/wwdc2018/219/)
  public class func downsampledImage(with imageData: Data, to pointSize: CGSize, scaleFactor: CGFloat) -> Image? {
    let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
    guard let imageSource = CGImageSourceCreateWithData(imageData as CFData, imageSourceOptions) else { return nil }

    return downsampledImage(imageSource: imageSource, to: pointSize, scaleFactor: scaleFactor)
  }

  private class func downsampledImage(imageSource: CGImageSource, to pointSize: CGSize, scaleFactor: CGFloat) -> Image? {
    let maxDimensionInPixels = max(pointSize.width, pointSize.height) * scaleFactor
    let downsampleOptions = [kCGImageSourceCreateThumbnailFromImageAlways: true,
                             kCGImageSourceShouldCacheImmediately: true,
                             kCGImageSourceCreateThumbnailWithTransform: true,
                             kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels] as CFDictionary

    guard let downsampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions) else { return nil }

    #if canImport(UIKit)
    return Image(cgImage: downsampledImage)
    #elseif canImport(AppKit)
    return Image(cgImage: downsampledImage, size: pointSize)
    #else
    return nil
    #endif
  }

  #endif
}

#endif
