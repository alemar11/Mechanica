//
//  Nib.swift
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

#if os(iOS) || os(tvOS)
  import UIKit
  /// **Mechanica**
  ///
  /// Alias for UINib.
  public typealias Nib = UINib
#elseif os(macOS)
  import Cocoa
  /// **Mechanica**
  ///
  /// Alias for NSNib.
  public typealias Nib = NSNib
#endif

// MARK: - NibKeyCodable

/// **Mechanica**
///
/// Types adopting the `NibKeyCodable` protocol can be used to define Nib names.
public protocol NibKeyCodable {
  associatedtype NibName: RawRepresentable
}

extension NibKeyCodable where NibName.RawValue == String {

  /**
   **Mechanica**

   Creates and returns a Nib object for a specified nib enum case.

   i.e.
   ```
   extension Nib: NibKeyCodable {
   enum NibName : String {
   case first   = "first"
   case second  = "second"
   }
   }

   let firstNib = Nib.nib(forKey: .first)
   ```
   - note: If the bundle parameter is nil, the main bundle is used.
   */
  public static func nib(forKey key: NibName, bundle: Bundle? = nil) -> Nib {
    #if os(iOS) || os(tvOS)
      return  UINib(nibName: key.rawValue, bundle: bundle)
    #elseif os(macOS)
      return NSNib(nibNamed: key.rawValue, bundle: bundle)!
    #endif
  }

}

// MARK: - NibLoadable

/// **Mechanica**
///
/// Types adopting the `NibLoadable` protocol can be loaded from a Nib.
public protocol NibLoadable {}

#if os(iOS) || os(tvOS)
  extension UIView : NibLoadable {}
#elseif os(macOS)
  extension NSView : NibLoadable {}
#endif


extension Nib {

  /// **Mechanica**
  ///
  /// Instantiates and returns an obejct conforming to `NibLoadable` from a Nib.
  public func instantiate<T>(withOwner owner: Any? = nil, options: [AnyHashable : Any]? = nil) -> T where T: NibLoadable {
    #if os(iOS) || os(tvOS)
      let contents = self.instantiate(withOwner: owner, options: options).filter { $0 is T }
    #elseif os(macOS)
      var array = NSArray()
      guard (self.instantiate(withOwner: owner, topLevelObjects: &array)) else {
        fatalError("\(String(describing: self)) could not be instantiated.")
      }
      let contents = (array as! Array<Any>).filter { $0 is T }
    #endif

    switch (contents.count) {
    case 0:
      fatalError("\(String(describing: T.self)) could not be found in \(String(describing: self)).")
    case 1:
      return contents.first as! T
    default:
      fatalError("More than one \(String(describing: T.self)) has been found in \(String(describing: self)).")
    }
  }

}

// MARK: - NibIdentifiable

/// **Mechanica**
///
/// Objects adopting the `NibIdentifiable` protocol are nib based and are the XIB root object.
public protocol NibIdentifiable: class {
  static var nibIdentifier: String { get }
}

// MARK: Default implementation

public extension NibIdentifiable {

  /// By default the *nibIdentifier* is the name of the class.
  static var nibIdentifier: String {
    return String(describing: self)
  }

  /// By default, uses the nib which is named as the name of the class and it's located in the bundle of that class.
  static var nib: Nib {
    #if os(iOS) || os(tvOS)
    return Nib(nibName: nibIdentifier, bundle: Bundle(for: self))
    #elseif os(macOS)
    return Nib(nibNamed: nibIdentifier, bundle: Bundle(for: self))!
    #endif
  }
}

