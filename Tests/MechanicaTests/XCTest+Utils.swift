//
//  XCTest+Utils.swift
//  Mechanica
//
//  Copyright © 2016-2017 Tinrobots.
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
import Foundation

// MARK: - XCTest Extension

extension XCTest {

  /// **Mechanica**
  ///
  /// Returns the current XCTest Bundle.
  var unitTestBundle: Bundle {
    // swift 4
    return Bundle(for: self.classForCoder)
  }

}

// MARK: - XCTAssert Additions

/// **Mechanica**
///
/// Asserts that an expression doesn't throw.
///
/// - Parameters:
///   - expression: An expression of type Void.
///   - message: An optional description of the failure.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
func XCTAssertNoThrows(_ expression: @autoclosure () throws -> Void, _ message: String = "", file: StaticString = #file, line: UInt = #line) -> Bool {
  var ok = false
  do {
    try expression()
    ok = true
  } catch {
    let failMessage = "Unexpected exception: \(error). \(message)"
    XCTFail(failMessage, file: file, line: line)
  }
  return ok
}

/// **Mechanica**
///
/// Asserts that an expression doesn't throw.
///
/// - Parameters:
///   - expression: An expression of generic type T.
///   - message: An optional description of the failure.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
func XCTAssertNoThrows<T>(_ expression: @autoclosure () throws -> T, _ message: String = "", file: StaticString = #file, line: UInt = #line) -> T? {
  var t: T? = nil
  do {
    t = try expression()
  } catch {
    let failMessage = "Unexpected exception: \(error). \(message)"
    XCTFail(failMessage, file: file, line: line)
  }
  return t
}

/// **Mechanica**
///
/// Asserts that an expression throws.
///
/// - Parameters:
///   - expression: An expression of generic type T.
///   - message: An optional description of the failure.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
func XCTAssertThrows<T>(_ expression: @autoclosure () throws -> T, _ message: String = "", file: StaticString = #file, line: UInt = #line) {
  do {
    let _ = try expression()
    XCTFail("Expected thrown error", file: file, line: line)
  } catch _ {
  }
}
