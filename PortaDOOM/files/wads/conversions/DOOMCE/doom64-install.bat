@echo off
cd %~dp0

setlocal ENABLEDELAYEDEXPANSION
set patchdir=patcher
if exist "%patchdir%\tmp" rmdir /q/s "%patchdir%\tmp"
SET ERROR=0

:wadfind
echo Searching for DOOM64.WAD...
echo.

for /F "usebackq tokens=3*" %%A in (`REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 1148590" /v InstallLocation 2^> nul`) do (
    set appdir=%%A %%B
)
for /F "usebackq tokens=3*" %%A in (`REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\GOG.com\Games\1456611261" /v path 2^> nul `) do (
    set appdir=%%A %%B
)
for /F "tokens=*" %%A in ('%patchdir%\jq\jq.exe -r ".InstallationList[] | select(.AppName == \"5b60142e120c4f2d88027595c21d4a04\").InstallLocation" %programdata%\Epic\UnrealEngineLauncher\LauncherInstalled.dat') do (
    echo %%A
    set appdir=%%A
)
for /F "usebackq tokens=3*" %%A IN (`REG QUERY "HKEY_CLASSES_ROOT\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Repository\Packages\BethesdaSoftworks.Doom641997_2.0.0.0_x64__3275kfvn8vcwc" /v PackageRootFolder 2^> nul`) do (
    set appdir=%%A %%B\
)

if not exist "%appdir%\DOOM64.WAD" set appdir=.
if not exist "%appdir%\DOOM64.WAD" goto notfound
echo DOOM64.WAD found at "%appdir%"
echo.

:wadpatch
echo Patching IWAD...
echo.
if exist DOOM64.IWAD goto alreadypatched
"%patchdir%\flips\flips.exe" -a "%patchdir%\DOOM64.BPS" "%appdir%\DOOM64.WAD" DOOM64.IWAD
if not exist DOOM64.IWAD goto failpatch
goto mapsassemble

:alreadypatched
echo [93mDOOM64.IWAD already exists. Skipping IWAD patch...[0m
echo.

:mapsassemble
echo Assembling the Lost Levels...
echo.
if exist DOOM64.CE.Maps.LostLevels.pk3 goto alreadyassembled
set waddir=%patchdir%\tmp\wad
set zipdir=%patchdir%\tmp\ce
set mapdir=%zipdir%\maps
mkdir "%waddir%"
mkdir "%mapdir%"
"%patchdir%\wadex\wadex.exe" E "%appdir%\DOOM64.WAD" "%waddir%"
set /a c=1
for /L %%M IN (34,1,40) DO (
    echo Processing MAP%%M...
    echo.
    "%patchdir%\flips\flips.exe" -a "%patchdir%\LOST0!c!.BPS" "%waddir%\MAP%%M" "%mapdir%\lost0!c!.wad"
    if not exist "%mapdir%\LOST0!c!.WAD" goto failassemble
    mkdir "%waddir%\LOST0!c!"
    "%patchdir%\wadex\wadex.exe" E "%waddir%\MAP%%M" "%waddir%\LOST0!c!"
    set /a c=c+1
)
echo Creating PK3...
echo.
"%patchdir%\7za\7za.exe" a -tzip DOOM64.CE.Maps.LostLevels.pk3 ".\%zipdir%\*"
if not exist DOOM64.CE.Maps.LostLevels.pk3 goto failassemble
goto :success

:alreadyassembled
echo [93mDOOM64.CE.Maps.LostLevels.pk3 already exists. Skipping assembly...[0m
echo.
goto :success

:failpatch
echo [91mCould not generate DOOM64.IWAD. Make sure your Steam DOOM 64 WAD has not been manually modified before running this patch.[0m
echo.
SET ERROR=1 & PAUSE
goto :end

:failassemble
echo [91mCould not assemble the Lost Levels. Make sure your Steam DOOM 64 WAD has not been manually modified before running this patch.[0m
echo.
SET ERROR=1 & PAUSE
goto :end

:notfound
echo [91mFailed to find DOOM64.WAD. Make sure the Steam version of DOOM 64 is installed or copy its DOOM64.WAD in the same folder as this batch file.[0m
echo.
SET ERROR=1 & PAUSE
goto :end

:success
echo [92mFinished. To play, open gzdoom and select DOOM 64 CE from the list.
echo.
echo If gzdoom is installed elsewhere, copy the IWAD and PK3s to its location or the paths configured in its [IWADSearch.Directories] and [FileSearch.Directories].[0m
echo.

:end
if exist "%patchdir%\tmp" rmdir /q/s "%patchdir%\tmp"
EXIT /B %ERROR%
REM pause