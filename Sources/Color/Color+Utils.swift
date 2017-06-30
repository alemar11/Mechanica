//
//  Colors+Utils.swift
//  Mechanica
//
//  Copyright © 2016-2017 Tinrobots.
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

import Foundation

#if os(iOS) || os(tvOS) || os(watchOS)
  import UIKit
  /// **Mechanica**
  ///
  /// Alias for UIColor.
  public typealias Color = UIKit.UIColor
#elseif os(macOS)
  import Cocoa
  /// **Mechanica**
  ///
  /// Alias for NSColor.
  public typealias Color = AppKit.NSColor
#endif

extension Color {

  fileprivate typealias ColorConverter = (Color) -> Color?

  fileprivate final func processingColor(using converter: ColorConverter) -> Color? { return converter(self) }

  /// **Mechanica**
  ///
  /// Returns the hexadecimal string representation of `self` in the sRGB space.
  public final var hexString: String {
    guard let components = rgba else { fatalError("Couldn't calculate RGBA values") }
    return String(format: "#%02X%02X%02X", Int(components.red * 0xff), Int(components.green * 0xff), Int(components.blue * 0xff))
  }

  /// **Mechanica**
  ///
  /// Initializes and returns a **random** color object in the sRGB space.
  public class func random() -> Self {
    //drand48() generates a random number between 0 to 1
    let red = CGFloat(drand48()), green = CGFloat(drand48()), blue = CGFloat(drand48()), alpha = CGFloat(drand48())
    #if os(iOS) || os(tvOS) || os(watchOS)
      return self.init(red: red, green: green, blue: blue, alpha: alpha)
    #else
      return self.init(srgbRed: red, green: green, blue: blue, alpha: alpha)
    #endif
  }

}

// MARK: - sRGBA

extension Color {

  /// **Mechanica**
  ///
  /// Alias for RGBA color space components
  public typealias RGBA = (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)

  /// **Mechanica**
  ///
  /// Returns the color's RGBA components as Ints.
  public final var rgbaInt: (red: Int, green: Int, blue: Int, alpha: Int)? {
    guard let rgba = self.rgba else { return nil }
    return (Int(rgba.red * 255), Int(rgba.green * 255), Int(rgba.blue * 255), Int(rgba.alpha * 255))
  }

  /// **Mechanica**
  ///
  /// Returns the color's RGBA components as CGFloats.
  public final var rgba: RGBA? {
    var red: CGFloat = .nan, green: CGFloat = .nan, blue: CGFloat = .nan, alpha: CGFloat = .nan
    #if os(iOS) || os(tvOS) || os(watchOS)
      guard let space = cgColor.colorSpace, let colorSpaceName = space.name else { return nil }
      let compatibleSRGBColor = (colorSpaceName == CGColorSpace.sRGB) ? self: self.convertingToCompatibleSRGBColor()
      guard let color = compatibleSRGBColor else { return nil }
      guard color.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else { return nil } // could not be converted
    #elseif os(macOS)
      let rgbColorSpaces: [NSColorSpace] = [.sRGB, .deviceRGB, .genericRGB]
      let compatibleSRGBColor = (rgbColorSpaces.contains(self.colorSpace)) ? self : self.usingColorSpace(.sRGB)
      guard let color = compatibleSRGBColor else { return nil } // could not be converted
      color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    #endif
    return (red, green, blue, alpha)
  }

  /// **Mechanica**
  ///
  /// Creates a `new` color in the **sRGB** color space that matches (or *closely approximates*) the current color.
  /// Although the new color might have different component values, it looks the same as the original.
  /// - Note: [WWDC 2016 - 712](https://developer.apple.com/videos/play/wwdc2016/712/?time=2368)
  public final func convertingToCompatibleSRGBColor() -> Color? {
    #if os(iOS) || os(tvOS) || os(watchOS)
      guard let colorSpace = CGColorSpace(name: CGColorSpace.sRGB) else { return nil }
      let compatibleSRGBColor = self.cgColor.converted(to: colorSpace, intent: CGColorRenderingIntent.defaultIntent, options: nil)!
      return Color(cgColor: compatibleSRGBColor)
    #elseif os(macOS)
      let compatibleSRGBColor = (self.colorSpaceName != NSColorSpaceName.calibratedRGB) ? self.usingColorSpace(NSColorSpace.sRGB) : self
      return compatibleSRGBColor
    #endif
  }

