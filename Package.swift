// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "IBGraph",
    products: [
        .executable(
            name: "ibgraph", targets: ["IBGraph"]
        ),
        .library(
            name: "IBGraphKit", targets: ["IBGraphKit"]
        ),
        .library(
            name: "IBGraphFrontend", targets: ["IBGraphFrontend"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/ferranpujolcamins/DotSwift.git", .revision("HEAD")),
        .package(url: "https://github.com/IBDecodable/IBDecodable.git", .revision("HEAD")),
        .package(url: "https://github.com/Carthage/Commandant.git", .upToNextMinor(from: "0.17.0")),
        .package(url: "https://github.com/jpsim/Yams.git", .upToNextMinor(from: "2.0.0")),
        .package(url:"https://github.com/kylef/PathKit.git", .upToNextMinor(from:"1.0.0"))
    ],
    targets: [
        .target(
            name: "IBGraph",
            dependencies: ["IBGraphKit", "IBGraphFrontend"],
            path: "Sources/IBGraph"
        ),
        .target(
            name: "IBGraphKit",
            dependencies: ["Commandant", "DotSwiftAttributes", "DotSwiftEncoder", "SwiftGraphBindings", "IBDecodable", "Yams"],
            path: "Sources/IBGraphKit"
        ),
        .target(
            name: "IBGraphFrontend",
            dependencies: [ "IBGraphKit", "PathKit"],
            path: "Sources/IBGraphFrontend"
        ),
        .testTarget(
            name: "IBGraphTests",
            dependencies: ["IBGraph", "IBGraphKit"],
            path: "Tests"
        )
    ]
)
