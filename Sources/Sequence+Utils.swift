//
//  Sequence+Utils.swift
//  Mechanica
//
//  Copyright © 2016-2017 Tinrobots.
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
  /// Returns: the first element (if any) `matching` the predicate.
  /// - Parameters:
  ///   - predicate: A closure that takes an element of the sequence as its argument and returns a Boolean value indicating whether the element is a match.
  /// - Note: Same as `first(where:)`.
  /// - SeeAlso: `first(where:)`
  public final func findFirst(where predicate: (Iterator.Element) -> Bool) -> Iterator.Element? {
    //return first(where: predicate)
    for element in self where predicate(element) {
      return element
    }
    return nil
  }

  /// **Mechanica**
  ///
  /// Returns true if there is at least one element `matching` the predicate.
  /// - Parameters:
  ///   - predicate: A closure that takes an element of the sequence as its argument and returns a Boolean value indicating whether the element is a match.
  public final func hasSome(where predicate: (Iterator.Element) -> Bool) -> Bool {
    return findFirst(where: predicate) != nil
  }

  /// **Mechanica**
  ///
  /// Returns true if all the elements `match` the predicate.
  /// - Parameters:
  ///   - predicate: A closure that takes an element of the sequence as its argument and returns a Boolean value indicating whether the element is a match.
  public final func hasAll(where predicate: (Iterator.Element) -> Bool) -> Bool {
    return findFirst { !predicate($0) } == nil
  }

  /// **Mechanica**
  ///
  /// - Parameter criteria: The criteria closure takes an `Iterator.Element` and returns its classification.
  /// - Returns: Returns a grouped dictionary with the keys that the criteria function returns.
  public final func grouped<Key: Hashable>(by criteria: (Iterator.Element) -> (Key)) -> [Key : [Iterator.Element]] {
    var dictionary: [Key : [Iterator.Element]] = [:]
    for element in self {
      let key = criteria(element)
      var array = dictionary.removeValue(forKey: key) ?? []
      array.append(element)
      dictionary.updateValue(array, forKey: key)
    }
    return dictionary
  }

  /// **Mechanica**
  ///
  /// Returns the elements count matching a predicate.
  /// - Parameter shouldCount: A closure that takes an element of the sequence as its argument and returns a Boolean value indicating whether the element should be counted or not.
  public final func count(_ shouldCount: (Iterator.Element) -> Bool) -> Int {
    var count = 0
    for element in self {
      if (shouldCount(element)) {
        count += 1
      }
    }
    return count
  }

}

// MARK: - AnyObject

extension Sequence where Iterator.Element: AnyObject {

  /// **Mechanica**
  ///
  /// Returns true if the `Sequence` contains an element identical (referential equality) to an `object`.
  public final func containsObjectIdentical(to object: AnyObject) -> Bool {
    return contains { $0 === object }
  }

}
