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
    /// Returns the image aspect ratio.
    var aspectRatio: CGFloat {
      return size.height / size.width
    }
    
    /// **Mechanica**
    ///
    /// Returns an image with a given `color` and `size`.
    public convenience init?(color: UIColor, size: CGSize) {
      let rect = CGRect(origin: .zero, size: size)
      
      UIGraphicsBeginImageContextWithOptions(size, false, 0)
      defer { UIGraphicsEndImageContext() }
      
      color.setFill()
      UIRectFill(rect)
      
      guard let image = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else { return nil }
      
      self.init(cgImage: image)
    }
    
    /// **Mechanica**
    ///
    /// Checks if the image has alpha component.
    var hasAlpha: Bool {
      let result: Bool
      guard let alpha = cgImage?.alphaInfo else { return false }
      
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
    var toData: Data? {
      return hasAlpha ? UIImagePNGRepresentation(self) : UIImageJPEGRepresentation(self, 1.0)
    }
    
    // WIP
    // https://stackoverflow.com/questions/11342897/how-to-compare-two-uiimage-objects
    // https://gist.github.com/SheffieldKevin/566dc048dd6f36716bcd
    func isEqual(to image: UIImage, density: CGFloat = 0.001, accuracy: Double = 0.01) -> Bool {
      if !self.size.equalTo(image.size) { return false }
      
      let pixelsWidth: Int = self.cgImage!.width
      let pixelsHeight: Int = self.cgImage!.height
      let pixelsToCompare: Int  = Int(CGFloat(pixelsWidth * pixelsHeight) * density)
      
      var pixel1 = UInt()
      let context1 = CGContext(data: &pixel1, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
      
      var pixel2 = UInt()
      let context2 = CGContext(data: &pixel2, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
      
      var misses = 0
      for _ in 0..<pixelsToCompare {
        let pixelX = Int(arc4random()) % pixelsWidth
        let pixelY = Int(arc4random()) % pixelsHeight
        
        context1?.draw(self.cgImage!, in: CGRect(x: CGFloat(-pixelX), y: CGFloat(-pixelY), width: CGFloat(pixelsWidth), height: CGFloat(pixelsHeight)))
        context2?.draw(image.cgImage!, in: CGRect(x: CGFloat(-pixelX), y: CGFloat(-pixelY), width: CGFloat(pixelsWidth), height: CGFloat(pixelsHeight)))
        
        if pixel1 != pixel2 { misses += 1 }
      }
      
      return (Double(misses / pixelsToCompare) <= accuracy)
    }
    
  }
  
#endif
