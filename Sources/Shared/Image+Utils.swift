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
    var imageRect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    guard let imageRef = cgImage(forProposedRect: &imageRect, context: nil, hints: nil) else { return false }

    let alphaInfo = imageRef.alphaInfo
    #endif

    //    switch alphaInfo {
    //    case .none, .noneSkipFirst, .noneSkipLast:
    //      return false
    //    default:
    //      return true
    //    }

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
  public var data: Data? {
    #if canImport(UIKit)
    return hasAlpha ? UIImagePNGRepresentation(self) : UIImageJPEGRepresentation(self, 1.0)

    #elseif canImport(AppKit)
    guard let data = tiffRepresentation else { return nil }
    let imageFileType: NSBitmapImageRep.FileType = hasAlpha ? .png : .jpeg

    return NSBitmapImageRep(data: data)? .representation(using: imageFileType, properties: [:])
    #endif
  }

}

extension Image {

  private struct AssociatedKey {
    static var inflated = "\(associatedKeyPrefix).UIImage.inflated"
  }

  /// **Mechanica**
  ///
  /// Returns whether the image is inflated.
  public var inflated: Bool {
    get {
      if let inflated = objc_getAssociatedObject(self, &AssociatedKey.inflated) as? Bool {
        return inflated
      }
      return false
    }
    set {
      objc_setAssociatedObject(self, &AssociatedKey.inflated, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
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
    guard !inflated else { return }

    inflated = true
    _ = cgImage?.dataProvider?.data
  }

}
