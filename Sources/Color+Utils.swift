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
  public typealias Color = UIColor
#elseif os(OSX)
  import Cocoa
  /// **Mechanica**
  ///
  /// Alias for NSColor.
  public typealias Color = NSColor
#endif


extension Color {

  /// **Mechanica**
  ///
  /// Alias for RGBA color space components
  public typealias RGBA = (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)
  
  /// **Mechanica**
  ///
  /// Alias for HSBA color space components
  public typealias HSBA = (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat)
  
  // MARK: - sRGBA

  /// Returns the color's RGBA components.
  private final var rgba: RGBA? {
    var red : CGFloat = .nan, green : CGFloat = .nan, blue : CGFloat = .nan, alpha : CGFloat = .nan
    #if os(iOS) || os(tvOS) || os(watchOS)
      guard let space = cgColor.colorSpace, let colorSpaceName = space.name else { return nil }
      let compatibleSRGBColor = (colorSpaceName == CGColorSpace.sRGB) ? self: self.convertingToCompatibleSRGBColor()
      guard let color = compatibleSRGBColor else { return nil }
      guard color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)  else { return nil } // could not be converted
    #elseif os(OSX)
      let rgbColorSpaces: [NSColorSpace] = [.sRGB, .deviceRGB, .genericRGB]
      let compatibleSRGBColor = (rgbColorSpaces.contains(self.colorSpace)) ? self : self.usingColorSpace(.sRGB)
      guard let color = compatibleSRGBColor else { return nil } // Could not be converted
      color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    #endif
    return (red, green, blue, alpha)
  }


  /// **Mechanica**
  ///
  /// Returns the components (in 8 bit) that make up the color in the sRGB color space.
  public final var rgba8Bit: (red: UInt8, green: UInt8, blue: UInt8, alpha: UInt8)? {
    guard let components = rgba else { return nil }
    return (red: UInt8(components.red * 255), green: UInt8(components.green * 255), blue: UInt8(components.blue * 255), alpha: UInt8(components.alpha * 255))
  }

  /// **Mechanica**
  ///
  /// Creates a `new` color in the **sRGB** color space that matches (or *closely approximates*) the current color.
  /// - Note: [WWDC 2016 - 712](https://developer.apple.com/videos/play/wwdc2016/712/?time=2368)
  public final func convertingToCompatibleSRGBColor() -> Color? {
    #if os(iOS) || os(tvOS) || os(watchOS)
      guard let colorSpace = CGColorSpace(name: CGColorSpace.sRGB) else { return nil }
      let compatibleSRGBColor = self.cgColor.converted(to: colorSpace, intent: CGColorRenderingIntent.defaultIntent, options: nil)!
      return Color(cgColor: compatibleSRGBColor)
    #else
      let compatibleSRGBColor = (self.colorSpaceName != NSCalibratedRGBColorSpace) ? self.usingColorSpace(NSColorSpace.sRGB) : self
      return compatibleSRGBColor
    #endif
  }

  /// **Mechanica**
  ///
  /// Initializes and returns a **random** color object in the sRGB space.
  public static func random() -> Color {
    //drand48() generates a random number between 0 to 1
    let red = CGFloat(drand48()), green = CGFloat(drand48()), blue = CGFloat(drand48()), alpha = CGFloat(drand48())
    #if os(iOS) || os(tvOS) || os(watchOS)
      return Color(red: red, green: green, blue: blue, alpha: alpha)
    #else
      return Color(srgbRed: red, green: green, blue: blue, alpha: alpha)
    #endif
  }

  // MARK: - Initializers

  /// **Mechanica**
  ///
  /// Returns a sRGB color from a hexadecimal integer.
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
    switch formattedHexString.characters.count {
    case 3: // rgb
      formattedHexString.append("f"); fallthrough
    case 4: // rgba
      formattedHexString = formattedHexString.characters.map{"\($0)\($0)"}.joined(separator: "")
    case 6: // rrggbb
      formattedHexString.append("ff")
    case 8: // rrggbbaa
      do {}
    default:
      return nil // invalid format
    }
    guard let hexEquivalent = Int64.init(formattedHexString, radix: 16) else { return nil }
    let r = CGFloat((hexEquivalent & 0xFF000000) >> 24) / 255.0
    let g = CGFloat((hexEquivalent & 0x00FF0000) >> 16) / 255.0
    let b = CGFloat((hexEquivalent & 0x0000FF00) >> 08) / 255.0
    let a = CGFloat((hexEquivalent & 0x000000FF) >> 00) / 255.0
    self.init(red: r, green: g, blue: b, alpha: a)
  }

  /// **Mechanica**
  ///
  /// Returns the hexadecimal string representation of `self` in the sRGB space.
  public final var hexString: String {
    return String(format:"#%06x", rgbUInt32)
  }

  /// **Mechanica**
  ///
  /// Returns an UInt32 representation of `self` in the sRGB space without alpha channel.
  private final var rgbUInt32: UInt32 {
    guard let components = rgba8Bit else { fatalError("Couldn't calculate RGBA values") }
    return (UInt32(components.red) << 16) | (UInt32(components.green) << 8) | UInt32(components.blue)
  }

  /// **Mechanica**
  ///
  /// Returns an UInt32 representation of `self` in the sRGB space with alpha channel.
  private final var rgbaUInt32: UInt32 {
    guard let components = rgba8Bit else { fatalError("Couldn't calculate RGBA values.") }
    return (UInt32(components.red) << 32) | (UInt32(components.green) << 16) | UInt32(components.blue) << 8 | UInt32(components.alpha)
  }

  // TODO: UInt32 to RGB

  // TODO: UInt32 to RGBA

  // MARK: - HSBA

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
  /// Returns a `new` Color derived from `self` varying in brightness by the given `percentage`.
  /// - Note: Brightness makes the color less or more closer to black.
  public func modifiedBrightness(by percentage: CGFloat) -> Color? {
    if percentage == 0 { return self.copy() as? Color }
    guard let components = hsba else { return nil }
    let newBrightness = components.brightness + percentage
    return Color(hue: components.hue, saturation: components.saturation, brightness: newBrightness, alpha: components.alpha)
  }
  
  // TODO: - wip
  private func _modifiedBrightness(by percentage: CGFloat) -> Color? {
    if percentage == 0 { return self.copy() as? Color }
    return applying{ ($0.hue, $0.saturation, $0.brightness + percentage, $0.alpha) }
  }
  
  // TODO: - wip
  private func _modifiedSaturation(by percentage: CGFloat) -> Color? {
    if percentage == 0 { return self.copy() as? Color }
    return applying{ ($0.hue, $0.saturation + percentage, $0.brightness, $0.alpha) }
  }
  
  // TODO: - wip
  private func applying(changes: ((HSBA) -> (HSBA)?)) -> Color? {
    guard let _components = hsba else { return nil }
    guard let components = changes(_components) else { return nil }
    return Color(hue: components.hue, saturation: components.saturation, brightness: components.brightness, alpha: components.alpha)
  }

  /// **Mechanica**
  ///
  /// Returns a `new` color derived from `self` lightened by the given percentage.
  public func lightened(by percentage: CGFloat = 0.1) -> Color? {
    return modifiedBrightness(by: percentage)
  }

  /// **Mechanica**
  ///
  /// Returns a `new` color derived from `self` darkened by the given percentage.
  public func darkened(by percentage: CGFloat = 0.1) -> Color? {
    return modifiedBrightness(by: -percentage)
  }

  /// **Mechanica**
  ///
  /// Returns a `new` color derived from `self` varying in saturation by the given`percentage`.
  /// - Note: Saturation makes the color less or more closer to white.
  public func modifiedSaturation(by percentage: CGFloat) -> Color? {
    if percentage == 0 { return self.copy() as? Color }
    guard let components = hsba else { return nil }
    let newSaturation = components.saturation + percentage
    return Color(hue: components.hue, saturation: newSaturation, brightness: components.brightness, alpha: components.alpha)
  }

  /// **Mechanica**
  ///
  /// Returns a `new` color derived from `self` saturating the hue by a `percentage`, making it more intense and darker .
  public func shaded(by percentage: CGFloat = 0.1) -> Color? {
    return modifiedSaturation(by: percentage)
  }

  /// **Mechanica**
  ///
  /// Returns a `new` color derived from `self` desaturating the hue by a `percentage`, making it less intense.
  public func tinted(by percentage: CGFloat = 0.1) -> Color? {
    return modifiedSaturation(by: -percentage)
  }
  
}

// TODO: - wip
//extension Color {
//
//    private func isEqual(to color: UIColor, withTolerance tolerance: CGFloat = 0.0) -> Bool{
//      guard let (r1, g1, b1, a1) = rgba, let (r2, g2, b2, a2) = color.rgba else { return false }
//      return fabs(r1 - r2) <= tolerance && fabs(g1 - g2) <= tolerance && fabs(b1 - b2) <= tolerance && fabs(a1 - a2) <= tolerance
//    }
//  
//}

