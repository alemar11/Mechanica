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
  testCase(FileManagerUtilsTests.allTests),
  testCase(FoundationUtilsTests.allTests),
  testCase(LocaleUtilsTests.allTests),
  testCase(NSObjectProtocolUtils.allTests),
  testCase(NSPredicateUtilsTests.allTests),
  testCase(StatUtilsTests.allTests),
  testCase(StringFoundationUtilsTests.allTests),
  testCase(URLUtilsTests.allTests),
  //testCase(UserDefaultsUtilsTests.allTests)
  ])


/**
 * Missing files:
 * FoundationUtils.swift
*/
