# Changelog

Each release of the SOLO iOS package is listed here, newest first.

## 1.0.0-alpha.10 (preview)

Makes capture failures terminal and adds device-attestation diagnostics on iOS.

- Debug and Release builds log fixed operation stages and numeric Apple error
  codes without keys, assertions, account identifiers or capture data.
- A failed capture shows **DONE**, returns the failure to the host, and requires
  a new session. The SDK no longer offers **TRY AGAIN** within the same session.
- Submitted data, server verdicts, automatic network backoff and key recovery
  behavior are unchanged.

## 1.0.0-alpha.7 (preview)

Simplifies Solo's consent screen.

- **Breaking:** `SoloConfiguration.privacyMessage` is removed, together with the
  `privacyMessage:` parameter of `SoloConfiguration.init`. Partners no longer add
  their own text to the consent screen; remove the argument where you pass it.
- The consent screen is shorter: Solo's logo without a close button (Decline
  leaves, as before), what your app receives, Solo's consent text and a
  one-line privacy note.
- Links in Solo's consent text open in an in-app Safari view instead of
  leaving your app.
- Solo's consent text is built into the SDK (version `2026-10-16-v1`): the
  screen shows the same text in every session, with links to Solo's Terms and
  Privacy Policy.

## 1.0.0-alpha.6 (preview)

Reduces directly readable internal metadata and resource identifiers in the
distributed iOS package.

- Preserves the existing public APIs and capture behavior.
- Preserves decoded model content and offline preparation of bundled resources.
- Removes diagnostic rendering that the distributed package cannot enable.

These measures reduce disclosure; they do not prevent binary analysis or resource
recovery.

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
