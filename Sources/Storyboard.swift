//
//  Storyboard.swift
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

#if os(iOS) || os(tvOS)
  import UIKit
  /// **Mechanica**
  ///
  /// Alias for UIStoryboard.
  public typealias Storyboard = UIStoryboard
#elseif os(macOS)
  import Cocoa
  /// **Mechanica**
  ///
  /// Alias for NSStoryboard.
  public typealias Storyboard = NSStoryboard
#endif

// MARK: - StoryboardKeyCodable

/// **Mechanica**
///
/// Types adopting the `StoryboardKeyCodable` protocol can be used to define Storyboard names.
public protocol StoryboardKeyCodable {
  associatedtype StoryboardName: RawRepresentable
}

extension StoryboardKeyCodable where StoryboardName.RawValue == String {
  
  /**
   **Mechanica**
   
   Creates and returns a storyboard object for a specified storyboard enum case.
   
   i.e.
   ```
   extension Storyboard: StoryboardKeyCodable {
   enum StoryboardName : String {
   case main    = "MainStoryboard"
   case detail  = "DetailStoryboard"
   }
   }
   
   let mainStoryboard = Storyboard.storyboard(forKey: .main)
   ```
   - Note: If the bundle parameter is nil, the main bundle is used.
   */
  public static func storyboard(forKey key: StoryboardName, bundle: Bundle? = nil) -> Storyboard {
    return Storyboard(storyboard: key, bundle: bundle)
  }
  
}

extension Storyboard {
  
  /**
   **Mechanica**
   
   Creates and returns a storyboard object for a specified storyboard enum case.
   
   i.e.
   ```
   extension Storyboard {
   enum StoryboardName : String {
   case main = "MainStoryboard"
   case detail = "DetailStoryboard"
   }
   }
   
   let mainStoryboard = Storyboard(storyboard: Storyboard.StoryboardName.main)
   ```
   
   */
  fileprivate convenience init<T: RawRepresentable>(storyboard: T, bundle: Bundle? = nil) where T.RawValue == String {
    self.init(name: storyboard.rawValue, bundle: bundle)
  }
}

// MARK: - Storyboard Main (default)

extension Storyboard {
  
  private enum MainStoryboard {
    static let uiMainStoryboardFileKey = "UIMainStoryboardFile"
    static let nsMainStoryboardFileKey = "NSMainStoryboardFile"
  }
  
  /// Returns the main storyboard defined in an Xcode project under *General* > *Deployment info* > *main interface*.
  public static var mainStoryboard: Storyboard? {
    
    #if os(iOS) || os(tvOS)
      let mainStoryboardFileName = MainStoryboard.uiMainStoryboardFileKey
    #elseif os(macOS)
      let mainStoryboardFileName = MainStoryboard.nsMainStoryboardFileKey
    #endif
    
    guard let mainStoryboardName = Bundle.main.infoDictionary?[mainStoryboardFileName] as? String else {
      //assertionFailure("\(mainStoryboardFileName) not found in main Bundle.")
      return nil
    }
    return Storyboard(name: mainStoryboardName, bundle: Bundle.main)
  }
  
}


// MARK: - StoryboardIdentifiable

/// **Mechanica**
///
/// Objects adopting the `StoryboardIdentifiable` protocol have an unique Storyboard ID.
public protocol StoryboardIdentifiable: class {
  static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable {
  
  /// **Mechanica**
  ///
  /// By default the *storyboardIdentifier* (Storyboard ID) is the name of the class.
  public static var storyboardIdentifier: String {
    return String(describing: self)
  }
}

#if os(iOS) || os(tvOS)
  
  extension UIViewController : StoryboardIdentifiable {}
  
#elseif os(macOS)
  
  extension NSViewController : StoryboardIdentifiable {}
  extension NSWindowController : StoryboardIdentifiable {}
  
#endif

extension Storyboard {
  
  #if os(iOS) || os(tvOS)
  
  /**
   **Mechanica**
   
   Instantiates and returns a UIViewController conforming to `StoryboardIdentifiable`.
   - Note: In Xcode, set as "Storyboard ID" the UIViewController class name.
   
   ```
   let vc = myStoryboard.instantiateViewController() as TestViewController
   ```
   */
  public final func instantiateViewController<T: UIViewController>() -> T where T: StoryboardIdentifiable {
    guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
      fatalError("Couldn't instantiate a View Controller with identifier \(T.storyboardIdentifier) ")
    }
    return viewController
  }
  
  
  #elseif os(macOS)
  
  /**
   **Mechanica**
   
   Instantiates and returns a NSViewController conforming to `StoryboardIdentifiable`.
   - Note: In Xcode, set as "Storyboard ID" the NSViewController class name.
   
   ```
   let vc = myStoryboard.instantiateViewController() as TestViewController
   ```
   */
  public final func instantiateViewController<T: NSViewController>() -> T where T: StoryboardIdentifiable {
    guard let viewController = self.instantiateController(withIdentifier: T.storyboardIdentifier) as? T else {
      fatalError("Couldn't instantiate a View Controller with identifier \(T.storyboardIdentifier) ")
    }
    return viewController
  }
  
  /**
   **Mechanica**
   
   Instantiates and returns a NSWindowController conforming to `StoryboardIdentifiable`.
   - Note: In Xcode, set as "Storyboard ID" the NSWindowController class name.
   
   ```
   let wc = myStoryboard.instantiateViewController() as TestViewController
   ```
   */
  public final func instantiateWindowController<T: NSWindowController>() -> T where T: StoryboardIdentifiable {
    guard let windowController = self.instantiateController(withIdentifier: T.storyboardIdentifier) as? T else {
      fatalError("Couldn't instantiate a Window Controller with identifier \(T.storyboardIdentifier) ")
    }
    return windowController
  }
  
  #endif
  
}


