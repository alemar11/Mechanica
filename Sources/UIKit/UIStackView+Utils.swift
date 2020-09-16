#if canImport(UIKit) && (os(iOS) || os(tvOS))

import UIKit

extension UIStackView {
  /// **Mechanica**
  ///
  /// Adds a background color.
  ///
  /// - Parameters:
  ///   - color: The view’s background color.
  /// - Returns: The UIView used to apply the background color.
  @discardableResult
  func addBackgroundColor(_ color: UIColor) -> UIView {
    return addUnarrangedView(color: color, cornerRadius: 0, at: 0)
  }

  /// **Mechanica**
  ///
  /// Adds a foreground color.
  ///
  /// - Parameters:
  ///   - color: The view’s foreground color.
  /// - Returns: The UIView used to apply the foreground color.
  @discardableResult
  func addForegroundColor(_ color: UIColor) -> UIView {
    let index = subviews.count
    return addUnarrangedView(color: color, cornerRadius: 0, at: index)
  }

  /// **Mechanica**
  ///
  /// Adds a `new` *unarranged* subview.
  ///
  /// - Parameters:
  ///   - color: The view’s background color.
  ///   - cornerRadius: The radius used to draw rounded corners.
  ///   - index: The index in the array of the subviews property at which to insert the view.
  /// - Returns: The inserted view.
  @discardableResult
  func addUnarrangedView(color: UIColor, cornerRadius: CGFloat = 0, at index: Int = 0) -> UIView {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = color
    view.layer.cornerRadius = cornerRadius
    insertSubview(view, at: index)

    NSLayoutConstraint.activate([
      view.leadingAnchor.constraint(equalTo: leadingAnchor),
      view.trailingAnchor.constraint(equalTo: trailingAnchor),
      view.topAnchor.constraint(equalTo: topAnchor),
      view.bottomAnchor.constraint(equalTo: bottomAnchor)
      ])

    return view
  }
}

#endif
