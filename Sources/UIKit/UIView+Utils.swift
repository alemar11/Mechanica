#if canImport(UIKit) && (os(iOS) || os(tvOS) || watchOS)

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
    if #available(iOS 11, tvOS 11, *) { // iOS 11+
      let format = UIGraphicsImageRendererFormat()
      format.opaque = isOpaque
      format.scale = scale
      let renderer = UIGraphicsImageRenderer(size: frame.size, format: format)
      
      return renderer.image { _ in
        drawHierarchy(in: frame, afterScreenUpdates: true)
      }
    } else { // iOS 10
      return UIGraphicsImageRenderer(bounds: bounds).image { layer.render(in: $0.cgContext) }
    }
  }
}

#endif
