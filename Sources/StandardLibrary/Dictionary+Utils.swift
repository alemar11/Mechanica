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

public extension Dictionary {

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

public extension Dictionary where Key: ExpressibleByStringLiteral {

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
