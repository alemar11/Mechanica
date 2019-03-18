//
// Mechanica
//
// Copyright © 2016-2019 Tinrobots.
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

// MARK: - Subscripts

extension Collection {

  /// **Mechanica**
  ///
  /// Returns the element at the specified index or nil if not exists.
  ///
  /// Example:
  ///
  ///     let array = [1, 2, 3]
  ///     array[100] -> crash
  ///     array[safe: 100] -> nil
  ///
  /// - Parameter index: the index of the desired element.
  public subscript(safe index: Index) -> Element? {
    guard index >= startIndex && index < endIndex else { return nil }

    return self[index]
  }

}

// MARK: - Methods

extension Collection {

  /// **Mechanica**
  ///
  /// - Parameter index: the index of the desired element.
  /// - Returns: The element at a given index or nil if not exists.
  ///
  /// Example:
  ///
  ///     let array = [1, 2, 3]
  ///     array[100] -> crash
  ///     array.at(100) -> nil
  ///
  public func at(_ index: Index) -> Element? {
    return self[safe: index]
  }

}

// MARK: - Equatable

extension Collection where Element: Equatable {

  /// **Mechanica**
  ///
  /// Returns all the indices of a specified item.
  ///
  /// Example:
  ///
  ///      [1, 2, 1, 2, 3, 4, 5, 1].indices(of: 1) -> [0, 2, 7])
  ///
  /// - Parameter item: item to verify.
  /// - Returns: all the indices of the given item.
  public func indices(of item: Element) -> [Index] {
    var indices = [Index]()
    var index = startIndex

    while index < endIndex {
      if self[index] == item {
        indices.append(index)
      }
      formIndex(after: &index)
    }

    return indices
  }

}

extension Collection where SubSequence == Self {

  /// **Mechanica**
  ///
  /// Scans `self` exactly for a given count of elements, removing all the scanned elements from `self`.
  ///
  /// Example:
  ///
  ///      var phrase = "tin robots"[...]
  ///      phrase.scan(count: 4) -> "tin "
  ///      phrase -> robots
  ///
  ///
  /// - Parameter count: The number of elements to be scanned.
  /// - Returns: The scanned elements.
  public mutating func scan(count: Int) -> Self? {
    let result = prefix(count)

    guard result.count == count else { return nil }

    removeFirst(count)

    return result
  }

  /// **Mechanica**
  ///
  /// Scans `self` until a given condition is met, removing all the scanned elements from `self` and accumulating them into a given buffer.
  ///
  /// Example:
  ///
  ///      var phrase = "tin robots"[...]
  ///      var buffer = String()
  ///      phrase.scan { $0 == Character("o") }
  ///      phrase -> "obots"
  ///
  /// - Parameter condition: The condition to be met.
  public mutating func scan(upToCondition condition: ((Element) -> Bool)) {
    guard let firstElement = first, !condition(firstElement) else { return }

    removeFirst()

    scan(upToCondition: condition)
  }

  /// **Mechanica**
  ///
  /// Scans `self` until a given condition is met, removing all the scanned elements from `self` and accumulating them into a given buffer.
  ///
  /// Example:
  ///
  ///      var phrase = "tin robots"[...]
  ///      var buffer = String()
  ///      phrase.scan(upToCondition: { $0 == Character("o")}, into: &buffer)
  ///      phrase -> "obots"
  ///      buffer -> "tin r"
  ///
  /// - Parameter condition: The condition to be met.
  /// - Parameter buffer: The buffer where all the scanned elements are accumulated.
  public mutating func scan<C>(upToCondition condition: ((Element) -> Bool), into buffer: inout C) where C: RangeReplaceableCollection, C.Element == Element {
    guard let firstElement = first, !condition(firstElement) else { return }

    let element = removeFirst()
    buffer.append(element)

    scan(upToCondition: condition, into: &buffer)
  }

}

extension Collection where SubSequence == Self, Element: Equatable {

  /// **Mechanica**
  ///
  /// Scans `self` for a specific index, removing all the scanned elements from `self`.
  ///
  /// Example:
  ///
  ///      var phrase = "tin robots"[...]
  ///      phrase.scan(prefix: "tin") -> true
  ///      phrase -> " robots")
  ///
  ///      var phrase2 = "tin robots"[...]
  ///      phrase2.scan(prefix: "in") -> false
  ///      phrase2 -> "tin robots"
  ///
  /// - Parameter prefix: The prefix to be scanned.
  /// - Returns: True is the prefix is met.
  public mutating func scan<C>(prefix: C) -> Bool where C: Collection, C.Element == Element {
    guard starts(with: prefix) else { return false }

    removeFirst(prefix.count)

    return true
  }

  /// **Mechanica**
  ///
  /// Scans `self` until a given collection is encountered, removing all the scanned elements from `self` and accumulating them into a given buffer.
  ///
  /// Example:
  ///
  ///      var phrase = "tin robots"[...]
  ///      var buffer = String()
  ///      phrase.scan(upToCollection: "obot", into: &buffer)
  ///      phrase -> "obots"
  ///      buffer -> "tin r"
  ///
  /// - Parameter collection: The collection to be encountered.
  /// - Parameter buffer: The buffer where all the scanned elements are accumulated.
  public mutating func scan<C>(upToCollection collection: Self, into buffer: inout C) where C: RangeReplaceableCollection, C.Element == Element {
    guard !isEmpty else { return }
    guard !starts(with: collection) else { return }

    let element = removeFirst()
    buffer.append(element)

    scan(upToCollection: collection, into: &buffer)
  }

  /// **Mechanica**
  ///
  /// Scans `self` until a given collection is encountered, removing all the scanned elements from `self`.
  ///
  /// Example:
  ///
  ///      var phrase = "tin robots"[...]
  ///      var buffer = String()
  ///      phrase.scan(upToCollection: "obot")
  ///      phrase -> "obots"
  ///
  /// - Parameter collection: The collection to be encountered.
  public mutating func scan(upToCollection collection: Self) {
    guard !isEmpty else { return }
    guard !starts(with: collection) else { return }

    removeFirst()

    scan(upToCollection: collection)
  }

}
