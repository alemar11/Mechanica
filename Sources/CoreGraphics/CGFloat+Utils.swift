#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)

  import CoreGraphics

  extension CGFloat {
    /// **Mechanica**
    ///
    /// Example:
    ///
    ///     CGFloat(180).degreesToRadians -> π
    ///
    public var degreesToRadians: CGFloat {
      return CGFloat.pi * self / 180.0
    }

    /// **Mechanica**
    ///
    /// Example:
    ///
    ///     CGFloat(π).radiansToDegrees -> 180
    ///
    public var radiansToDegrees: CGFloat {
      return self * 180 / CGFloat.pi
    }

    /// **Mechanica**
    ///
    ///  Returns the shortest angle between two angles. The result is always between -π and π.
    ///
    /// Example:
    ///
    ///     CGFloat.shortestAngleInRadians(from: 0, to: 3π/2) -> -π/2
    ///
    public static func shortestAngleInRadians(from first: CGFloat, to second: CGFloat) -> CGFloat {
      // https://github.com/raywenderlich/SKTUtils/blob/master/SKTUtils/CGFloat%2BExtensions.swift
      let twoPi = CGFloat(.pi * 2.0)
      var angle = (second - first).truncatingRemainder(dividingBy: twoPi)
      if angle >= .pi {
        angle -= twoPi
      }
      if angle <= -.pi {
        angle += twoPi
      }
      return angle
    }
  }

#endif
