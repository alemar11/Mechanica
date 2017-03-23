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


/// **Mechanica**
///
/// Global shortcut for `UserDefaults.standard`
/// - Note: If you want to use a shared user defaults, redefine this global variable in your app, like so:
/// ```
/// var Defaults = UserDefaults(suiteName: "org.tinrobots.app")!
/// ```
public let Defaults = UserDefaults.standard



/// Base struct for static user defaults keys.
/// Specialize with value type and pass key name to the initializer to create a key.

public struct Key<T> {
  public let value: String
}


public extension UserDefaults {

  /// **Mechanica**
  ///
  /// Returns `true` if `key` exists.
  public func hasKey(_ key: String) -> Bool {
    return object(forKey: key) != nil
  }

  /// **Mechanica**
  ///
  /// Removes all keys and values from user defaults.
  /// - Note: This method only removes keys on the receiver `UserDefaults` object.
  ///         System-defined keys will still be present afterwards.
  ///         `resetStandardUserDefaults` simply resets the in-memory user defaults object.
  public func removeAll() {
    for (key, _) in dictionaryRepresentation() {
      removeObject(forKey: key)
    }
  }

  /// Removes the contents of the specified persistent domain from the user’s defaults.
  public func destory(bundleIdentifier: String) {
    removePersistentDomain(forName: bundleIdentifier)
  }

}


extension UserDefaults {

  /// This function allows you to create your own custom subscript. Example: `[Int: String]`.
  public func set<T>(_ value: Any?, forKey key: Key<T>) {
    set(value, forKey: key.value)
  }

  /// Returns `true` if `key` exists
  public func hasKey<T>(_ key: Key<T>) -> Bool {
    return object(forKey: key.value) != nil
  }

  /// Removes value for `key`
  public func removeObject<T>(forKey key: Key<T>) {
    removeObject(forKey: key.value)
  }

}

extension UserDefaults {

  //  MARK: - String

  public subscript(key: Key<String>) -> String? {
    get { return string(forKey: key) }
    set { set(newValue, forKey: key) }
  }

  /// **Mechanica**
  ///
  /// Returns the string associated with the specified key.
  public func string(forKey key: Key<String>) -> String? {
    return string(forKey: key.value)
  }

  /// **Mechanica**
  ///
  /// Stores a string (or removes the value if nil is passed as the value) for the provided key.
  public func set(string: String?, forKey key: Key<String>) {
    set(string, forKey: key)
  }

  // MARK: - Object

  public subscript(key: Key<Any>) -> Any? {
    get { return object(forKey: key) }
    set { set(newValue, forKey: key) }
  }

  /// Returns the object associated with the first occurrence of the specified default.
  func object(forKey key: Key<Any>) -> Any? {
    return object(forKey: key.value)
  }

  /// Sets the value of the specified default key in the standard application domain.
  /// The value parameter can be only property list objects: NSData, NSString, NSNumber, NSDate, NSArray, or NSDictionary. For NSArray and NSDictionary objects, their contents must be property list objects.
  public func set(object: Any?, forKey key: Key<Any>) {
    set(object, forKey: key)
  }

  // MARK: - NSNumber

  public subscript(key: Key<NSNumber?>) -> NSNumber? {
    get { return object(forKey: key.value) as? NSNumber }
    set { set(newValue, forKey: key) }
  }

  /// Returns the NSNumber associated with the first occurrence of the specified default.
  public func number(forKey key: Key<NSNumber>) -> NSNumber? {
    return object(forKey: key.value) as? NSNumber
  }

  /// Sets the value of the specified default key in the standard application domain.
  public func set(number: NSNumber?, forKey key: Key<NSNumber>) {
    set(number, forKey: key)
  }

  // MARK: - Array

  public subscript(key: Key<[Any]>) -> [Any]? {
    get { return array(forKey: key) }
    set { set(newValue, forKey: key) }
  }

  /// Returns the array associated with the specified key.
  public func array(forKey key: Key<[Any]>) -> [Any]? {
    return array(forKey: key.value)
  }

  /// Sets the value of the specified default key in the standard application domain.
  public func set(array: [Any]?, forKey key: Key<[Any]>) {
    set(array, forKey: key)
  }

  // MARK: - Dictionary

