// swift-tools-version:4.0

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
    .testTarget(name: "AppKitTests", dependencies: ["Mechanica"])
  ],
  swiftLanguageVersions: [4]
)

#if os(Linux)

package.targets = [
  .target(name: "Mechanica",
          path: "Sources",
          exclude: ["AssociatedValueSupporting.swift", "BundleInfoTests.swift", "NSObjectProtocol+Swizzling.swift"],
          sources: ["StandardLibrary", "Foundation"]
  ),
  .testTarget(name: "StandardLibraryTests", dependencies: ["Mechanica"]),
  .testTarget(name: "FoundationTests",
              dependencies: ["Mechanica"],
              exclude: ["AssociatedValueSupportingTests.swift",
                        "BundleInfoTests.swift",
                        "NSAttributedStringUtilsTests.swift",
                        "NSMutableAttributedStringUtilsTests.swift",
                        "NSObjectProtocolSwizzlingTests.swift",
                        "UserDefaultsUtilsTests.swift"
    ]
  )
]

#endif
