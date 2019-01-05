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

#if canImport(UIKit) && (os(iOS) || os(tvOS))

import UIKit

public extension UIStackView {

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
