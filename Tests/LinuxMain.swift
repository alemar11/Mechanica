import XCTest
@testable import StandardLibraryTests
@testable import FoundationTests

XCTMain([
  testCase(BinaryFloatingPointUtilsTests.allTests),
  testCase(BinaryIntegerUtilsTests.allTests),
  testCase(BoolUtilsTests.allTests),
  testCase(CollectionUtilsTests.allTests),
  testCase(DictionaryUtilsTests.allTests),
  testCase(FixedWidthIntegerIntervalRandomizableTests.allTests),
  testCase(FloatingPointUtilsTests.allTests),
  testCase(OperatorsTests.allTests),
  testCase(OptionalUtilsTests.allTests),
  testCase(RangeReplaceableCollectionUtilsTests.allTests),
  testCase(SequenceUtilsTests.allTests),
  testCase(SignedIntegerTests.allTests),
  testCase(StringUtilsTests.allTests),
  testCase(UnsignedIntegerUtilsTests.allTests),
  
  testCase(BundleInfoTests.allTests),
  testCase(DataUtilsTests.allTests),
  testCase(DictionaryFoundationUtilsTests.allTests),
  testCase(FileManagerUtilsTests.allTests)
  ])
