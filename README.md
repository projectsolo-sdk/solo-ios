# Solo for iOS

Solo Proof-of-Humanity protocol for iOS, distributed as a compiled XCFramework through
Swift Package Manager. This repository holds only the package manifest and its
documentation; the framework binary is downloaded by SwiftPM from the URL in
`Package.swift` and verified against the checksum there.

## Install

In Xcode choose **File > Add Package Dependencies...** and enter this
repository's URL, or add it to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/projectsolo-sdk/solo-ios.git", from: "1.0.0-alpha.3"),
],
targets: [
    .target(name: "YourApp", dependencies: [
        .product(name: "SOLO", package: "solo-ios"),
    ]),
]
```

then `import SOLO`.

`1.0.0-alpha.3` is a preview release. SwiftPM resolves a pre-release only when the
requirement itself names one, as above: `from: "1.0.0"` matches nothing until 1.0.0
is released.

Requirements: iOS 16 or later, on arm64 (devices and Apple silicon simulators), and a
physical device for capture.

## Preparation

This package is the bundled distribution: the models ship inside `SOLO.xcframework`, so
preparing them verifies the bundled files and downloads nothing. `Solo.verify()` prepares
automatically; the optional `Solo.preloadModels()`, `Solo.prewarm()`,
`Solo.offloadModels()` and `Solo.clearModelCache()` let your app control preparation,
memory and cache timing.

See the [lifecycle guide](https://developers.projectsolo.ai/docs/sdk-lifecycle) for preview
availability, asynchronous usage and error handling.

## Verifying the package

`SOLO.xcframework` is code-signed by **Solo Research Ltd.**, Apple Team ID
**`4795N7VA99`** (certificate "Apple Distribution: Solo Research Ltd.
(4795N7VA99)"). SwiftPM also checks the downloaded zip against the `checksum`
in `Package.swift` before using it.

- **In Xcode** (15 or later): under **Package Dependencies**, select the `SOLO`
  binary target's `SOLO.xcframework`. The File inspector's **Signature**
  section shows the signer, Solo Research Ltd., and the team.
- **From the command line**, on the resolved framework (for an Xcode project,
  under `DerivedData/<project>/SourcePackages/artifacts/`):

  ```sh
  codesign -dv --verbose=4 SOLO.xcframework 2>&1 | grep -E '^(Authority|TeamIdentifier)='
  # Authority=Apple Distribution: Solo Research Ltd. (4795N7VA99)
  # TeamIdentifier=4795N7VA99
  codesign --verify --strict --verbose=2 SOLO.xcframework
  ```

  Any other signer or team, or a failed verify, means the framework is not
  the one Solo released: don't ship it.

## Releases

Every release is one commit and one tag in this repository. See
[CHANGELOG.md](CHANGELOG.md). Released binaries are immutable: a version's
checksum never changes.

## Terms, privacy and support

Use of the SDK is governed by the Solo
[Terms of Service](https://projectsolo.ai/terms) and
[Privacy Policy](https://projectsolo.ai/privacy). For questions about the SDK or
these documents, write to [contact@projectsolo.ai](mailto:contact@projectsolo.ai).

## Licence

The SDK is proprietary, commercial software of Solo Research Limited, not open source; no
source code is provided. It may be used only by a partner who has accepted the Solo Terms
and holds credentials issued by Solo.
