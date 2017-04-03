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


// TODO: https://github.com/apple/swift-evolution/blob/master/proposals/0148-generic-subscripts.md

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
  public final func hasKey(_ key: String) -> Bool {
    return object(forKey: key) != nil
  }

  /// **Mechanica**
  ///
  /// Removes all keys and values from user defaults.
  /// - Note: This method only removes keys on the receiver `UserDefaults` object.
  ///         System-defined keys will still be present afterwards.
  ///         `resetStandardUserDefaults` simply resets the in-memory user defaults object.
  public final func removeAll() {
    for (key, _) in dictionaryRepresentation() {
      removeObject(forKey: key)
    }
  }

  /// **Mechanica**
  ///
  /// Removes the contents of the specified persistent domain from the user’s defaults.
  public final func destroy(bundleIdentifier: String) {
    removePersistentDomain(forName: bundleIdentifier)
  }

}


extension UserDefaults {

  /// **Mechanica**
  ///
  /// This function allows you to create your own custom subscript. Example: `[Int: String]`.
  public final func set<T>(_ value: Any?, forKey key: Key<T>) {
    set(value, forKey: key.value)
  }

  /// **Mechanica**
  ///
  /// Returns `true` if `key` exists
  public final func hasKey<T>(_ key: Key<T>) -> Bool {
    return object(forKey: key.value) != nil
  }

  /// **Mechanica**
  ///
  /// Removes value for `key`
  public final func removeObject<T>(forKey key: Key<T>) {
    removeObject(forKey: key.value)
  }

}

extension UserDefaults {

  //  MARK: - String

  public final subscript(key: Key<String>) -> String? {
    get { return string(forKey: key) }
    set { set(newValue, forKey: key) }
  }

  /// **Mechanica**
  ///
  /// Returns the string associated with the specified key.
  public final func string(forKey key: Key<String>) -> String? {
    return string(forKey: key.value)
  }

  /// **Mechanica**
  ///
  /// Stores a string (or removes the value if nil is passed as the value) for the provided key.
  public final func set(string: String?, forKey key: Key<String>) {
    set(string, forKey: key)
  }

  // MARK: - Object

  public final subscript(key: Key<Any>) -> Any? {
    get { return object(forKey: key) }
    set { set(newValue, forKey: key) }
  }

  /// **Mechanica**
  ///
  /// Returns the object associated with the first occurrence of the specified default.
  public final func object<T>(forKey key: Key<T>) -> T? {
    return object(forKey: key.value) as? T
  }

  /// **Mechanica**
  ///
  /// Sets the value of the specified default key in the standard application domain.
  /// The value parameter can be only property list objects: NSData, NSString, NSNumber, NSDate, NSArray, or NSDictionary. For NSArray and NSDictionary objects, their contents must be property list objects.
  public final func set<T>(object: T?, forKey key: Key<T>) {
    set(object, forKey: key)
  }

  // MARK: - NSNumber

  public final subscript(key: Key<NSNumber>) -> NSNumber? {
    get { return object(forKey: key.value) as? NSNumber }
    set { set(newValue, forKey: key) }
  }

  /// **Mechanica**
  ///
  /// Returns the NSNumber associated with the first occurrence of the specified default.
  public final func number(forKey key: Key<NSNumber>) -> NSNumber? {
    return object(forKey: key.value) as? NSNumber
  }

  /// **Mechanica**
  ///
  /// Sets the value of the specified default key in the standard application domain.
  public final func set(number: NSNumber?, forKey key: Key<NSNumber>) {
    set(number, forKey: key)
  }

  // MARK: - Array

  public final subscript(key: Key<[Any]>) -> [Any]? {
    get { return array(forKey: key) }
    set { set(newValue, forKey: key) }
  }

  /// **Mechanica**
  ///
  /// Returns the array associated with the specified key.
  public final func array<T>(forKey key: Key<[T]>) -> [T]? {
    return array(forKey: key.value) as? [T]
  }

  /// **Mechanica**
  ///
  /// Sets the value of the specified default key in the standard application domain.
  public final func set<T>(array: [T]?, forKey key: Key<[T]>) {
    set(array, forKey: key)
  }

  // MARK: - Dictionary

  public final subscript(key: Key<[String: Any]>) -> [String: Any]? {
    get { return dictionary(forKey: key.value) }
    set { set(newValue, forKey: key) }
  }

  /// **Mechanica**
  ///
  /// Returns the dictionary object associated with the specified key.
  public final func dictionary<K: Hashable, V: Any>(forKey key: Key<[K:V]>) -> [K: V]? {
    return dictionary(forKey: key.value) as? [K: V]
  }

