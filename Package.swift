// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "swabble",
    platforms: [
        .macOS(.v26),
    ],
    dependencies: [
        .package(path: "../Peekaboo/Commander"),
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
            dependencies: ["swabble"]),
    ],
    swiftLanguageModes: [.v6]
)
