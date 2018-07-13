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

import XCTest
@testable import Mechanica

final class DateUtilsTests: XCTestCase {

  override func setUp() {
    super.setUp()
    NSTimeZone.default = TimeZone(abbreviation: "UTC")!
  }

  func testEra() {
    let date = Date(timeIntervalSince1970: 0)
    XCTAssertEqual(date.era(), 1)
  }

  func testQuarter() {
    let date1 = Date(timeIntervalSince1970: 0)
    XCTAssertEqual(date1.quarter(), 1)

    let date2 = Calendar.current.date(byAdding: .month, value: 4, to: date1)
    XCTAssertEqual(date2?.quarter(), 2)

    let date3 = Calendar.current.date(byAdding: .month, value: 8, to: date1)
    XCTAssertEqual(date3?.quarter(), 3)

    let date4 = Calendar.current.date(byAdding: .month, value: 11, to: date1)
    XCTAssertEqual(date4?.quarter(), 4)
  }

  func testWeekOfYear() {
    let date = Date(timeIntervalSince1970: 0)
    XCTAssertEqual(date.weekOfYear(), 1)

    let dateAfter7Days = Calendar.current.date(byAdding: .day, value: 7, to: date)
    XCTAssertEqual(dateAfter7Days?.weekOfYear(), 2)

    let originalDate = Calendar.current.date(byAdding: .day, value: -7, to: dateAfter7Days!)
    XCTAssertEqual(originalDate?.weekOfYear(), 1)
  }

  func testWeekOfMonth() {
    let date = Date(timeIntervalSince1970: 0)
    XCTAssertEqual(date.weekOfMonth(), 1)

    let dateAfter7Days = Calendar.current.date(byAdding: .day, value: 7, to: date)
    XCTAssertEqual(dateAfter7Days?.weekOfMonth(), 2)

    let originalDate = Calendar.current.date(byAdding: .day, value: -7, to: dateAfter7Days!)
    XCTAssertEqual(originalDate?.weekOfMonth(), 1)
  }

  func testYear() {
    var date = Date(timeIntervalSince1970: 100000.123450040)
    XCTAssertEqual(date.year(), 1970)

    var isLowerComponentsValid: Bool {
      guard date.month() == 1 else { return false }
      guard date.day() == 2 else { return false }
      guard date.hour() == 3 else { return false }
      guard date.minute() == 46 else { return false }
      guard date.second() == 40 else { return false }
      guard date.nanosecond() == 123450040 else { return false }
      return true
    }
  }

  func testMonth() {
    var date = Date(timeIntervalSince1970: 100000.123450040)
    XCTAssertEqual(date.month(), 1)

    var isLowerComponentsValid: Bool {
      guard date.day() == 2 else { return false }
      guard date.hour() == 3 else { return false }
      guard date.minute() == 46 else { return false }
      guard date.second() == 40 else { return false }
      guard date.nanosecond() == 123450040 else { return false }
      return true
    }
  }

  func testDay() {
    var date = Date(timeIntervalSince1970: 100000.123450040)
    XCTAssertEqual(date.day(), 2)

    var isLowerComponentsValid: Bool {
      guard date.hour() == 3 else { return false }
      guard date.minute() == 46 else { return false }
      guard date.second() == 40 else { return false }
      guard date.nanosecond() == 123450040 else { return false }
      return true
    }
  }

  func testWeekday() {
    let date = Date(timeIntervalSince1970: 100000)
    XCTAssertEqual(date.weekday(), 6)
  }

  func testHour() {
    var date = Date(timeIntervalSince1970: 100000.123450040)
    XCTAssertEqual(date.hour(), 3)

    var isLowerComponentsValid: Bool {
      guard date.minute() == 46 else { return false }
      guard date.second() == 40 else { return false }
      guard date.nanosecond() == 123450040 else { return false }
      return true
    }
  }

  func testMinute() {
    var date = Date(timeIntervalSince1970: 100000.123450040)
    XCTAssertEqual(date.minute(), 46)

    var isLowerComponentsValid: Bool {
      guard date.second() == 40 else { return false }
      guard date.nanosecond() == 123450040 else { return false }
      return true
    }
  }

  func testSecond() {
    var date = Date(timeIntervalSince1970: 100000.123450040)
    XCTAssertEqual(date.second(), 40)

    var isLowerComponentsValid: Bool {
      guard date.nanosecond() == 123450040 else { return false }
      return true
    }
  }

  func testNanosecond() {
    let date = Date(timeIntervalSince1970: 100000.123450040)
    XCTAssertEqual(date.nanosecond(), 123450040)
  }

