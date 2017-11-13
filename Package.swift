// swift-tools-version:4.0

import PackageDescription

let package = Package(
  name: "Mechanica",
  products: [
    // Products define the executables and libraries produced by a package, and make them visible to other packages.
    .library(name: "Mechanica", targets: ["StandardLibrary"])
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages which this package depends on.

    .target(name: "StandardLibrary"),
   .testTarget(name: "StandardLibraryTests", dependencies: ["StandardLibrary"]),

//    .target(name: "Mechanica", path: "Sources"),
//    .testTarget(name: "FoundationTests", dependencies: ["Mechanica"]),
//    .testTarget(name: "SharedTests", dependencies: ["Mechanica"]),
//    .testTarget(name: "StandardLibraryTests", dependencies: ["Mechanica"]),
//    .testTarget(name: "UIKitTests", dependencies: ["Mechanica"])
  ]
)
