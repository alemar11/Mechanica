import XCTest
@testable import StandardLibraryTests

XCTMain([
  testCase(BinaryFloatingPointUtilsTests.allTests),
  testCase(BinaryIntegerUtilsTests.allTests),
  testCase(BoolUtilsTests.allTests),
  testCase(CollectionUtilsTests.allTests),
  testCase(DictionaryUtilsTests.allTests),
  testCase(FixedWidthIntegerIntervalRandomizableTests.allTests),
  testCase(FloatingPointUtilsTests.allTests),
  testCase(OperatorsTests.allTests),
  testCase(OptionalUtilsTests.allTests)
  ])
