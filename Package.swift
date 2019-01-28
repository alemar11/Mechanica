// swift-tools-version:5.0.0

import PackageDescription

let package = Package(
  name: "Mechanica",
  products: [
    .library(name: "Mechanica", targets: ["Mechanica"])
  ],
  targets: [
    .target(name: "Mechanica", path: "Sources"),
    .testTarget(name: "FoundationTests", dependencies: ["Mechanica"]),
    .testTarget(name: "SharedTests", dependencies: ["Mechanica"]),
    .testTarget(name: "StandardLibraryTests", dependencies: ["Mechanica"]),
    .testTarget(name: "UIKitTests", dependencies: ["Mechanica"]),
    .testTarget(name: "AppKitTests", dependencies: ["Mechanica"]),
    .testTarget(name: "AVFoundationTests", dependencies: ["Mechanica"])
  ],
  swiftLanguageVersions: [.v5]
)

#if os(Linux)

package.targets = [
  .target(name: "Mechanica",
          path: "Sources",
          exclude: ["BundleInfoTests.swift"],
          sources: ["StandardLibrary", "Foundation"]
  ),
  .testTarget(name: "StandardLibraryTests", dependencies: ["Mechanica"]),
  .testTarget(name: "FoundationTests",
              dependencies: ["Mechanica"],
              exclude: ["BundleInfoTests.swift"]
  )
]

#endif
