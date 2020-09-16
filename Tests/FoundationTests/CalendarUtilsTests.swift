import XCTest
@testable import Mechanica

extension CalendarUtilsTests {
  static var allTests = [
    // ("testQuarter", testQuarter),
    // ("testIsDateInCurrentWeek", testIsDateInCurrentWeek), // TODO: crash on Swift 5
     ("testIsDateInWorkDay", testIsDateInWorkDay),
    //("testIsDateInCurrentMonth", testIsDateInCurrentMonth), // TODO: crash on Swift 5
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

  func testIsDateInCurrentWeek() {
    let date = Date()

    let newDate = calendar.date(byAdding: .month, value: 1, to: date)!
    XCTAssertFalse(calendar.isDateInCurrentWeek(newDate))

    XCTAssertTrue(calendar.isDateInCurrentWeek(date)) // unless the test is run between two months...  }
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

  #endif

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
}


