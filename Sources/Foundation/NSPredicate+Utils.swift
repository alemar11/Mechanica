//
// Mechanica
//
// Copyright © 2016-2018 Tinrobots.
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

#if canImport(Foundation)
import Foundation

extension NSPredicate {

  /// **Mechanica**
  ///
  ///
  /// - Parameter predicate: A `NSPredicate` object.
  /// - Returns: a `new` compound NSPredicate formed by **AND**-ing `self` with `predicate`.
  public func and(_ predicate: NSPredicate) -> NSPredicate {
    return NSCompoundPredicate(andPredicateWithSubpredicates: [self, predicate])
  }

  /// **Mechanica**
  ///
  ///
  /// - Parameter predicate: A `NSPredicate` object.
  /// - Returns: a `new` compound NSPredicate formed by **OR**-ing `self` with `predicate`.
  public func or(_ predicate: NSPredicate) -> NSPredicate {
    return NSCompoundPredicate(orPredicateWithSubpredicates: [self, predicate])
  }

}

extension NSPredicate {

  // MARK: Operators

  /// **Mechanica**
  ///
  /// Returns a `new` predicate formed by **AND-ing** the two predicates.
  /// - Parameters:
  ///   - lhs: The left-hand side of the operation.
  ///   - rhs: The right-hand side of the operation.
  public static func && (lhs: NSPredicate, rhs: NSPredicate) -> NSPredicate {
    return NSCompoundPredicate(andPredicateWithSubpredicates: [lhs, rhs])
  }

  /// **Mechanica**
  ///
  /// Returns a `new` predicate formed by **OR-ing** the two predicates.
  /// - Parameters:
  ///   - lhs: The left-hand side of the operation.
  ///   - rhs: The right-hand side of the operation.
  public static func || (lhs: NSPredicate, rhs: NSPredicate) -> NSPredicate {
    return NSCompoundPredicate(orPredicateWithSubpredicates: [lhs, rhs])
  }

  /// **Mechanica**
  ///
  /// Returns a `new` predicate forme d by **NOT-ing** a given predicate.
  /// - Parameter p: The NSPredicate to negate.
  public static prefix func ! (predicate: NSPredicate) -> NSPredicate {
    return NSCompoundPredicate(notPredicateWithSubpredicate: predicate)
  }

}
#endif
