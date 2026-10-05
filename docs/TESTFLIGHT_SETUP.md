# TestFlight setup

The repository now contains two iOS workflows:

- **iOS Build Check** — builds the Flutter app on macOS without code signing and uploads a compile-check artifact.
- **TestFlight Release** — creates a signed IPA and uploads it to App Store Connect/TestFlight when Apple signing secrets are configured.

## GitHub Actions secrets required for TestFlight

Add these in:

**GitHub repo → Settings → Secrets and variables → Actions → New repository secret**

1. `IOS_BUNDLE_ID`  
   Example: `com.yourcompany.fashionai`

2. `APPLE_TEAM_ID`  
   Your Apple Developer Team ID.

3. `APPLE_CERTIFICATE_BASE64`  
   Base64-encoded Apple Distribution `.p12` certificate.

4. `APPLE_CERTIFICATE_PASSWORD`  
   Password used when exporting the `.p12`.

5. `APPLE_PROVISIONING_PROFILE_BASE64`  
   Base64-encoded App Store distribution `.mobileprovision` profile matching the bundle ID.

6. `APPSTORE_API_KEY_ID`  
   App Store Connect API Key ID.

7. `APPSTORE_API_ISSUER_ID`  
   App Store Connect API Issuer ID.

8. `APPSTORE_API_PRIVATE_KEY_BASE64`  
   Base64-encoded contents of the App Store Connect `AuthKey_XXXXXX.p8` file.

## Apple-side prerequisites

Before the TestFlight workflow can work:

- Active Apple Developer Program membership.
- An App ID using the same value as `IOS_BUNDLE_ID`.
- An App Store Connect app record created for that App ID.
- Apple Distribution certificate and App Store provisioning profile.
- App Store Connect API key with permission to upload builds.

## Run TestFlight release

After all secrets are configured:

**GitHub repo → Actions → TestFlight Release → Run workflow**

The workflow will:

1. Install Flutter.
2. Import the signing certificate and provisioning profile.
3. Set the bundle ID/team for the Runner target.
4. Build a signed release IPA.
5. Save the IPA as a GitHub Actions artifact.
6. Upload it to App Store Connect for TestFlight processing.

Do not commit Apple private keys, certificates, passwords, or provisioning profiles to the repository.
