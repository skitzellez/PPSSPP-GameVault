@echo off
rem Copyright (c) 2026 Skitzelles - part of Game Vault, https://github.com/skitzellez/xbox-game-vault
rem Signs PPSSPP for Game Vault: package_gv.bat <version, e.g. 1.20.4.1> -> dist\PPSSPPForGameVault_<version>_x64.appx
rem (the package build_gv.bat made, copied and signed with Game Vault's own key, which is not part of this repository)
setlocal
cd /d "%~dp0"
if "%~1"=="" (echo usage: package_gv.bat 1.20.4.x & exit /b 1)
set SDK=C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x64
set GV=%~dp0..\GameVault
set PKG=build-uwp\AppPackages\PPSSPP_UWP_%~1_x64_Test\PPSSPP_UWP_%~1_x64.msix
if not exist "%PKG%" (echo no %PKG% & exit /b 1)
if not exist dist mkdir dist
copy /y "%PKG%" dist\PPSSPPForGameVault_%~1_x64.appx >nul || exit /b 1
if not defined PFX_PASSWORD for /f "usebackq delims=" %%p in (`powershell -NoProfile -ExecutionPolicy Bypass -File "%GV%\pfx_password.ps1"`) do set "PFX_PASSWORD=%%p"
if not defined PFX_PASSWORD (echo password could not be read & exit /b 1)
"%SDK%\signtool.exe" sign /fd SHA256 /a /f "%GV%\cert\GameVault.pfx" /p %PFX_PASSWORD% dist\PPSSPPForGameVault_%~1_x64.appx || exit /b 1
echo Package ready: dist\PPSSPPForGameVault_%~1_x64.appx
