// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "Inspector",
    products: [
        .library(
            name: "Inspector",
            targets: ["Inspector"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Inspector",
            dependencies: []),
        .testTarget(
            name: "InspectorTests",
            dependencies: ["Inspector"]),
    ]
)
