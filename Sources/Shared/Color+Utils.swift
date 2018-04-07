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

#if canImport(UIKit)
  import UIKit
  /// **Mechanica**
  ///
  /// Alias for UIColor.
  public typealias Color = UIKit.UIColor
#elseif canImport(AppKit)
  import AppKit
  /// **Mechanica**
  ///
  /// Alias for NSColor.
  public typealias Color = AppKit.NSColor
#endif

extension Color {

  /// **Mechanica**
  ///
  /// Returns the hexadecimal string representation of `self` in the sRGB space.
  public final var hexString: String? {
    guard let components = rgba else { return nil }

    return String(format: "#%02X%02X%02X", Int(components.red * 0xff), Int(components.green * 0xff), Int(components.blue * 0xff))
  }

  /// **Mechanica**
  ///
  /// Initializes and returns a **random** color object in the sRGB space.
  public class func random(randomAlpha: Bool = false) -> Self {
    // drand48() generates a random number between 0 to 1
    let red = CGFloat(drand48()), green = CGFloat(drand48()), blue = CGFloat(drand48()), alpha = randomAlpha ? CGFloat(drand48()) : 1.0

    #if canImport(UIKit)
      return self.init(red: red, green: green, blue: blue, alpha: alpha)
    #else
      return self.init(srgbRed: red, green: green, blue: blue, alpha: alpha)
    #endif
  }

}

extension Color {

  // MARK: - sRGBA

  /// **Mechanica**
  ///
  /// Alias for RGBA color space components
  public typealias RGBA = (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)

  /// **Mechanica**
  ///
  /// Returns the color's RGBA components as Ints.
  public final var rgbaComponents: (red: Int, green: Int, blue: Int, alpha: Int)? {
    guard let rgba = self.rgba else { return nil }

    return (Int(rgba.red * 255), Int(rgba.green * 255), Int(rgba.blue * 255), Int(rgba.alpha * 255))
  }

  /// **Mechanica**
  ///
  /// Returns the color's RGBA components as a tuple of `CGFloat`.
  public final var rgba: RGBA? {
    var red: CGFloat = .nan, green: CGFloat = .nan, blue: CGFloat = .nan, alpha: CGFloat = .nan
    let compatibleSRGBColor = convertedToCompatibleSRGBColor()

    guard let color = compatibleSRGBColor else { return nil }

    #if canImport(UIKit)
      guard color.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else { return nil }
    #elseif os(macOS)
      color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    #endif

    return (red, green, blue, alpha)
  }

  /// **Mechanica**
  ///
  /// Creates a `new` color in the **sRGB** color space (if needed)  guard letthat matches (or *closely approximates*) the current color.
  /// Although the new color might have different component values, it looks the same as the original.
  /// - Note: [WWDC 2016 - 712](https://developer.apple.com/videos/play/wwdc2016/712/?time=2368)
  public final func convertedToCompatibleSRGBColor() -> Color? {
    let convertedColor: Color?

    #if canImport(UIKit)
      guard let colorSpace = CGColorSpace(name: CGColorSpace.sRGB) else { return nil }
      if cgColor.colorSpace == colorSpace {
        convertedColor  = self
      } else {
        guard let compatibleSRGBColor = cgColor.converted(to: colorSpace, intent: .defaultIntent, options: nil) else { return nil }
         convertedColor =  Color(cgColor: compatibleSRGBColor)
      }

    #elseif os(macOS)
      let rgbColorSpaces: [NSColorSpace] = [.sRGB, .deviceRGB, .genericRGB]
      let compatibleSRGBColor = rgbColorSpaces.contains(colorSpace) ? self : usingColorSpace(.sRGB)
      convertedColor =  compatibleSRGBColor

    #endif

    return convertedColor
  }

}

extension Color {

  // MARK: - Initializers

  /// **Mechanica**
  ///
  /// Returns a sRGB color from a hexadecimal integer.
  ///
  /// Example:
  ///
  ///     Color(hex: 0xFF0000)
  ///     Color(hex: 0xFF0000, alpha: 0.5)
  ///
  /// - Parameters:
  ///   - hex: The hex component of the color object, specified as a value from 0x000000 to 0xFFFFFF
  ///   - alpha: The opacity component of the color object, specified as a value from 0.0 to 1.0 (optional).
  public convenience init(hex: UInt32, alpha: CGFloat = 1) {
    let red   = CGFloat((hex & 0xFF0000) >> 16) / 255
    let green = CGFloat((hex & 0x00FF00) >> 8) / 255
    let blue  = CGFloat(hex & 0x0000FF) / 255

    #if canImport(UIKit)
      self.init(red: red, green: green, blue: blue, alpha: alpha)

    #else
      self.init(srgbRed: red, green: green, blue: blue, alpha: alpha)

    #endif
  }

