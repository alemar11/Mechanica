// MARK: - Methods

extension RangeReplaceableCollection {
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
    guard let idx = firstIndex(where: condition) else { return nil }

    return remove(at: idx)
  }

  /// **Mechanica**
  ///
  /// Removes the first element that matches the given `condition` and returns a tuple with a `new` collection and the removed element.
  /// - Parameters:
  ///   - condition: A closure that takes an element of the sequence as its argument and returns a Boolean value indicating whether the element is a match.
  /// - Returns: A tuple with a `new` collection and the removed element.
  public func removingFirst(where condition: (Element) -> Bool) -> (Self, Element?) {
    var copy = self
    let removed = copy.removeFirst(where: condition)

    return (copy, removed)
  }

  /// **Mechanica**
  ///
  /// Removes the last element that matches the given `condition`.
  /// - Parameters:
  ///   - condition: A closure that takes an element of the sequence as its argument and returns a Boolean value indicating whether the element is a match.
  @discardableResult
  public mutating func removeLast(where condition: (Element) -> Bool) -> Element? {
    for idx in indices.reversed() {
      guard condition(self[idx]) else { continue }

      return remove(at: idx)
    }
    return nil
  }

  /// **Mechanica**
  ///
  /// Removes the last element that matches the given `condition` and returns a tuple with a `new` collection and the removed element.
  /// - Parameters:
  ///   - condition: A closure that takes an element of the sequence as its argument and returns a Boolean value indicating whether the element is a match.
  /// - Returns: A tuple with a `new` collection and the removed element.
  public func removingLast(where condition: (Element) -> Bool) -> (Self, Element?) {
    var copy = self
    let removed = copy.removeLast(where: condition)

    return (copy, removed)
  }
}

// MARK: - Methods (MutableCollection)

extension RangeReplaceableCollection where Self: MutableCollection {
  /// **Mechanica**
  ///
  /// Removes all the elements that matches the given `condition` and returns all the removed element (if any).
  /// - Parameters:
  ///   - condition: A closure that takes an element of the sequence as its argument and returns a Boolean value indicating whether the element is a match.
  /// - Note: use `filter` if you don't need the removed element.
  @discardableResult
  public mutating func remove(where condition: (Element) -> Bool) -> [Element] {
    var removed: [Element] = []

    guard var idx = firstIndex(where: condition) else { return [] }
    removed.append(self[idx])

    var jdx = index(after: idx)
    while jdx < endIndex {
      if !condition(self[jdx]) {
        self[idx] = self[jdx]
        idx = index(after: idx)
      } else {
        removed.append(self[jdx])
      }

      jdx = index(after: jdx)
    }

    removeSubrange(idx...)

    return removed
  }

  /// **Mechanica**
  ///
  /// Removes all the elements that matches the given `condition` and returns a tuple with a `new` collection and the removed elements.
  /// - Parameters:
  ///   - condition: A closure that takes an element of the sequence as its argument and returns a Boolean value indicating whether the element is a match.
  /// - Returns: A tuple with a `new` collection and the removed elements.
  /// - Note: use `filter` if you don't need the removed element.
  public func removing(where condition: (Element) -> Bool) -> (Self, [Element]) {
    var copy = self
    let removed = copy.remove(where: condition)

    return (copy, removed)
  }
}

// MARK: Methods (Equatable)

extension RangeReplaceableCollection where Element: Equatable {
  /// **Mechanica**
  /// Removes the first specified element from the collection (if exists).
  /// - Returns: The element removed (if any).
  /// - Parameter element: The element to remove the last occurrence.
  @discardableResult
  public mutating func removeFirstOccurrence(of element: Element) -> Element? {
    if let idx = firstIndex(of: element) {
      return remove(at: idx)
    }

    return nil
  }
}

// MARK: - Methods (BidirectionalCollection)

extension RangeReplaceableCollection where Self: BidirectionalCollection, Element: Equatable {
  /// **Mechanica**
  ///
  /// Removes the last specified element from the array (if exists).
  /// - Returns: The element removed (if any).
  /// - Parameter element: The element to remove the collection occurrence.
  @discardableResult
  public mutating func removeLastOccurrence(of element: Element) -> Element? {
    if let idx = lastIndex(of: element) {
      return remove(at: idx)
    }

    return nil
  }
}
