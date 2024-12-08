#!/bin/bash

echo "Building SaudiChain Wallet for macOS..."

# Set environment variables
export FLUTTER_ROOT="$HOME/flutter"
export PATH="$FLUTTER_ROOT/bin:$PATH"

# Clean previous builds
flutter clean

# Get dependencies
flutter pub get

# Build for macOS
flutter build macos --release

# Create DMG
create-dmg \
  --volname "SaudiChain Wallet" \
  --window-pos 200 120 \
  --window-size 800 400 \
  --icon-size 100 \
  --icon "SaudiChain Wallet.app" 200 190 \
  --hide-extension "SaudiChain Wallet.app" \
  --app-drop-link 600 185 \
  "SaudiChain-Wallet-macOS.dmg" \
  "build/macos/Build/Products/Release/SaudiChain Wallet.app"

echo "Build complete!"
