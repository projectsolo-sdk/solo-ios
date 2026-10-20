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
            url: "https://cdn.projectsolo.ai/ios/2.1.2/SOLO.xcframework.zip",
            checksum: "b144139fc204d45ac3486ca706e9cd7211bd7df0a190665c4d67a76de7268c3a"
        ),
    ]
)
