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
            url: "https://storage.googleapis.com/solo-poh-sdk-releases/ios/1.0.0-alpha.6/SOLO.xcframework.zip",
            checksum: "deb08fb04c8e4ae1cdbfe2be3657c6fa75c47a12958e7cdd652a8d47745e458f"
        ),
    ]
)
