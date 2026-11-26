@echo off
rem Copyright (c) 2026 Skitzelles - part of Game Vault, https://github.com/skitzellez/xbox-game-vault
rem Builds PPSSPP for Game Vault (Xbox, UWP x64): build_gv.bat > build-uwp.log
rem The version is the one in UWP\Package.appxmanifest. The package is built unsigned; package_gv.bat signs it.
cd /d "%~dp0"
set MSB=C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\MSBuild\Current\Bin\MSBuild.exe
"%MSB%" UWP\PPSSPP_UWP.sln /t:restore /p:RestorePackagesConfig=true /p:Configuration=Release /p:Platform=x64 /v:minimal || exit /b 1
"%MSB%" UWP\PPSSPP_UWP.sln /m /p:Configuration=Release /p:Platform=x64 /p:AppxBundle=Never /p:UapAppxPackageBuildMode=SideloadOnly /p:AppxPackageSigningEnabled=false /p:AppxPackageDir=%~dp0build-uwp\AppPackages\ /v:minimal || exit /b 1
