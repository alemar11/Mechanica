//
//  UserDefaults+Key.swift
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

extension UserDefaults {

  /// **Mechanica**
  ///
  /// Returns `true` if a `key` exists.
  /// - Note: When a value for a give key is set to nil, the key is automatically removed.
  public final func hasKey<T>(_ key: Key<T>) -> Bool {
    return hasKey(key.value)
  }

  /// **Mechanica**
  ///
  /// Removes value for `key`.
  public final func removeObject<T>(forKey key: Key<T>) {
    removeObject(forKey: key.value)
  }

  // MARK: - Object

  /// **Mechanica**
  ///
  /// Accesses the object value associated with the given key for reading and writing.
  /// - Parameter key: The key to find.
  /// - Returns: The value associated with `key` if `key` is in the dictionary otherwise, `nil`.
  public final subscript<T>(key: Key<T>) -> T? {
    get { return object(forKey: key) }
    set { set(object: newValue, forKey: key) }
  }

  /// **Mechanica**
  ///
  /// Returns the object associated with the specified key, or nil if the key was not found.
  public final func object<T>(forKey key: Key<T>) -> T? {
    return object(forKey: key.value) as? T
  }

  /// **Mechanica**
  ///
  /// Sets the value of the specified default key.
  /// - Note: The value parameter can be only property list objects: Data, String, NSNumber, SDate, NSArray, or NSDictionary.
  /// For NSArray and NSDictionary objects, their contents must be property list objects.
  public final func set<T>(object: T?, forKey key: Key<T>) {
    set(object, forKey: key.value)
  }

  // MARK: - String

  /// **Mechanica**
  ///
  /// Accesses the `String` associated with the given key for reading and writing.
  /// - Parameter key: The key to find.
  /// - Returns: The value associated with `key` if `key` is in the dictionary otherwise, `nil`.
  public final subscript(key: Key<String>) -> String? {
    get { return string(forKey: key) }
    set { set(object: newValue, forKey: key) }
  }

  /// **Mechanica**
  ///
  /// Returns the `String` associated with the specified key.
  public final func string(forKey key: Key<String>) -> String? {
    return string(forKey: key.value)
  }

  /// **Mechanica**
  ///
  /// Stores a `String` (or removes the value if nil is passed as the value) for the provided key.
  public final func set(string: String?, forKey key: Key<String>) {
    set(object: string, forKey: key)
  }

  // MARK: - NSNumber

  /// **Mechanica**
  ///
  /// Accesses the `NSNumber` associated with the given key for reading and writing.
  /// - Parameter key: The key to find.
  /// - Returns: The value associated with `key` if `key` is in the dictionary otherwise, `nil`.
  public final subscript(key: Key<NSNumber>) -> NSNumber? {
    get { return object(forKey: key) }
    set { set(object: newValue, forKey: key) }
  }

  /// **Mechanica**
  ///
  /// Returns the `NSNumber` associated with the specified key, or nil if the key was not found.
  public final func number(forKey key: Key<NSNumber>) -> NSNumber? {
    return object(forKey: key)
  }

  /// **Mechanica**
  ///
  /// Stores a `String` (or removes the value if nil is passed as the value) for the provided key.
  public final func set(number: NSNumber?, forKey key: Key<NSNumber>) {
    set(object: number, forKey: key)
  }

  // MARK: - Array

  /// **Mechanica**
  ///
  /// Accesses the `Array` value associated with the given key for reading and writing.
  /// - Parameter key: The key to find.
  /// - Returns: The value associated with `key` if `key` is in the dictionary otherwise, `nil`.
  public final subscript<V>(key: Key<[V]>) -> [V]? {
    get { return array(forKey: key) }
    set { set(object: newValue, forKey: key) }
  }

  /// **Mechanica**
  ///
  /// Returns the `Array` associated with the specified key, or nil if the key was not found.
  public final func array<T>(forKey key: Key<[T]>) -> [T]? {
    return array(forKey: key.value) as? [T]
  }

  /// **Mechanica**
  ///
  /// Stores an `Array` (or removes the value if nil is passed as the value) for the provided key.
  /// - Note: The value parameter can be only property list objects: Data, String, NSNumber, SDate, NSArray, or NSDictionary.
  /// For NSArray and NSDictionary objects, their contents must be property list objects.
  public final func set<T>(array: [T]?, forKey key: Key<[T]>) {
    set(object: array, forKey: key)
  }

  // MARK: - Dictionary

  /// **Mechanica**
  ///
  /// Accesses the `Dictionary` value [String: V] associated with the given key for reading and writing.
  /// - Parameter key: The key to find.
  /// - Returns: The value associated with `key` if `key` is in the dictionary otherwise, `nil`.
  public final subscript<V>(key: Key<[String: V]>) -> [String: V]? {
    get { return dictionary(forKey: key.value) as? [String : V] }
    set { set(object: newValue, forKey: key) }
  }

