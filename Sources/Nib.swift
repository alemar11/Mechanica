//
//  Nib.swift
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

import UIKit

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
   case first = "first"
   case second = "second"
   }
   }
   
   let firstNib = Nib.nib(forKey: main)
   ```
   - note: If the bundle parameter is nil, the main bundle is used.
   */
  public static func nib(forKey key: NibName, bundle: Bundle? = nil) -> UINib {
    return  UINib(nibName: key.rawValue, bundle: bundle)
  }
  
}

/// **Mechanica**
///
/// Types adopting the `NibLoadable` protocol can be loaded from a Nib.
public protocol NibLoadable {}

extension UIView : NibLoadable {}

extension UINib {
  
  /// **Mechanica**
  ///
  /// Instantiates and returns an obejct conforming to `NibLoadable` from a Nib.
  public func instantiate<T>(withOwner owner: Any? = nil, options: [AnyHashable : Any]? = nil) -> T where T: NibLoadable {
    
    let contents = self.instantiate(withOwner: owner, options: options).filter { return $0 is T }
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
