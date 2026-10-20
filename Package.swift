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
            url: "https://cdn.projectsolo.ai/ios/2.1.1/SOLO.xcframework.zip",
            checksum: "6f3981ad553897bcefadf43356854babff0c68436881b3997915f488c5ad62ee"
        ),
    ]
)
