// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "QuickHatch",
    platforms: [.iOS(.v11),
                .watchOS(.v5),
                .macOS(.v10_10),
                .tvOS(.v12)],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "QuickHatch",
            targets: ["QuickHatch"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "QuickHatch",
            dependencies: [],
            path: "Sources"),
        .testTarget(
            name: "QuickHatchTests",
            dependencies: ["QuickHatch"],
        path: "Tests"),
    ]
)
