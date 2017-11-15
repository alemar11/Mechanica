import XCTest
@testable import StandardLibraryTests

XCTMain([
  testCase(BinaryFloatingPointUtilsTests.allTests),
  testCase(BoolUtilsTests.allTests),
  //testCase(FixedWidthIntegerIntervalRandomizableTests.allTests)
  ])
