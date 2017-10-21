//
// Mechanica
//
// Copyright © 2016-2017 Tinrobots.
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

extension Sequence {

  /// **Mechanica**
  ///
  /// Returns true if there is at least one element `matching` the predicate.
  /// - Parameters:
  ///   - predicate: A closure that takes an element of the sequence as its argument and returns a Boolean value indicating whether the element is a match.
  public func hasSomeElements(where predicate: (Element) -> Bool) -> Bool {
    return first { predicate($0) } != nil
  }

  /// **Mechanica**
  ///
  /// Returns true if all the elements `match` the predicate.
  /// - Parameters:
  ///   - predicate: A closure that takes an element of the sequence as its argument and returns a Boolean value indicating whether the element is a match.
  public func hasAllElements(where predicate: (Element) -> Bool) -> Bool {
    return first { !predicate($0) } == nil
  }

  /// **Mechanica**
  ///
  /// - Parameter criteria: The criteria closure takes an `Element` and returns its classification.
  /// - Returns: Returns a grouped dictionary with the keys that the criteria function returns.
  public func grouped<Key>(by criteria: (Element) -> (Key)) -> [Key: [Element]] {
    return Dictionary(grouping: self, by: {return criteria($0)})
  }

  /// **Mechanica**
  ///
  /// Returns the elements count matching a predicate.
  /// - Parameter where: A closure that takes an element of the sequence as its argument and returns a Boolean value indicating whether the element should be counted or not.
  public func count(where predicate: (Element) -> Bool) -> Int {
    var count = 0

    for element in self {
      if predicate(element) { count += 1 }
    }
    return count
  }

  /// **Mechanica**
  ///
  /// Returns a collection of unique elements preserving their original order.
  /// - Parameter elementsEqual: The comparing function.
  /// - Returns: Returns a collection of unique elements preserving their original order.
  func uniqueElements(by elementsEqual: (Element, Element) -> Bool) -> [Element] {
    var result: [Element] = []
    
    for element in self {
      if !result.contains(where: { resultElement in
        elementsEqual(element, resultElement)}) {
        result.append(element)
      }
    }
    
    return result
  }

}

extension Sequence where Element: Equatable {

  /// **Mechanica**
  ///
  /// Returns a collection of unique elements preserving their original order.
  func uniqueElements() -> [Element] {
    return uniqueElements(by: ==)
  }

}

// MARK: - Hashable

extension Sequence where Element: Hashable {

  /// **Mechanica**
  ///
  /// Returns a collection of tuples where it's indicated the frequencies of the elements in the sequence.
  public var frequencies: [(Element, Int)] {
    var result = [Element:Int]()

    for element in self {
      result[element] = (result[element] ?? 0) + 1
    }

    return result.sorted { $0.1 > $1.1 }
  }

}

// MARK: - AnyObject

extension Sequence where Element: AnyObject {

  /// **Mechanica**
  ///
  /// Returns true if the `Sequence` contains an element identical (referential equality) to an `object`.
  public func containsObjectIdentical(to object: AnyObject) -> Bool {
    return contains {$0 === object}
  }

}
