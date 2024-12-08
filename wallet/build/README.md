# SaudiChain Wallet Builds

## Available Builds

### Windows
- SaudiChain-Wallet-Win64.exe (64-bit Windows)
- SaudiChain-Wallet-Win32.exe (32-bit Windows)

### macOS
- SaudiChain-Wallet-macOS.dmg (Intel)
- SaudiChain-Wallet-macOS-M1.dmg (Apple Silicon)

### Linux
- saudichain-wallet-linux-x64.AppImage
- saudichain-wallet-linux.deb

## Build Instructions

### Windows
```bash
flutter build windows
```

### macOS
```bash
flutter build macos --release
```

### Linux
```bash
flutter build linux --release
```

## Installation

### Windows
1. Download the appropriate .exe file
2. Run the installer
3. Follow the setup wizard

### macOS
1. Download the .dmg file
2. Open the disk image
3. Drag the app to Applications

### Linux
1. For AppImage:
   - Make executable: `chmod +x saudichain-wallet-linux-x64.AppImage`
   - Run directly
2. For .deb:
   - Install: `sudo dpkg -i saudichain-wallet-linux.deb`

## Verifying Builds

All builds are signed and can be verified using:
```bash
# Get SHA256 hash
shasum -a 256 [filename]
```

## Support

For support contact:
- GitHub Issues
- Community Forums
- Development Team