//
//  PropertyListReadable.swift
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
/// Types conforming to `PropertyListReadable` can be used to read values from a Property List (.plist) file.
public protocol PropertyListReadable {

  /// **Mechanica**
  ///
  /// Protocol `PropertyListReadable`.
  ///
  /// Dictionary representing the Propery List File.
  var propertyList: NSDictionary { get }

}

// MARK: - PropertyListReadable + Key

extension PropertyListReadable {

  // MARK: - Bool

  /// **Mechanica**
  ///
  /// Returns an `Bool` value for a specified key path or nil if the key was not found.
  public final func bool(forKeyPath keyPath: Key<Bool>) -> Bool? {
    return propertyList.value(forKeyPath: keyPath.value) as? Bool
  }

  // MARK: - String

  /// **Mechanica**
  ///
  /// Returns an `String` value for a specified key path or nil if the key was not found.
  public final func string(forKeyPath keyPath: Key<String>) -> String? {
    return propertyList.value(forKeyPath: keyPath.value) as? String
  }

  // MARK: - URL

  /// **Mechanica**
  ///
  /// Returns an `URL` value for a specified key path or nil if the key was not found.
  public final func url(forKeyPath keyPath: Key<URL>) -> URL? {
    guard let url = propertyList.value(forKeyPath: keyPath.value) as? String else { return nil }
    return URL(string: url)
  }

  // MARK: - NSNumber

  /// **Mechanica**
  ///
  /// Returns a `NSNumber` object for a specified key path or nil if the key was not found.
  public final func number(forKeyPath keyPath: Key<NSNumber>) -> NSNumber? {
    return propertyList.value(forKeyPath: keyPath.value) as? NSNumber
  }

  // MARK: - Date

  /// **Mechanica**
  ///
  /// Returns an `Date` value value for a specified key path or nil if the key was not found.
  public final func date(forKeyPath keyPath: Key<Date>) -> Date? {
    return propertyList.value(forKeyPath: keyPath.value) as? Date
  }

  // MARK: - Data

  /// **Mechanica**
  ///
  /// Returns an `Data` value for a specified key path or nil if the key was not found.
  public final func data(forKeyPath keyPath: Key<Data>) -> Data? {
    return propertyList.value(forKeyPath: keyPath.value) as? Data
  }

  // MARK: - Array

  /// **Mechanica**
  ///
  /// Returns an `Array` value for a specified key path or nil if the key was not found.
  public final func array<T: Any>(forKeyPath keyPath: Key<[T]>) -> [T]? {
    return (propertyList.value(forKeyPath: keyPath.value) as? [T])
  }

  // MARK: - Dictionary

  /// **Mechanica**
  ///
  /// Returns an `Dictionary` [String:V] for a specified key path or nil if the key was not found.
  public final func dictionary<V: Any>(forKeyPath keyPath: Key<[String: V]>) ->  [String:V]? {
    return propertyList.value(forKeyPath: keyPath.value) as? [String: V]
  }

}
