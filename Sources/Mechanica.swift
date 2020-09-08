/// **Mechanica**
///
/// Mechanica Bundle Identifier
internal let bundleIdentifier = "org.tinrobots.Mechanica"

/// **Mechanica**
///
/// Associated Key prefix.
internal let associatedKeyPrefix = "Mechanica.AssociatedKey"

#if canImport(Foundation)
// TODO: move in another file
import Foundation

/// **Mechanica**
///
/// Mechanica Bundle
internal var bundle: Bundle {
  class Object {}
  return Bundle(for: Object.self)
}

#endif
