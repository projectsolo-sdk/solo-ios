// swift-tools-version: 5.9
// Generated for each SOLO release. Do not edit.
// SOLO Proof of Humanity is distributed as a compiled XCFramework only.
import PackageDescription

let package = Package(
    name: "SOLO",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "SOLO", targets: ["SOLO"]),
    ],
    targets: [
        .binaryTarget(
            name: "SOLO",
            url: "https://storage.googleapis.com/solo-poh-sdk-releases/ios/1.0.0-alpha.7/SOLO.xcframework.zip",
            checksum: "aadef37c938ab8f59d92d7dde6d3fe1a9f34a33053476ddc0ad22a70dfe3156e"
        ),
    ]
)
