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

#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)

  import CoreGraphics

  extension CGRect {

    /// **Mechanica**
    ///
    /// Returns a `CGRect` value initialized with an origin at (0,0) and the provided width and height.
    ///
    /// - Parameters:
    ///   - width: The width.
    ///   - height: The height.
    public init(width: CGFloat, height: CGFloat) {
      self.init(x: 0, y: 0, width: width, height: height)
    }

    /// **Mechanica**
    ///
    /// The center point.
    public var center: CGPoint {
      get {
        return CGPoint(x: midX, y: midY)
      }
      set {
        // swiftlint:disable identifier_name
        let x = newValue.x - width / 2.0
        let y = newValue.y - height / 2.0
        // swiftlint:enable identifier_name
        let newOrigin = CGPoint(x: x, y: y)

        self.origin = newOrigin
      }
    }

    /// **Mechanica**
    ///
    /// Returns the `CGRect` area.
    public var area: CGFloat {
      return height * width
    }

    /// **Mechanica**
    ///
    /// Returns a `CGRect` rounded to an integral value using the specified rounding `rule`.
    ///
    /// Example:
    ///
    ///     CGRect(x: 10.3, y: 11.5, width: 12.7, height: 13.0).rounded(rule: .down) -> CGRect(x: 10, y: 11, width: 12, height: 13)
    ///     CGRect(x: 10.3, y: 11.5, width: 12.7, height: 13.0).rounded(rule: .up) -> CGRect(x: 11, y: 12, width: 13, height: 13)
    ///
    public func rounded(rule: FloatingPointRoundingRule) -> CGRect {
      return CGRect(
        x: origin.x.rounded(rule),
        y: origin.y.rounded(rule),
        width: size.width.rounded(rule),
        height: size.height.rounded(rule)
      )
    }

  }

#endif
