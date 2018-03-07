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
    /// Returns the `CGRect` area.
    public var area: CGFloat {
      return height * width
    }

    /// **Mechanica**
    ///
    /// Returns a `CGRect` with all its components floored.
    ///
    /// Example:
    ///
    ///     CGRect(x: 10.3, y: 11.5, width: 12.7, height: 13.0).floor -> CGRect(x: 10, y: 11, width: 12, height: 13)
    ///
    public var floor: CGRect {
      return CGRect(
        x: CoreGraphics.floor(origin.x),
        y: CoreGraphics.floor(origin.y),
        width: CoreGraphics.floor(size.width),
        height: CoreGraphics.floor(size.height)
      )
    }

    /// **Mechanica**
    ///
    /// Returns a `CGRect` with all its components ceiled.
    ///
    /// Example:
    ///
    ///     CGRect(x: 10.3, y: 11.5, width: 12.7, height: 13.0).ceil -> CGRect(x: 11, y: 12, width: 13, height: 13)
    ///
    public var ceil: CGRect {
      return CGRect(
        x: CoreGraphics.ceil(origin.x),
        y: CoreGraphics.ceil(origin.y),
        width: CoreGraphics.ceil(size.width),
        height: CoreGraphics.ceil(size.height)
      )
    }

  }

#endif
