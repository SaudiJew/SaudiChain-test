# SaudiChain Wallet Executables

## Building the Executables

### Prerequisites
1. Install Visual Studio 2019 or later with C++ support
2. Install Flutter SDK
3. Install NSIS (Nullsoft Scriptable Install System)

### Build Steps

```bash
# 1. Set up Flutter
flutter config --enable-windows-desktop
flutter doctor

# 2. Build the wallet
cd wallet
flutter build windows --release

# 3. Create installer
cd windows
makensis installer.nsi
```

## Direct Download Links
Pre-built executables can be downloaded from:
- [SaudiChain-Wallet-Setup-x64.exe](https://github.com/SaudiJew/SaudiChain-test/releases/latest/download/SaudiChain-Wallet-Setup-x64.exe)
- [SaudiChain-Wallet-Simple-x64.exe](https://github.com/SaudiJew/SaudiChain-test/releases/latest/download/SaudiChain-Wallet-Simple-x64.exe)

## Installation

### Full Installer (Recommended)
1. Download SaudiChain-Wallet-Setup-x64.exe
2. Run the installer
3. Follow the installation wizard
4. Launch from Start Menu

### Portable Version
1. Download SaudiChain-Wallet-Simple-x64.exe
2. Run directly - no installation needed

## System Requirements
- Windows 10 or later (64-bit)
- 4GB RAM minimum
- 500MB free disk space
- Internet connection

## Verification
Verify file integrity using SHA256 checksums:
```
SaudiChain-Wallet-Setup-x64.exe: [checksum]
SaudiChain-Wallet-Simple-x64.exe: [checksum]
```