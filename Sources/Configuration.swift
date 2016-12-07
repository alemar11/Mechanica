//
//  Configuration.swift
//  Mechanica
//
//  Copyright © 2016 Tinrobots.
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
/// Types conforming to `PropertyListConfiguration` can be used to create a Property List configuration element.
public protocol PropertyListConfiguration {
  
  /// **Mechanica**
  ///
  /// Protocol `PropertyListConfiguration`.
  ///
  /// Propery List dictionary.
  var propertyList: NSDictionary { get }
  
}

// MARK: - Configuration

/**
 **Mechanica**
 
 `Configuration` is a Property List reader.
 Extends this struct with `StringKeyCodable`, `BoolKeyCodable`, `URLKeyCodable,`NumberKeyCodable`, `DateKeyCodable`, `DataKeyCodable`, `ArrayKeyCodable`, `DictionaryKeyCodable` to avoid *stringly typed* APIs.
 
 ```
 extension Configuration: StringKeyCodable {
  public enum StringKey: String {
    case value1  = "path.to.value1"
    case value2  = "path.to.value2"
  }
 }
 
 extension Configuration: BoolKeyCodable {
  public enum StringKey: String {
    case value3  = "path.to.value3"
    case value4  = "path.to.value4"
  }
 }
 
 let cfg: Configuration = ...
 
 let stringValue1 = cfg.string(forKey: .value3)
 let boolValue3   = cfg.bool(forKey: .value3)
 ```
*/
public struct Configuration: PropertyListConfiguration {
  
  public let propertyList: NSDictionary
  
  /// **Mechanica**
  ///
  /// Initializes a `new` Configuration using a .plist file found at a given path.
  public init?(plistPath: String) {
    guard let plist = NSDictionary(contentsOfFile: plistPath) else {
      assertionFailure("Could not read plist file or the plist file is an array.")
      return nil
    }
    propertyList = plist
  }
  
  /// **Mechanica**
  ///
  /// Initializes a `new` Configuration using a .plist file found at a given URL.
  public init?(plistURL: URL) {
    guard let plist = NSDictionary(contentsOf: plistURL) else {
      assertionFailure("Could not read plist file or the plist file is an array.")
      return nil
    }
    propertyList = plist
  }
  
}

// MARK: - Bool

/// **Mechanica**
///
/// Types adopting the `BoolKeyCodable` protocol can be used to construct key path to `Bool` values avoiding *stringly typed* APIs.
public protocol BoolKeyCodable {
  associatedtype BoolKey : RawRepresentable
}

extension BoolKeyCodable where BoolKey.RawValue == String, Self: PropertyListConfiguration {
  
  /// **Mechanica**
  ///
  /// Returns a `Bool` value for a `BoolKey`.
  public func bool(forKey key: BoolKey) -> Bool {
    let value = propertyList.value(forKeyPath: key.rawValue) as? Bool
    assert(value.hasValue, "No Bool value found for key path: \(key.rawValue)")
    return value!
  }
  
}

// MARK: - String

/// **Mechanica**
///
/// Types adopting the `StringKeyCodable` protocol can be used to construct key path to `String` values avoiding *stringly typed* APIs.
public protocol StringKeyCodable {
  associatedtype StringKey : RawRepresentable
}

extension StringKeyCodable where StringKey.RawValue == String, Self: PropertyListConfiguration {
  
  /// **Mechanica**
  ///
  /// Returns a `String` value for a `StringKey`.
  public func string(forKey key: StringKey) -> String {
    let value = propertyList.value(forKeyPath: key.rawValue) as? String
    assert(value.hasValue, "No String value found for key path: \(key.rawValue)")
    return value!
  }
  
}

// MARK: - URL

/// **Mechanica**
///
/// Types adopting the `URLKeyCodable` protocol can be used to construct key path to `URL` values avoiding *stringly typed* APIs.
public protocol URLKeyCodable {
  associatedtype URLKey : RawRepresentable
}

extension URLKeyCodable where URLKey.RawValue == String, Self: PropertyListConfiguration {
  