  /// **Mechanica**
  ///
  /// Returns the `Dictionary` associated with the specified key, or nil if the key was not found.
  public final func dictionary<V: Any>(forKey key: Key<[String: V]>) -> [String: V]? {
    return dictionary(forKey: key.value) as? [String: V]
  }

  /// **Mechanica**
  ///
  /// Stores a `Dictionary` [String:Any] (or removes the value if nil is passed as the value) for the provided key.
  /// - Note: The value parameter can be only property list objects: Data, String, NSNumber, SDate, NSArray, or NSDictionary. 
  /// For NSArray and NSDictionary objects, their contents must be property list objects.
  public final func set<V>(dictionary: [String: V]?, forKey key: Key<[String: V]>) {
    set(object: dictionary, forKey: key)
  }

  // MARK: - Date

  /// **Mechanica**
  ///
  /// Accesses the `Date` value associated with the given key for reading and writing.
  /// - Parameter key: The key to find.
  /// - Returns: The value associated with `key` if `key` is in the dictionary otherwise, `nil`.
  public final subscript(key: Key<Date>) -> Date? {
    get { return object(forKey: key.value) as? Date }
    set { set(object: newValue, forKey: key) }
  }

  /// **Mechanica**
  ///
  /// Returns the `Date` associated with the specified key, or nil if the key was not found.
  public final func date(forKey key: Key<Date>) -> Date? {
    return object(forKey: key)
  }

  /// **Mechanica**
  ///
  /// Stores a `Date` value (or removes the value if nil is passed as the value) for the provided key.
  public final func set(date: Date?, forKey key: Key< Date>) {
    set(object: date, forKey: key)
  }

  // MARK: - Data

  /// **Mechanica**
  ///
  /// Accesses the `Data` value associated with the given key for reading and writing.
  /// - Parameter key: The key to find.
  /// - Returns: The value associated with `key` if `key` is in the dictionary otherwise, `nil`.
  public final subscript(key: Key<Data>) -> Data? {
    get { return data(forKey: key.value) }
    set { set(object: newValue, forKey: key) }
  }

  /// **Mechanica**
  ///
  /// Returns the `Data` value associated with the specified key, or nil if the key was not found.
  public final func data(forKey key: Key<Data>) -> Data? {
    return data(forKey: key.value)
  }

  /// **Mechanica**
  ///
  /// Stores a `Data` (or removes the value if nil is passed as the value) for the provided key.
  public final func set(data: Data?, forKey key: Key< Data>) {
    set(object: data, forKey: key)
  }

  // MARK: - Int

  /// **Mechanica**
  ///
  /// Accesses the `Int` value associated with the given key for reading and writing.
  /// - Parameter key: The key to find.
  /// - Returns: The value associated with `key` if `key` is in the dictionary otherwise, `nil`.
  public final subscript(key: Key<Int>) -> Int? {
    get { return integer(forKey: key) }
    set { set(object: newValue, forKey: key) }
  }

  /// **Mechanica**
  ///
  /// Returns the `Int` value associated with the specified key, or nil if the key was not found.
  public final func integer(forKey key: Key<Int>) -> Int? {
    return optionalInteger(forKey: key.value)
  }

  /// **Mechanica**
  ///
  /// Stores an `Int` value (or removes the value if nil is passed as the value) for the provided key.
  public final func set(integer: Int?, forKey key: Key<Int>) {
    set(object: integer, forKey: key)
  }

  // MARK: - Double

  /// **Mechanica**
  ///
  /// Accesses the `Double` value associated with the given key for reading and writing.
  /// - Parameter key: The key to find.
  /// - Returns: The value associated with `key` if `key` is in the dictionary otherwise, `nil`.
  public final subscript(key: Key<Double>) -> Double? {
    get { return double(forKey: key) }
    set { set(object: newValue, forKey: key) }
  }

  /// **Mechanica**
  ///
  /// Returns the `Double` value associated with the specified key, or nil if the key was not found.
  public final func double(forKey key: Key<Double>) -> Double? {
    return optionalDouble(forKey: key.value)
  }

  /// **Mechanica**
  ///
  /// Stores a `Double` value (or removes the value if nil is passed as the value) for the provided key.
  public final func set(double: Double?, forKey key: Key<Double>) {
    set(object: double, forKey: key)
  }

  // MARK: - Float

  /// **Mechanica**
  ///
  /// Accesses the `Flaoting-Point` value associated with the given key for reading and writing.
  /// - Parameter key: The key to find.
  /// - Returns: The value associated with `key` if `key` is in the dictionary otherwise, `nil`.
  public final subscript(key: Key<Float>) -> Float? {
    get { return float(forKey: key) }
    set { set(object: newValue, forKey: key) }
  }

