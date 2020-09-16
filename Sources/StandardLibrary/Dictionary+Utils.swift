extension Dictionary {
  /// **Mechanica**
  ///
  /// Returns true if the `key` exists in the dictionary.
  public func hasKey(_ key: Key) -> Bool {
    return index(forKey: key) != nil
  }

  /// **Mechanica**
  ///
  /// Removes the given kesy and theris associated values from the dictionary.
  ///
  /// - Parameter keys: The keys to remove along with theirs associated values.
  /// - Returns: The key’s associated values (if any).
  public mutating func removeAll(forKeys keys: [Key]) -> [Key: Value]? {
    var removedElements: [Key: Value]?
    keys.forEach {
      if let removed = removeValue(forKey: $0) {
        removedElements = removedElements == nil ? [Key: Value]() : removedElements
        removedElements?[$0] = removed
      }
    }
    return removedElements
  }
}

extension Dictionary where Key: ExpressibleByStringLiteral {
  // MARK: - ExpressibleByStringLiteral

  /// **Mechanica**
  ///
  /// Lowercase all keys in dictionary.
  public mutating func lowercaseAllKeys() {
    for key in keys {
      if let lowercaseKey = String(describing: key).lowercased() as? Key {
        self[lowercaseKey] = removeValue(forKey: key)
      }
    }
  }
}
