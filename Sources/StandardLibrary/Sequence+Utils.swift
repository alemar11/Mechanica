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

/// A Sequence can be either finite or infinite.

extension Sequence {

  /// **Mechanica**
  ///
  /// Checks if all the elements in collection satisfiy the given predicate.
  ///
  /// Example:
  ///
  ///     [2, 2, 4, 4].all(matching: {$0 % 2 == 0}) -> true
  ///     [1, 2, 2, 4].all(matching: {$0 % 2 == 0}) -> false
  ///
  /// - Parameter predicate: condition to evaluate each element against.
  /// - Returns: true when all elements in the array match the specified condition.
  /// - Attention: the sequence must be finite.
  public func all(matching predicate: (Element) throws -> Bool) rethrows -> Bool {
    return try !contains { try !predicate($0) }
  }

  /// **Mechanica**
  ///
  /// Checks if no elements in collection satisfiy the given predicate.
  ///
  /// Example:
  ///
  ///     [2, 2, 4].none(matching: {$0 % 2 == 0}) -> false
  ///     [1, 3, 5].none(matching: {$0 % 2 == 0}) -> true
  ///
  /// - Parameter predicate: condition to evaluate each element against.
  /// - Returns: true when no elements satisfy the specified condition.
  /// - Attention: the sequence must be finite.
  public func none(matching predicate: (Element) throws -> Bool) rethrows -> Bool {
    return try !contains { try predicate($0) }
  }

  /// **Mechanica**
  ///
  /// Checks if any elements in collection satisfiy the given predicate.
  ///
  /// Example:
  ///
  ///     [2, 2, 4].any(matching: {$0 % 2 == 0}) -> false
  ///     [1, 3, 5, 7].any(matching: {$0 % 2 == 0}) -> true
  ///
  /// - Parameter predicate: condition to evaluate each element against.
  /// - Returns: true when no elements satisfy the specified condition.
  /// - Attention: the sequence must be finite.
  public func any(matching predicate: (Element) throws -> Bool) rethrows -> Bool {
    return try contains { try predicate($0) }
  }

  /// **Mechanica**
  ///
  /// Returns the last element that satisfies the given predicate, or `nil` if no element does.
  ///
  /// Example:
  ///
  ///     [2, 2, 4, 7].last(where: {$0 % 2 == 0}) -> 4
  ///
  /// - Parameter predicate: condition to evaluate each element against.
  /// - Returns: the last element satisfying the given predicate. (optional)
  /// - Attention: the sequence must be finite.
  func last(where predicate: (Element) throws -> Bool) rethrows -> Element? {
    var result: Element?
    for element in self {
      if try predicate(element) {
        result = element
      }
    }
    return result
  }

  /// **Mechanica**
  ///
  /// Returns true if there is at least one element satisfying the given predicate.
  /// - Parameters:
  ///   - predicate: A closure that takes an element of the sequence as its argument and returns a Boolean value indicating whether the element is a match.
  /// - Attention: the sequence must be finite.
  public func hasAny(where predicate: (Element) -> Bool) -> Bool {
    return first { predicate($0) } != nil
  }

  /// **Mechanica**
  ///
  /// Returns true if all the elements satisfy the predicate.
  /// - Parameter predicate: A closure that takes an element of the sequence as its argument and returns a Boolean value indicating whether the element is a match.
  /// - Attention: the sequence must be finite.
  public func hasAll(where predicate: (Element) -> Bool) -> Bool {
    return first { !predicate($0) } == nil
  }

  /// **Mechanica**
  ///
  /// - Parameter criteria: The criteria closure takes an `Element` and returns its classification.
  /// - Returns: A grouped dictionary with the keys that the criteria function returns.
  /// - Attention: the sequence must be finite.
  public func grouped<Key>(by criteria: (Element) -> (Key)) -> [Key: [Element]] {
    return Dictionary(grouping: self, by: { return criteria($0) })
  }

