// swift-tools-version:5.10

import PackageDescription

let package = Package(
    name: "URLSession",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "SSE", targets: ["SSE"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "SSE"),
        .testTarget(name: "SSETests", dependencies: ["SSE"]),
    ]
)
