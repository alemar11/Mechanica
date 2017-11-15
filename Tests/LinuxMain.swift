import XCTest
@testable import StandardLibraryTests

XCTMain([
  testCase(BoolUtilsTests.allTests),
  testCase(FixedWidthIntegerIntervalRandomizableTests.allTests)
  ])
