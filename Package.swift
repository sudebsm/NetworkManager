// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "NetworkingKit",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "NetworkingKit",
            targets: ["NetworkingKit"]
        ),
    ],
    targets: [
        .target(
            name: "NetworkingKit",
            dependencies: [],
            path: "Sources/NetworkingKit"
        ),
        .testTarget(
            name: "NetworkingKitTests",
            dependencies: ["NetworkingKit"],
            path: "Tests/NetworkingKitTests"
        )
    ]
)
