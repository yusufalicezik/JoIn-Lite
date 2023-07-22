// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoreUtils",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "CoreUtils",
            targets: ["CoreUtils"]),
    ],
    dependencies: [
        // Remote Packages
        .package(
            url: "https://github.com/jrendel/SwiftKeychainWrapper",
            .upToNextMajor(from: "4.0.1")
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "CoreUtils",
            dependencies: ["SwiftKeychainWrapper"]
        ),
        .testTarget(
            name: "CoreUtilsTests",
            dependencies: ["CoreUtils"]),
    ]
)
