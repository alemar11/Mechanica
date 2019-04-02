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

#if canImport(UIKit)

import UIKit

// MARK: - Properties

extension UIEdgeInsets {
  /// **Mechanica**
  ///
  /// Returns the vertical insets (composed by top + bottom).
  public var vertical: CGFloat {
    return top + bottom
  }

  /// **Mechanica**
  ///
  /// Returns the horizontal insets (composed by  left + right).
  public var horizontal: CGFloat {
    return left + right
  }
}

// MARK: - Methods

extension UIEdgeInsets {
  /// **Mechanica**
  ///
  /// Creates an `UIEdgeInsets` with the same inset value applied to all (top, bottom, right, left)
  public init(inset: CGFloat) {
    self.init(top: inset, left: inset, bottom: inset, right: inset)
  }

  /// **Mechanica**
  ///
  /// Creates an `UIEdgeInsets` with the horizontal value equally divided and applied to right and left and the vertical value equally divided and applied to top and bottom.
  ///
  /// - Parameter horizontal: Inset to be applied to right and left.
  /// - Parameter vertical: Inset to be applied to top and bottom.
  public init(horizontal: CGFloat, vertical: CGFloat) {
    self.init(top: vertical / 2, left: horizontal / 2, bottom: vertical / 2, right: horizontal / 2)
  }
}

#endif
