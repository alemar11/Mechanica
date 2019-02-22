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
  /// ||TODO
  ///
  /// - Parameter condition: <#condition description#>
  /// - Returns: <#return value description#>
  public mutating func scan(_ condition: (Element) -> Bool) -> Element? {
    guard let firstElement = first, condition(firstElement) else {
      return nil
    }

    return removeFirst()
  }

  /// **Mechanica**
  ///
  /// ||TODO
  ///
  /// Example:
  ///
  ///      ||TODO
  ///
  ///
  /// - Parameter count: <#count description#>
  /// - Returns: <#return value description#>
  public mutating func scan(count: Int) -> Self? {
    let result = prefix(count)

    guard result.count == count else {
      return nil
    }

    removeFirst(count)

    return result
  }

  public mutating func scan(upTo condition: ((Element) -> Bool), into: inout [Element]) {
    guard
      let firstElement = first,
      !condition(firstElement) else {
      return
    }

    let element = removeFirst()
    into.append(element)

    scan(upTo: condition, into: &into)
  }

}

extension Collection where SubSequence == Self, Element: Equatable {

  /// **Mechanica**
  ///
  ///
  /// Example:
  ///
  ///      ||TODO
  ///
  ///
  /// - Parameter prefix: <#prefix description#>
  /// - Returns: <#return value description#>
  public mutating func scan<C>(prefix: C) -> Bool where C: Collection, C.Element == Element {
    guard starts(with: prefix) else { return false }

    removeFirst(prefix.count)

    return true
  }

  public mutating func scan<C>(upTo condition: ((Element) -> Bool), into: inout C) where C: RangeReplaceableCollection, C.Element == Element {
    guard let firstElement = first, !condition(firstElement) else { return }

    let element = removeFirst()
    into.append(element)

    scan(upTo: condition, into: &into)
  }

  /// Scans `self` until a given collection is encountered, removing all the scanned elements from `self` and accumulating them into a given buffer.
  public mutating func scan2<C>(upTo collection: Self, into buffer: inout C?) where C: RangeReplaceableCollection, C.Element == Element {
    guard !isEmpty else { return }

    guard !starts(with: collection) else { return }

    let element = removeFirst()

    if buffer == nil {
      buffer = C()
    }

    buffer?.append(element)

    scan2(upTo: collection, into: &buffer)
  }

}
