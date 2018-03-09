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

  import CoreGraphics.CGGeometry

  public extension CGSize {

    /// **Mechanica**
    ///
    ///  Returns the scale to fit `self` into a different `size`.
    ///
    /// - Parameter size: The size to fit into.
    /// - Returns: The scale to fit into the given size.
    public func scaleToFit(boundingSize size: CGSize) -> CGFloat {
      return fmin(size.width / width, size.height / height)
    }

    /// **Mechanica**
    ///
    /// Returns a `CGSize` to fit `self` into the `size` by maintaining the aspect ratio.
    ///
    /// - Parameter size: The size to fit into.
    /// - Returns: Returns a `CGSize` to fit `self` into the `size` by maintaining the aspect ratio.
    ///
    /// Example:
    ///
    ///     CGSize(width: 100, height: 50).aspectFit(boundingSize: CGSize(width: 70, height: 30)) -> CGSize(width: 60, height: 30)
    ///
    public func aspectFit(boundingSize size: CGSize) -> CGSize {
      let minRatio = scaleToFit(boundingSize: size)

      return CGSize(width: width * minRatio, height: height * minRatio)
    }

  }

  // MARK: - Operators

  extension CGSize {

    /// **Mechanica**
    ///
    /// Adds two `CGSize`.
    ///
    /// Example:
    ///
    ///     CGSize(width: 10, height: 10) + CGSize(width: 20, height: 10) -> CGSize(width: 30, height: 20)
    ///
    public static func + (lhs: CGSize, rhs: CGSize) -> CGSize {
      return CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }

    /// **Mechanica**
    ///
    /// Adds a `CGSize` to `self`.
    ///
    /// Example:
    ///
    ///     var size = CGSize(width: 10, height: 10)
    ///     size += CGSize(width: 20, height: 10) -> point is equal to CGSize(width: 30, height: 20)
    ///
    public static func += (lhs: inout CGSize, rhs: CGSize) {
      lhs = CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }

    /// **Mechanica**
    ///
    /// Subtracts two `CGSize`.
    ///
    /// Example:
    ///
    ///     CGSize(width: 20, height: 10) - CGSize(width: 10, height: 5) -> CGSize(width: 10, height: 5)
    ///
    public static func - (lhs: CGSize, rhs: CGSize) -> CGSize {
      return CGSize(width: lhs.width - rhs.width, height: lhs.height - rhs.height)
    }

    /// **Mechanica**
    ///
    /// Subtracts a CGSize from `self`.
    ///
    /// Example:
    ///
    ///     var size = CGSize(width: 20, height: 10)
    ///     size -= CGSize(width: 10, height: 5) -> point is equal to CGSize(width: 10, height: 5)
    ///
    public static func -= (lhs: inout CGSize, rhs: CGSize) {
      lhs = CGSize(width: lhs.width - rhs.width, height: lhs.height - rhs.height)
    }

    /// **Mechanica**
    ///
    /// Multiplies a `CGPoint` with a scalar.
    ///
    /// Example:
    ///
    ///     CGSize(width: 20, height: 10) * 3 -> CGSize(width: 60, height: 30)
    ///
    public static func * (size: CGSize, scalar: CGFloat) -> CGSize {
      return CGSize(width: size.width * scalar, height: size.height * scalar)
    }

    /// **Mechanica**
    ///
    /// Multiply `self` with a scalar.
    ///
    /// Example:
    ///
    ///     var size = CGSize(width: 20, height: 10)
    ///     size *= 3 -> point is equal to CGSize(width: 60, height: 30)
    ///
    public static func *= (size: inout CGSize, scalar: CGFloat) {
      size = CGSize(width: size.width * scalar, height: size.height * scalar)
    }

  }

#endif