  func testMillisecond() {
    let date = Date(timeIntervalSince1970: 0)
    XCTAssertEqual(date.millisecond(), 0)
  }

  func testIsInFuture() {
    let oldDate = Date(timeIntervalSince1970: 512) // 1970-01-01T00:08:32.000Z
    let futureDate = Date(timeIntervalSinceNow: 512)

    XCTAssert(futureDate.isInFuture)
    XCTAssertFalse(oldDate.isInFuture)
  }

  func testIsInPast() {
    let oldDate = Date(timeIntervalSince1970: 512) // 1970-01-01T00:08:32.000Z
    let futureDate = Date(timeIntervalSinceNow: 512)

    XCTAssert(oldDate.isInPast)
    XCTAssertFalse(futureDate.isInPast)
  }

  func testIsInToday() {
    XCTAssert(Date().isInToday())
    let tomorrow = Date().adding(.day, value: 1)
    XCTAssertFalse(tomorrow.isInToday())
    let yesterday = Date().adding(.day, value: -1)
    XCTAssertFalse(yesterday.isInToday())
  }

  func testIsInYesterday() {
    XCTAssertFalse(Date().isInYesterday())
    let tomorrow = Date().adding(.day, value: 1)
    XCTAssertFalse(tomorrow.isInYesterday())
    let yesterday = Date().adding(.day, value: -1)
    XCTAssert(yesterday.isInYesterday())
  }

  func testIsInTomorrow() {
    XCTAssertFalse(Date().isInTomorrow())
    let tomorrow = Date().adding(.day, value: 1)
    XCTAssert(tomorrow.isInTomorrow())
    let yesterday = Date().adding(.day, value: -1)
    XCTAssertFalse(yesterday.isInTomorrow())
  }

  func testIsInWeekend() {
    let date = Date()
    XCTAssertEqual(date.isInWeekend(), Calendar.current.isDateInWeekend(date))
  }

  func testIsWorkday() {
    let date = Date()
    XCTAssertEqual(date.isWorkday(), !Calendar.current.isDateInWeekend(date))
  }

  func testIsInCurrentWeek() {
    let date = Date()
    XCTAssert(date.isInCurrentWeek())
    let dateOneYearFromNow = date.adding(.year, value: 1)
    XCTAssertFalse(dateOneYearFromNow.isInCurrentWeek())
  }

  func testIsInCurrentMonth() {
    let date = Date()
    XCTAssert(date.isInCurrentMonth())
    let dateOneYearFromNow = date.adding(.year, value: 1)
    XCTAssertFalse(dateOneYearFromNow.isInCurrentMonth())
  }

  func testIsInCurrentYear() {
    let date = Date()
    XCTAssert(date.isInCurrentYear())
    let dateOneYearFromNow = date.adding(.year, value: 1)
    XCTAssertFalse(dateOneYearFromNow.isInCurrentYear())
  }

  func testiso8601Representation() {
    let date = Date(timeIntervalSince1970: 512) // 1970-01-01T00:08:32.000Z
    XCTAssertEqual(date.iso8601Representation, "1970-01-01T00:08:32.000Z")
  }

  func testUnixTimestamp() {
    let date = Date()
    XCTAssertEqual(date.unixTimestamp, date.timeIntervalSince1970)

    let date2 = Date(timeIntervalSince1970: 100)
    XCTAssertEqual(date2.unixTimestamp, 100)
  }

  func testAdding() {
    let date = Date(timeIntervalSince1970: 3610) // Jan 1, 1970, 3:00:10 AM
    XCTAssertEqual(date.adding(.second, value: 0), date)
    let date1 = date.adding(.second, value: 10)
    XCTAssertEqual(date1.second(), date.second() + 10)
    XCTAssertEqual(date1.adding(.second, value: -10), date)

    XCTAssertEqual(date.adding(.minute, value: 0), date)
    let date2 = date.adding(.minute, value: 10)
    XCTAssertEqual(date2.minute(), date.minute() + 10)
    XCTAssertEqual(date2.adding(.minute, value: -10), date)

    XCTAssertEqual(date.adding(.hour, value: 0), date)
    let date3 = date.adding(.hour, value: 2)
    XCTAssertEqual(date3.hour(), date.hour() + 2)
    XCTAssertEqual(date3.adding(.hour, value: -2), date)

    XCTAssertEqual(date.adding(.day, value: 0), date)
    let date4 = date.adding(.day, value: 2)
    XCTAssertEqual(date4.day(), date.day() + 2)
    XCTAssertEqual(date4.adding(.day, value: -2), date)

    XCTAssertEqual(date.adding(.weekOfYear, value: 0), date)
    let date5 = date.adding(.weekOfYear, value: 1)
    XCTAssertEqual(date5.day(), date.day() + 7)
    XCTAssertEqual(date5.adding(.weekOfYear, value: -1), date)

    XCTAssertEqual(date.adding(.weekOfMonth, value: 0), date)
    let date6 = date.adding(.weekOfMonth, value: 1)
    XCTAssertEqual(date6.day(), date.day() + 7)
    XCTAssertEqual(date6.adding(.weekOfMonth, value: -1), date)

    XCTAssertEqual(date.adding(.month, value: 0), date)
    let date7 = date.adding(.month, value: 2)
    XCTAssertEqual(date7.month(), date.month() + 2)
    XCTAssertEqual(date7.adding(.month, value: -2), date)

    XCTAssertEqual(date.adding(.year, value: 0), date)
    let date8 = date.adding(.year, value: 4)
    XCTAssertEqual(date8.year(), date.year() + 4)
    XCTAssertEqual(date8.adding(.year, value: -4), date)
  }

