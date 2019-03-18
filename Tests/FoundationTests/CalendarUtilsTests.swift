//
// Mechanica
//
// Copyright © 2016-2019 Tinrobots.
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

extension CalendarUtilsTests {
  static var allTests = [
    // ("testQuarter", testQuarter),
    ("testIsDateInCurrentWeek", testIsDateInCurrentWeek), // TODO: crash on Swift 5
    ("testIsDateInWorkDay", testIsDateInWorkDay),
    ("testIsDateInCurrentMonth", testIsDateInCurrentMonth), // TODO: crash on Swift 5
    // ("testIsDateInCurrentYear", testIsDateInCurrentYear) //TODO enumerateDates(startingAfter:matching:options:using:) is not yet implemented (Swift 4.1.2)
  ]
}

final class CalendarUtilsTests: XCTestCase {

  let calendar = Calendar.current

  #if os(iOS) || os(tvOS) || os(watchOS) || os(macOS)
  func testQuarter() {
    let date1 = Date(timeIntervalSince1970: 0)
    XCTAssertEqual(calendar.quarter(from: date1), 1)

    let date2 = Calendar.current.date(byAdding: .month, value: 4, to: date1)!
    XCTAssertEqual(calendar.quarter(from: date2), 2)

    let date3 = Calendar.current.date(byAdding: .month, value: 8, to: date1)!
    XCTAssertEqual(calendar.quarter(from: date3), 3)

    let date4 = Calendar.current.date(byAdding: .month, value: 11, to: date1)!
    XCTAssertEqual(calendar.quarter(from: date4), 4)
  }
  #endif

  func testIsDateInCurrentWeek() {
    let date = Date()

    let newDate = calendar.date(byAdding: .month, value: 1, to: date)!
    XCTAssertFalse(calendar.isDateInCurrentWeek(newDate))

    XCTAssertTrue(calendar.isDateInCurrentWeek(date)) // unless the test is run between two months...  }
  }

  func testIsDateInWorkDay() {
    let components = DateComponents(calendar: calendar,
                                    timeZone: TimeZone(abbreviation: "UTC"),
                                    year: 2018,
                                    month: 7,
                                    day: 14)
    let date = calendar.date(from: components)!
    XCTAssertFalse(calendar.isDateInWorkDay(date))

    let newDate = calendar.date(byAdding: .day, value: 2, to: date)!
    XCTAssertTrue(calendar.isDateInWorkDay(newDate))
  }

  func testIsDateInCurrentMonth() {
    let date = Date()

    let newDate = calendar.date(byAdding: .month, value: 1, to: date)!
    XCTAssertFalse(calendar.isDateInCurrentMonth(newDate))

    XCTAssertTrue(calendar.isDateInCurrentMonth(date)) // unless the test is run between two months...
  }

  func testIsDateInCurrentYear() {
    let date = Date()
    let year = calendar.component(.year, from: Date())

    let newDate = calendar.date(bySetting: .year, value: year + 1, of: date)!
    XCTAssertFalse(calendar.isDateInCurrentYear(newDate))


    let newDate2 = calendar.date(bySetting: .year, value: year, of: date)!
    XCTAssertTrue(calendar.isDateInCurrentYear(newDate2))
  }

}


