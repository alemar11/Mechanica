//
//  Colors+Utils.swift
//  Mechanica
//
//  Copyright © 2016 Tinrobots.
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

// MARK: - iOS, tvOS, watchOS

#if os(iOS) || os(tvOS) || os(watchOS)
  
  extension Color {
    
    /// **Mechanica**
    ///
    /// Returns the components that make up the color in the sRGB color space.
    public final var rgba: (red: UInt8, green: UInt8, blue: UInt8, alpha: UInt8)? {
      
      guard let space = self.cgColor.colorSpace, let colorSpaceName = space.name else { return nil}
      
      let compatibleSRGBColor = (colorSpaceName == CGColorSpace.sRGB) ? self: self.convertingToCompatibleSRGBColor()
      guard let color = compatibleSRGBColor else { return nil }
      
      var r : CGFloat = 0
      var g : CGFloat = 0
      var b : CGFloat = 0
      var a : CGFloat = 0
      
      guard color.getRed(&r, green: &g, blue: &b, alpha: &a)  else { return nil } // could not be converted
      
      //guard (0.0...1.0 ~= r && 0.0...1.0 ~= g && 0.0...1.0 ~= b && 0.0...1.0 ~= a) else { return nil } // invalid sRGB color
      
      return (red: UInt8(r * 255), green: UInt8(g * 255), blue: UInt8(b * 255), alpha: UInt8(a * 255))
    }
    
  }
  
  
#endif

// MARK: - macOS

#if os(OSX)
  
  extension Color {
    
    /// **Mechanica**
    ///
    /// Returns the components that make up the color in the sRGB color space.
    public final var rgba: (red: UInt8, green: UInt8, blue: UInt8, alpha: UInt8)? {
      
      let rgbColorSpaces: [NSColorSpace] = [.sRGB, .deviceRGB, .genericRGB]
      let compatibleSRGBColor = (rgbColorSpaces.contains(self.colorSpace)) ? self : self.usingColorSpace(.sRGB)
      
      guard let color = compatibleSRGBColor else { return nil } // Could not be converted
      
      var r : CGFloat = 0
      var g : CGFloat = 0
      var b : CGFloat = 0
      var a : CGFloat = 0
      color.getRed(&r, green: &g, blue: &b, alpha: &a)
      
      //guard (0.0...1.0 ~= r && 0.0...1.0 ~= g && 0.0...1.0 ~= b && 0.0...1.0 ~= a) else { return nil } // invalid sRGB color
      
      return (red: UInt8(r * 255), green: UInt8(g * 255), blue: UInt8(b * 255), alpha: UInt8(a * 255))
    }
    
  }
  
#endif

// MARK: - Universal

extension Color {
  
  /// **Mechanica**
  ///
  /// Converts the color in an sRGB compatible color.
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
  public convenience init?(hexString: String, alpha: CGFloat = 1) {
    
    guard !hexString.isBlank else { return nil }
    
    var formattedHexString = hexString.hasPrefix("#") ? String(hexString.characters.dropFirst()) : hexString
    
    guard formattedHexString.length == 6 || formattedHexString.length == 3 else { return nil }
    
    //shortcut hex color, i.e. f0f becomes f0ff0f
    if (formattedHexString.length == 3) {
      let newHexString = formattedHexString[0]!*2 + formattedHexString[1]!*2 + formattedHexString[2]!*2
      formattedHexString = newHexString
    }
  
    var hexEquivalent: UInt32 = 0
    Scanner(string: formattedHexString).scanHexInt32(&hexEquivalent)
    self.init(hex: hexEquivalent, alpha: alpha)
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
  
  //TODO: UInt32 -> RGB
  
  //TODO: UInt32 -> RGBA
  
}

