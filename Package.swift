// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Swiki",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .tvOS(.v16),
        .watchOS(.v9)
    ],
    products: [
        .library(
            name: "Swiki",
            targets: ["Swiki", "SwikiModels"]),
        .library(
            name: "SwikiModels",
            targets: ["SwikiModels"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/GraphQLSwift/GraphQL", .upToNextMajor(from: "4.1.0")),
        .package(url: "https://github.com/apple/swift-argument-parser", .upToNextMajor(from: "1.7.0"))
    ],
    targets: [
        .executableTarget(
            name: "SwikiGraphQLOperationGenerator",
            dependencies: [
                .product(name: "GraphQL", package: "GraphQL"),
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]
        ),
        .target(
            name: "Swiki",
            dependencies: [
                "SwikiModels"
            ],
            swiftSettings: [.swiftLanguageMode(.v6)]
        ),
        .target(
            name: "SwikiModels",
            dependencies: [
                .product(name: "GraphQL", package: "GraphQL")
            ],
            exclude: [
                "schema.graphql"
            ]
        ),
        .testTarget(
            name: "SwikiTests",
            dependencies: ["Swiki", "SwikiModels"]
        ),
    ]
)
