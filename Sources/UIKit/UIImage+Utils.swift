//
// Mechanica
//
// Copyright © 2016-2017 Tinrobots.
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

#if os(iOS) || os(tvOS) || watchOS

import UIKit

extension UIImage {

  /// **Mechanica**
  ///
  /// Returns an image with a background `color`, `size` and `scale`.
  /// - Parameters:
  ///   - color: The background UIColor.
  ///   - size: The image size (default is 1x1).
  ///   - scale: The scale factor to apply; if you specify a value of 0.0, the scale factor is set to the scale factor of the device’s main screen.
  /// - Note: The size of the rectangle is beeing rounded from UIKit.
  public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1), scale: CGFloat = 0.0) {
    let rect = CGRect(origin: .zero, size: size)

    let format = UIGraphicsImageRendererFormat()
    format.scale = scale
    let renderer = UIGraphicsImageRenderer(size: size, format: format)
    let image = renderer.image { (context) in
      color.setFill()
      context.fill(rect)
    }
    guard let cgImage = image.cgImage else { return nil }
    self.init(cgImage: cgImage)

    // left only for reference
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

#endif
