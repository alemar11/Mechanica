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
/// - key: key value
/// - namespacedKey: optional namespace, if not empty Key value will be namespace.key
///
/// ```
/// K<String>(key: "myKey1") // value: myKey1
/// K<Int>(key: "myKey2", namespace: "org.tinrobots") // value: org.tinrobots.myKey2
/// K<Bool>(key: "myKey2", namespace: "org.tinrobots") // value: org.tinrobots.myKey3
/// ```
///
public enum Key<T> {

  case key(key: String)
  case namespacedKey(namespace:String, key: String)

  init(key: String, namespace: String = "") {
    if namespace.isBlank {
      self = .key(key: key)
    } else {
      self = .namespacedKey(namespace: namespace, key: key)
    }
  }

  var value: String {
    print(self)
    switch self {
    case .key(let k):
      print("1")
      return k
    case let .namespacedKey(k,n):
      print("2")
      return k + "." + n //TODO add . only if needed
    }
  }

}



