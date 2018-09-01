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

#if os(iOS) || os(tvOS) || watchOS

  import UIKit

  extension UIView {

    /// **Mechanica**
    ///
    /// The radius to use when drawing rounded corners.
    /// - Note: Inspectable from Storyboard.
    @IBInspectable
    var cornerRadius: CGFloat {
      get {
        return layer.cornerRadius
      }
      set {
        layer.cornerRadius = newValue
      }
    }

    /// **Mechanica**
    ///
    /// The width of the view's border.
    /// - Note: Inspectable from Storyboard.
    @IBInspectable
    var borderWidth: CGFloat {
      get {
        return layer.borderWidth
      }
      set {
        layer.borderWidth = newValue
      }
    }

    /// **Mechanica**
    ///
    /// The color of the view's border.
    /// - Note: Inspectable from Storyboard.
    @IBInspectable
    var borderColor: UIColor? {
      get {
        guard let color = layer.borderColor else { return nil }
        return UIColor(cgColor: color)
      }
      set {
        if let color = newValue {
          layer.borderColor = color.cgColor
        } else {
          layer.borderColor = nil
        }
      }
    }

    /// **Mechanica**
    ///
    /// The blur radius (in points) used to render the view's shadow.
    /// - Note: Inspectable from Storyboard.
    @IBInspectable
    var shadowRadius: CGFloat {
      get {
        return layer.shadowRadius
      }
      set {
        layer.shadowRadius = newValue
      }
    }

    /// **Mechanica**
    ///
    /// The opacity of the view's shadow.
    /// - Note: Inspectable from Storyboard.
    @IBInspectable
    var shadowOpacity: Float {
      get {
        return layer.shadowOpacity
      }
      set {
        layer.shadowOpacity = newValue
      }
    }

    /// **Mechanica**
    ///
    /// The offset (in points) of the view's shadow.
    /// - Note: Inspectable from Storyboard.
    @IBInspectable
    var shadowOffset: CGSize {
      get {
        return layer.shadowOffset
      }
      set {
        layer.shadowOffset = newValue
      }
    }

    /// **Mechanica**
    ///
    /// The color of the view's shadow.
    /// - Note: Inspectable from Storyboard.
    @IBInspectable
    var shadowColor: UIColor? {
      get {
        guard let color = layer.shadowColor else { return nil }
        return UIColor(cgColor: color)
      }
      set {
        if let color = newValue {
          layer.shadowColor = color.cgColor
        } else {
          layer.shadowColor = nil
        }
      }
    }

  }

#endif

#if os(iOS) || os(tvOS)

  extension UIView {

    /// **Mechanica**
    ///
    /// A Boolean value that determines whether the view’s autoresizing mask is translated into Auto Layout constraints.
    public var usesAutoLayout: Bool {
      get { return !translatesAutoresizingMaskIntoConstraints }
      set { translatesAutoresizingMaskIntoConstraints = !newValue }
    }

    /// **Mechanica**
    ///
    /// Takes a screenshot with the current device's screen scale.
    /// If an animation is running it captures the final frame of the animation.
    ///
    /// - Parameter scale: The scale factor to apply; if you specify a value of 0.0, the scale factor is set to the scale factor of the device’s main screen.
    public func screenshot(scale: CGFloat = 0.0) -> UIImage {
      if #available(iOS 10, *) {
        return UIGraphicsImageRenderer(bounds: bounds).image { layer.render(in: $0.cgContext) }
      }

      let format = UIGraphicsImageRendererFormat()
      format.opaque = isOpaque
      format.scale = scale
      let renderer = UIGraphicsImageRenderer(size: frame.size, format: format)

      return renderer.image { _ in
        drawHierarchy(in: frame, afterScreenUpdates: true)
      }
    }

  }

#endif
