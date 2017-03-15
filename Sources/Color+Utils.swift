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

  // MARK: - sRGBA

  /// Returns the color's RGBA components.
  internal final func rgbaComponents() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
    var r : CGFloat = .nan, g : CGFloat = .nan, b : CGFloat = .nan, a : CGFloat = .nan

    #if os(iOS) || os(tvOS) || os(watchOS)
      guard let space = cgColor.colorSpace, let colorSpaceName = space.name else { return nil }
      let compatibleSRGBColor = (colorSpaceName == CGColorSpace.sRGB) ? self: self.convertingToCompatibleSRGBColor()
      guard let color = compatibleSRGBColor else { return nil }
      guard color.getRed(&r, green: &g, blue: &b, alpha: &a)  else { return nil } // could not be converted
    #elseif os(OSX)
      let rgbColorSpaces: [NSColorSpace] = [.sRGB, .deviceRGB, .genericRGB]
      let compatibleSRGBColor = (rgbColorSpaces.contains(self.colorSpace)) ? self : self.usingColorSpace(.sRGB)
      guard let color = compatibleSRGBColor else { return nil } // Could not be converted
      color.getRed(&r, green: &g, blue: &b, alpha: &a)
    #endif
      return (r, g, b, a)
  }


  /// **Mechanica**
  ///
  /// Returns the components that make up the color in the sRGB color space.
  public final var rgba: (red: UInt8, green: UInt8, blue: UInt8, alpha: UInt8)? {
    guard let (r, g, b, a) = rgbaComponents() else { return nil }
    return (red: UInt8(r * 255), green: UInt8(g * 255), blue: UInt8(b * 255), alpha: UInt8(a * 255))
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
    let red = CGFloat(drand48())
    let green = CGFloat(drand48())
    let blue = CGFloat(drand48())
    let alpha = CGFloat(drand48())

    #if os(iOS) || os(tvOS) || os(watchOS)
      return Color(red: red, green: green, blue: blue, alpha: alpha)
    #else
      return Color(srgbRed: red, green: green, blue: blue, alpha: alpha)
    #endif
  }


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
  /// Returns a color from a given hex color string.
  ///
  /// - Parameters:
  ///   - hexString: The hex color string **#RRGGBB** (e.g.: "#551a8b", "551a8b", "551A8B", #FFF).
  ///   - alpha: The opacity value for the color (default = 1.0)
//  private convenience init?(hexString: String, alpha: CGFloat = 1) {
//    guard !hexString.isBlank else { return nil }
//    var formattedHexString = hexString.hasPrefix("#") ? String(hexString.characters.dropFirst()) : hexString
//    guard formattedHexString.length == 6 || formattedHexString.length == 3 else { return nil }
//
//    //shortcut hex color, i.e. f0f becomes f0ff0f
//    if (formattedHexString.length == 3) {
//      let newHexString = formattedHexString[0]!*2 + formattedHexString[1]!*2 + formattedHexString[2]!*2
//      formattedHexString = newHexString
//    }
//
//    var hexEquivalent: UInt32 = 0
//    guard Scanner(string: formattedHexString).scanHexInt32(&hexEquivalent) == true else { return nil }
//    self.init(hex: hexEquivalent, alpha: alpha)
//  }

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
    guard let (r, g, b, _) = self.rgba else { fatalError("Couldn't calculate RGBA values") }
    return (UInt32(r) << 16) | (UInt32(g) << 8) | UInt32(b)
  }

  /// **Mechanica**
  ///
  /// Returns an UInt32 representation of `self` in the sRGB space with alpha channel.
  private final var rgbaUInt32: UInt32 {
    guard let (r, g, b, a) = self.rgba else { fatalError("Couldn't calculate RGBA values") }
    return (UInt32(r) << 32) | (UInt32(g) << 16) | UInt32(b) << 8 | UInt32(a)
  }

  // TODO: UInt32 to RGB

  // TODO: UInt32 to RGBA

  // MARK: - HSBA

  /// **Mechanica**
  ///
  /// Returns the components that make up the color in the HSBA color space.
  public func hsba() -> (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat)? {
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
  public func modifiedBrightness(byPercentage percentage: CGFloat) -> Color? {
    if percentage == 0 { return self.copy() as? Color }
    guard let hsba = hsba() else { return nil }
    let newBrightness = hsba.brightness + percentage
    return Color(hue: hsba.hue, saturation: hsba.saturation, brightness: newBrightness, alpha: hsba.alpha)
  }

  /// **Mechanica**
  ///
  /// Returns a `new` color derived from `self` lightened by the given percentage.
  public func lightened(byPercentage percentage: CGFloat = 0.1) -> Color? {
    return modifiedBrightness(byPercentage: percentage)
  }

  /// **Mechanica**
  ///
  /// Returns a `new` color derived from `self` darkened by the given percentage.
  public func darkened(byPercentage percentage: CGFloat = 0.1) -> Color? {
    return modifiedBrightness(byPercentage: -percentage)
  }

  /// **Mechanica**
  ///
  /// Returns a `new` color derived from `self` varying in saturation by the given`percentage`.
  /// - Note: Saturation makes the color less or more closer to white.
  public func modifiedSaturation(byPercentage percentage: CGFloat) -> Color? {
    if percentage == 0 { return self.copy() as? Color }
    guard let hsba = hsba() else { return nil }
    let newSaturation = hsba.saturation + percentage
    return Color(hue: hsba.hue, saturation: newSaturation, brightness: hsba.brightness, alpha: hsba.alpha)
  }

  /// **Mechanica**
  ///
  /// Returns a `new` color derived from `self` saturating the hue by a `percentage`, making it more intense and darker .
  public func shaded(byPercentage percentage: CGFloat = 0.1) -> Color? {
    return modifiedSaturation(byPercentage: percentage)
  }

  /// **Mechanica**
  ///
  /// Returns a `new` color derived from `self` desaturating the hue by a `percentage`, making it less intense.
  public func tinted(byPercentage percentage: CGFloat = 0.1) -> Color? {
    return modifiedSaturation(byPercentage: -percentage)
  }
  
}


