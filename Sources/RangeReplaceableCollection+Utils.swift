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
  /// Removes the first element that matches the given `predicate`.
  /// - Parameters:
  ///   - predicate: A closure that takes an element of the sequence as its argument and returns a Boolean value indicating whether the element is a match.
  @discardableResult
  public mutating func removeFirst(where predicate: (Iterator.Element) -> Bool) -> Iterator.Element? {
    guard let idx = index(where: predicate) else { return nil }
    return remove(at: idx)
  }
  
  /// **Mechanica**
  ///
  /// Removes the first element that matches the given `predicate` and returns a `new` collection.
  /// - Parameters:
  ///   - predicate: A closure that takes an element of the sequence as its argument and returns a Boolean value indicating whether the element is a match.
  internal func removingFirst(where predicate: (Iterator.Element) -> Bool) -> Self {
    var items = self
    items.removeFirst(where: predicate)
    return items
  }
  
  /// **Mechanica**
  ///
  /// Removes the last element that matches the given `predicate`.
  /// - Parameters:
  ///   - predicate: A closure that takes an element of the sequence as its argument and returns a Boolean value indicating whether the element is a match.
  @discardableResult
  internal mutating func removeLast(where predicate: (Iterator.Element) -> Bool) -> Iterator.Element? {
    //guard let idx = reversed().index(where: predicate) else { return nil }
    //return remove(at: (endIndex-1) - idx)
    for idx in stride(from: self.endIndex-1, through: 0, by: -1) {
      guard predicate(self[idx]) else { continue }
      return remove(at: idx)
    }
    return nil
  }
  
  /// **Mechanica**
  ///
  /// Removes the last element that matches the given `predicate` and returns a `new` collection.
  /// - Parameters:
  ///   - predicate: A closure that takes an element of the sequence as its argument and returns a Boolean value indicating whether the element is a match.
  internal func removingLast(where predicate: (Iterator.Element) -> Bool) -> Self {
    var items = self
    items.removeLast(where: predicate)
    return items
  }
  
  /// **Mechanica**
  ///
  /// Removes all the elements that matches the given `predicate` and returns all the removed element (if any).
  /// - Parameters:
  ///   - predicate: A closure that takes an element of the sequence as its argument and returns a Boolean value indicating whether the element is a match.
  @discardableResult
  internal mutating func removeAll(where predicate: (Iterator.Element) -> Bool) -> [Iterator.Element] {
    var removedElements: [Iterator.Element]  = []
    for idx in stride(from: self.endIndex-1, through: 0, by: -1) {
      let element = self[idx]
      guard predicate(element) else { continue }
      remove(at: idx)
      removedElements.insert(element, at: 0)
    }
    return removedElements
  }
  
  /// **Mechanica**
  ///
  /// Removes all the elements that matches the given `predicate` and returns a `new` array.
  /// - Parameters:
  ///   - predicate: A closure that takes an element of the sequence as its argument and returns a Boolean value indicating whether the element is a match.
  internal func removingAll(where predicate: (Iterator.Element) -> Bool) -> Self {
    var items = self
    items.removeAll(where: predicate)
    return items
  }
  
}

extension RangeReplaceableCollection where Self.Index == Int, Iterator.Element: Equatable {
  
  /// **Mechanica**
  /// Removes the first specified element from the collection (if exists).
  /// - Returns: The element removed (if any).
  /// - Parameter element: The element to remove the last occurrence.
  @discardableResult
  internal mutating func removeFirstOccurrence(of element: Iterator.Element) -> Iterator.Element? {
    guard let idx = index(of: element) else { return nil }
    return remove(at: idx)
  }

  /// **Mechanica**
  ///
  /// Removes the last specified element from the array (if exists).
  /// - Returns: The element removed (if any).
  /// - Parameter element: The element to remove the collection occurrence.
  @discardableResult
  internal mutating func removeLastOccurrence(of element: Iterator.Element) -> Iterator.Element? {
    if let idx = lastIndex(of: element) {
      return remove(at: idx)
    }
    return nil
  }
  
}