  /// **Mechanica**
  ///
  /// Mixes the given color object with the receiver. Specifically, takes the average of each of the RGB components, optionally weighted by the given percentage.
  ///
  /// - Parameters:
  ///   - color: color to be mixed.
  ///   - percentage: mixing weight. (by default (0.5) takes the average of each of the RGBA components.
  /// - Returns: a `new color` mixing `self` with the given `color`.
  /// - Note: See [lighter and darker color](http://stackoverflow.com/questions/11598043/get-slightly-lighter-and-darker-color-from-uicolor/23120676#23120676)
  public final func mixing(with color: Color, by percentage: CGFloat = 0.5) -> Color? {
    let converter: ColorConverter = {
      guard let (r1, g1, b1, a1) = $0.rgba, let (r2, g2, b2, a2) = color.rgba else { return nil }
      return Color(red: r1+percentage*(r2-r1), green: g1+percentage*(g2-g1), blue: b1+percentage*(b2-b1), alpha: a1+percentage*(a2-a1))
    }
    return processingColor(using: converter)
  }

  /// **Mechanica**
  ///
  /// Returns a `new` color derived from `self` darkened by the given percentage in the RGBA color space.
  /// - Note: The `new` color is obtained mixing `self` with the black color.
  public final func darkened(by percentage: CGFloat = 0.25) -> Color? {
    //return mixing(with: .black, by: percentage)
    guard let (r, g, b, a) = rgba else { return nil }
    return Color(red: r - percentage, green: g - percentage, blue: b - percentage, alpha: a)
  }

  /// **Mechanica**
  ///
  /// Returns a `new` color derived from `self` lightened by the given percentage in the RGBA color space.
  /// - Note: The `new` color is obtained mixing `self` with the white color.
  public final func lightened(by percentage: CGFloat = 0.25) -> Color? {
    //return mixing(with: .white, by: percentage)
    guard let (r, g, b, a) = rgba else { return nil }
    return Color(red: r + percentage, green: g + percentage, blue: b + percentage, alpha: a)
  }
}

// MARK: - Initializers

extension Color {

  /// **Mechanica**
  ///
  /// Returns a sRGB color from a hexadecimal integer.
  ///
  /// ```
  /// Color(hex: 0xFF0000)
  /// Color(hex: 0xFF0000, alpha: 0.5)
  /// ```
  ///
  /// - Parameters:
  ///   - hex: The hex component of the color object, specified as a value from 0x000000 to 0xFFFFFF
  ///   - alpha: The opacity component of the color object, specified as a value from 0.0 to 1.0 (optional).
  public convenience init(hex: UInt32, alpha: CGFloat = 1) {
    let red   = CGFloat((hex & 0xFF0000) >> 16) / 255
    let green = CGFloat((hex & 0x00FF00) >> 8) / 255
    let blue  = CGFloat(hex & 0x0000FF) / 255
    #if os(iOS) || os(tvOS) || os(watchOS)
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
    var formattedHexString = hexString.hasPrefix("#") ? String(hexString.characters.dropFirst()) : hexString
    switch formattedHexString.count {
    case 3: // rgb
      formattedHexString.append("f"); fallthrough
    case 4: // rgba
      formattedHexString = formattedHexString.characters.map { "\($0)\($0)" }.joined( separator: "" )
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

    //    #if os(iOS) || os(tvOS) || os(watchOS)
    //      self.init(red: red, green: green, blue: blue, alpha: alpha)
    //    #else
    //       self.init(srgbRed: red, green: green, blue: blue, alpha: alpha)
    //    #endif
    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }

}

// MARK: - HSBA

extension Color {

