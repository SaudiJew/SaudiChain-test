# SaudiChain Wallet Setup

## Development Setup

1. Flutter Installation
   ```bash
   git clone https://github.com/flutter/flutter.git
   export PATH="$PATH:`pwd`/flutter/bin"
   flutter doctor
   ```

2. Dependencies
   ```bash
   flutter pub get
   ```

3. Build Instructions

   ### Android
   ```bash
   flutter build apk --release
   ```

   ### iOS
   ```bash
   flutter build ios --release
   ```

   ### Desktop (Windows/Mac/Linux)
   ```bash
   flutter build windows
   flutter build macos
   flutter build linux
   ```

   ### Web
   ```bash
   flutter build web
   ```

## Configuration

1. Network Settings
   - Update RPC endpoints in `lib/config/network_config.dart`
   - Set appropriate network magic bytes
   - Configure peer discovery seeds

2. Branding
   - Update app name in `pubspec.yaml`
   - Replace logo assets in `assets/images/`
   - Modify color scheme in `lib/theme/`

## Features

1. Core Functionality
   - Wallet creation/import
   - Send/receive transactions
   - Transaction history
   - Address book

2. Security
   - Biometric authentication
   - Encrypted storage
   - Backup/restore functionality

3. Additional Features
   - Price tracking
   - Multiple account support
   - QR code scanning
   - Push notifications
