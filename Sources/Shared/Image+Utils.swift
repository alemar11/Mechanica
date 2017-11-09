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

#if os(iOS) || os(tvOS) || os(watchOS)
  import UIKit
  /// **Mechanica**
  ///
  /// Alias for UIImage.
  public typealias Image = UIKit.UIImage
#elseif os(macOS)
  import AppKit
  /// **Mechanica**
  ///
  /// Alias for NSImage.
  public typealias Image = AppKit.NSImage
#endif

extension Image {
  
  /// **Mechanica**
  ///
  /// Initializes and returns the image object with the specified base64 data.
  public convenience init?(base64EncodedString: String) {
    guard
      let url = URL(string: base64EncodedString),
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
    let result: Bool
    #if os(iOS) || os(tvOS) || os(watchOS)
      guard let alpha = cgImage?.alphaInfo else { return false }
      
    #elseif os(macOS)
      var imageRect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
      guard let imageRef = cgImage(forProposedRect: &imageRect, context: nil, hints: nil) else { return false }
      
      let alpha = imageRef.alphaInfo
    #endif
    
    switch alpha {
    case .none, .noneSkipFirst, .noneSkipLast:
      result = false
    default:
      result = true
    }
    
    return result
  }
  
  /// **Mechanica**
  ///
  /// Convert the image to data.
  public var data: Data? {
    #if os(iOS) || os(tvOS) || os(watchOS)
      return hasAlpha ? UIImagePNGRepresentation(self) : UIImageJPEGRepresentation(self, 1.0)
      
    #elseif os(macOS)
      guard let data = tiffRepresentation else { return nil }
      let imageFileType: NSBitmapImageRep.FileType = hasAlpha ? .png : .jpeg
      
      return NSBitmapImageRep(data: data)? .representation(using: imageFileType, properties: [:])
    #endif
  }
  
}
