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

public extension Date {

  // MARK: - Components

  /// **Mechanica**
  ///
  /// Returns the Era.
  ///
  /// Example:
  ///
  ///     Date().era() -> 1
  ///
  public func era(usingCalendar calendar: Calendar = .current) -> Int {
    return calendar.component(.era, from: self)
  }

  /// **Mechanica**
  ///
  /// Returns the Quarter.
  ///
  /// Example:
  ///
  ///     Date().quarter -> 4 // date in fourth quarter of the year.
  ///
  public func quarter(usingCalendar calendar: Calendar = .current) -> Int {
    let month = Double(calendar.component(.month, from: self))
    let numberOfMonths = Double(calendar.monthSymbols.count)
    let numberOfMonthsInQuarter = numberOfMonths / 4
    return Int(ceil(month / numberOfMonthsInQuarter))
  }

  /// **Mechanica**
  ///
  /// Returns the Week of year.
  ///
  /// Example:
  ///
  ///     Date().weekOfYear() -> 3 // third week in the year.
  ///
  public func weekOfYear(usingCalendar calendar: Calendar = .current) -> Int {
    return calendar.component(.weekOfYear, from: self)
  }

  /// **Mechanica**
  ///
  /// Returns the Week of month.
  ///
  /// Example:
  ///
  ///     Date().weekOfMonth() -> 2 // date is in second week of the month.
  ///
  public func weekOfMonth(usingCalendar calendar: Calendar = .current) -> Int {
    return calendar.component(.weekOfMonth, from: self)
  }

  /// **Mechanica**
  ///
  /// Returns the Year.
  ///
  /// Example:
  ///
  ///     Date().year() -> 1983
  ///
  public func year(usingCalendar calendar: Calendar = .current) -> Int {
    return calendar.component(.year, from: self)
  }

  /// **Mechanica**
  ///
  /// Returns the Month.
  ///
  /// Example:
  ///
  ///     Date().month() -> 4
  ///
  public func month(usingCalendar calendar: Calendar = .current) -> Int {
    return calendar.component(.month, from: self)
  }

  /// **Mechanica**
  ///
  /// Returns the Day.
  ///
  /// Example:
  ///
  ///     Date().day() -> 11
  ///
  public func day(usingCalendar calendar: Calendar = .current) -> Int {
    return calendar.component(.day, from: self)
  }

  /// **Mechanica**
  ///
  /// Returns the Week Day.
  ///
  /// Example:
  ///
  ///     Date().weekday() -> 1 // first day in the current week.
  ///
  public func weekday(usingCalendar calendar: Calendar = .current) -> Int {
    return calendar.component(.weekday, from: self)
  }

  /// **Mechanica**
  ///
  /// Returns the Hour.
  ///
  /// Example:
  ///
  ///     Date().hour() -> 16 // 4 pm
  ///
  public func hour(usingCalendar calendar: Calendar = .current) -> Int {
    return calendar.component(.hour, from: self)
  }

  /// **Mechanica**
  ///
  /// Returns the Minutes.
  ///
  /// Example:
  ///
  ///     Date().minute() -> 14
  ///
  public func minute(usingCalendar calendar: Calendar = .current) -> Int {
    return calendar.component(.minute, from: self)
  }

  /// **Mechanica**
  ///
  /// Returns the Seconds.
  ///
  /// Example:
  ///
  ///     Date().second() -> 18
  ///
  public func second(usingCalendar calendar: Calendar = .current) -> Int {
    return calendar.component(.second, from: self)
  }

  /// **Mechanica**
  ///
  /// Returns the Nanoseconds.
  ///
  /// Example:
  ///
  ///     Date().nanosecond() -> 981379985
  ///
  public func nanosecond(usingCalendar calendar: Calendar = .current) -> Int {
    return calendar.component(.nanosecond, from: self)
  }

  /// **Mechanica**
  ///
  /// Returns the Milliseconds.
  ///
  /// Example:
  ///
  ///     Date().millisecond() -> 68 //TODO
  ///
  public func millisecond(usingCalendar calendar: Calendar = .current) -> Int {
    return calendar.component(.nanosecond, from: self) / 1_000_000
  }

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
  /// Checks if date is is within today.
  public func isToday(usingCalendar calendar: Calendar = .current) -> Bool {
    return calendar.isDateInToday(self)
  }

