; SaudiChain Wallet Installer Script

!include "MUI2.nsh"

; Application name and version
Name "SaudiChain Wallet"
OutFile "SaudiChain-Wallet-Setup.exe"

; Default installation directory
InstallDir "$PROGRAMFILES64\SaudiChain Wallet"

; Request application privileges
RequestExecutionLevel admin

; Interface Settings
!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico"

; Pages
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

; Languages
!insertmacro MUI_LANGUAGE "English"

; Installation
Section "Install"
  SetOutPath "$INSTDIR"
  
  ; Include all files from the Flutter build
  File /r "build\windows\runner\Release\*.*"
  
  ; Create start menu shortcut
  CreateDirectory "$SMPROGRAMS\SaudiChain Wallet"
  CreateShortcut "$SMPROGRAMS\SaudiChain Wallet\SaudiChain Wallet.lnk" "$INSTDIR\saudichain_wallet.exe"
  
  ; Write uninstaller
  WriteUninstaller "$INSTDIR\uninstall.exe"
  
  ; Create uninstaller entries in Control Panel
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\SaudiChain Wallet" \
                 "DisplayName" "SaudiChain Wallet"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\SaudiChain Wallet" \
                 "UninstallString" "$INSTDIR\uninstall.exe"
SectionEnd

; Uninstaller
Section "Uninstall"
  ; Remove installed files
  RMDir /r "$INSTDIR"
  
  ; Remove start menu items
  RMDir /r "$SMPROGRAMS\SaudiChain Wallet"
  
  ; Remove registry entries
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\SaudiChain Wallet"
SectionEnd