  /// **Mechanica**
  ///
  /// Returns the count of the elements satisfying the given predicate.
  ///
  ///     [2, 2, 4, 7].count(where: {$0 % 2 == 0}) -> 3
  ///
  /// - Parameter predicate: predicate to evaluate each element against.
  /// - Returns: number of times the condition evaluated to true.
  /// - Attention: the sequence must be finite.
  public func count(where predicate: (Element) throws -> Bool) rethrows -> Int {
    // TODO: Swift 5 - https://github.com/apple/swift-evolution/blob/master/proposals/0220-count-where.md
    var count = 0
    for element in self where try predicate(element) {
      count += 1
    }
    return count
  }

  /// **Mechanica**
  ///
  /// Splits `self` into partitions of a given `length`.
  ///
  /// Example:
  ///
  ///     let string = "Hello"
  ///     string.split(by: 2) -> ["He", "ll", "o"]
  ///
  /// - Attention: the sequence must be finite.
  public func split(by length: Int) -> [[Element]] {
    guard length != 0 else { return [] }

    var result: [[Element]] = []
    var batch: [Element] = []

    for element in self {
      batch.append(element)

      if batch.count == length {
        result.append(batch)
        batch = []
      }
    }

    if !batch.isEmpty {
      result.append(batch)
    }

    return result
  }

  /// **Mechanica**
  ///
  /// Returns a sequence that contains no duplicates according to the generic hash and equality comparisons on the keys reuteruned by the given key generating block.
  /// If an element occurs multiple times, the later occurrences are discarded
  ///
  /// - Parameter keyGenerator: The key generating block.
  public func distinct<Key: Hashable>(by keyGenerator: (Element) -> Key) -> [Element] {
    var seen =  [Key: Bool]()
    return filter { seen.updateValue(true, forKey: keyGenerator($0)) == nil }
  }

}

// MARK: - Equatable

extension Sequence where Element: Equatable {

  /// **Mechanica**
  ///
  /// Returns a collection of unique elements preserving their original order.
  /// - Attention: the sequence must be finite.
  func uniqueOrderedElements() -> [Element] {
    var result: [Element] = []

    for element in self {
      if !result.contains(where: { $0 == element }) { result.append(element) }
    }

    return result
  }

}

// MARK: - Hashable

extension Sequence where Element: Hashable {

  /// **Mechanica**
  ///
  /// Returns true if the `Sequence` contains all the given elements.
  ///
  /// Example:
  ///
  ///     [1, 2, 3, 4, 5].contains([1, 2]) -> true
  ///     ["h", "e", "l", "l", "o"].contains(["l", "o"]) -> true
  ///
  /// - Attention: the sequence must be finite.
  public func contains(_ elements: [Element]) -> Bool {
    // return Set(elements).isSubset(of: Set(self))
    guard !elements.isEmpty else {
      return true
    }
    for element in elements {
      if !contains(element) {
        return false
      }
    }
    return true
  }

  /// **Mechanica**
  ///
  /// Returns a collection of tuples where it's indicated the frequencies of the elements in the sequence.
  /// - Attention: the sequence must be finite.
  public var frequencies: [(Element, Int)] {
    var result = [Element: Int]()

    for element in self {
      result[element] = (result[element] ?? 0) + 1
    }

    return result.sorted { $0.1 > $1.1 }
  }

  /// **Mechanica**
  ///
  /// - Returns: Returns true if the `Sequence` contains duplicates
  /// - Attention: the sequence must be finite.
  public func hasDuplicates() -> Bool {
    var set = Set<Element>()
    for element in self {
      if !set.insert(element).inserted {
        return true
      }
    }
    return false
  }

}

// MARK: - AnyObject

extension Sequence where Element: AnyObject {

  /// **Mechanica**
  ///
  /// Returns true if the `Sequence` contains an element identical (referential equality) to an `object`.
  /// - Attention: the sequence must be finite.
  public func containsObjectIdentical(to object: AnyObject) -> Bool {
    return contains { $0 === object }
  }

}

// MARK: - Numeric

public extension Sequence where Element: Numeric {

  /// **Mechanica**
  ///
  /// Sums of all elements in array.
  ///
  /// Example:
  ///
  ///     [1, 2, 3, 4].sum() -> 10
  ///
  /// - Attention: the sequence must be finite.
  public func sum() -> Element {
    return reduce(0, { $0 + $1 })
  }

}
