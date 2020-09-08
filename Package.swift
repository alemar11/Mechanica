// swift-tools-version:5.2

import PackageDescription

let package = Package(name: "Mechanica")
package.products = [.library(name: "Mechanica", targets: ["Mechanica"])]
package.targets = [
  .target(name: "Mechanica", path: "Sources"),
  .testTarget(name: "FoundationTests", dependencies: ["Mechanica"]),
  .testTarget(name: "SharedTests", dependencies: ["Mechanica"]),
  .testTarget(name: "StandardLibraryTests", dependencies: ["Mechanica"]),
  .testTarget(name: "UIKitTests", dependencies: ["Mechanica"]),
  .testTarget(name: "AppKitTests", dependencies: ["Mechanica"]),
  .testTarget(name: "AVFoundationTests", dependencies: ["Mechanica"])
]
package.swiftLanguageVersions = [.v5]
package.platforms = [.macOS(.v10_14), .iOS(.v12), .tvOS(.v12), .watchOS(.v5)]

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