  func testAdd() {
    var date = Date(timeIntervalSince1970: 0)

    date.add(.second, value: -1)
    XCTAssertEqual(date.second(), 59)
    date.add(.second, value: 0)
    XCTAssertEqual(date.second(), 59)

    date.add(.second, value: 1)
    XCTAssertEqual(date.second(), 0)

    date.add(.minute, value: -2)
    XCTAssertEqual(date.minute(), 58)
    date.add(.minute, value: 3)
    XCTAssertEqual(date.minute(), 1)
    date.add(.minute, value: -1)
    XCTAssertEqual(date.minute(), 0)

    date.add(.hour, value: -1)
    XCTAssertEqual(date.hour(), 23)
    date.add(.hour, value: 0)
    XCTAssertEqual(date.hour(), 23)
    date.add(.hour, value: 1)
    XCTAssertEqual(date.hour(), 0)

    date.add(.day, value: -1)
    XCTAssertEqual(date.day(), 31)
    date.add(.day, value: 0)
    XCTAssertEqual(date.day(), 31)
    date.add(.day, value: 1)
    XCTAssertEqual(date.day(), 1)

    date.add(.month, value: -1)
    XCTAssertEqual(date.month(), 12)
    date.add(.month, value: 0)
    XCTAssertEqual(date.month(), 12)
    date.add(.month, value: 1)
    XCTAssertEqual(date.month(), 1)

    date = Date(timeIntervalSince1970: 1531480052.2243021)
    date.add(.year, value: -1)
    XCTAssertEqual(date.year(), 2017)
    date.add(.year, value: 0)
    XCTAssertEqual(date.year(), 2017)
    date.add(.year, value: 1)
    XCTAssertEqual(date.year(), 2018)
  }

  func testChanging() {
    let date = Date(timeIntervalSince1970: 0)

    XCTAssertNil(date.changing(.nanosecond, value: -10))
    XCTAssertNotNil(date.changing(.nanosecond, value: 123450040))
    XCTAssertEqual(date.changing(.nanosecond, value: 123450040)?.nanosecond(), 123450040)

    XCTAssertNil(date.changing(.second, value: -10))
    XCTAssertNil(date.changing(.second, value: 70))
    XCTAssertNotNil(date.changing(.second, value: 20))
    XCTAssertEqual(date.changing(.second, value: 20)?.second(), 20)

    XCTAssertNil(date.changing(.minute, value: -10))
    XCTAssertNil(date.changing(.minute, value: 70))
    XCTAssertNotNil(date.changing(.minute, value: 20))
    XCTAssertEqual(date.changing(.minute, value: 20)?.minute(), 20)

    XCTAssertNil(date.changing(.hour, value: -2))
    XCTAssertNil(date.changing(.hour, value: 25))
    XCTAssertNotNil(date.changing(.hour, value: 6))
    XCTAssertEqual(date.changing(.hour, value: 6)?.hour(), 6)

    XCTAssertNil(date.changing(.day, value: -2))
    XCTAssertNil(date.changing(.day, value: 35))
    XCTAssertNotNil(date.changing(.day, value: 6))
    XCTAssertEqual(date.changing(.day, value: 6)?.day(), 6)

    XCTAssertNil(date.changing(.month, value: -2))
    XCTAssertNil(date.changing(.month, value: 13))
    XCTAssertNotNil(date.changing(.month, value: 6))
    XCTAssertEqual(date.changing(.month, value: 6)?.month(), 6)

    XCTAssertNil(date.changing(.year, value: -2))
    XCTAssertNil(date.changing(.year, value: 0))
    XCTAssertNotNil(date.changing(.year, value: 2015))
    XCTAssertEqual(date.changing(.year, value: 2015)?.year(), 2015)

    let date1 = Date()
    let date2 = date1.changing(.weekOfYear, value: 10)
    XCTAssertEqual(date2, Calendar.current.date(bySetting: .weekOfYear, value: 10, of: date1))
  }

