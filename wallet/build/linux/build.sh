#!/bin/bash

echo "Building SaudiChain Wallet for Linux..."

# Set environment variables
export FLUTTER_ROOT="$HOME/flutter"
export PATH="$FLUTTER_ROOT/bin:$PATH"

# Clean previous builds
flutter clean

# Get dependencies
flutter pub get

# Build for Linux
flutter build linux --release

# Create AppImage
linuxdeploy --appdir=AppDir --plugin=qt --output=appimage

# Create .deb package
dpkg-deb --build debian saudichain-wallet-linux.deb

echo "Build complete!"