  /// **Mechanica**
  ///
  /// Alias for HSBA color space components
  public typealias HSBA = (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat)

  /// **Mechanica**
  ///
  /// Returns the components that make up the color in the HSBA color space.
  public final var hsba: HSBA? {
    var hue: CGFloat = .nan, saturation: CGFloat = .nan, brightness: CGFloat = .nan, alpha: CGFloat = .nan
    #if os(iOS) || os(tvOS) || os(watchOS)
      guard self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) else { return nil }
    #else
      self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
    #endif
    return (hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
  }

  /// **Mechanica**
  ///
  /// Returns a `new` color derived from `self` lightened increasing the brightness by a `percentage` in the HSB color space.
  public final func lightened(byIncreasingBrightness percentage: CGFloat = 0.25) -> Color? {
    if percentage == 0 { return self.copy() as? Color }
    let converter: ColorConverter = {
      guard let hsba = $0.hsba else { return nil }
      //let percentage: CGFloat = min(max(percentage, -1), 1)
      //let newBrightness = min(max(hsba.brightness + percentage, -1), 1)
      return Color(hue: hsba.hue, saturation: hsba.saturation, brightness: hsba.brightness + percentage, alpha: hsba.alpha)
    }
    return processingColor(using: converter)
  }

  /// **Mechanica**
  ///
  /// Returns a `new` color derived from `self` darkened decreasing the brightness by a `percentage` in the HSB color space.
  public final func darkened(byDecreasingBrightness percentage: CGFloat = 0.25) -> Color? {
    if percentage == 0 { return self.copy() as? Color }
    let converter: ColorConverter = {
      guard let hsba = $0.hsba else { return nil }
      return Color(hue: hsba.hue, saturation: hsba.saturation, brightness: hsba.brightness - percentage, alpha: hsba.alpha)
    }
    return processingColor(using: converter)
  }

  /// **Mechanica**
  ///
  /// Returns a `new` color derived from `self` saturating the hue (increasing the saturation) by a `percentage` in the HSB color space, making it more intense and darker.
  /// - Note: Increasing the saturation makes the color less closer to white.
  public final func shaded(byIncreasingSaturation percentage: CGFloat = 0.25) -> Color? {
    if percentage == 0 { return self.copy() as? Color }
    let converter: ColorConverter = {
      guard let hsba = $0.hsba else { return nil }
      return Color(hue: hsba.hue, saturation: hsba.saturation + percentage, brightness: hsba.brightness, alpha: hsba.alpha)
    }
    return processingColor(using: converter)
  }

  /// **Mechanica**
  ///
  /// Returns a `new` color derived from `self` desaturating the hue (decreasing the saturation) by a `percentage` in the HSB color space, making it less intense.
  /// - Note: Decreasing the saturation makes the color closer to white.
  public final func tinted(byDecreasingSaturation percentage: CGFloat = 0.25) -> Color? {
    if percentage == 0 { return self.copy() as? Color }
    let converter: ColorConverter = {
      guard let hsba = $0.hsba else { return nil }
      return Color(hue: hsba.hue, saturation: hsba.saturation - percentage, brightness: hsba.brightness, alpha: hsba.alpha)
    }
    return processingColor(using: converter)
  }

}

//extension Color {
//
//  private func isEqual(to color: UIColor, withTolerance tolerance: CGFloat = 0.0) -> Bool{
//    guard let (r1, g1, b1, a1) = rgba, let (r2, g2, b2, a2) = color.rgba else { return false }
//    return fabs(r1 - r2) <= tolerance && fabs(g1 - g2) <= tolerance && fabs(b1 - b2) <= tolerance && fabs(a1 - a2) <= tolerance
//  }
//
//}
