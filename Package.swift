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
            url: "https://storage.googleapis.com/solo-poh-sdk-releases/ios/1.0.0-alpha.4/SOLO.xcframework.zip",
            checksum: "ddb144bfdb211412b39aab3b0305f54c8a9ed1b1c8b2bf1951e7b26f17225a9e"
        ),
    ]
)
