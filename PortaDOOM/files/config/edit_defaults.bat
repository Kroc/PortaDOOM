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
ECHO  [A] Chocolate-Doom
ECHO  [B] Chocolate-Heretic
ECHO  [C] Chocolate-Hexen
ECHO  [D] Chocolate-Strife
ECHO  [E] DOOM 64 EX
ECHO  [F] GZDoom
ECHO  [G] PRBoom+ ^(software^)
ECHO  [H] PRBoom+ ^(hardware^)
ECHO  [I] Zandronum ^(v2^)
ECHO  [J] Zandronum ^(v3^)
ECHO  [K] ZDoom
ECHO:
SET /P "$=? "

IF /I "%$%" == "A" (
	REM # delete the user's config that would override the default
	IF EXIST "%SAVES%\config.choco-doom.cfg" DEL "%SAVES%\config.choco-doom.cfg"  >NUL 2>&1
	IF EXIST "%SAVES%\config.choco-doom.extra.cfg" DEL "%SAVES%\config.choco-doom.extra.cfg"  >NUL 2>&1
	REM # launch the engine using our default config file
	CALL %DOOM% /DEFAULT /WAIT choco-doom-setup DOOM
)
IF /I "%$%" == "B" (
	REM # delete the user's config that would override the default
	IF EXIST "%SAVES%\config.choco-heretic.cfg" DEL "%SAVES%\config.choco-heretic.cfg"  >NUL 2>&1
	IF EXIST "%SAVES%\config.choco-heretic.extra.cfg" DEL "%SAVES%\config.choco-heretic.extra.cfg"  >NUL 2>&1
	REM # launch the engine using our default config file
	CALL %DOOM% /DEFAULT /WAIT choco-heretic-setup DOOM
)
IF /I "%$%" == "C" (
	REM # delete the user's config that would override the default
	IF EXIST "%SAVES%\config.choco-hexen.cfg" DEL "%SAVES%\config.choco-hexen.cfg"  >NUL 2>&1
	IF EXIST "%SAVES%\config.choco-hexen.extra.cfg" DEL "%SAVES%\config.choco-hexen.extra.cfg"  >NUL 2>&1
	REM # launch the engine using our default config file
	CALL %DOOM% /DEFAULT /WAIT choco-hexen-setup DOOM
)
IF /I "%$%" == "D" (
	REM # delete the user's config that would override the default
	IF EXIST "%SAVES%\config.choco-strife.cfg" DEL "%SAVES%\config.choco-strife.cfg"  >NUL 2>&1
	IF EXIST "%SAVES%\config.choco-strife.extra.cfg" DEL "%SAVES%\config.choco-strife.extra.cfg"  >NUL 2>&1
	REM # launch the engine using our default config file
	CALL %DOOM% /DEFAULT /WAIT choco-strife-setup DOOM
)
IF /I "%$%" == "E" (
	REM # delete the user's config that would override the default
	IF EXIST "%SAVES%\config.doom64ex.cfg" DEL "%SAVES%\config.doom64ex.cfg"  >NUL 2>&1
	REM # launch the engine using our default config file
	CALL %DOOM% /DEFAULT /WAIT doom64ex DOOM64
)
IF /I "%$%" == "F" (
	REM # delete the user's config that would override the default
	IF EXIST "%SAVES%\config.gzdoom.cfg" DEL "%SAVES%\config.gzdoom.cfg"  >NUL 2>&1
	REM # launch the engine using our default config file
	CALL %DOOM% /DEFAULT /WAIT gzdoom DOOM
)
IF /I "%$%" == "G" (
	REM # delete the user's config that would override the default
	IF EXIST "%SAVES%\config.glboom-plus.cfg" DEL "%SAVES%\config.glboom-plus.cfg"  >NUL 2>&1
	REM # launch the engine using our default config file
	CALL %DOOM% /DEFAULT /WAIT glboom DOOM
)
IF /I "%$%" == "H" (
	REM # delete the user's config that would override the default
	IF EXIST "%SAVES%\config.prboom-plus.cfg" DEL "%SAVES%\config.prboom-plus.cfg"  >NUL 2>&1
	REM # launch the engine using our default config file
	CALL %DOOM% /DEFAULT /WAIT prboom DOOM
)
IF /I "%$%" == "I" (
	REM # delete the user's config that would override the default
	IF EXIST "%SAVES%\config.zandronum.cfg" DEL "%SAVES%\config.zandronum.cfg"  >NUL 2>&1
	REM # launch the engine using our default config file
	CALL %DOOM% /DEFAULT /WAIT zandronum-2 DOOM
)
IF /I "%$%" == "J" (
	REM # delete the user's config that would override the default
	IF EXIST "%SAVES%\config.zandronum-dev.cfg" DEL "%SAVES%\config.zandronum-dev.cfg"  >NUL 2>&1
	REM # launch the engine using our default config file
	CALL %DOOM% /DEFAULT /WAIT zandronum-3 DOOM
)
IF /I "%$%" == "K" (
	REM # delete the user's config that would override the default
	IF EXIST "%SAVES%\config.zdoom.cfg" DEL "%SAVES%\config.zdoom.cfg"  >NUL 2>&1
	REM # launch the engine using our default config file
	CALL %DOOM% /DEFAULT /WAIT zdoom DOOM
)
REM # secret for the moment
IF /I "%$%" == "Q" (
	REM # delete the user's config that would override the default
	IF EXIST "%SAVES%\config.qzdoom.cfg" DEL "%SAVES%\config.qzdoom.cfg"  >NUL 2>&1
	REM # launch the engine using our default config file
	CALL %DOOM% /DEFAULT /WAIT qzdoom DOOM
)

POPD