  /// **Mechanica**
  ///
  /// Returns an `URL` value (if any) for an `URLKey`.
  public func url(forKey key: URLKey) -> URL? {
    guard let url = propertyList.value(forKeyPath: key.rawValue) as? String else { return nil }
    return URL(string: url)
  }
  
}

// MARK: - NSNumber

/// **Mechanica**
///
/// Types adopting the `NumberKeyCodable` protocol can be used to construct key path to `NSNumber` objects avoiding *stringly typed* APIs.
public protocol NumberKeyCodable {
  associatedtype NumberKey : RawRepresentable
}

extension NumberKeyCodable where NumberKey.RawValue == String, Self: PropertyListConfiguration {
  
  /// **Mechanica**
  ///
  /// Returns a `NSNumber` object for a `NumberKey`.
  public func number(forKey key: NumberKey) -> NSNumber {
    let value = propertyList.value(forKeyPath: key.rawValue) as? NSNumber
    assert(value.hasValue, "No NSNumber value found for key path: \(key.rawValue)")
    return value!
  }
  
}

// MARK: - Date

/// **Mechanica**
///
/// Types adopting the `Date` protocol can be used to construct key path to `Date` values avoiding *stringly typed* APIs.
public protocol DateKeyCodable {
  associatedtype DateKey : RawRepresentable
}

extension DateKeyCodable where DateKey.RawValue == String, Self: PropertyListConfiguration {
  
  /// **Mechanica**
  ///
  /// Returns a `Date` value for a `DateKey`.
  public func date(forKey key: DateKey) -> Date {
    let value = propertyList.value(forKeyPath: key.rawValue) as? Date
    assert(value.hasValue, "No Date value found for key path: \(key.rawValue)")
    return value!
  }
  
}

// MARK: - Data

/// **Mechanica**
///
/// Types adopting the `DataKeyCodable` protocol can be used to construct key path to `Data` values avoiding *stringly typed* APIs.
public protocol DataKeyCodable {
  associatedtype DataKey : RawRepresentable
}

extension DataKeyCodable where DataKey.RawValue == String, Self: PropertyListConfiguration {
  
  /// **Mechanica**
  ///
  /// Returns a `Data` value for a `DataKey`.
  public func data(forKey key: DataKey) -> Data {
    let value = propertyList.value(forKeyPath: key.rawValue) as? Data
    assert(value.hasValue, "No Bool value found for key path: \(key.rawValue)")
    return value!
  }
  
}

// MARK: - Array

/// **Mechanica**
///
/// Types adopting the `ArrayKeyCodable` protocol can be used to construct key path to `Array` values avoiding *stringly typed* APIs.
public protocol ArrayKeyCodable {
  associatedtype ArrayKey : RawRepresentable
}

extension ArrayKeyCodable where ArrayKey.RawValue == String, Self: PropertyListConfiguration {
  
  /// **Mechanica**
  ///
  /// Returns an `Array` value for an `ArrayKey`.
  public func array(forKey key: ArrayKey) -> Array<Any> {
    let value = propertyList.value(forKeyPath: key.rawValue) as? Array<Any>
    assert(value.hasValue, "No Array found for key path: \(key.rawValue)")
    return value!
  }
  
}

// MARK: - Dictionary

/// **Mechanica**
///
/// Types adopting the `DictionaryKeyCodable` protocol can be used to construct key path to `Dictionary` values avoiding *stringly typed* APIs.
public protocol DictionaryKeyCodable {
  associatedtype DictionaryKey : RawRepresentable
}

extension DictionaryKeyCodable where DictionaryKey.RawValue == String, Self: PropertyListConfiguration {
  
  /// **Mechanica**
  ///
  /// Returns a `Dictionary` value for a `DictionaryKey`.
  public func dictionary(forKey key: DictionaryKey) -> Dictionary<String, Any> {
    let value = propertyList.value(forKeyPath: key.rawValue) as? Dictionary<String, Any>
    assert(value.hasValue, "No Array found for key path: \(key.rawValue)")
    return value!
  }
  
}

