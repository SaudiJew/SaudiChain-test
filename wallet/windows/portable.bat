@echo off
echo Creating Portable SaudiChain Wallet...

:: Set paths
set BUILD_DIR=build\windows\runner\Release
set PORTABLE_DIR=build\portable
set PORTABLE_NAME=SaudiChain-Wallet-Portable.exe

:: Create portable directory
if not exist %PORTABLE_DIR% mkdir %PORTABLE_DIR%

:: Copy main executable
copy %BUILD_DIR%\saudichain_wallet.exe %PORTABLE_DIR%\%PORTABLE_NAME%

:: Copy required DLLs
copy %BUILD_DIR%\*.dll %PORTABLE_DIR%\

:: Copy data files
xcopy /s /y data %PORTABLE_DIR%\data\

:: Create portable config
echo Creating portable configuration...
(echo portable=true
echo data_dir=.\data
echo wallet_dir=.\wallets
) > %PORTABLE_DIR%\config.ini

echo Portable wallet created in %PORTABLE_DIR%\