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

// MARK: - Subscripts

extension Collection {

  /// **Mechanica**
  ///
  /// Returns the element at the specified index or nil if not exists.
  ///
  /// Example:
  ///
  ///     let array = [1, 2, 3]
  ///     array[100] -> crash
  ///     array[safe: 100] -> nil
  ///
  /// - Parameter index: the index of the desired element.
  public subscript(safe index: Index) -> Element? {
    guard index >= startIndex && index < endIndex else {
      return nil
    }

    return self[index]
  }

}

// MARK: - Methods

extension Collection {

  /// **Mechanica**
  ///
  /// - Parameter index: the index of the desired element.
  /// - Returns: The element at a given index or nil if not exists.
  ///
  /// Example:
  ///
  ///     let array = [1, 2, 3]
  ///     array[100] -> crash
  ///     array.at(100) -> nil
  ///
  public func at(_ index: Index) -> Element? {
    return self[safe: index]
  }

}

// MARK: - Equatable

extension Collection where Element: Equatable {

  /// **Mechanica**
  ///
  /// Returns all the indices of a specified item.
  ///
  /// Example:
  ///
  ///      [1, 2, 1, 2, 3, 4, 5, 1].indices(of: 1) -> [0, 2, 7])
  ///
  /// - Parameter item: item to verify.
  /// - Returns: all the indices of the given item.
  public func indices(of item: Element) -> [Index] {
    var indices = [Index]()
    var index = startIndex
    while index < endIndex {
      if self[index] == item {
        indices.append(index)
      }
      formIndex(after: &index)
    }
    return indices
  }

}
