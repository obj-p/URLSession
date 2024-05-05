// swift-tools-version:5.10

import PackageDescription

let package = Package(
    name: "URLSession",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "HTTP", targets: ["HTTP"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "HTTP"),
        .testTarget(name: "HTTPTests", dependencies: ["HTTP"]),
    ]
)
