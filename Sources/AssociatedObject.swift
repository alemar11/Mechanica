//
//  AssociatedObject.swift
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

/// **Mechanica**
///
/// Sets an associated value for a given object using a given key and association policy.
///
/// - Parameters:
///   - value: The value to associate with the key key for object. Pass nil to clear an existing association.
///   - object: The source object for the association.
///   - key: The key for the association.
///   - policy: The policy for the association.
public func setAssociatedValue<T>(_ value: T?, forObject object: Any, usingKey key: UnsafeRawPointer, andPolicy policy : objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN_NONATOMIC) {
  objc_setAssociatedObject(object, key, value, policy)
}

/// **Mechanica**
///
/// Returns the value associated with a given object for a given key.
///
/// - Parameters:
///   - object: The source object for the association.
///   - key: The key for the association.
/// - Returns: he value associated with the key key for object.
public func getAssociatedValue<T>(forObject object: Any, usingKey key: UnsafeRawPointer) -> T? {
  return objc_getAssociatedObject(object, key) as? T
}

// MARK: - Private

/// **Mechanica**
///
/// Clears an associated value for a given object using a given key and association policy.
///
/// - Parameters:
///   - object: The source object for the association.
///   - key: The key for the association.
///   - policy: The policy for the association.
public func clearAssociatedValue(forObject object: Any, usingKey key: UnsafeRawPointer, andPolicy policy : objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN_NONATOMIC) {
  objc_setAssociatedObject(object, key, nil, policy)
}

/// **Mechanica**
///
/// Sets an associated value for a given object using a given key and association policy.
///
/// - Parameters:
///   - object: The source object for the association.
///   - key: The key for the association.
///   - value: The value to associate with the key key for object. Pass nil to clear an existing association.
///   - policy: The policy for the association.
private func setAssociatedObject<T>(object: Any, key: UnsafeRawPointer, value: T?, policy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN_NONATOMIC) {
  objc_setAssociatedObject(object, key, value, policy)
}

/// **Mechanica**
///
/// Returns the value associated with a given object for a given key.
///
/// - Parameters:
///   - object: The source object for the association.
///   - key: The key for the association.
/// - Returns: he value associated with the key key for object.
private func getAssociatedObject<T>(object: Any, key: UnsafeRawPointer) -> T? {
  return objc_getAssociatedObject(object, key) as? T
}

/// **Mechanica**
///
/// Clears an associated value for a given object using a given key and association policy.
///
/// - Parameters:
///   - object: The source object for the association.
///   - key: The key for the association.
///   - policy: The policy for the association.
private func clearAssociatedObject(object: Any, key: UnsafeRawPointer, policy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN_NONATOMIC) {
  objc_setAssociatedObject(object, key, nil, policy)
}
