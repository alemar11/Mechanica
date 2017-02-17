//
//  Array+Utils.swift
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

extension Array  {
  
  /// **Mechanica**
  ///
  /// Removes the first element that matches the given `condition`.
  @discardableResult
  internal mutating func removeFirst(matching condition: (Element) -> Bool) -> Element? {
    guard let idx = index(where: condition) else { return nil }
    let item = self[idx]
    remove(at: idx)
    return item
  }
  
  /// **Mechanica**
  ///
  /// Removes the first element that matches the given `condition` and returns a `new` array.
  internal func removedFirst(matching condition: (Element) -> Bool) -> Array {
    var items = self
    items.removeFirst(matching: condition)
    return items
  }
  
  /// **Mechanica**
  ///
  /// Removes the last element that matches the given `condition`.
  @discardableResult
  internal mutating func removeLast(matching condition: (Element) -> Bool) -> Element? {
    guard let idx = reversed().index(where: condition) else { return nil }
    print(idx)
    let item = self[idx.base-1]
    remove(at: idx.base-1)
    return item
  }
  
  /// **Mechanica**
  ///
  /// Removes the last element that matches the given `condition` and returns a `new` array.
  internal mutating func removedLast(matching condition: (Element) -> Bool) -> Array {
    var items = self
    items.removeLast(matching: condition)
    return items
  }
  
  /// **Mechanica**
  ///
  /// Removes all the elements that matches the given `condition` and returns all the removed element (if any).
  @discardableResult
  internal mutating func removeAll(matching condition: (Element) -> Bool) -> [Element] {
   //FIXME: verify the faster solution
    var removedElements: [Element]  = []
    for index in stride(from: self.endIndex-1, through: 0, by: -1) {
      let element = self[index]
      guard condition(element) else { continue }
      remove(at: index)
      //removedElements.append(element)
      removedElements.insert(element, at: 0)
    }
    //return removedElements.reversed()
    return removedElements
  }
  
  /// **Mechanica**
  ///
  /// Removes all the elements that matches the given `condition` and returns a `new` array.
  internal mutating func removedAll(matching condition: (Element) -> Bool) -> Array {
    var items = self
    items.removeAll(matching: condition)
    return items
  }
  
  
}

extension Array where Element: Equatable {
  
  /// **Mechanica**
  /// Removes and returns the specified element from the array (if exists).
  public mutating func remove(_ element: Element) -> Element? {
    guard let index = index(of: element) else { return nil }
    return remove(at: index)
  }
  
  /// **Mechanica**
  ///  Returns the last index where the specified value appears in the collection.
  ///  After using lastIndex(of:) to find the last position of a particular element in a collection, you can use it to access the element by subscripting.
  /// - Parameter element: The element to find the last Index
  internal func lastIndex(of element: Element) -> Index? {
    if let index = reversed().index(of: element) {
      return  index.base - 1
    }
    return nil
  }
  
  // TODO: firstIndex, removeFirstOccurrence
  
  /// **Mechanica**
  /// Removes the last occurrence where the specified value appears in the collection.
  /// - Returns: True if the last occurrence element was found and removed or false if not.
  /// - Parameter element: The element to remove the last occurrence.
  @discardableResult
  internal mutating func removeLastOccurrence(of element: Element) -> Element? {
    if let index = lastIndex(of: element) {
      let element = self[index]
      remove(at: index)
      return element
    }
    return nil
  }
  
}
