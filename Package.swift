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
            url: "https://cdn.projectsolo.ai/ios/2.2.0/SOLO.xcframework.zip",
            checksum: "688b538270a27685b244ed5fc1a8007a7965922897fc1c8cc9d8f9ca8fc43500"
        ),
    ]
)