  public subscript(key: Key<[String: Any]?>) -> [String: Any]? {
    get { return dictionary(forKey: key.value) }
    set { set(newValue, forKey: key) }
  }

  public func dictionary(forKey key: Key<[String: Any]>) -> [String: Any]? {
    return dictionary(forKey: key.value)
  }

  /// Sets the value of the specified default key in the standard application domain.
  public func set(dictionary: [String: Any]? , forKey key: Key<[String: Any]>) {
    set(dictionary, forKey: key)
  }


  // MARK: - Date

  public subscript(key: Key<Date?>) -> Date? {
    get { return object(forKey: key.value) as? Date }
    set { set(newValue, forKey: key) }
  }

  public func date(forKey key: Key<Date>) -> Date? {
    return object(forKey: key.value) as? Date
  }

  /// Sets the value of the specified default key in the standard application domain.
  public func set(date: Date?, forKey key: Key< Date>) {
    set(date, forKey: key)
  }

  // MARK: - Data

  public subscript(key: Key<Data?>) -> Data? {
    get { return data(forKey: key.value) }
    set { set(newValue, forKey: key) }
  }

  /// Returns the data object associated with the specified key.
  public func data(forKey key: Key<Data>) -> Data? {
    return data(forKey: key.value)
  }

  /// Sets the data value of the specified default key in the standard application domain.
  public func set(data:  Data? , forKey key: Key< Data>) {
    set(data, forKey: key)
  }


  // MARK: - Int

  public subscript(key: Key<Int?>) -> Int? {
    get { return integer(forKey: key.value) }
    set { set(newValue, forKey: key) }
  }

  /// Returns the integer value associated with the specified key.
  public func integer(forKey key: Key<Int>) -> Int? {
    return integer(forKey: key.value)
  }

  /// Sets the value of the specified default key in the standard application domain.
  public func set(integer: Int?, forKey key: Key<Int>) {
    set(integer, forKey: key)
  }


  // MARK: - Double

  public subscript(key: Key<Double?>) -> Double? {
    get { return double(forKey: key.value) }
    set { set(newValue, forKey: key) }
  }

  /// Returns the double value associated with the specified key.
  public func double(forKey key: Key<Double>) -> Double? {
    return double(forKey: key.value)
  }

  /// Sets the value of the specified default key in the standard application domain.
  public func set(double: Double?, forKey key: Key<Double>) {
    set(double, forKey: key)
  }

  // MARK: - Float

  public subscript(key: Key<Float?>) -> Float? {
    get { return float(forKey: key.value) }
    set { set(newValue, forKey: key) }
  }

  /// Returns the floating-point value associated with the specified key.
  public func float(forKey key: Key<Float>) -> Float? {
    return float(forKey: key.value)
  }

  /// Sets the value of the specified default key in the standard application domain.
  public func set(float: Float?, forKey key: Key<Float>) {
    set(float, forKey: key)
  }

  // MARK: - Bool

  public subscript(key: Key<Bool?>) -> Bool? {
    get { return bool(forKey: key.value) }
    set { set(newValue, forKey: key) }
  }

  /// Returns the Boolean value associated with the specified key.
  public func bool(forKey key: Key<Bool>) -> Bool? {
    return bool(forKey: key.value)
  }

  /// Sets the value of the specified default key in the standard application domain.
  public func set(int: Bool?, forKey key: Key<Bool>) {
    set(int, forKey: key)
  }


  //  MARK: - URL

  public subscript(key: Key<URL?>) -> URL? {
    get { return url(forKey: key.value) }
    set { set(newValue, forKey: key) }
  }

  /// Returns the URL instance associated with the specified key.
  public func url(forKey key: Key<URL>) -> URL? {
    return url(forKey: key.value)
  }

  /// Sets the value of the specified default key in the standard application domain.
  public func set(url: URL?, forKey key: Key<URL>) {
    set(url, forKey: key)
  }


}



// Use <T: Any> and <T: _ObjectiveCBridgeable> to suppress compiler warnings about NSArray not being convertible to [T]
// Any is for NSData and NSDate, _ObjectiveCBridgeable is for value types bridge-able to Foundation types (String, Int, ...)

extension UserDefaults {

