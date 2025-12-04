// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "swabble",
    platforms: [
        .macOS(.v26),
    ],
    dependencies: [
        .package(path: "../Peekaboo/Commander"),
        .package(url: "https://github.com/apple/swift-testing", from: "0.99.0"),
    ],
    targets: [
        .executableTarget(
            name: "swabble",
            dependencies: [
                .product(name: "Commander", package: "Commander"),
            ],
            path: "Sources"),
        .testTarget(
            name: "swabbleTests",
            dependencies: [
                "swabble",
                .product(name: "Testing", package: "swift-testing"),
            ]),
    ],
    swiftLanguageModes: [.v6]
)
