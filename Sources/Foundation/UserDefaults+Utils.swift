#if canImport(Foundation)

import Foundation

extension UserDefaults {
  /// **Mechanica**
  ///
  /// Returns `true` if `key` exists.
  public final func hasKey(_ key: String) -> Bool {
    return dictionaryRepresentation().hasKey(key)
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

  //#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
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
  //#endif
}

#endif