  /// **Mechanica**
  ///
  /// Sets the value of the specified default key in the standard application domain.
  public final func set<K: Hashable, V: Any>(dictionary: [K: V]? , forKey key: Key<[K: V]>) {
    set(dictionary, forKey: key)
  }


  // MARK: - Date

  public final subscript(key: Key<Date>) -> Date? {
    get { return object(forKey: key.value) as? Date }
    set { set(newValue, forKey: key) }
  }

  public final func date(forKey key: Key<Date>) -> Date? {
    return object(forKey: key.value) as? Date
  }

  /// **Mechanica**
  ///
  /// Sets the value of the specified default key in the standard application domain.
  public final func set(date: Date?, forKey key: Key< Date>) {
    set(date, forKey: key)
  }

  // MARK: - Data

  public final subscript(key: Key<Data>) -> Data? {
    get { return data(forKey: key.value) }
    set { set(newValue, forKey: key) }
  }

  /// **Mechanica**
  ///
  /// Returns the data object associated with the specified key.
  public final func data(forKey key: Key<Data>) -> Data? {
    return data(forKey: key.value)
  }

  /// **Mechanica**
  ///
  /// Sets the data value of the specified default key in the standard application domain.
  public final func set(data:  Data? , forKey key: Key< Data>) {
    set(data, forKey: key)
  }


  // MARK: - Int

  public final subscript(key: Key<Int>) -> Int {
    get { return integer(forKey: key.value) }
    set { set(newValue, forKey: key) }
  }

  /// **Mechanica**
  ///
  /// Returns the integer value associated with the specified key. If no Integer is associated with the key, returns 0.
  public final func integer(forKey key: Key<Int>) -> Int {
    return integer(forKey: key.value)
  }

  /// **Mechanica**
  ///
  /// Sets the value of the specified default key in the standard application domain.
  public final func set(integer: Int?, forKey key: Key<Int>) {
    set(integer, forKey: key)
  }


  // MARK: - Double

  public final subscript(key: Key<Double>) -> Double? {
    get { return double(forKey: key.value) }
    set { set(newValue, forKey: key) }
  }

  /// **Mechanica**
  ///
  /// Returns the double value associated with the specified key. If no Double is associated with the key, returns 0.
  public final func double(forKey key: Key<Double>) -> Double? {
    return double(forKey: key.value)
  }

  /// **Mechanica**
  ///
  /// Sets the value of the specified default key in the standard application domain.
  public final func set(double: Double?, forKey key: Key<Double>) {
    set(double, forKey: key)
  }

  // MARK: - Float

  public final subscript(key: Key<Float>) -> Float {
    get { return float(forKey: key.value) }
    set { set(newValue, forKey: key) }
  }

  /// **Mechanica**
  ///
  /// Returns the floating-point value associated with the specified key. If no Float is associated with the key, returns 0.
  public final func float(forKey key: Key<Float>) -> Float {
    return float(forKey: key.value)
  }

  /// **Mechanica**
  ///
  /// Sets the value of the specified default key in the standard application domain.
  public final func set(float: Float?, forKey key: Key<Float>) {
    set(float, forKey: key)
  }

  // MARK: - Bool

  public final subscript(key: Key<Bool>) -> Bool {
    get { return bool(forKey: key.value) }
    set { set(newValue, forKey: key) }
  }

  /// **Mechanica**
  ///
  /// Returns the Boolean value associated with the specified key. If no Boolean is associated with the key, returns false.
  public final func bool(forKey key: Key<Bool>) -> Bool {
    return bool(forKey: key.value)
  }

  /// **Mechanica**
  ///
  /// Sets the value of the specified default key in the standard application domain.
  public final func set(int: Bool?, forKey key: Key<Bool>) {
    set(int, forKey: key)
  }


  // MARK: - URL

  public final subscript(key: Key<URL>) -> URL? {
    get { return url(forKey: key.value) }
    set { set(newValue, forKey: key) }
  }

  /// **Mechanica**
  ///
  /// Returns the URL instance associated with the specified key.
  public final func url(forKey key: Key<URL>) -> URL? {
    return url(forKey: key.value)
  }

  /// **Mechanica**
  ///
  /// Sets the value of the specified default key in the standard application domain.
  public final func set(url: URL?, forKey key: Key<URL>) {
    set(url, forKey: key)
  }


}



// Use <T: Any> and <T: _ObjectiveCBridgeable> to suppress compiler warnings about NSArray not being convertible to [T]
// Any is for NSData and NSDate, _ObjectiveCBridgeable is for value types bridge-able to Foundation types (String, Int, ...)

extension UserDefaults {

