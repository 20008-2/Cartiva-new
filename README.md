# CARTIVA — fresh Flutter starter

This repository contains a beginner-friendly Flutter starter interface for CARTIVA.

## Included
- Shop screen with sample products
- Cart screen (local demo only)
- Partner Deals screen (sample placeholders)
- About screen
- GitHub Actions workflow that generates Android project files and builds a release APK

## Important before real launch
This is **not yet a live shopping business**. Product names, prices and images are examples. It does not yet process payments, send orders to suppliers, arrange delivery, track affiliate referrals, create customer accounts, or manage returns. Add and test those services, policies, and security before accepting real orders or customer information.

## Build APK with GitHub
1. Create a new GitHub repository named `cartiva`.
2. Upload the contents of this folder (not the ZIP file itself). Make sure `pubspec.yaml`, `README.md`, and `lib` are at the repository's top level.
3. Add `.github/workflows/build-apk.yml` at that exact path using the file included here. If your upload method supports hidden folders, upload `.github` too.
4. Open the repository's **Actions** tab. The workflow runs after a push to `main`, or choose **Build CARTIVA Android APK** and tap **Run workflow**.
5. When the run succeeds, open it, scroll to **Artifacts**, and download `CARTIVA-Android-APK`.

## Files
- `lib/main.dart` — CARTIVA app interface
- `pubspec.yaml` — Flutter project settings
- `.github/workflows/build-apk.yml` — Android APK build workflow
