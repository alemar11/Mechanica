//
//  Key.swift
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
/// Base enum for static keys with a phantom type.
/// Specialize this struct with a type and initialize it with a value.
/// - Note: Use `Key` to avoid *stringly typed* APIs.
///
/// - simple: a `String` key.
/// - namespaced: a namespaced `String` key.
/// - path: a `String` key path.
///
///
/// ```
/// K<String>(key: "myKey1") // value: myKey1
/// K<Int>(key: "myKey2", namespace: "org.tinrobots") // value: org.tinrobots.myKey2
/// K<Bool>(key: "myKey2", namespace: "org.tinrobots") // value: org.tinrobots.myKey3
/// ```
///
public enum Key<T> {
  
  /// **Mechanica**
  ///
  /// A simple `String` key.
  case simple(String)
  /// **Mechanica**
  ///
  /// A namespaced String key.
  case namespaced(String, namespace: String)
  /// **Mechanica**
  ///
  /// A string key path.
  case path(String)
  
  /// Create a new Key.
  ///
  /// - Parameters:
  ///   - key: key value
  ///   - namespace: optional namespace for the key to avoid collision with other keys with the same value defined in other libraries.
  init(key: String, namespace: String? = nil) {
    if let namespace = namespace {
      self = .namespaced(key, namespace: namespace)
    } else {
      self = .simple(key)
    }
  }
  
  
  /// Create a new Key with a path.
  ///
  /// - Parameter path: a `String` composed by a list of keys separated by dots used to identify a nested value.
  init(path: String) {
    self = .path(path)
  }
  
  var value: String {
    switch self {
    case .simple(let k):
      return k
    case let .namespaced(k,n):
      return k + "." + n
    case .path(let path):
      return path
    }
  }
  
}

//TODO: var description



