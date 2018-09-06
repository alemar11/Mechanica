import XCTest
@testable import StandardLibraryTests
@testable import FoundationTests

XCTMain([
  // Standard Library
  testCase(BinaryFloatingPointUtilsTests.allTests),
  testCase(BinaryIntegerUtilsTests.allTests),
  testCase(BoolUtilsTests.allTests),
  testCase(CharacterUtilsTests.allTests),
  testCase(CollectionUtilsTests.allTests),
  testCase(DictionaryUtilsTests.allTests),
  testCase(FloatingPointUtilsTests.allTests),
  testCase(OperatorsTests.allTests),
  testCase(OptionalUtilsTests.allTests),
  testCase(RangeReplaceableCollectionUtilsTests.allTests),
  testCase(SequenceUtilsTests.allTests),
  testCase(SignedIntegerTests.allTests),
  testCase(StringUtilsTests.allTests),
  testCase(UnsignedIntegerUtilsTests.allTests),

  // Foundation
  testCase(CalendarUtilsTests.allTests),
  testCase(DataUtilsTests.allTests),
  testCase(DateUtilsTests.allTests),
  testCase(DictionaryFoundationUtilsTests.allTests),
  testCase(FileManagerUtilsTests.allTests),
  testCase(FoundationUtilsTests.allTests),
  testCase(LocaleUtilsTests.allTests),
  testCase(NSObjectProtocolUtils.allTests),
  testCase(NSPredicateUtilsTests.allTests),
  testCase(NSAttributedStringUtilsTests.allTests),
  testCase(NSMutableAttributedStringUtilsTests.allTests),
  testCase(ProcessInfoTests.allTests),
  testCase(StatUtilsTests.allTests),
  testCase(StringFoundationUtilsTests.allTests),
  testCase(URLRequestUtilsTests.allTests),
  testCase(URLUtilsTests.allTests),
  testCase(UserDefaultsUtilsTests.allTests)
  ])


/**
 * Missing files:
 * BundleInfoTests.swift (Foundation)
 * FoundationUtilsTests.swift (Foundation)
*/