  /// **Mechanica**
  ///
  /// Creates and returns an Color object given an hex color string.
  ///
  /// - Note: Supported formats: `RGB`, `#RGB`, `RGBA`, `#RGBA`, `RRGGBB`, `#RRGGBB`, `RRGGBBAA`, `#RRGGBBAA`).
  ///
  /// - Parameters:
  ///   - hexString: The hex color string (e.g.: `#551a8b`, `551a8b`, `551A8B`, `#FFF`).
  public convenience init?(hexString: String) {
    guard !hexString.isBlank else { return nil }

    var formattedHexString = hexString.hasPrefix("#") ? String(hexString.dropFirst()) : hexString

    switch formattedHexString.count {
    case 3: // rgb
      formattedHexString.append("f"); fallthrough
    case 4: // rgba
      formattedHexString = formattedHexString.map { "\($0)\($0)" }.joined( separator: "" )
    case 6: // rrggbb
      formattedHexString.append("ff")
    case 8: // rrggbbaa
      do {}
    default:
      return nil // invalid format
    }

    guard let hexEquivalent = Int64.init(formattedHexString, radix: 16) else { return nil }

    let red = CGFloat((hexEquivalent & 0xFF000000) >> 24) / 255.0
    let green = CGFloat((hexEquivalent & 0x00FF0000) >> 16) / 255.0
    let blue = CGFloat((hexEquivalent & 0x0000FF00) >> 08) / 255.0
    let alpha = CGFloat((hexEquivalent & 0x000000FF) >> 00) / 255.0

    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }

}

extension Color {

  // MARK: - HSBA

  /// **Mechanica**
  ///
  /// Alias for HSBA color space components
  public typealias HSBA = (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat)

  /// **Mechanica**
  ///
  /// Returns the components that make up the color in the HSBA color space.
  public final var hsba: HSBA? {
    var hue: CGFloat = .nan, saturation: CGFloat = .nan, brightness: CGFloat = .nan, alpha: CGFloat = .nan

    #if canImport(UIKit)
      guard self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) else { return nil }

    #else
      self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)

    #endif

    return (hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
  }

}

extension Color {

  // MARK: - Editing

  /// **Mechanica**
  ///
  /// Blends two colors together.
  ///
  /// - Parameters:
  ///   - firstColor: First color to blend.
  ///   - firstPercentage: Intensity of first color (default is 0.5)
  ///   - secondColor: Second color to blend.
  ///   - secondPercentage: Intensity of second color (default is 0.5)
  /// - Returns: a `new color` blending the two colors.
  /// - Note: The sum of the two percentages must be 1.0 otherwise the blendind operation is not executed.
  public static func blend(_ firstColor: Color, percentage firstPercentage: CGFloat = 0.5, with secondColor: Color, percentage secondPercentage: CGFloat = 0.5) -> Color? {
    // http://stackoverflow.com/questions/27342715/blend-uicolors-in-swift

    guard firstPercentage >= 0 else { return nil }
    guard secondPercentage >= 0 else { return nil }

    let total = firstPercentage + secondPercentage
    guard total == 1.0 else { return nil }

    let level1 = firstPercentage/total
    let level2 = secondPercentage/total

    guard level1 > 0 else { return secondColor.copy() as? Color }
    guard level2 > 0 else { return firstColor.copy() as? Color }

    guard let components1 = firstColor.rgba, let components2 = secondColor.rgba else { return nil }

    let red1 = components1.red
    let red2 = components2.red

    let green1 = components1.green
    let green2 = components2.green

    let blue1 = components1.blue
    let blue2 = components2.blue

    let alpha1 = firstColor.cgColor.alpha
    let alpha2 = secondColor.cgColor.alpha

    let red = (level1 * red1) + (level2 * red2)
    let green = (level1 * green1) + (level2 * green2)
    let blue = (level1 * blue1) + (level2 * blue2)
    let alpha = (level1 * alpha1) + (level2 * alpha2)

    return Color(red: red, green: green, blue: blue, alpha: alpha)
  }

}
