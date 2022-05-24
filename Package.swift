// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "About",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "About",
            targets: ["About"]),
    ],
    dependencies: [
         .package(url: "https://github.com/micro-frontends-mobile/Env", from: "0.3.2"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "About",
            dependencies: ["Env"]),
        .testTarget(
            name: "AboutTests",
            dependencies: ["About"]),
    ]
)