  func testDateString() {
    let date = Date(timeIntervalSince1970: 512)
    let formatter = DateFormatter()
    formatter.timeStyle = .none

    formatter.dateStyle = .short
    XCTAssertEqual(date.string(withStyle: .short), formatter.string(from: date))

    formatter.dateStyle = .medium
    XCTAssertEqual(date.string(withStyle: .medium), formatter.string(from: date))

    formatter.dateStyle = .long
    XCTAssertEqual(date.string(withStyle: .long), formatter.string(from: date))

    formatter.dateStyle = .full
    XCTAssertEqual(date.string(withStyle: .full), formatter.string(from: date))

    formatter.dateStyle = .none

    formatter.dateFormat = "dd/MM/yyyy"
    XCTAssertEqual(date.string(withFormat: "dd/MM/yyyy"), formatter.string(from: date))

    formatter.dateFormat = "HH:mm"
    XCTAssertEqual(date.string(withFormat: "HH:mm"), formatter.string(from: date))

    formatter.dateFormat = "dd/MM/yyyy HH:mm"
    XCTAssertEqual(date.string(withFormat: "dd/MM/yyyy HH:mm"), formatter.string(from: date))

    formatter.dateFormat = "iiiii"
    XCTAssertEqual(date.string(withFormat: "iiiii"), formatter.string(from: date))
  }

  func testIsInCurrent() {
    let date = Date()
    let oldDate = Date(timeIntervalSince1970: 512) // 1970-01-01T00:08:32.000Z
    XCTAssert(date.isInCurrent(.second))
    XCTAssertFalse(oldDate.isInCurrent(.second))

    XCTAssert(date.isInCurrent(.minute))
    XCTAssertFalse(oldDate.isInCurrent(.minute))

    XCTAssert(date.isInCurrent(.hour))
    XCTAssertFalse(oldDate.isInCurrent(.hour))

    XCTAssert(date.isInCurrent(.day))
    XCTAssertFalse(oldDate.isInCurrent(.day))

    XCTAssert(date.isInCurrent(.weekOfMonth))
    XCTAssertFalse(oldDate.isInCurrent(.weekOfMonth))

    XCTAssert(date.isInCurrent(.month))
    XCTAssertFalse(oldDate.isInCurrent(.month))

    XCTAssert(date.isInCurrent(.year))
    XCTAssertFalse(oldDate.isInCurrent(.year))

    XCTAssert(date.isInCurrent(.era))
  }

  func testSecondsSince() {
    let date1 = Date(timeIntervalSince1970: 100)
    let date2 = Date(timeIntervalSince1970: 180)
    XCTAssertEqual(date2.secondsSince(date1), 80)
    XCTAssertEqual(date1.secondsSince(date2), -80)
  }

  func testMinutesSince() {
    let date1 = Date(timeIntervalSince1970: 120)
    let date2 = Date(timeIntervalSince1970: 180)
    XCTAssertEqual(date2.minutesSince(date1), 1)
    XCTAssertEqual(date1.minutesSince(date2), -1)
  }

  func testHoursSince() {
    let date1 = Date(timeIntervalSince1970: 3600)
    let date2 = Date(timeIntervalSince1970: 7200)
    XCTAssertEqual(date2.hoursSince(date1), 1)
    XCTAssertEqual(date1.hoursSince(date2), -1)
  }

  func testDaysSince() {
    let date1 = Date(timeIntervalSince1970: 0)
    let date2 = Date(timeIntervalSince1970: 86400)
    XCTAssertEqual(date2.daysSince(date1), 1)
    XCTAssertEqual(date1.daysSince(date2), -1)
  }

  func testIsBetween() {
    let date1 = Date(timeIntervalSince1970: 0)
    let date2 = date1.addingTimeInterval(60)
    let date3 = date2.addingTimeInterval(60)

    XCTAssert(date2.isBetween(date1, date3))
    XCTAssertFalse(date1.isBetween(date2, date3))
    XCTAssert(date1.isBetween(date1, date2, includingBounds: true))
    XCTAssertFalse(date1.isBetween(date1, date2))
  }