  /// **Mechanica**
  ///
  /// Checks if date is is within yesterday.
  ///
  /// Example:
  ///
  ///     Date().isYesterday() -> false
  ///
  public func isYesterday(usingCalendar calendar: Calendar = .current) -> Bool {
    return calendar.isDateInYesterday(self)
  }

  /// **Mechanica**
  ///
  /// Checks if date is is within tomorrow.
  ///
  public func isTomorrow(usingCalendar calendar: Calendar = .current) -> Bool {
    return calendar.isDateInTomorrow(self)
  }

  /// **Mechanica**
  ///
  /// Checks if date is is within a weekend period.
  ///
  public func isWeekend(usingCalendar calendar: Calendar = .current) -> Bool {
    return calendar.isDateInWeekend(self)
  }

  /// **Mechanica**
  ///
  /// Checks if date is is within a weekday period.
  ///
  public func isWorkday(usingCalendar calendar: Calendar = .current) -> Bool {
    return !calendar.isDateInWeekend(self)
  }

  /// **Mechanica**
  ///
  /// Checks if date is is within the current week.
  ///
  public func isInCurrentWeek(usingCalendar calendar: Calendar = .current) -> Bool {
    return calendar.isDate(self, equalTo: Date(), toGranularity: .weekOfYear)
  }

  /// **Mechanica**
  ///
  /// Checks if date is is within the current month.
  ///
  public func isInCurrentMonth(usingCalendar calendar: Calendar = .current) -> Bool {
    return calendar.isDate(self, equalTo: Date(), toGranularity: .month)
  }

  /// **Mechanica**
  ///
  /// Checks if date is is within the current year.
  ///
  public func isInCurrentYear(usingCalendar calendar: Calendar = .current) -> Bool {
    return calendar.isDate(self, equalTo: Date(), toGranularity: .year)
  }

  // MARK: - Utilities

  /// **Mechanica**
  ///
  /// Returns the ISO8601 string representation (yyyy-MM-dd'T'HH:mm:ss.SSS) from `self`.
  ///
  /// Example:
  ///
  ///     Date().iso8601String -> "2017-01-12T14:51:29.574Z" //TODO
  ///
  public var iso8601Representation: String {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale.posix
    dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"

    return dateFormatter.string(from: self).appending("Z")
  }

  /// **Mechanica**
  ///
  /// Returns the UNIX timestamp from `self`.
  ///
  /// Example:
  ///
  ///     Date().unixTimestamp -> 1484233862.826291 //TODO
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

  // MARK: - Methods

  /// **Mechanica**
  ///
  /// Returns a `new` Date by adding a `Calendar` component.
  ///
  /// Example:
  ///
  ///     let date = Date() // "Jan 12, 2017, 7:07 PM"
  ///     let date2 = date.adding(.minute, value: -10) // "Jan 12, 2017, 6:57 PM"
  ///     let date3 = date.adding(.day, value: 4) // "Jan 16, 2017, 7:07 PM"
  ///     let date4 = date.adding(.month, value: 2) // "Mar 12, 2017, 7:07 PM"
  ///     let date5 = date.adding(.year, value: 13) // "Jan 12, 2030, 7:07 PM"
  ///
  /// - Parameters:
  ///   - component: component type.
  ///   - value: multiples of components to add.
  /// - Returns: A new date, or nil if a date could not be calculated.
  public func adding(_ component: Calendar.Component, value: Int, usingCalendar calendar: Calendar = .current) -> Date? {
    return calendar.date(byAdding: component, value: value, to: self)
  }

  /// **Mechanica**
  ///
  /// Adds a calendar component to `self`.
  ///
  /// Example:
  ///
  ///     var date = Date() // "Jan 12, 2017, 7:07 PM"
  ///     date.add(.minute, value: -10) // "Jan 12, 2017, 6:57 PM"
  ///     date.add(.day, value: 4) // "Jan 16, 2017, 7:07 PM"
  ///     date.add(.month, value: 2) // "Mar 12, 2017, 7:07 PM"
  ///     date.add(.year, value: 13) // "Jan 12, 2030, 7:07 PM"
  ///
  /// - Parameters:
  ///   - component: component type.
  ///   - value: multiples of compnenet to add.
  public mutating func add(_ component: Calendar.Component, value: Int, usingCalendar calendar: Calendar = .current) {
    if let date = calendar.date(byAdding: component, value: value, to: self) {
      self = date
    }
  }

