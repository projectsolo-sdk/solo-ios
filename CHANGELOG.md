# Changelog

Each release of the SOLO iOS package is listed here, newest first.

## 1.0.0-alpha.5 (preview)

Reduces implementation symbols and compiler metadata exposed by the iOS package.

- The documented public API and stable Swift module interfaces are preserved.
- Model resources and capture logic are unchanged.
- Private crash symbols are retained separately from the distributed package.

## 1.0.0-alpha.4 (preview)

Fixes sandbox device-attestation recovery after an earlier verification ran
before the app was registered.

- Sandbox configurations now keep separate device-attestation keys.
- When a sandbox key is no longer registered, the SDK can obtain a fresh key
  on the next verification without reinstalling the app.
- Update the SDK in place and start a new verification after registering the
  app in the sandbox Apps settings. The current sandbox result remains unchanged.
- No public API changes; signature and replay validation remain required.

## 1.0.0-alpha.3 (preview)

The package now includes the SOLO SDK License and the third-party notices.

- `LICENSE`: the SOLO SDK License is part of the package.
- `THIRD_PARTY_NOTICES.txt`: the licence texts and copyright notices of the
  third-party components the SDK contains, at the root of `SOLO.framework`
  (and so in your app bundle when you embed it).
- No change to the API.

## 1.0.0-alpha.2 (preview)

First public release of the SOLO Proof of Humanity SDK for iOS, as a binary
XCFramework distributed through Swift Package Manager.

- The Proof of Humanity flow behind one call, `Solo.verify()`, returning a
  `SoloResult`.
- The bundled distribution: the models ship inside the framework.
- Optional preparation and cleanup controls: `Solo.preloadModels()`,
  `Solo.prewarm()`, `Solo.offloadModels()` and `Solo.clearModelCache()`.
- Code-signed by Solo Research Ltd. (Apple Team ID 4795N7VA99); iOS 16 or later, arm64.
