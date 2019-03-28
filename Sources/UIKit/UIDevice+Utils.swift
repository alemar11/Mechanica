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

extension UIDevice {
  // MARK: - Device Interface Type

  /// **Mechanica**
  ///
  /// Returns `true` if the interface is designed for iPhone or iPod.
  public var hasPhoneInterface: Bool {
    return userInterfaceIdiom == .phone
  }

  /// **Mechanica**
  ///
  /// Returns `true` if the interface is designed for iPad.
  public var hasPadInterface: Bool {
    return userInterfaceIdiom == .pad
  }

  /// **Mechanica**
  ///
  /// Returns `true` if the interface is designed for Apple TV.
  public var hasTVInterface: Bool {
    return userInterfaceIdiom == .tv
  }

  /// **Mechanica**
  ///
  /// Returns `true` if the interface is designed for Apple CarPlay.
  public var hasCarPlayInterface: Bool {
    return userInterfaceIdiom == .carPlay
  }
}

#endif
