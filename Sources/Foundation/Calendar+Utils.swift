#if canImport(Foundation)

import Foundation

extension Calendar {
  #if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
  /// **Mechanica**
  ///
  /// Returns the quarter for a given date.
  ///
  /// Example:
  ///
  ///     Calendar.current.quarter(from: Date()) -> 4 // date in fourth quarter of the year.
  ///
  public func quarter(from date: Date) -> Int {
    let month = Double(component(.month, from: date))
    let numberOfMonths = Double(monthSymbols.count)
    let numberOfMonthsInQuarter = numberOfMonths / 4

    return Int(ceil(month / numberOfMonthsInQuarter))
  }

  /// **Mechanica**
  ///
  /// Checks if date is is within the current week.
  ///
  public func isDateInCurrentWeek(_ date: Date) -> Bool {
    return isDate(date, equalTo: Date(), toGranularity: .weekOfYear)
  }

  /// **Mechanica**
  ///
  /// Checks if date is is within the current month.
  ///
  public func isDateInCurrentMonth(_ date: Date) -> Bool {
    return isDate(date, equalTo: Date(), toGranularity: .month)
  }

  /// **Mechanica**
  ///
  /// Checks if date is is within the current year.
  ///
  public func isDateInCurrentYear(_ date: Date) -> Bool {
    return isDate(date, equalTo: Date(), toGranularity: .year)
  }
  #endif

  /// **Mechanica**
  ///
  /// Checks if date is is within a weekday period.
  ///
  public func isDateInWorkDay(_ date: Date) -> Bool {
    return !isDateInWeekend(date)
  }
}

#endif
