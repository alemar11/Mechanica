#if canImport(Foundation)

import Foundation

extension Date {
  /// **Mechanica**
  ///
  /// Checks if date is the in the future.
  public var isFuture: Bool {
    return self > Date()
  }

  /// **Mechanica**
  ///
  /// Checks if date is the in the past.
  public var isPast: Bool {
    return self < Date()
  }

  /// **Mechanica**
  ///
  /// Returns the UNIX timestamp from `self`.
  ///
  /// Example:
  ///
  ///     Date().unixTimestamp -> 1484233862.826291
  ///
  public var unixTimestamp: Double {
    return timeIntervalSince1970
  }

  /// **Mechanica**
  ///
  /// Returns the number of seconds between two date.
  ///
  /// - Parameter date: date to compate self to.
  /// - Returns: number of seconds between self and given date.
  public func secondsSince(_ date: Date) -> Double {
    return timeIntervalSince(date)
  }

  /// **Mechanica**
  ///
  /// Returns the number of minutes between two date.
  ///
  /// - Parameter date: date to compate self to.
  /// - Returns: number of minutes between self and given date.
  public func minutesSince(_ date: Date) -> Double {
    return timeIntervalSince(date) / 60
  }

  /// **Mechanica**
  ///
  /// Returns the number of hours between two date.
  ///
  /// - Parameter date: date to compate self to.
  /// - Returns: number of hours between self and given date.
  public func hoursSince(_ date: Date) -> Double {
    return timeIntervalSince(date) / 3600
  }

  /// **Mechanica**
  ///
  /// Returns the number of days between two date.
  ///
  /// - Parameter date: date to compare self to.
  /// - Returns: number of days between self and given date.
  public func daysSince(_ date: Date) -> Double {
    return timeIntervalSince(date) / (3600 * 24)
  }

  /// **Mechanica**
  ///
  /// Checks if a date is between two other dates.
  ///
  /// - Parameters:
  ///   - startDate: start date to compare self to.
  ///   - endDate: endDate date to compare self to.
  ///   - includingBounds: true if the start and end date should be included (default is false)
  /// - Returns: true if the date is between the two given dates.
  public func isBetween(_ startDate: Date, _ endDate: Date, includingBounds: Bool = false) -> Bool {
    let result = startDate.compare(self).rawValue * compare(endDate).rawValue
    if includingBounds {
      return result >= 0
    }
    return result > 0
  }

  /// **Mechanica**
  ///
  /// Generates a random date between two dates.
  ///
  /// Example:
  ///
  ///     Date.random()
  ///     Date.random(from: Date())
  ///     Date.random(upTo: Date())
  ///     Date.random(from: Date(), upTo: Date())
  ///
  /// - Parameters:
  ///   - fromDate: minimum date (default is Date.distantPast)
  ///   - toDate: maximum date (default is Date.distantFuture)
  /// - Returns: random date between two dates.
  public static func random(from fromDate: Date = .distantPast, upTo toDate: Date = .distantFuture) -> Date {
    guard fromDate != toDate else { return fromDate }

    let diff = llabs(Int64(toDate.timeIntervalSinceReferenceDate - fromDate.timeIntervalSinceReferenceDate))
    var randomValue = Int64.random(in: Int64.min...Int64.max)
    randomValue = llabs(randomValue % diff)

    let startReferenceDate = toDate > fromDate ? fromDate : toDate
    return startReferenceDate.addingTimeInterval(TimeInterval(randomValue))
  }
}

// MARK: - Initializers

extension Date {
  /// **Mechanica**
  ///
  /// Creates a new `Date` instance from an UNIX timestamp.
  ///
  /// Example:
  ///
  ///    let date = Date(unixTimestamp: 1484239783.922743) // "Jan 12, 2017, 7:49 PM"
  ///
  /// - Parameter unixTimestamp: UNIX timestamp.
  public init(unixTimestamp: Double) {
    self.init(timeIntervalSince1970: unixTimestamp)
  }
}

#endif
