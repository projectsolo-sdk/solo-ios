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
    .package(url: "https://github.com/projectsolo-sdk/solo-ios.git", from: "2.1.2"),
],
targets: [
    .target(name: "YourApp", dependencies: [
        .product(name: "SOLO", package: "solo-ios"),
    ]),
]
```

then `import SOLO`.

`from: "2.1.2"` accepts 2.1.2 and any later 2.x release, up to but not including
3.0.0. If your app's requirement names a 1.x version (or a `1.0.0-alpha` preview),
replace it with the one above; see [CHANGELOG.md](CHANGELOG.md) for what changed in 2.0.0.

Requirements: iOS 16 or later, on arm64 (devices and Apple silicon simulators), and a
physical device for capture.

## Preparation

The package has one product, `SOLO`. The models it needs are not inside the
framework: the first time they are prepared on a device, the SDK downloads them
(about 34 MB) over HTTPS from `cdn.projectsolo.ai`, checks every file against a
SHA-256 built into the SDK, and caches them in your app's Application Support
directory (`SOLOResources`, excluded from backups). So the first scan on a device
needs a network connection; later scans use the cache. If your app restricts
network access, allow `cdn.projectsolo.ai`.

`Solo.verify()` prepares the models automatically. The optional
`Solo.preloadModels()`, `Solo.prewarm()`, `Solo.offloadModels()` and
`Solo.clearModelCache()` let your app control preparation, memory and cache timing:
call `Solo.preloadModels()` ahead of the first scan (for example on the screen before
it) to download early, and retry it when the device is online if it fails.
`Solo.clearModelCache()` deletes the downloaded files; the next preparation downloads
them again.

### Progress and failures

`Solo.preloadModels(progress:)` and `Solo.prewarm(progress:)` take an optional closure
that receives `SoloPreparationProgress` on the main actor, about ten times a second at
most, and last with `.ready` before the call returns:

```swift
try await Solo.prewarm { progress in
    bar.progress = Float(progress.fractionCompleted)          // 0...1, never decreases
    label.isHidden = progress.phase != .downloading           // .checking, .downloading,
}                                                              // .loading, .warming, .ready
```

`progress.completedBytes` and `progress.totalBytes` (known from the start) cover the model
files, as do `completedFiles` and `totalFiles`. When the files are already in your app or
cached, there is no `.downloading` phase. To follow every preparation, including the one
`Solo.verify()` runs by itself, iterate `Solo.preparationProgress` (an `AsyncStream`; each
access is a new stream) from the main actor, for example in a SwiftUI `.task`.

Downloads retry transient failures (timeouts, a lost or missing connection, HTTP 5xx and
429) up to three times with a growing delay, and continue an interrupted file where it
stopped. A file that does not match its checksum is downloaded once more. If preparation
still fails, the call throws `SoloPreparationError`:

| Case | Meaning |
|---|---|
| `.offline` | No usable connection. Retry when the device is online. |
| `.server(status:)` | SOLO's file server answered with that HTTP status. |
| `.integrity` | A file did not match its checksum, also after downloading it again. |
| `.storageFull` | The device has no space left for the files. |
| `.cancelled` | The SDK's own transfer was cancelled (for example by the system). |
| `.preparationFailed` | Any other cause. |

Cancelling the calling task still throws `CancellationError`. `Solo.verify()` still returns
`.failed` with `SoloErrorCode.modelUnavailable` when it cannot prepare; its `detail` names
the cause (`preparation_offline`, `preparation_server_<status>`, `preparation_integrity`,
`preparation_storage_full`, `preparation_cancelled` or `preparation_failed`).

### Optional: ship the models in your app

To make the first scan work without downloading, ship the models with your app:

1. Download `SOLOResources.zip` for **exactly the SDK version you use**:
   `https://cdn.projectsolo.ai/ios/<version>/SOLOResources.zip`
   (for this version,
   `https://cdn.projectsolo.ai/ios/2.1.2/SOLOResources.zip`).
   Its SHA-256 is published beside it as `SOLOResources.zip.checksum`.
2. Unzip it. It holds one folder, `SOLOResources`.
3. Drag the `SOLOResources` folder into your app target in Xcode and choose
   **Create folder references** (a blue folder), so the app bundle contains
   `SOLOResources/` with its subfolders unchanged. Make sure your app target is
   checked under **Add to targets**.

The SDK then uses those files in place: it copies and downloads nothing. It checks
every file against the SHA-256 built into the SDK first. Update the folder whenever
you update the SDK to a version whose models changed (download `SOLOResources.zip`
for the new version): if any file is missing or does not match, the SDK ignores that
file, downloads it as above and logs a warning (unified logging, subsystem
`ai.projectsolo.sdk`, category `resources`, message prefix `SOLO_RESOURCES`). The
folder adds about 34 MB to your app.

See the [lifecycle guide](https://developers.projectsolo.ai/docs/sdk-lifecycle) for package
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

## Device-attestation diagnostics

From `1.0.0-alpha.10`, the SDK emits unified logs in Debug and Release builds with
subsystem `ai.projectsolo.sdk`, category `app-attest`, and message prefix
`SOLO_APP_ATTEST`. Failures use the error level; other stage results use notice.
No configuration or private SDK API is required.

Filter Console for that subsystem/category, or an existing device log stream for
`SOLO_APP_ATTEST`. Share only those message lines when investigating a failure.
They contain fixed `stage`, `outcome`, `family`, and `operation` values, an optional
numeric `code`, and `elapsed_ms`. A `device_check` code is Apple's `DCError.Code`;
a `keychain` code is a Security `OSStatus`. `not_found` (`-25300`) is normal when
no key has been saved. `skipped` means a key changed before a marker write or
matching-key reset. No key, challenge, assertion, session, account, biometric
data, or arbitrary Apple error message is logged.

A failure identifies the local operation; it does not change the server's
verification result. Existing key recovery takes effect on a subsequent
verification. Simulator support failures cannot establish whether App Attest
works on a physical device.

## After a failed capture

A failed capture shows **DONE** and returns its failure to your app. The SDK does
not restart the capture in the same verification session. When the result's
recovery is `newSession`, create a new session on your server and call
`Solo.verify` with its fresh claim token. Server rejections are also terminal.
