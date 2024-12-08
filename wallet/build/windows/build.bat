@echo off
echo Building SaudiChain Wallet for Windows...

:: Set environment variables
set FLUTTER_ROOT=C:\flutter
set PATH=%FLUTTER_ROOT%\bin;%PATH%

:: Clean previous builds
flutter clean

:: Get dependencies
flutter pub get

:: Build for Windows
flutter build windows --release

:: Create installer using NSIS (assuming it's installed)
makensis installer.nsi

echo Build complete!
