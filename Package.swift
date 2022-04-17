// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LeetCodeCollection",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "LeetCodeCollection",
            targets: ["LeetCodeCollection"]),
    ],
    dependencies: [
        .package(
              url: "https://github.com/apple/swift-collections.git",
              .upToNextMajor(from: "1.0.0") // or `.upToNextMinor
            )
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "LeetCodeCollection",
            dependencies: [ .product(name: "Collections", package: "swift-collections")]),
        .testTarget(
            name: "LeetCodeCollectionTests",
            dependencies: ["LeetCodeCollection"]),
    ]
)
