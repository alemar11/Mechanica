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
  /// Removes the first element that matches the given condition.
  @discardableResult
  private mutating func removeFirst(matchingCondition condition: (Element) -> Bool) -> Element? {
    guard let idx = index(where: condition) else { return nil }
    let item = self[idx]
    remove(at: idx)
    return item
  }

  /// **Mechanica**
  ///
  /// Removes the first element that matches the given condition & returns a `new` array.
  @discardableResult
  private func removedFirst(matchingCondition condition: (Element) -> Bool) -> Array {
    var items = self
    items.removeFirst(matchingCondition: condition)
    return items
  }

  @discardableResult
  private mutating func removeAll(matchingCondition handler: (Element) -> Bool) -> Element? {
    guard let idx = index(where: handler) else { return nil }
    let item = self[idx]
    remove(at: idx)
    return item
  }

  private mutating func removeAll(matchingCondition condition: (Element) -> Bool) -> [Element] {
    var removedElements: [Element] = []

    for index in stride(from: self.endIndex-1, through: 0, by: -1) {
      print(index)
      let element = self[index]
      if condition(element) {
        remove(at: index)
        removedElements.append(element)
      }
    }
    return removedElements
  }

  private func find(matchingCondition condition: (Element) -> Bool) -> [Element] {
    var foundElements: [Element] = []
    for x in self {
      let t = x as Element;
      if condition(t) {
        foundElements.append(t)
      }
    }
    return foundElements
  }

}
