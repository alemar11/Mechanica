#if canImport(Dispatch)

import Dispatch

// MARK: - Properties

extension DispatchQueue {
  /// **Mechanica**
  ///
  /// Returns a Boolean value indicating whether the current dispatch queue is the main queue.
  static var isMainQueue: Bool {
    enum Static {
      static var key: DispatchSpecificKey<Void> = {
        let key = DispatchSpecificKey<Void>()
        DispatchQueue.main.setSpecific(key: key, value: ())
        return key
      }()
    }
    return DispatchQueue.getSpecific(key: Static.key) != nil
  }
}

// MARK: - Methods

extension DispatchQueue {
  /// **Mechanica**
  ///
  /// Returns a Boolean value indicating whether the current dispatch queue is the specified queue.
  ///
  /// - Parameter queue: The queue to compare against.
  /// - Returns: `true` if the current queue is the specified queue, otherwise `false`.
  public static func isCurrent(_ queue: DispatchQueue) -> Bool {
    let key = DispatchSpecificKey<Void>()

    queue.setSpecific(key: key, value: ())
    defer { queue.setSpecific(key: key, value: nil) }

    return DispatchQueue.getSpecific(key: key) != nil
  }
}

#endif
