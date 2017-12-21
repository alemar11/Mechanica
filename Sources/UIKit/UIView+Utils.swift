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

#if os(iOS) || os(tvOS)

import UIKit

extension UIView {

  /// **Mechanica**
  ///
  /// A Boolean value that determines whether the view’s autoresizing mask is translated into Auto Layout constraints.
  internal var usesAutoLayout: Bool {
    //TODO: review
    get { return !translatesAutoresizingMaskIntoConstraints }
    set { translatesAutoresizingMaskIntoConstraints = !newValue }
  }

  /// **Mechanica**
  ///
  /// Take sceenshot with the current device's screen scale.
  internal func screenshot() -> UIImage {
    //TODO: review
    // note: by default UIGraphicsImageRenderer sets the scale to the device's screen scale.
    return UIGraphicsImageRenderer(bounds: bounds).image { rendererContext in
      //layer.render(in: rendererContext.cgContext)
      drawHierarchy(in: CGRect(origin: .zero, size: bounds.size), afterScreenUpdates: true)
    }

  }

}

#endif
