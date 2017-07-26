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

import Foundation

/// **Mechanica**
///
/// Base enum for static keys with a phantom type.
/// Specialize this enum with a type and initialize it with a key, key path (both namespaced or not).
/// - Note: Use `Key` to avoid *stringly typed* APIs.
///
/// - simple: a `String` key or key path.
/// - namespaced: a namespaced `String` key or key path.
///
///
/// ```
/// Key<String>("myKey1") // value: myKey1
/// Key<Int>("myKey2", namespace: "org.tinrobots")  // value: org.tinrobots.myKey2
/// Key<Bool>("myKey2", namespace: "org.tinrobots") // value: org.tinrobots.myKey3
/// ```
///
public enum Key<T>: CustomStringConvertible {

  /// **Mechanica**
  ///
  /// A simple `String` key, use it for no namespaced keys or key paths.
  case simple(String)

  /// **Mechanica**
  ///
  /// A namespaced String key.
  case namespaced(String, namespace: String)

  /// Create a new Key.
  ///
  /// - Parameters:
  ///   - string: key or key path value.
  ///   - namespace: optional namespace for the key to avoid collision with other keys with the same value defined in other libraries.
  public init(_ string: String, namespace: String...) {
    if namespace.count > 0 {
      self = .namespaced(string, namespace:  namespace.joined(separator: "."))
    } else {
      self = .simple(string)
    }
  }

  /// **Mechanica**
  ///
  /// Returns the key formatted with the namespace if defined.
  public var value: String {
    switch self {
    case .simple(let k):
      return k
    case let .namespaced(k, n):
      return n + "." + k
    }
  }

  public var description: String {
    return ("Key<\(T.self)> with value: \(value)")
  }

}
