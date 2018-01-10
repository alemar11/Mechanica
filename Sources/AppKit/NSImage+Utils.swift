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

#if os(macOS)

import AppKit

extension NSImage {

  /// **Mechanica**
  ///
  /// - Parameters:
  ///   - name: The name of the image.
  ///   - bundle: The bundle containing the image file or asset catalog, if nil the behavior is identical to `init(named:)`.
  /// - Returns: The image object associated with the specified filename.
  internal class func imageNamed(name: String, in bundle: Bundle?) -> NSImage? {
    //TODO: review
    let name = NSImage.Name(rawValue: name)

    guard let bundle = bundle else { return NSImage(named: name) }

    if let image = bundle.image(forResource: name) {
      image.setName(name)
      return image
    }

    return nil
  }

  /// **Mechanica**
  ///
  /// Returns a CGImage object for the associated image data.
  public var cgImage: CGImage? {
    let imageData = self.tiffRepresentation
    guard let source = CGImageSourceCreateWithData(imageData! as CFData, nil) else { return nil }
    return CGImageSourceCreateImageAtIndex(source, 0, nil)
  }

}

#endif