  func testIsWithin() {
    let date1 = Date(timeIntervalSince1970: 60 * 60 * 24) // 1970-01-01T00:00:00.000Z
    let date2 = date1.addingTimeInterval(60 * 60) // 1970-01-01T00:01:00.000Z, one hour later than date1
    // The regular
    XCTAssertFalse(date1.isWithin(1, .second, of: date2))
    XCTAssertFalse(date1.isWithin(1, .minute, of: date2))
    XCTAssert(date1.isWithin(1, .hour, of: date2))
    XCTAssert(date1.isWithin(1, .day, of: date2))

    // The other way around
    XCTAssertFalse(date2.isWithin(1, .second, of: date1))
    XCTAssertFalse(date2.isWithin(1, .minute, of: date1))
    XCTAssert(date2.isWithin(1, .hour, of: date1))
    XCTAssert(date2.isWithin(1, .day, of: date1))

    // With itself
    XCTAssert(date1.isWithin(1, .second, of: date1))
    XCTAssert(date1.isWithin(1, .minute, of: date1))
    XCTAssert(date1.isWithin(1, .hour, of: date1))
    XCTAssert(date1.isWithin(1, .day, of: date1))

    // Invalid
    XCTAssertFalse(Date().isWithin(1, .calendar, of: Date()))
  }

  func testNewDateFromIso8601String() {
    let date = Date(timeIntervalSince1970: 512) // 1970-01-01T00:08:32.000Z
    let dateFromIso8601 = Date(iso8601String: "1970-01-01T00:08:32.000Z")
    XCTAssertEqual(date, dateFromIso8601)
    XCTAssertNil(Date(iso8601String: "hello"))
  }

  func testNewDateFromUnixTimestamp() {
    let date = Date(timeIntervalSince1970: 512) // 1970-01-01T00:08:32.000Z
    let dateFromUnixTimestamp = Date(unixTimestamp: 512)
    XCTAssertEqual(date, dateFromUnixTimestamp)
  }

  func testRandom() {
    var randomDate = Date.random()
    XCTAssertTrue(randomDate.isBetween(Date.distantPast, Date.distantFuture, includingBounds: true))

    var date = Date(timeIntervalSinceReferenceDate: 0)
    randomDate = Date.random(from: date)
    XCTAssertTrue(randomDate.isBetween(date, Date.distantFuture, includingBounds: true))

    date = Date(timeIntervalSince1970: 10000)
    randomDate = Date.random(from: date)
    XCTAssertTrue(randomDate.isBetween(date, Date.distantFuture, includingBounds: true))

    date = Date(timeIntervalSince1970: -10000)
    randomDate = Date.random(from: date)
    XCTAssertTrue(randomDate.isBetween(date, Date.distantFuture, includingBounds: true))

    date = Date(timeIntervalSinceReferenceDate: 0)
    randomDate = Date.random(upTo: date)
    XCTAssertTrue(randomDate.isBetween(Date.distantPast, date, includingBounds: true))

    date = Date(timeIntervalSince1970: 10000)
    randomDate = Date.random(upTo: date)
    XCTAssertTrue(randomDate.isBetween(Date.distantPast, date, includingBounds: true))

    date = Date(timeIntervalSince1970: -10000)
    randomDate = Date.random(upTo: date)
    XCTAssertTrue(randomDate.isBetween(Date.distantPast, date, includingBounds: true))

    var sinceDate = Date(timeIntervalSinceReferenceDate: 0)
    var toDate = Date(timeIntervalSinceReferenceDate: 10000)
    randomDate = Date.random(from: sinceDate, upTo: toDate)
    XCTAssertTrue(randomDate.isBetween(sinceDate, toDate, includingBounds: true))

    sinceDate = Date(timeIntervalSince1970: -10000)
    toDate = Date(timeIntervalSince1970: -10)
    randomDate = Date.random(from: sinceDate, upTo: toDate)
    XCTAssertTrue(randomDate.isBetween(sinceDate, toDate, includingBounds: true))

    sinceDate = Date(timeIntervalSinceReferenceDate: -1000)
    toDate = Date(timeIntervalSinceReferenceDate: 10000)
    randomDate = Date.random(from: sinceDate, upTo: toDate)
    XCTAssertTrue(randomDate.isBetween(sinceDate, toDate, includingBounds: true))

    sinceDate = Date(timeIntervalSinceReferenceDate: 0)
    toDate = sinceDate
    randomDate = Date.random(from: sinceDate, upTo: toDate)
    XCTAssertTrue(randomDate.isBetween(sinceDate, toDate, includingBounds: true))
  }

}
