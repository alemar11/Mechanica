//
//  RangeReplaceableCollection+Utils.swift
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

extension RangeReplaceableCollection where Self.Index == Int {
  
  /// **Mechanica**
  ///
  /// Removes the first element that matches the given `condition`.
  @discardableResult
  public mutating func removeFirst(where predicate: (Iterator.Element) -> Bool) -> Iterator.Element? {
    guard let idx = index(where: predicate) else { return nil }
    return remove(at: idx)
  }
  
  /// **Mechanica**
  ///
  /// Removes the first element that matches the given `condition` and returns a `new` collection.
  internal func removingFirst(where predicate: (Iterator.Element) -> Bool) -> Self {
    var items = self
    items.removeFirst(where: predicate)
    return items
  }
  
  /// **Mechanica**
  ///
  /// Removes the last element that matches the given `condition`.
  @discardableResult
  internal mutating func removeLast(where predicate: (Iterator.Element) -> Bool) -> Iterator.Element? {
    guard let idx = reversed().index(where: predicate) else { return nil }
    return remove(at: (endIndex-1) - idx)
  }
  
  /// **Mechanica**
  ///
  /// Removes the last element that matches the given `condition` and returns a `new` collection.
  internal func removingLast(where predicate: (Iterator.Element) -> Bool) -> Self {
    var items = self
    items.removeLast(where: predicate)
    return items
  }
  
  /// **Mechanica**
  ///
  /// Removes all the elements that matches the given `condition` and returns all the removed element (if any).
  @discardableResult
  internal mutating func removeAll(where predicate: (Iterator.Element) -> Bool) -> [Iterator.Element] {
    var removedElements: [Iterator.Element]  = []
    for index in stride(from: self.endIndex-1, through: 0, by: -1) {
      let element = self[index]
      guard predicate(element) else { continue }
      remove(at: index)
      removedElements.insert(element, at: 0)
    }
    return removedElements
  }
  
  /// **Mechanica**
  ///
  /// Removes all the elements that matches the given `condition` and returns a `new` array.
  internal func removingAll(where predicate: (Iterator.Element) -> Bool) -> Self {
    var items = self
    items.removeAll(where: predicate)
    return items
  }
  
}

extension RangeReplaceableCollection where Self.Index == Int, Iterator.Element: Equatable {
  
  /// **Mechanica**
  /// Removes and returns the specified element from the array (if exists).
  internal mutating func remove(_ element: Iterator.Element) -> Iterator.Element? {
    guard let idx = index(of: element) else { return nil }
    return remove(at: idx)
  }
  
  // TODO: removeFirstOccurrence
  
  /// **Mechanica**
  /// Removes the last occurrence where the specified value appears in the collection.
  /// - Returns: True if the last occurrence element was found and removed or false if not.
  /// - Parameter element: The element to remove the last occurrence.
  @discardableResult
  internal mutating func removeLastOccurrence(of element: Iterator.Element) -> Iterator.Element? {
    if let index = lastIndex(of: element) {
      return remove(at: index)
    }
    return nil
  }
  
}

extension Collection where Self.Index == Int, Iterator.Element: Equatable {
  
  /// **Mechanica**
  ///  Returns the last index where the specified value appears in the collection.
  ///  After using lastIndex(of:) to find the last position of a particular element in a collection, you can use it to access the element by subscripting.
  /// - Parameter element: The element to find the last Index
  internal func lastIndex(of element: Iterator.Element) -> Self.Index? {
    if let idx = reversed().index(of: element) {
      return (endIndex-1) - idx
    }
    return nil
  }
  
}
