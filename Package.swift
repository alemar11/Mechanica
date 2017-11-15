// swift-tools-version:4.0

import PackageDescription

let package = Package(
  name: "Mechanica",
  products: [
    // Products define the executables and libraries produced by a package, and make them visible to other packages.
    //.library(name: "Mechanica", targets: ["Mechanica"])
    .library(name: "Mechanica", targets: ["Mechanica"])
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages which this package depends on.

    .target(name: "Mechanica", path: "Sources"),
    .testTarget(name: "FoundationTests", dependencies: ["Mechanica"]),
    .testTarget(name: "SharedTests", dependencies: ["Mechanica"]),
    .testTarget(name: "StandardLibraryTests", dependencies: ["Mechanica"]),
    .testTarget(name: "UIKitTests", dependencies: ["Mechanica"])

    /*
     .target(name: "Mechanica", path: "Sources/StandardLibrary", sources: [
     "BinaryFloatingPoint+Utils.swift",
     "BinaryInteger+Utils.swift",
     "Bool+Utils.swift",
     "Character+Utils.swift",
     "Collection+Utils.swift",
     "Dictionary+Utils.swift",
     "ExpressibleByIntegerLiteral+Utils.swift",
     "FixedWidthInteger+Utils.swift",
     "FixedWidthIntegerRandomizable.swift",
     "FloatingPoint+Utils.swift",
     "Operators.swift",
     "Optional+Utils.swift",
     "RangeReplaceableCollection+Utils.swift",
     "Sequence+Utils.swift",
     "SignedInteger.swift",
     "String+Utils.swift",
     "Unicode+Utils.swift"
     ]),

     .testTarget(name: "StandardLibraryTests", dependencies: ["Mechanica"], sources: [
     "BinaryFloatingPointUtilsTests.swift",
     "BinaryIntegerUtilsTests.swift",
     "BoolUtilsTests.swift",
     "CollectionUtilsTests.swift",
     "DictionaryUtilsTests.swift",
     "FixedWidthIntegerRandomizableTests.swift",
     "FloatingPointUtilsTests.swift",
     "OperatorsTests.swift",
     "OptionalUtilsTests.swift",
     "RangeReplaceableCollectionUtilsTests.swift",
     "SequenceUtilsTests.swift",
     "SignedIntegerUtilsTests.swift",
     "StringUtilsTests.swift",
     "UnsignedIntegerUtilsTests.swift"
     ]),
     */

  ]
)

#if os(Linux)

package.targets = [
  .library(name: "Mechanica", targets: ["Mechanica"])
  .target(name: "Mechanica", path: "Sources/SwiftStandardLibrary"),
  .testTarget(name: "StandardLibraryTests", dependencies: ["Mechanica"], path: "Tests/SQLiteTests")
]
  
#endif
