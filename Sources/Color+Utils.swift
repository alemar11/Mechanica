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
    /// Returns the components that make up the color in the RGB color space.
    public final var rgba: (red: UInt8, green: UInt8, blue: UInt8, alpha: UInt8)? {
      
      var r : CGFloat = 0
      var g : CGFloat = 0
      var b : CGFloat = 0
      var a : CGFloat = 0
      
      guard self.getRed(&r, green: &g, blue: &b, alpha: &a)  else { return nil } // Could not be converted
      
      return (red: UInt8(r * 255), green: UInt8(g * 255), blue: UInt8(b * 255), alpha: UInt8(a * 255))
    }
    
    /// **Mechanica**
    ///
    /// The red component value of the color.
    public final var redComponent: CGFloat {
      var r: CGFloat = 0
      getRed(&r, green: nil, blue: nil, alpha: nil)
      return r
    }
    
    /// **Mechanica**
    ///
    /// The green component value of the color.
    public final var greenComponent: CGFloat {
      var g: CGFloat = 0
      getRed(nil, green: &g, blue: nil, alpha: nil)
      return g
    }
    
    /// **Mechanica**
    ///
    /// The blue component value of the color.
    public final var blueComponent: CGFloat {
      var b: CGFloat = 0
      getRed(nil, green: nil, blue: &b, alpha: nil)
      return b
    }
    
    /// **Mechanica**
    ///
    /// The alpha component value of the color.
    public final var alphaComponent: CGFloat {
        var alpha: CGFloat = 0
        getRed(nil, green: nil, blue: nil, alpha: &alpha)
        return alpha
    }
    
    
//     private convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
//      self.init(r: r, g: g, b: b, a: 1)
//    }
//    
//    private convenience init (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
//      assert(r >= 0 && r <= 255, "Invalid red component")
//      assert(g >= 0 && g <= 255, "Invalid green component")
//      assert(b >= 0 && b <= 255, "Invalid blue component")
//      self.init(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
//    }
    
    /// **Mechanica**
    ///
    /// Generates a random color.
    private final var random: Color {
      //drand48() generates a random number between 0 to 1
      let red = CGFloat(drand48())
      let green = CGFloat(drand48())
      let blue = CGFloat(drand48())
      return Color(red: red, green: green, blue: blue, alpha: 1)
    }
    
    public final func changingAlpha(_ alpha: CGFloat) -> Color {
      return withAlphaComponent(alpha)
    }
    
  }
  
  
#endif

// MARK: - macOS

#if os(OSX)
  
  extension Color {
    
    /// **Mechanica**
    ///
    /// Returns the components that make up the color in the RGB color space.
    public final var rgba: (red: UInt8, green: UInt8, blue: UInt8, alpha: UInt8)? {
      
      let spacedColor = (self.colorSpaceName != NSCalibratedRGBColorSpace) ? self.usingColorSpace(NSColorSpace.sRGB) : self
      guard let color = spacedColor else { return nil } // Could not be converted
        
      let r = color.redComponent
      let g = color.greenComponent
      let b = color.blueComponent
      let a = color.alphaComponent
      
      return (red: UInt8(r * 255), green: UInt8(g * 255), blue: UInt8(b * 255), alpha: UInt8(a * 255))
    }
    
  }
  
#endif


extension Color {
  
  /// **Mechanica**
  ///
  /// Returns a color from an hexidecimal integer.
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
      self.init(red: red, green: green, blue: blue, alpha: alpha)
    #endif
  }
  
  /// **Mechanica**
  ///
  /// Returns a color from a given hex color string.
  ///
  /// - Parameters:
  ///   - hexString: The hex color string, e.g.: "#551a8b" or "551a8b" or "551A8B".
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
  /// Returns the hexadecimal string representation of the color.
  public final var hexString: String {
    return String(format:"#%06x", rgbUInt32)
  }
  
  //A UInt32 that represents the RGB color.
  private final var rgbUInt32: UInt32 {
    let (r, g, b, _) = self.rgba!
    return (UInt32(r) << 16) | (UInt32(g) << 8) | UInt32(b)
  }
  
  //A UInt32 that represents the RGBA color.
  private final var rgbaUInt32: UInt32 {
    let (r, g, b, a) = self.rgba!
    return (UInt32(r) << 32) | (UInt32(g) << 16) | UInt32(b) << 8 | UInt32(a)
  }
  
  //    /**
  //     Returns the color representation as a 32-bit integer.
  //     - returns: A UInt32 that represents the hexadecimal color.
  //     */
  //    public final var hex: UInt32 {
  //      let (r, g, b, _) = self.rgba
  //      return Model.rgb(r * 255, g * 255, b * 255).hex
  //    }
  //
  //    /// Converts RGB to UInt32
  //    private func convert(rgb r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> UInt32 {
  //      return (UInt32(r) << 16) | (UInt32(g) << 8) | UInt32(b)
  //    }
  

}

