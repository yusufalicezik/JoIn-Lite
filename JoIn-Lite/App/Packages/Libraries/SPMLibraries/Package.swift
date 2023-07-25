// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

private let localPackagesPath = ".."

let package = Package(
    name: "SPMLibraries",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SPMLibraries",
            targets: ["SPMLibraries"]),
    ],
    dependencies: [
        // Remote Packages
        .package(
            url: "https://github.com/yusufalicezik/YACNetwork",
            branch: "main"
        ),
        .package(
            url: "https://github.com/onevcat/Kingfisher.git",
            .upToNextMajor(from: "7.0.0")
        ),
        
        //Local Packages
        .package(
            name: "Localization",
            path: localPackagesPath + "/Localization"
        ),
        .package(
            name: "CoreUtils",
            path: localPackagesPath + "/CoreUtils"
        ),
        .package(
            name: "Environment",
            path: localPackagesPath + "/Environment"
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SPMLibraries",
            dependencies: ["YACNetwork", "Kingfisher", "Localization", "CoreUtils", "Environment"]
        ),
        .testTarget(
            name: "SPMLibrariesTests",
            dependencies: ["SPMLibraries"]),
    ]
)
