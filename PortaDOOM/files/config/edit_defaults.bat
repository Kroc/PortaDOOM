@ECHO OFF

REM # switch the current directory to that of this file
PUSHD %~dp0
REM # relative location of the saves folder (where user-configs are stored)
SET "SAVES=..\saves"
REM # relative path to doom.bat
SET "DOOM=..\doom.bat"
REM # relative path for doom.bat to the config folder
SET "CONFIG=..\..\..\config"

:menu
CLS
ECHO:
ECHO  Edit DOOM Engine Defaults:
ECHO  ==========================
ECHO  Note that this will delete your current user-config for an engine!
ECHO:
ECHO  Doom:
ECHO    [A] Chocolate-Doom
ECHO    [B] PRBoom+ ^(hardware^)       [C] PRBoom+ ^(software^)
ECHO    [D] Zandronum ^(v3^)           [E] Zandronum ^(v2^)
ECHO    [F] DOOM 64 EX
ECHO    [G] GZDoom
ECHO    [H] ZDoom ^(v2.8.1^)
ECHO:
ECHO  Heretic:
ECHO    [I] Chocolate-Heretic
ECHO    [J] GZDoom
ECHO:
ECHO  Hexen:
ECHO    [K] Chocolate-Hexen
ECHO:
ECHO  Strife:
ECHO    [L] Chocolate-Strife
ECHO:
SET "$="
SET /P "$=? "

IF "%$%" == "" POPD & EXIT /B

REM # Doom:
REM --------------------------------------------------------------------------------------------------------------------
IF /I "%$%" == "A" (
	REM # delete the user's config that would override the default
	IF EXIST "%SAVES%\config.choco-doom.cfg" DEL "%SAVES%\choco-doom\config.choco-doom.cfg"  >NUL 2>&1
	IF EXIST "%SAVES%\config.choco-doom.extra.cfg" DEL "%SAVES%\choco-doom\config.choco-doom.extra.cfg"  >NUL 2>&1
	REM # launch the engine using our default config file
	CALL %DOOM% /DEFAULT /WAIT /USE choco-doom-setup /IWAD DOOM.WAD
)
IF /I "%$%" == "B" (
	REM # delete the user's config that would override the default
	IF EXIST "%SAVES%\config.glboom-plus.cfg" DEL "%SAVES%\prboom\config.glboom-plus.cfg"  >NUL 2>&1
	REM # launch the engine using our default config file
	CALL %DOOM% /DEFAULT /WAIT /USE prboom /IWAD DOOM.WAD
)
IF /I "%$%" == "C" (
	REM # delete the user's config that would override the default
	IF EXIST "%SAVES%\config.prboom-plus.cfg" DEL "%SAVES%\prboom\config.prboom-plus.cfg"  >NUL 2>&1
	REM # launch the engine using our default config file
	CALL %DOOM% /DEFAULT /WAIT /USE prboom /SW /IWAD DOOM.WAD
)
IF /I "%$%" == "D" (
	REM # delete the user's config that would override the default
	IF EXIST "%SAVES%\config.zandronum-3.ini" DEL "%SAVES%\zandronum\config.zandronum-3.ini"  >NUL 2>&1
	REM # launch the engine using our default config file
	CALL %DOOM% /DEFAULT /WAIT zandronum-3 /IWAD DOOM.WAD
)
IF /I "%$%" == "E" (
	REM # delete the user's config that would override the default
	IF EXIST "%SAVES%\config.zandronum-2.ini" DEL "%SAVES%\zandronum\config.zandronum-2.ini"  >NUL 2>&1
	REM # launch the engine using our default config file
	CALL %DOOM% /DEFAULT /WAIT /USE zandronum-2 /IWAD DOOM.WAD
)
IF /I "%$%" == "F" (
	REM # delete the user's config that would override the default
	IF EXIST "%SAVES%\config.doom64ex.cfg" DEL "%SAVES%\doom64ex\config.doom64ex.cfg"  >NUL 2>&1
	REM # launch the engine using our default config file
	CALL %DOOM% /DEFAULT /WAIT /USE doom64ex
)
IF /I "%$%" == "G" (
	REM # delete the user's config that would override the default
	IF EXIST "%SAVES%\config.gzdoom.ini" DEL "%SAVES%\gzdoom\config.gzdoom.ini"  >NUL 2>&1
	REM # launch the engine using our default config file
	CALL %DOOM% /DEFAULT /WAIT /USE gzdoom /IWAD DOOM.WAD
)
IF /I "%$%" == "H" (
	REM # delete the user's config that would override the default
	IF EXIST "%SAVES%\config.zdoom.ini" DEL "%SAVES%\gzdoom\config.zdoom.ini"  >NUL 2>&1
	REM # launch the engine using our default config file
	CALL %DOOM% /DEFAULT /WAIT /USE zdoom /IWAD DOOM.WAD
)

REM # Heretic:
REM --------------------------------------------------------------------------------------------------------------------
IF /I "%$%" == "I" (
	REM # delete the user's config that would override the default
	IF EXIST "%SAVES%\config.choco-heretic.cfg" DEL "%SAVES%\choco-heretic\config.choco-heretic.cfg"  >NUL 2>&1
	IF EXIST "%SAVES%\config.choco-heretic.extra.cfg" DEL "%SAVES%\choco-heretic\config.choco-heretic.extra.cfg"  >NUL 2>&1
	REM # launch the engine using our default config file
	CALL %DOOM% /DEFAULT /WAIT /USE choco-heretic-setup /IWAD SHAREWARE\HERETIC1.WAD
)
IF /I "%$%" == "J" (
	REM # delete the user's config that would override the default
	IF EXIST "%SAVES%\config.gzdoom.ini" DEL "%SAVES%\gzdoom\config.gzdoom.ini"  >NUL 2>&1
	REM # launch the engine using our default config file
	CALL %DOOM% /DEFAULT /WAIT /USE gzdoom /IWAD SHAREWARE\HERETIC1.WAD
)

REM # Hexen:
REM --------------------------------------------------------------------------------------------------------------------
IF /I "%$%" == "K" (
	REM # delete the user's config that would override the default
	IF EXIST "%SAVES%\config.choco-hexen.cfg" DEL "%SAVES%\choco-hexen\config.choco-hexen.cfg"  >NUL 2>&1
	IF EXIST "%SAVES%\config.choco-hexen.extra.cfg" DEL "%SAVES%\choco-hexen\config.choco-hexen.extra.cfg"  >NUL 2>&1
	REM # launch the engine using our default config file
	CALL %DOOM% /DEFAULT /WAIT /USE choco-hexen-setup /IWAD SHAREWARE\HEXEN.WAD
)

REM # Strife:
REM --------------------------------------------------------------------------------------------------------------------
IF /I "%$%" == "L" (
	REM # delete the user's config that would override the default
	IF EXIST "%SAVES%\config.choco-strife.cfg" DEL "%SAVES%\choco-strife\config.choco-strife.cfg"  >NUL 2>&1
	IF EXIST "%SAVES%\config.choco-strife.extra.cfg" DEL "%SAVES%\choco-strife\config.choco-strife.extra.cfg"  >NUL 2>&1
	REM # launch the engine using our default config file
	CALL %DOOM% /DEFAULT /WAIT /USE choco-strife-setup /IWAD SHAREWARE\STRIFE0.WAD
)

ECHO:
PAUSE
GOTO :menu