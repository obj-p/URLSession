// swift-tools-version:5.10

import PackageDescription

let package = Package(
    name: "URLSession",
    platforms: [
        .iOS(.v17),
        .macOS(.v13),
    ],
    products: [
        .library(name: "HTTP", targets: ["HTTP"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.96.0"),
    ],
    targets: [
        .target(name: "HTTP"),
        .testTarget(name: "HTTPTests", dependencies: ["HTTP"]),
        .executableTarget(
            name: "MockServer",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
            ]
        ),
    ]
)
