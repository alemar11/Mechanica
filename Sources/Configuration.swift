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

//MARK: - -Configuration

/// **Mechanica**
///
/// `Configuration` is a Property List reader.
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

//MARK: - Bool

/// **Mechanica**
///
/// Types adopting the `BoolMappable` protocol can be used to construct key path to `Bool` values avoiding stringly typed API.
public protocol BoolMappable {
  associatedtype BoolKey : RawRepresentable
}

extension BoolMappable where BoolKey.RawValue == String, Self: PropertyListConfiguration {
  
  /// **Mechanica**
  ///
  /// Returns a `Bool` value for a `BoolKey`.
  public func bool(forKey key: BoolKey) -> Bool {
    let value = propertyList.value(forKeyPath: key.rawValue) as? Bool
    assert(value.hasValue, "No Bool value found for key path: \(key.rawValue)")
    return value!
  }
  
}

//MARK: - String

/// **Mechanica**
///
/// Types adopting the `StringMappable` protocol can be used to construct key path to `String` values avoiding stringly typed API.
public protocol StringMappable {
  associatedtype StringKey : RawRepresentable
}

extension StringMappable where StringKey.RawValue == String, Self: PropertyListConfiguration {
  
  /// **Mechanica**
  ///
  /// Returns a `String` value for a `StringKey`.
  public func string(forKey key: StringKey) -> String {
    let value = propertyList.value(forKeyPath: key.rawValue) as? String
    assert(value.hasValue, "No String value found for key path: \(key.rawValue)")
    return value!
  }
  
}

//MARK: - URL

/// **Mechanica**
///
/// Types adopting the `URLMappable` protocol can be used to construct key path to `URL` values avoiding stringly typed API.
public protocol URLMappable {
  associatedtype URLKey : RawRepresentable
}

extension URLMappable where URLKey.RawValue == String, Self: PropertyListConfiguration {
  
  /// **Mechanica**
  ///
  /// Returns an `URL` value (if any) for an `URLKey`.
  public func url(forKey key: URLKey) -> URL? {
    guard let url = propertyList.value(forKeyPath: key.rawValue) as? String else { return nil }
    return URL(string: url)
  }
  
}

//MARK: - NSNumber

/// **Mechanica**
///
/// Types adopting the `NumberMappable` protocol can be used to construct key path to `NSNumber` objects avoiding stringly typed API.
public protocol NumberMappable {
  associatedtype NumberKey : RawRepresentable
}

extension NumberMappable where NumberKey.RawValue == String, Self: PropertyListConfiguration {
  
  /// **Mechanica**
  ///
  /// Returns a `NSNumber` object for a `NumberKey`.
  public func number(forKey key: NumberKey) -> NSNumber {
    let value = propertyList.value(forKeyPath: key.rawValue) as? NSNumber
    assert(value.hasValue, "No NSNumber value found for key path: \(key.rawValue)")
    return value!
  }
  
}

//MARK: - Date

/// **Mechanica**
///
/// Types adopting the `Date` protocol can be used to construct key path to `Date` values avoiding stringly typed API.
public protocol DateMappable {
  associatedtype DateKey : RawRepresentable
}

extension DateMappable where DateKey.RawValue == String, Self: PropertyListConfiguration {
  
  /// **Mechanica**
  ///
  /// Returns a `Date` value for a `DateKey`.
  public func date(forKey key: DateKey) -> Date {
    let value = propertyList.value(forKeyPath: key.rawValue) as? Date
    assert(value.hasValue, "No Date value found for key path: \(key.rawValue)")
    return value!
  }
  
}

//MARK: - Data

/// **Mechanica**
///
/// Types adopting the `DataMappable` protocol can be used to construct key path to `Data` values avoiding stringly typed API.
public protocol DataMappable {
  associatedtype DataKey : RawRepresentable
}

extension DataMappable where DataKey.RawValue == String, Self: PropertyListConfiguration {
  
  /// **Mechanica**
  ///
  /// Returns a `Data` value for a `DataKey`.
  public func data(forKey key: DataKey) -> Data {
    let value = propertyList.value(forKeyPath: key.rawValue) as? Data
    assert(value.hasValue, "No Bool value found for key path: \(key.rawValue)")
    return value!
  }
  
}

//MARK: - Array

/// **Mechanica**
///
/// Types adopting the `ArrayMappable` protocol can be used to construct key path to `Array` values avoiding stringly typed API.
public protocol ArrayMappable {
  associatedtype ArrayKey : RawRepresentable
}

extension ArrayMappable where ArrayKey.RawValue == String, Self: PropertyListConfiguration {
  
  /// **Mechanica**
  ///
  /// Returns an `Array` value for an `ArrayKey`.
  public func array(forKey key: ArrayKey) -> Array<Any> {
    let value = propertyList.value(forKeyPath: key.rawValue) as? Array<Any>
    assert(value.hasValue, "No Array found for key path: \(key.rawValue)")
    return value!
  }
  
}

//MARK: - Dictionary

/// **Mechanica**
///
/// Types adopting the `DictionaryMappable` protocol can be used to construct key path to `Dictionary` values avoiding stringly typed API.
public protocol DictionaryMappable {
  associatedtype DictionaryKey : RawRepresentable
}

extension DictionaryMappable where DictionaryKey.RawValue == String, Self: PropertyListConfiguration {
  
  /// **Mechanica**
  ///
  /// Returns a `Dictionary` value for a `DictionaryKey`.
  public func dictionary(forKey key: DictionaryKey) -> Dictionary<String, Any> {
    let value = propertyList.value(forKeyPath: key.rawValue) as? Dictionary<String, Any>
    assert(value.hasValue, "No Array found for key path: \(key.rawValue)")
    return value!
  }
  
}

