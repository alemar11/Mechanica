#if canImport(Foundation)
import Foundation

// MARK: Properties

extension NSPredicate {
  /// **Mechanica**
  ///
  /// An always `true` NSPredicate.
  public static let `true` = NSPredicate(value: true)

  /// **Mechanica**
  ///
  /// An always `false` NSPredicate.
  public static let `false` = NSPredicate(value: false)
}

// MARK: Methods

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

// MARK: Operators

extension NSPredicate {
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
