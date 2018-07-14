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

#if canImport(Glibc)
import Glibc
#elseif canImport(Darwin)
import Darwin.C
#endif

#if canImport(Foundation)
import Foundation

extension Calendar {

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
  /// Checks if date is is within a weekday period.
  ///
  public func isDateInWorkDay(_ date: Date) -> Bool {
    return !isDateInWeekend(date)
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
 */
