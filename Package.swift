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
            url: "https://cdn.projectsolo.ai/ios/2.0.0/SOLO.xcframework.zip",
            checksum: "b2695fdd37e6c3e652b533a1fef0500ce4fdb82cabdef4ab7c416d27641585ed"
        ),
    ]
)
