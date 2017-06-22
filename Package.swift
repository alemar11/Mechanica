// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "Mechanica",
    targets:
        [
          Target(name: "Mechanica")
        ],
    //dependencies : [],
    exclude: ["Tests/CoreDataTests"]
)
