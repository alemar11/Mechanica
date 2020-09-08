#if canImport(Foundation)

import Foundation

// MARK: - Utilities

extension NSObjectProtocol {
  /// **Mechanica**
  ///
  /// Returns the type of an object conforming to `NSObjectProtocol` as `String`.
  public var type: String {
    return typeName(of: self)
  }

  /// **Mechanica**
  ///
  /// Returns the type of an object instance conforming to `NSObjectProtocol` as `String`.
  public static var type: String {
    return typeName(of: self)
  }
}

// MARK: - Associated Objects

#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
extension NSObjectProtocol {
  /// **Mechanica**
  ///
  /// Sets an associated value using a given key and association policy.
  ///
  /// - Parameters:
  ///   - value: The value to associate with the key key for object. Pass nil to clear an existing association.
  ///   - key: The key for the association.
  ///   - policy: The policy for the association.
  public func setAssociatedValue<T>(_ value: @autoclosure () -> T?,
                                    forKey key: UnsafeRawPointer,
                                    andPolicy policy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN_NONATOMIC) {
    Mechanica.setAssociatedValue(value(), forObject: self, usingKey: key)
  }

  /// **Mechanica**
  ///
  /// Returns the value associated for a given key.
  ///
  /// - Parameter key: The key for the association.
  /// - Returns: The value associated with the key for object.
  public func getAssociatedValue<T>(forKey key: UnsafeRawPointer) -> T? {
    return Mechanica.getAssociatedValue(forObject: self, usingKey: key)
  }

  /// **Mechanica**
  ///
  /// Removes an associated value using a given key and association policy.
  ///
  /// - Parameters:
  ///   - key: The key for the association.
  ///   - policy: The policy for the association.
  public func removeAssociatedValue(forKey key: UnsafeRawPointer,
                                    andPolicy policy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN_NONATOMIC) {
    Mechanica.removeAssociatedValue(forObject: self, usingKey: key, andPolicy: policy)
  }

  /// **Mechanica**
  ///
  /// Removes all the associated values.
  public func removeAllAssociatedValues() {
    Mechanica.removeAllAssociatedValues(forObject: self)
  }
}
#endif

// MARK: - Method Swizzling

#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
extension NSObjectProtocol {
  /// **Mechanica**
  ///
  /// Couple of `Selector` where the method corresponding to the first one needs to be exchanged with the second one.
  public typealias SwizzlingSelectors = (originalSelector: Selector, swizzledSelector: Selector)

  /// **Mechanica**
  ///
  /// Exchanges the implementations of two methods given their corresponding selectors.
  ///
  /// To use method swizzling with your Swift classes there are two requirements that you must comply with:
  /// 1. The class containing the methods to be swizzled must extend **NSObject**.
  /// 1. The methods you want to swizzle must have the **dynamic** attribute.
  ///
  /// - Parameters:
  ///   - originalSelector: `Selector` for the original method
  ///   - swizzledSelector: `Selector` for the swizzled methos
  ///
  /// - Note: In Objective-C you'd perform the swizzling in load() , but this method is not permitted in Swift.
  /// But load is a Objective-C only method and cannot be overridden in Swift, trying to do it anyway will result in a compile time error.
  /// The next best place to perform the swizzling is in initialize, a method called right before the first method of your class is invoked.
  /// - SeeAlso: [Effective method swizzling with Swift](https://www.uraimo.com/2015/10/23/effective-method-swizzling-with-swift/)
  public static func swizzle(method originalSelector: Selector, with swizzledSelector: Selector) {
    let originalMethod = class_getInstanceMethod(self, originalSelector)!
    let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)!
    let isMethodAdded = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))

    if isMethodAdded {
      class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
    } else {
      method_exchangeImplementations(originalMethod, swizzledMethod)
    }
  }

  /// **Mechanica**
  ///
  /// Exchanges the implementations of each couple of Selectors.
  /// - SeeAlso: `swizzle(method:with:)`
  public static func swizzle(_ selectors: [SwizzlingSelectors]) {
    selectors.forEach { swizzle(method: $0.0, with: $0.1) }
  }
}
#endif

#endif
