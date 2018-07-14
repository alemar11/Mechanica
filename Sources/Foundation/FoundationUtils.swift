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
