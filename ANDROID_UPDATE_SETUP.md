# Android In-App Update — One-Time Signing Setup

The app now checks the latest GitHub Release at startup and also has a manual
**Settings → Check for updates** option.

For Android to update an already installed APK, every future APK must be signed
with the exact same private signing key. Never commit the keystore to this public
repository.

## 1. Generate the upload keystore once

On macOS / Linux with a JDK installed:

```bash
keytool -genkeypair -v \
  -keystore fashion-ai-upload.jks \
  -keyalg RSA \
  -keysize 2048 \
  -validity 10000 \
  -alias fashionai
```

Keep the keystore file and passwords safe. Losing this key means future builds
cannot update installations signed by it.

## 2. Convert the keystore to base64

macOS:

```bash
base64 -i fashion-ai-upload.jks | pbcopy
```

Linux:

```bash
base64 -w 0 fashion-ai-upload.jks
```

## 3. Add these GitHub Actions repository secrets

Open:

**Repository → Settings → Secrets and variables → Actions → New repository secret**

Create:

- `ANDROID_KEYSTORE_BASE64` — the full base64 text
- `ANDROID_KEYSTORE_PASSWORD` — keystore password
- `ANDROID_KEY_ALIAS` — `fashionai`
- `ANDROID_KEY_PASSWORD` — key password

## 4. Publish the first updater-enabled APK

Run the GitHub Actions workflow:

**Publish Android In-App Update**

It publishes a GitHub Release named like `android-12` with the asset:

`fashion-ai-app.apk`

Install this signed APK once manually. After that, future builds signed with the
same key can be installed from the in-app **Update available** prompt.

## Important

Older CI APKs were development builds. If Android reports a signature conflict
when installing the first signed updater build, uninstall the older development
APK once and install the signed updater build. After that, normal in-app updates
will work without repeating the GitHub Actions download process.
