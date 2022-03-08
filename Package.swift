// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Tourism",
    platforms: [.iOS(.v14), .macOS(.v10_15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Tourism",
            targets: ["Tourism"]),
    ],
    dependencies: [
        .package(name: "Realm", url: "https://github.com/realm/realm-cocoa.git", from: "5.4.4"),
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.2.0")),
        .package(url: "https://github.com/aripratom/Core", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/square/Cleanse", .upToNextMajor(from: "4.2.6")),
        .package(url: "https://github.com/ReactiveX/RxSwift", .upToNextMajor(from: "6.5.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Tourism",
            dependencies: [
                .product(name: "RealmSwift", package: "Realm"),
                "Core",
                "Alamofire",
                "Cleanse",
                "RxSwift"
            ]),
        .testTarget(
            name: "TourismTests",
            dependencies: ["Tourism"]),
    ]
)
