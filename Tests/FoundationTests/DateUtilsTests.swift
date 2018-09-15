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

extension DateUtilsTests {
  static var allTests = [
    ("testIsInFuture", testIsInFuture),
    ("testIsInPast", testIsInPast),
    ("testSecondsSince", testSecondsSince),
    ("testMinutesSince", testMinutesSince),
    ("testHoursSince", testHoursSince),
    ("testDaysSince", testDaysSince),
    ("testIsBetween", testIsBetween),
    ("testNewDateFromUnixTimestamp", testNewDateFromUnixTimestamp),
    ("testRandom", testRandom)
  ]
}

final class DateUtilsTests: XCTestCase {

  override func setUp() {
    super.setUp()
    NSTimeZone.default = TimeZone(abbreviation: "UTC")!
  }

  func testIsInFuture() {
    let oldDate = Date(timeIntervalSince1970: 512) // 1970-01-01T00:08:32.000Z
    let futureDate = Date(timeIntervalSinceNow: 512)

    XCTAssert(futureDate.isFuture)
    XCTAssertFalse(oldDate.isFuture)
  }

  func testIsInPast() {
    let oldDate = Date(timeIntervalSince1970: 512) // 1970-01-01T00:08:32.000Z
    let futureDate = Date(timeIntervalSinceNow: 512)

    XCTAssert(oldDate.isPast)
    XCTAssertFalse(futureDate.isPast)
  }


  // MARK: - Utilities

  func testUnixTimestamp() {
    let date = Date()
    XCTAssertEqual(date.unixTimestamp, date.timeIntervalSince1970)

    let date2 = Date(timeIntervalSince1970: 100)
    XCTAssertEqual(date2.unixTimestamp, 100)
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