  public func array<T: _ObjectiveCBridgeable>(forKey key: Key<[T]>) -> [T] {
    return array(forKey: key.value) as NSArray? as? [T] ?? []
  }

  public func array<T: _ObjectiveCBridgeable>(forKey key: Key<[T]?>) -> [T]? {
    return array(forKey: key.value) as NSArray? as? [T]
  }

  public func array<T: Any>(forKey key: Key<[T]>) -> [T] {
    return array(forKey: key.value) as NSArray? as? [T] ?? []
  }

  public func array<T: Any>(forKey key: Key<[T]?>) -> [T]? {
    return array(forKey: key.value) as NSArray? as? [T]
  }

}

extension UserDefaults {

  public subscript(key: Key<[String]?>) -> [String]? {
    get { return array(forKey: key) }
    set { set(newValue, forKey: key) }
  }

  public subscript(key: Key<[String]>) -> [String] {
    get { return array(forKey: key) }
    set { set(newValue, forKey: key) }
  }

  public subscript(key: Key<[Int]?>) -> [Int]? {
    get { return array(forKey: key) }
    set { set(newValue, forKey: key) }
  }

  public subscript(key: Key<[Int]>) -> [Int] {
    get { return array(forKey: key) }
    set { set(newValue, forKey: key) }
  }

  public subscript(key: Key<[Double]?>) -> [Double]? {
    get { return array(forKey: key) }
    set { set(newValue, forKey: key) }
  }

  public subscript(key: Key<[Double]>) -> [Double] {
    get { return array(forKey: key) }
    set { set(newValue, forKey: key) }
  }

  public subscript(key: Key<[Bool]?>) -> [Bool]? {
    get { return array(forKey: key) }
    set { set(newValue, forKey: key) }
  }

  public subscript(key: Key<[Bool]>) -> [Bool] {
    get { return array(forKey: key) }
    set { set(newValue, forKey: key) }
  }

  public subscript(key: Key<[Data]?>) -> [Data]? {
    get { return array(forKey: key) }
    set { set(newValue, forKey: key) }
  }

  public subscript(key: Key<[Data]>) -> [Data] {
    get { return array(forKey: key) }
    set { set(newValue, forKey: key) }
  }

  public subscript(key: Key<[Date]?>) -> [Date]? {
    get { return array(forKey: key) }
    set { set(newValue, forKey: key) }
  }

  public subscript(key: Key<[Date]>) -> [Date] {
    get { return array(forKey: key) }
    set { set(newValue, forKey: key) }
  }

}

// MARK: - Archiving custom types

// MARK: RawRepresentable

extension UserDefaults {

  // TODO: we need to be sure that T.RawValue is compatible
  public func archive<T: RawRepresentable>(_ key: Key<T>, _ value: T) {
    set(value.rawValue, forKey: key)
  }

  public func archive<T: RawRepresentable>(_ key: Key<T?>, _ value: T?) {
    if let value = value {
      set(value.rawValue, forKey: key)
    } else {
      removeObject(forKey: key)
    }
  }

  public func unarchive<T: RawRepresentable>(_ key: Key<T?>) -> T? {
    return object(forKey: key.value).flatMap { T(rawValue: $0 as! T.RawValue) }
  }

  public func unarchive<T: RawRepresentable>(_ key: Key<T>) -> T? {
    return object(forKey: key.value).flatMap { T(rawValue: $0 as! T.RawValue) }
  }
}

// MARK: NSCoding

extension UserDefaults {

  public func archive<T: NSCoding>(_ key: Key<T>, _ value: T) {
    set(NSKeyedArchiver.archivedData(withRootObject: value), forKey: key)
  }

  public func archive<T: NSCoding>(_ key: Key<T?>, _ value: T?) {
    if let value = value {
      set(NSKeyedArchiver.archivedData(withRootObject: value), forKey: key)
    } else {
      removeObject(forKey: key)
    }
  }

  public func unarchive<T: NSCoding>(_ key: Key<T>) -> T? {
    return data(forKey: key.value).flatMap { NSKeyedUnarchiver.unarchiveObject(with: $0) } as? T
  }
  
  public func unarchive<T: NSCoding>(_ key: Key<T?>) -> T? {
    return data(forKey: key.value).flatMap { NSKeyedUnarchiver.unarchiveObject(with: $0) } as? T
  }
  
}



