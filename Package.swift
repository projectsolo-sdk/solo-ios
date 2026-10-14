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
            url: "https://storage.googleapis.com/solo-poh-sdk-releases/ios/1.0.0-alpha.5/SOLO.xcframework.zip",
            checksum: "8c9dc634e154dadfb329d13156d1e27b0634b98d8884573db7a1c19ff1b25526"
        ),
    ]
)