  // MARK: - NSArray

  public final func array<T: _ObjectiveCBridgeable>(forKey key: Key<[T]>) -> [T] {
    return array(forKey: key.value) as NSArray? as? [T] ?? []
  }

  public final func array<T: _ObjectiveCBridgeable>(forKey key: Key<[T]?>) -> [T]? {
    return array(forKey: key.value) as NSArray? as? [T]
  }

  public final func array<T: Any>(forKey key: Key<[T]>) -> [T] {
    return array(forKey: key.value) as NSArray? as? [T] ?? []
  }

  public final func array<T: Any>(forKey key: Key<[T]?>) -> [T]? {
    return array(forKey: key.value) as NSArray? as? [T]
  }

}

//extension UserDefaults {
//
//  public final subscript(key: Key<[String]?>) -> [String]? {
//    get { return array(forKey: key) }
//    set { set(newValue, forKey: key) }
//  }
//
//  public final subscript(key: Key<[String]>) -> [String] {
//    get { return array(forKey: key) }
//    set { set(newValue, forKey: key) }
//  }
//
//  public final subscript(key: Key<[Int]?>) -> [Int]? {
//    get { return array(forKey: key) }
//    set { set(newValue, forKey: key) }
//  }
//
//  public final subscript(key: Key<[Int]>) -> [Int] {
//    get { return array(forKey: key) }
//    set { set(newValue, forKey: key) }
//  }
//
//  public final subscript(key: Key<[Double]?>) -> [Double]? {
//    get { return array(forKey: key) }
//    set { set(newValue, forKey: key) }
//  }
//
//  public final subscript(key: Key<[Double]>) -> [Double] {
//    get { return array(forKey: key) }
//    set { set(newValue, forKey: key) }
//  }
//
//  public final subscript(key: Key<[Bool]?>) -> [Bool]? {
//    get { return array(forKey: key) }
//    set { set(newValue, forKey: key) }
//  }
//
//  public final subscript(key: Key<[Bool]>) -> [Bool] {
//    get { return array(forKey: key) }
//    set { set(newValue, forKey: key) }
//  }
//
//  public final subscript(key: Key<[Data]?>) -> [Data]? {
//    get { return array(forKey: key) }
//    set { set(newValue, forKey: key) }
//  }
//
//  public final subscript(key: Key<[Data]>) -> [Data] {
//    get { return array(forKey: key) }
//    set { set(newValue, forKey: key) }
//  }
//
//  public final subscript(key: Key<[Date]?>) -> [Date]? {
//    get { return array(forKey: key) }
//    set { set(newValue, forKey: key) }
//  }
//
//  public final subscript(key: Key<[Date]>) -> [Date] {
//    get { return array(forKey: key) }
//    set { set(newValue, forKey: key) }
//  }
//
//}

// MARK: - Archiving custom types

// MARK: RawRepresentable

extension UserDefaults {

  // TODO: we need to be sure that T.RawValue is compatible
  public final func archive<T: RawRepresentable>(_ key: Key<T>, _ value: T) {
    set(value.rawValue, forKey: key)
  }

  public final func archive<T: RawRepresentable>(_ key: Key<T?>, _ value: T?) {
    if let value = value {
      set(value.rawValue, forKey: key)
    } else {
      removeObject(forKey: key)
    }
  }

  public final func unarchive<T: RawRepresentable>(_ key: Key<T?>) -> T? {
    return object(forKey: key.value).flatMap { T(rawValue: $0 as! T.RawValue) }
  }

  public final func unarchive<T: RawRepresentable>(_ key: Key<T>) -> T? {
    return object(forKey: key.value).flatMap { T(rawValue: $0 as! T.RawValue) }
  }
}

// MARK: NSCoding

extension UserDefaults {

  public final func archive<T: NSCoding>(_ key: Key<T>, _ value: T) {
    set(NSKeyedArchiver.archivedData(withRootObject: value), forKey: key)
  }

  public final func archive<T: NSCoding>(_ key: Key<T?>, _ value: T?) {
    if let value = value {
      set(NSKeyedArchiver.archivedData(withRootObject: value), forKey: key)
    } else {
      removeObject(forKey: key)
    }
  }

  public final func unarchive<T: NSCoding>(_ key: Key<T>) -> T? {
    return data(forKey: key.value).flatMap { NSKeyedUnarchiver.unarchiveObject(with: $0) } as? T
  }
  
  public final func unarchive<T: NSCoding>(_ key: Key<T?>) -> T? {
    return data(forKey: key.value).flatMap { NSKeyedUnarchiver.unarchiveObject(with: $0) } as? T
  }
  
}