  /// **Mechanica**
  ///
  /// Returns the `Floating-Point` value associated with the specified key, or nil if the key was not found.
  public final func float(forKey key: Key<Float>) -> Float? {
    return optionalFloat(forKey: key.value)
  }

  /// **Mechanica**
  ///
  /// Stores a `Floating-Point` value (or removes the value if nil is passed as the value) for the provided key.
  public final func set(float: Float?, forKey key: Key<Float>) {
    set(object: float, forKey: key)
  }

  // MARK: - Bool

  /// **Mechanica**
  ///
  /// Accesses the `Bool` value associated with the given key for reading and writing.
  /// - Parameter key: The key to find.
  /// - Returns: The value associated with `key` if `key` is in the dictionary otherwise, `nil`.
  public final subscript(key: Key<Bool>) -> Bool? {
    get { return bool(forKey: key) }
    set { set(object: newValue, forKey: key) }
  }

  /// **Mechanica**
  ///
  /// Returns the `Bool` value associated with the specified key, or nil if the key was not found.
  public final func bool(forKey key: Key<Bool>) -> Bool? {
    return optionalBool(forKey: key.value)
  }

  /// **Mechanica**
  ///
  /// Stores a `Bool` value (or removes the value if nil is passed as the value) for the provided key.
  public final func set(bool: Bool?, forKey key: Key<Bool>) {
    set(object: bool, forKey: key)
  }

  // MARK: - URL

  /// **Mechanica**
  ///
  /// Accesses the `URL` instance associated with the given key for reading and writing.
  /// - Parameter key: The key to find.
  /// - Returns: The value associated with `key` if `key` is in the dictionary otherwise, `nil`.
  public final subscript(key: Key<URL>) -> URL? {
    get { return url(forKey: key.value) }
    set { set(url: newValue, forKey: key) }
  }

  /// **Mechanica**
  ///
  /// Returns the `URL` instance associated with the specified key, or nil if the key was not found.
  public final func url(forKey key: Key<URL>) -> URL? {
    return url(forKey: key.value)
  }

  /// **Mechanica**
  ///
  /// Stores an `URL` instance (or removes the value if nil is passed as the value) for the provided key.
  public final func set(url: URL?, forKey key: Key<URL>) {
    if let url = url {
      set(url, forKey: key.value)
    } else {
      removeObject(forKey: key)
    }
  }

  // MARK: NSCoding

  /// **Mechanica**
  ///
  /// Returns the object conformig to `NSCoding` associated with the specified key, or nil if the key was not found.
  public final func archivableValue<T: NSCoding>(forKey key: Key<T>) -> T? {
    return archivableValue(forKey: key.value)
  }

  /// **Mechanica**
  ///
  /// Stores an object conformig to `NSCoding` (or removes the value if nil is passed as the value) for the provided key.
  public final func set<T: NSCoding>(archivableValue value: T?, forKey key: Key<T>) {
    set(archivableValue: value, forKey: key.value)
  }

}

//extension UserDefaults {
//
//  public final subscript(key: Key<[String]>) -> [String]? {
//    get { return array(forKey: key) }
//    set { set(newValue, forKey: key) }
//  }
//
//  public final subscript(key: Key<[Int]>) -> [Int]? {
//    get { return array(forKey: key) }
//    set { set(newValue, forKey: key) }
//  }
//
//  public final subscript(key: Key<[Double]>) -> [Double]? {
//    get { return array(forKey: key) }
//    set { set(newValue, forKey: key) }
//  }
//
//  public final subscript(key: Key<[Bool]>) -> [Bool]? {
//    get { return array(forKey: key) }
//    set { set(newValue, forKey: key) }
//  }
//
//  public final subscript(key: Key<[Data]>) -> [Data]? {
//    get { return array(forKey: key) }
//    set { set(newValue, forKey: key) }
//  }
//
//  public final subscript(key: Key<[Date]>) -> [Date]? {
//    get { return array(forKey: key) }
//    set { set(newValue, forKey: key) }
//  }
//
//}

// MARK: RawRepresentable

//extension UserDefaults {
//
//  public final func set<T: RawRepresentable>(rawRepresentable value: T?, forKey key: Key<T>) {
//    guard let value = value else {
//      removeObject(forKey: key)
//      return
//    }
//    switch value.rawValue {
//    case let raw as String:
//      set(raw, forKey: key.value)
//    case let raw as Int:
//      set(raw, forKey: key.value)
//    case let raw as Float:
//      set(raw, forKey: key.value)
//    case let raw as Double:
//      set(raw, forKey: key.value)
//    default:
//      fatalError("\(type(of: T.self)) is not a compatible type.")
//    }
//
//  }
//
//  public final func rawRepresentable<T: RawRepresentable>(forKey key: Key<T>) -> T? {
//    return object(forKey: key.value).flatMap { T(rawValue: $0 as! T.RawValue) }
//  }
//  
//}