  // swiftlint:disable cyclomatic_complexity
  /// **Mechanica**
  ///
  /// Returns a `new` Date by changing a `Calendar` components.
  ///
  /// Example:
  ///
  ///     let date = Date() // "Jan 12, 2017, 7:07 PM"
  ///     let date2 = date.changing(.minute, value: 10) // "Jan 12, 2017, 6:10 PM"
  ///     let date3 = date.changing(.day, value: 4) // "Jan 4, 2017, 7:07 PM"
  ///     let date4 = date.changing(.month, value: 2) // "Feb 12, 2017, 7:07 PM"
  ///     let date5 = date.changing(.year, value: 2000) // "Jan 12, 2000, 7:07 PM"
  ///
  /// - Parameters:
  ///   - component: component type.
  ///   - value: new value of compnenet to change.
  /// - Returns: original date after changing given component to given value.
  public func changing(_ component: Calendar.Component, value: Int, usingCalendar calendar: Calendar = .current) -> Date? {
    return calendar.date(bySetting: component, value: value, of: self)
//    switch component {
//    case .nanosecond:
//      guard let allowedRange = calendar.range(of: .nanosecond, in: .second, for: self) else { return nil }
//      guard allowedRange.contains(value) else { return nil }
//
//      let currentNanoseconds = calendar.component(.nanosecond, from: self)
//      let nanosecondsToAdd = value - currentNanoseconds
//      return calendar.date(byAdding: .nanosecond, value: nanosecondsToAdd, to: self)
//
//    case .second:
//      guard let allowedRange = calendar.range(of: .second, in: .minute, for: self) else { return nil }
//      guard allowedRange.contains(value) else { return nil }
//
//      let currentSeconds = calendar.component(.second, from: self)
//      let secondsToAdd = value - currentSeconds
//      return calendar.date(byAdding: .second, value: secondsToAdd, to: self)
//
//    case .minute:
//      guard let allowedRange = calendar.range(of: .minute, in: .hour, for: self) else { return nil }
//      guard allowedRange.contains(value) else { return nil }
//
//      let currentMinutes = calendar.component(.minute, from: self)
//      let minutesToAdd = value - currentMinutes
//      return calendar.date(byAdding: .minute, value: minutesToAdd, to: self)
//
//    case .hour:
//      guard let allowedRange = calendar.range(of: .hour, in: .day, for: self) else { return nil }
//      guard allowedRange.contains(value) else { return nil }
//
//      let currentHour = calendar.component(.hour, from: self)
//      let hoursToAdd = value - currentHour
//      return calendar.date(byAdding: .hour, value: hoursToAdd, to: self)
//
//    case .day:
//      guard let allowedRange = calendar.range(of: .day, in: .month, for: self) else { return nil }
//      guard allowedRange.contains(value) else { return nil }
//
//      let currentDay = calendar.component(.day, from: self)
//      let daysToAdd = value - currentDay
//      return calendar.date(byAdding: .day, value: daysToAdd, to: self)
//
//    case .month:
//      guard let allowedRange = calendar.range(of: .month, in: .year, for: self) else { return nil }
//      guard allowedRange.contains(value) else { return nil }
//
//      let currentMonth = calendar.component(.month, from: self)
//      let monthsToAdd = value - currentMonth
//      return calendar.date(byAdding: .month, value: monthsToAdd, to: self)
//
//    case .year:
//      guard value > 0 else { return nil }
//
//      let currentYear = calendar.component(.year, from: self)
//      let yearsToAdd = value - currentYear
//      return calendar.date(byAdding: .year, value: yearsToAdd, to: self)
//
//    default:
//      return calendar.date(bySetting: component, value: value, of: self)
//    }
  }
  // swiftlint:enable cyclomatic_complexity

  /// **Mechanica**
  ///
  /// Checks if date is in current given `Calendar` component.
  ///
  /// - Parameter component: calendar component to check.
  /// - Returns: true if date is in current given calendar component.
  public func isInCurrent(_ component: Calendar.Component, usingCalendar calendar: Calendar = .current) -> Bool {
    return calendar.isDate(self, equalTo: Date(), toGranularity: component)
  }

