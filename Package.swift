// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Inspector",
    products: [
        .library(name: "Inspector", targets: ["Inspector"]),
    ],
    targets: [
        .target(name: "Inspector"),
        //dev .testTarget(name: "InspectorTests", dependencies: ["Inspector"]),
    ]
)
