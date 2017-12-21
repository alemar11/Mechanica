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

extension Collection where Self.Index == Int, Element: Equatable {

  // MARK: - Equatable

  /// **Mechanica**
  ///
  ///  Returns the first index where the specified value appears in the collection.
  ///  After using firstIndex(of:) to find the last position of a particular element in a collection, you can use it to access the element by subscripting.
  /// - Parameter element: Index of the first element found (if any).
  /// - Note: Same as `index(of:)`.
  /// - SeeAlso: `index(of:)`
  public func firstIndex(of element: Element) -> Self.Index? {
    return index(of: element)
  }

  /// **Mechanica**
  ///
  ///  Returns the last index where the specified value appears in the collection.
  ///  After using lastIndex(of:) to find the last position of a particular element in a collection, you can use it to access the element by subscripting.
  /// - Parameter element: Index of the last element found (if any).
  public func lastIndex(of element: Element) -> Self.Index? {
    for idx in stride(from: endIndex-1, through: 0, by: -1) {
      guard element == self[idx] else { continue }
      return idx
    }
    return nil
  }

}

extension Collection where Self.Index == Int {

  /// **Mechanica**
  ///
  /// - Parameter index: the index of the desired element.
  /// - Returns: The element at a given index or nil if not exists.
  /// Example:
  ///
  ///     let array = [1, 2, 3]
  ///     array[100] -> crash
  ///     array.at(100) -> nil
  ///
  public func at(_ index: Int) -> Element? {
    return (index < self.count) ? self[index] : nil
  }

  /// **Mechanica**
  ///
  /// Returns a random element from `self`.
  public func random() -> Element {
    let index = Int.random(lowerBound: startIndex, upperBound: endIndex)
    return self[index]
  }

}