  /// **Mechanica**
  ///
  /// Returns a string representation for a given date format.
  ///
  /// Example:
  ///
  ///     Date().string(withFormat: "dd/MM/yyyy") -> "1/12/17"
  ///     Date().string(withFormat: "HH:mm") -> "23:50"
  ///     Date().string(withFormat: "dd/MM/yyyy HH:mm") -> "1/12/17 23:50"
  ///
  /// - Parameter format: Date format (default is "dd/MM/yyyy").
  /// - Returns: date string.
  public func string(withFormat format: String = "dd/MM/yyyy HH:mm") -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: self)
  }

  /// **Mechanica**
  ///
  /// Returns a string representation for a given date style.
  ///
  /// Example:
  ///
  ///     Date().string(withStyle: .short) -> "1/12/17" //TODO: add time stile
  ///     Date().string(withStyle: .medium) -> "Jan 12, 2017"
  ///     Date().string(withStyle: .long) -> "January 12, 2017"
  ///     Date().string(withStyle: .full) -> "Thursday, January 12, 2017"
  ///
  /// - Parameter style: DateFormatter style (default is .medium).
  /// - Returns: date string.
  public func string(withStyle style: DateFormatter.Style = .medium, timeStile: DateFormatter.Style = .none) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.timeStyle = timeStile
    dateFormatter.dateStyle = style
    return dateFormatter.string(from: self)
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
    if includingBounds {
      return startDate.compare(self).rawValue * compare(endDate).rawValue >= 0
    }
    return startDate.compare(self).rawValue * compare(endDate).rawValue > 0
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
    var randomValue = Int64.random(lowerBound: .min, upperBound: .max)
    randomValue = llabs(randomValue % diff)

    let startReferenceDate = toDate > fromDate ? fromDate : toDate
    return startReferenceDate.addingTimeInterval(TimeInterval(randomValue))
  }

}

// MARK: - Initializers

public extension Date {

  /// **Mechanica**
  ///
  /// Creates a new `Date` instance from an ISO8601 string.
  ///
  /// Example:
  ///
  ///    let date = Date(iso8601String: "2017-01-12T16:48:00.959Z") // "Jan 12, 2017, 7:48 PM"
  ///
  /// - Parameter iso8601String: ISO8601 string of format (yyyy-MM-dd'T'HH:mm:ss.SSSZ).
  public init?(iso8601String: String) {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale.posix
    dateFormatter.timeZone = TimeZone.current
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    if let date = dateFormatter.date(from: iso8601String) {
      self = date
    } else {
      return nil
    }
  }

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

// TODO
/*
 extension DispatchTimeInterval {

 /// **Mechanica**
 ///
 /// Returns a dispatch time interval in nanoseconds from a `Double` number of seconds
 ///
 /// Example:
 ///
 ///    let timeInEightAndHalf: DispatchTime = .now() + .seconds(8.5)
 public static func seconds(_ amount: Double) -> DispatchTimeInterval {
 // http://ericasadun.com/2017/05/23/5-easy-dispatch-tricks/
 let delay = Double(NSEC_PER_SEC) * amount
 return DispatchTimeInterval.nanoseconds(Int(delay))
 }
 }

 extension DispatchTime {
 /// Returns a dispatch time offset by `duration` seconds from `now`
 ///
 /// Example:
 ///
 ///    DispatchQueue.main.asyncAfter(deadline: .secondsFromNow($0)) {...}
 ///
 public static func secondsFromNow(_ duration: Double) -> DispatchTime {
 // http://ericasadun.com/2017/05/23/5-easy-dispatch-tricks/
 return DispatchTime.now() + duration
 }
 }

 extension DateComponents {
 /// **Mechanica**
 ///
 /// Returns a DispatchTime that's been component offset from now
 public var dispatchTime: DispatchTime? {
 guard let offsetDate = Calendar.autoupdatingCurrent.date(byAdding: self, to: Date()) else { return nil }
 let seconds = offsetDate.timeIntervalSinceNow
 return DispatchTime.now() + seconds
 }
 }
 */
