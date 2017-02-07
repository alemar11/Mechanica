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
  public typealias Element = Iterator.Element

  /// **Mechanica**
  ///
  /// Returns the first element (if any) `matching` the condition.
  public func findFirstOccurence(matching condition: (Element) -> Bool) -> Element? {
    for element in self where condition(element) {
      return element
    }
    return nil
  }

  /// **Mechanica**
  ///
  /// Returns true if there is at least one element `matching` the condition.
  public func hasSomeOccurrences(matching condition: (Element) -> Bool) -> Bool {
    return findFirstOccurence(matching: condition) != nil
  }

  /// **Mechanica**
  ///
  /// Returns true if all the elements `match` the condition.
  public func hasAllOccurrences(matching condition: (Element) -> Bool) -> Bool {
    return findFirstOccurence { !condition($0) } == nil
  }

  /// **Mechanica**
  ///
  ///  Returns a grouped dictionary by the closure.
  public func grouped<Key: Hashable>(by key: (Element) -> (Key)) -> [Key : [Element]] {
    var dictionary: [Key : [Element]] = [:]
    for element in self {
      let key = key(element)
      var array = dictionary.removeValue(forKey: key) ?? []
      array.append(element)
      dictionary.updateValue(array, forKey: key)
    }
    return dictionary
  }

}

// MARK: - AnyObject

extension Sequence where Iterator.Element: AnyObject {

  /// **Mechanica**
  ///
  /// Returns true if the `Sequence` contains an element identical (referential equality) to an `object`.
  public func contains(objectIdenticalTo object: AnyObject) -> Bool {
    return contains { $0 === object }
  }

}

