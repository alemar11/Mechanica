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

#if os(iOS) || os(tvOS) || os(watchOS)
  import UIKit
  /// **Mechanica**
  ///
  /// Alias for UIFont.
  public typealias Font = UIKit.UIFont

  /// **Mechanica**
  ///
  /// Alias for UIFontDescriptorSymbolicTraits.
  public typealias FontDescriptorSymbolicTraits = UIKit.UIFontDescriptorSymbolicTraits
#elseif os(macOS)
  import AppKit
  /// **Mechanica**
  ///
  /// Alias for NSFont.
  public typealias Font = AppKit.NSFont

  /// **Mechanica**
  ///
  /// Alias for NSFontDescriptor.SymbolicTraits.
  public typealias FontDescriptorSymbolicTraits = AppKit.NSFontDescriptor.SymbolicTraits
#endif

extension Font {

  /// **Mechanica**
  ///
  /// Applies the specified traits to `self` without changing the current size.
  func withTraits(_ traits: FontDescriptorSymbolicTraits) -> Font? {
    let descriptor = fontDescriptor.withSymbolicTraits(traits)
    //size 0 means keep the size as it is
    let size = CGFloat(0) //TODO: use "pointSize" instead of 0?

    #if os(macOS)
      return Font(descriptor: descriptor, size: size) ?? self
    #else
      guard let d = descriptor else { return self }
      return UIFont(descriptor: d, size: size)
    #endif
  }

  /// **Mechanica**
  ///
  /// Applies the *bold* trait.
  ///
  /// Example:
  ///
  ///     let font = Font.preferredFont(forTextStyle: .headline).bold() // iOS/tvOS/watchOS
  ///     let font = Font.systemFont(ofSize: 16).bold() // macOS
  ///
  func bold() -> Font {
    let traits: FontDescriptorSymbolicTraits
    #if os(macOS)
      traits = .bold
    #else
      traits = .traitBold
    #endif
    return withTraits([fontDescriptor.symbolicTraits, traits]) ?? self
  }

  /// **Mechanica**
  ///
  /// Applies the *italic* trait.
  ///
  /// Example:
  ///
  ///     let font = Font.preferredFont(forTextStyle: .headline).italic() // iOS/tvOS/watchOS
  ///     let font = Font.systemFont(ofSize: 16).italic() // macOS
  ///
  func italic() -> Font {
    let traits: FontDescriptorSymbolicTraits
    #if os(macOS)
      traits = .italic
    #else
      traits = .traitItalic
    #endif
    return withTraits([fontDescriptor.symbolicTraits, traits]) ?? self
  }

  /// **Mechanica**
  ///
  /// Returns true if the font contains the bold trait.
  var isBold: Bool {
    #if os(macOS)
      return fontDescriptor.symbolicTraits.contains(.bold)
    #else
      return fontDescriptor.symbolicTraits.contains(.traitBold)
    #endif
  }

  /// **Mechanica**
  ///
  /// Returns true if the font contains the italic trait.
  var isItalic: Bool {
    #if os(macOS)
      return fontDescriptor.symbolicTraits.contains(.italic)
    #else
      return fontDescriptor.symbolicTraits.contains(.traitItalic)
    #endif
  }

}
