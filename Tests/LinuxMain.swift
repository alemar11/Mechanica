import XCTest
@testable import StandardLibraryTests

XCTMain([
  testCase(BinaryFloatingPointUtilsTests.allTests),
  testCase(BinaryIntegerUtilsTests.allTests),
  testCase(BoolUtilsTests.allTests),
  //testCase(FixedWidthIntegerIntervalRandomizableTests.allTests)
  ])
