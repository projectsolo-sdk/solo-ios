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
            url: "https://storage.googleapis.com/solo-poh-sdk-releases/ios/1.0.0-alpha.3/SOLO.xcframework.zip",
            checksum: "b57010b6e3c00cdf569762baa0ef85edf42fa1af0eccb2901abefbfdd22230b5"
        ),
    ]
)
