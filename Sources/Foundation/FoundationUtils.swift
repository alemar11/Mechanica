#if canImport(Foundation)

import Foundation

/// **Mechanica**
///
/// Returns the type name as `String`.
public func typeName(of some: Any) -> String {
  let value = (some is Any.Type) ? "\(some)" : "\(type(of: some))"
  if !value.starts(with: "(") { return value }

  // match a word inside "(" and " in" https://regex101.com/r/eO6eB7/17
  let pattern = "(?<=\\()[^()]{1,}(?=\\sin)"
  // if let result = value.range(of: pattern, options: .regularExpression) { return value[result] }
  if let result = value.firstRange(matching: pattern) {
    return String(value[result])
  }

  return value
}

// MARK: - Objective-C Associated Objects

#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
/// **Mechanica**
///
/// Sets an associated value for a given object using a given key and association policy.
///
/// - Parameters:
///   - value: The value to associate with the key key for object. Pass nil to clear an existing association.
///   - object: The source object for the association.
///   - key: The key for the association.
///   - policy: The policy for the association.
internal func setAssociatedValue<T>(_ value: T?,
                                    forObject object: Any,
                                    usingKey key: UnsafeRawPointer,
                                    andPolicy policy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN_NONATOMIC) {
  Foundation.objc_setAssociatedObject(object, key, value, policy)
}

/// **Mechanica**
///
/// Returns the value associated with a given object for a given key.
///
/// - Parameters:
///   - object: The source object for the association.
///   - key: The key for the association.
/// - Returns: The value associated with the key for object.
internal func getAssociatedValue<T>(forObject object: Any, usingKey key: UnsafeRawPointer) -> T? {
  return Foundation.objc_getAssociatedObject(object, key) as? T
}

/// **Mechanica**
///
/// Removes an associated value for a given object using a given key and association policy.
///
/// - Parameters:
///   - object: The source object for the association.
///   - key: The key for the association.
///   - policy: The policy for the association.
internal func removeAssociatedValue(forObject object: Any,
                                    usingKey key: UnsafeRawPointer,
                                    andPolicy policy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN_NONATOMIC) {
  Foundation.objc_setAssociatedObject(object, key, nil, policy)
}

/// **Mechanica**
///
/// Removes all the associated value for a given object using a given key and association policy.
///
/// - Parameters:
///   - object: The source object for the association.
///   - key: The key for the association.
///   - policy: The policy for the association.
internal func removeAllAssociatedValues(forObject object: Any) {
  Foundation.objc_removeAssociatedObjects(object)
}
#endif

#endif
