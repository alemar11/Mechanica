//
// Mechanica
//
// Copyright © 2016-2017 Tinrobots.
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
  public typealias Nib = UIKit.UINib
#elseif os(macOS)
  import Cocoa
  /// **Mechanica**
  ///
  /// Alias for NSNib.
  public typealias Nib = AppKit.NSNib
#endif

// MARK: - NibEnumerable

/// **Mechanica**
///
/// Types adopting the `NibEnumerable` protocol can be used to define Nib names.
public protocol NibEnumerable {
  associatedtype NibName: RawRepresentable
}

extension NibEnumerable where NibName.RawValue == String {

/// **Mechanica**
/// Creates and returns a Nib object for a specified nib enum case.
///
///  Example:
///
///       extension Nib: NibEnumerable {
///          enum NibName : String {
///            case first   = "first"
///            case second  = "second"
///          }
///       }
///       let firstNib = Nib.nib(forKey: .first)
///
/// - Note: If the bundle parameter is nil, the main bundle is used.
  public static func nib(forKey key: NibName, bundle: Bundle? = nil) -> Nib {
    #if os(iOS) || os(tvOS)
      return  UINib(nibName: key.rawValue, bundle: bundle)
    #elseif os(macOS)
      return NSNib(nibNamed: NSNib.Name(rawValue: key.rawValue), bundle: bundle)!
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
  /// Instantiates and returns an object conforming to `NibLoadable` from a Nib.
  public final func instantiate<T>(withOwner owner: Any? = nil, options: [AnyHashable : Any]? = nil) -> T where T: NibLoadable {
    #if os(iOS) || os(tvOS)
      let contents = self.instantiate(withOwner: owner, options: options).flatMap { $0 as? T }

    #elseif os(macOS)
      var objects: NSArray?

      guard (self.instantiate(withOwner: owner, topLevelObjects: &objects)), let array = objects else {
        fatalError("\(String(describing: self)) could not be instantiated.")
      }
      let contents = array.flatMap { $0 as? T }

    #endif

    switch contents.count {
    case 0:
      fatalError("\(String(describing: T.self)) could not be found in \(String(describing: self)).")
    case 1:
      // swiftlint:disable force_cast
      return contents.first!
      // swiftlint:enable force_cast
    default:
      fatalError("More than one \(String(describing: T.self)) has been found in \(String(describing: self)).")
    }
  }

}

// MARK: - NibIdentifiable

/// **Mechanica**
///
/// Objects adopting the `NibIdentifiable` protocol are nib based and are the only XIB root object.
public protocol NibIdentifiable: class {

  /// **Mechanica**
  ///
  /// The name of the nib file.
  static var nibIdentifier: String { get }

}

// MARK: - NibIdentifiable Default implementation

public extension NibIdentifiable {

  /// **Mechanica**
  ///
  /// The name of the nib file.
  ///
  /// By default the *nibIdentifier* is the name of the class.
  static var nibIdentifier: String {
    return String(describing: self)
  }

  /// **Mechanica**
  ///
  /// - Parameter bundle: the bundle where the .xib file is located.
  /// - Returns: the nib whose `Self` is the the only XIB root object.
  ///
  /// Example:
  ///
  ///       extension MyView: NibIdentifiable {} //in a MyView.xib should exists only an object of class "MyView".
  ///       let nib = nib()
  ///
  static func nib(inBundle bundle: Bundle? = nil) -> Nib {
    #if os(iOS) || os(tvOS)
      return Nib(nibName: nibIdentifier, bundle: bundle)
    #elseif os(macOS)
      return Nib(nibNamed: NSNib.Name(rawValue: nibIdentifier), bundle: bundle)!
    #endif
  }

  /// **Mechanica**
  ///
  /// - Parameter bundle: the bundle where the .xib file is located
  /// - Returns: an instance of 'Self´ unarchived from the nib whose `Self` is the the only XIB root object.
  ///
  /// Example:
  ///
  ///       extension MyView: NibIdentifiable {} //in a MyView.xib should exists only an object of class "MyView"
  ///       let view = MyView.instantiateFromNib()
  ///
  static func instantiateFromNib(inBundle bundle: Bundle? = nil) -> Self {
    #if os(iOS) || os(tvOS)
      let content = nib(inBundle: bundle).instantiate(withOwner: self, options: nil).first as? Self
    #elseif os(macOS)
      var objects: NSArray?
      guard (nib(inBundle: bundle).instantiate(withOwner: self, topLevelObjects: &objects)) else {
        fatalError("\(String(describing: self)) could not be instantiated.")
      }
      guard let array = objects else {
        fatalError("\(String(describing: self)) could not be instantiated. There should be a top object.")
      }
      let contents = array.filter { $0 is Self }
      guard contents.count == 1 else {
        fatalError("\(String(describing: self)) could not be instantiated. There should be only a top object (and not \(contents.count) whose class is \(String(describing: self)).")
      }
      let content = contents.first as? Self
    #endif

    guard let rootContent = content else {
      fatalError("\(String(describing: self)) could not be instantiated. Please verify if \(nibIdentifier).xib exists and contains only a top object whose class is \(String(describing: self)).")
    }
    return rootContent
  }

}
