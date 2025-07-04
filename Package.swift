// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftRadler",
    platforms: [
      .iOS(.v15), .tvOS(.v15), .macOS(.v12)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "SwiftRadler",
            targets: ["SwiftRadler"]),
        .library(
            name: "SwiftRadlerMSAL",
            targets: ["SwiftRadlerMSAL"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
      .package(name: "MSAL", url: "https://github.com/AzureAD/microsoft-authentication-library-for-objc.git", from: "2.1.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "SwiftRadler",
            dependencies: []),
        .target(
            name: "SwiftRadlerMSAL",
            dependencies: ["SwiftRadler", "MSAL"]),
        .testTarget(
            name: "SwiftRadlerTests",
            dependencies: ["SwiftRadler", "SwiftRadlerMSAL"]),
    ]
)
