// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "FlowStudioSDK",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "FlowStudioSDK",
            targets: ["FlowStudioSDKWrapper"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/Bureau-Inc/bureau-id-fraud-sdk.git", from: "4.0.1")
    ],
    targets: [
        .binaryTarget(
            name: "FlowStudioSDK",
            path: "FlowStudioSDK.xcframework"
        ),
        .target(
            name: "FlowStudioSDKWrapper",
            dependencies: [
                "FlowStudioSDK",
                .product(name: "bureau-id-fraud-sdk", package: "bureau-id-fraud-sdk")
            ],
            path: "Sources"
        )
    ]
)
