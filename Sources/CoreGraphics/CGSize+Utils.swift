#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)

import CoreGraphics.CGGeometry

extension CGSize {
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
