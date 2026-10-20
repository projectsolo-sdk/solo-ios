# Changelog

Each release of the SOLO iOS package is listed here, newest first.

## 2.1.1

Adds preparation progress, download retries and specific preparation errors. Existing code
keeps compiling.

- `Solo.preloadModels(progress:)` and `Solo.prewarm(progress:)` take an optional closure
  that receives `SoloPreparationProgress` (phase, bytes, files and a 0...1 fraction) on the
  main actor, ending with `.ready`. `Solo.preparationProgress` streams every preparation,
  including the one `Solo.verify()` runs by itself.
- Model downloads retry transient failures up to three times with backoff, resume an
  interrupted file instead of starting over, and download a file that fails its checksum
  once more.
- `SoloPreparationError` now says why preparation failed: `.offline`,
  `.server(status:)`, `.integrity`, `.storageFull`, `.cancelled`, or `.preparationFailed`
  for any other cause. Before 2.1.1 every failure was `.preparationFailed`: code that
  matched only that case should now catch `SoloPreparationError`. `rawValue` still exists
  (`preparation_failed`, `offline`, `server`, `integrity`, `storage_full`, `cancelled`).
- `Solo.verify()` still returns `MODEL_UNAVAILABLE` when it cannot prepare; `detail` now
  names the cause (for example `preparation_offline`).
- Install with `from: "2.1.1"`.

## 2.0.0

**Breaking release.** The models no longer ship inside the framework, and the
`SOLOOnDemand` product is removed. A `from: "1.x"` requirement does not pick up
this version; you upgrade by changing it to `from: "2.0.0"`.

What changes for you:

- **If you use `SOLO` (1.3.x):** the framework no longer contains the models. The
  SDK now downloads them (about 34 MB) from `cdn.projectsolo.ai` the first time they
  are prepared, verifies each file and caches it on the device, so the first scan on
  a device needs a network connection. Your app is about 34 MB smaller. To keep the
  first scan offline, ship the models yourself (below).
- **If you use `SOLOOnDemand` (1.3.5):** that product no longer exists. Depend on
  `SOLO` instead; it behaves the way `SOLOOnDemand` did.
- The public APIs and their behavior are otherwise unchanged; no code changes are
  needed.

How to migrate:

1. Change this package's requirement to `from: "2.0.0"` (see README.md, "Install")
   and depend on `.product(name: "SOLO", package: "solo-ios")`.
2. Optional, to make the first scan work without downloading: download
   `SOLOResources.zip` for exactly this version, unzip it and add the
   `SOLOResources` folder to your app target as a folder reference (see README.md,
   "Optional: ship the models in your app"). Replace it whenever you update to a
   version whose models changed; otherwise the SDK downloads the missing or
   different files.
3. If your app restricts network access, allow `cdn.projectsolo.ai`.

## 1.3.5

Adds a download variant of the iOS package.

- New product `SOLOOnDemand`: the same `import SOLO` API without the models in the
  framework. The SDK downloads them (about 34 MB) the first time they are prepared,
  verifies each file and caches it on the device, so the first scan needs a network
  connection.
- The `SOLO` product is unchanged and still includes the models. Add exactly one of
  the two products to your app.
- Install with `from: "1.3.5"`.

## 1.3.3

First stable release of the SOLO iOS package.

- Same public APIs and behavior as `1.0.0-alpha.10`; no code changes are needed
  to upgrade from it.
- Install with `from: "1.3.3"` instead of naming a preview version.

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
