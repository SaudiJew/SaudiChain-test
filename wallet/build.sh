#!/bin/bash

echo "Building SaudiChain Wallet for all platforms..."

# Set up environment
export FLUTTER_ROOT="$HOME/flutter"
export PATH="$FLUTTER_ROOT/bin:$PATH"

# Clean and get dependencies
flutter clean
flutter pub get

# Build for Windows
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    echo "Building Windows executable..."
    flutter build windows --release
    cd windows
    makensis installer.nsi
    cd ..
fi

# Build for macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Building macOS application..."
    flutter build macos --release
    create-dmg \
      --volname "SaudiChain Wallet" \
      --window-pos 200 120 \
      --window-size 800 400 \
      --icon-size 100 \
      --icon "SaudiChain Wallet.app" 200 190 \
      --hide-extension "SaudiChain Wallet.app" \
      --app-drop-link 600 185 \
      "build/SaudiChain-Wallet-macOS.dmg" \
      "build/macos/Build/Products/Release/SaudiChain Wallet.app"
fi

# Build for Linux
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "Building Linux packages..."
    flutter build linux --release
    
    # Build AppImage
    linuxdeploy --appdir=AppDir --plugin=qt --output=appimage
    
    # Build .deb package
    mkdir -p debian/usr/local/bin
    cp -r build/linux/x64/release/bundle/* debian/usr/local/bin/
    dpkg-deb --build debian build/saudichain-wallet-linux.deb
fi

echo "Build process complete!"
