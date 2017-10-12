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

extension RangeReplaceableCollection where Self.Index == Int {

  /// **Mechanica**
  ///
  /// Appends a new `element`.
  @discardableResult
  public func appending(_ element: Element) -> Self {
    var copy = self
    copy.append(element)
    
    return copy
  }
  
  /// **Mechanica**
  ///
  /// Removes the first element that matches the given `condition`.
  /// - Parameters:
  ///   - condition: A closure that takes an element of the sequence as its argument and returns a Boolean value indicating whether the element is a match.
  @discardableResult
  public mutating func removeFirst(where condition: (Element) -> Bool) -> Element? {
    guard let idx = index(where: condition) else { return nil }
    
    return remove(at: idx)
  }

  /// **Mechanica**
  ///
  /// Removes the first element that matches the given `condition` and returns a `new` collection.
  /// - Parameters:
  ///   - condition: A closure that takes an element of the sequence as its argument and returns a Boolean value indicating whether the element is a match.
  public func removingFirst(where condition: (Element) -> Bool) -> Self {
    var copy = self
    copy.removeFirst(where: condition)
    
    return copy
  }

  /// **Mechanica**
  ///
  /// Removes the last element that matches the given `condition`.
  /// - Parameters:
  ///   - condition: A closure that takes an element of the sequence as its argument and returns a Boolean value indicating whether the element is a match.
  @discardableResult
  public mutating func removeLast(where condition: (Element) -> Bool) -> Element? {
    for idx in stride(from: self.endIndex-1, through: 0, by: -1) {
      guard condition(self[idx]) else { continue }
      
      return remove(at: idx)
    }
    
    return nil
  }

  /// **Mechanica**
  ///
  /// Removes the last element that matches the given `condition` and returns a `new` collection.
  /// - Parameters:
  ///   - condition: A closure that takes an element of the sequence as its argument and returns a Boolean value indicating whether the element is a match.
  public func removingLast(where condition: (Element) -> Bool) -> Self {
    var items = self
    items.removeLast(where: condition)
    
    return items
  }

  /// **Mechanica**
  ///
  /// Removes all the elements that matches the given `condition` and returns all the removed element (if any).
  /// - Parameters:
  ///   - condition: A closure that takes an element of the sequence as its argument and returns a Boolean value indicating whether the element is a match.
  @discardableResult
  public mutating func removeAll(where condition: (Element) -> Bool) -> [Element] {
    var removedElements: [Element]  = []
    // fix this
    //self = filter { !condition($0) }
    for idx in stride(from: self.endIndex-1, through: 0, by: -1) {
      let element = self[idx]
      guard condition(element) else { continue }
      
      remove(at: idx)
      removedElements.insert(element, at: 0)
    }
    
    return removedElements
  }

  /// **Mechanica**
  ///
  /// Removes all the elements that matches the given `condition` and returns a `new` array.
  /// - Parameters:
  ///   - condition: A closure that takes an element of the sequence as its argument and returns a Boolean value indicating whether the element is a match.
  public func removingAll(where condition: (Element) -> Bool) -> Self {
    var copy = self
    copy.removeAll(where: condition)
    
    return copy
  }

}

extension RangeReplaceableCollection where Self.Index == Int, Element: Equatable {

  /// **Mechanica**
  /// Removes the first specified element from the collection (if exists).
  /// - Returns: The element removed (if any).
  /// - Parameter element: The element to remove the last occurrence.
  @discardableResult
  public mutating func removeFirstOccurrence(of element: Element) -> Element? {
    guard let idx = index(of: element) else { return nil }
    
    return remove(at: idx)
  }

  /// **Mechanica**
  ///
  /// Removes the last specified element from the array (if exists).
  /// - Returns: The element removed (if any).
  /// - Parameter element: The element to remove the collection occurrence.
  @discardableResult
  public mutating func removeLastOccurrence(of element: Element) -> Element? {
    if let idx = lastIndex(of: element) { return remove(at: idx) }
    
    return nil
  }

}
