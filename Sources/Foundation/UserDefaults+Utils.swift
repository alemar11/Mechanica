//
// Mechanica
//
// Copyright © 2016-2018 Tinrobots.
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

public extension UserDefaults {

  /// **Mechanica**
  ///
  /// Returns `true` if `key` exists.
  public final func hasKey(_ key: String) -> Bool {
    #if os(Linux)
      return object(forKey: key) != nil
    #else
      return dictionaryRepresentation().hasKey(key) //not implemented on Linux (Swift 4.0.2)
    #endif
  }

  /// **Mechanica**
  ///
  /// - Parameter defaultName: A key in the current user's defaults database.
  /// - Returns: The bool value associated with the specified key. If the specified key does not exist, this method returns nil.
  public final func optionalBool(forKey defaultName: String) -> Bool? {
    return (object(forKey: defaultName) as? NSNumber)?.boolValue
  }

  /// **Mechanica**
  ///
  /// - Parameter defaultName: A key in the current user's defaults database.
  /// - Returns: The double value associated with the specified key. If the specified key does not exist, this method returns nil.
  public final func optionalDouble(forKey defaultName: String) -> Double? {
    return (object(forKey: defaultName) as? NSNumber)?.doubleValue
  }

  /// **Mechanica**
  ///
  /// - Parameter defaultName: A key in the current user's defaults database.
  /// - Returns: The floating-point value associated with the specified key. If the key does not exist, this method returns nil.
  public final func optionalFloat(forKey defaultName: String) -> Float? {
    return (object(forKey: defaultName) as? NSNumber)?.floatValue
  }

  /// **Mechanica**
  ///
  /// - Parameter defaultName: A key in the current user's defaults database.
  /// - Returns: The integer value associated with the specified key. If the specified key does not exist, this method returns nil.
  public final func optionalInteger(forKey defaultName: String) -> Int? {
    return (object(forKey: defaultName) as? NSNumber)?.intValue
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

}

extension UserDefaults {

  // MARK: Codable

  /// **Mechanica**
  ///
  /// Returns the object conformig to `Codable` associated with the specified key, or nil if the key was not found.
  ///
  /// - Parameter defaultName: A key in the current user's defaults database.
  public final func codableValue<T: Codable>(forKey defaultName: String) -> T? {
    guard let encodedData = data(forKey: defaultName) else { return nil }
    return try? JSONDecoder().decode(T.self, from: encodedData)
  }

  /// **Mechanica**
  ///
  /// Stores an object conformig to `Codable` (or removes the value if nil is passed as the value) for the provided key.
  ///
  /// - Parameters:
  ///   - value: The object to store in the defaults database.
  ///   - defaultName: The key with which to associate with the value.
  /// - Throws: An error if any value throws an error during encoding.
  public final func set<T: Codable>(codableValue value: T?, forKey defaultName: String) throws {
    if let value = value {
      do {
        let encodedData = try JSONEncoder().encode(value)
        set(encodedData, forKey: defaultName)
      } catch {
        throw error
      }

    } else {
      removeObject(forKey: defaultName)
    }
  }

}
