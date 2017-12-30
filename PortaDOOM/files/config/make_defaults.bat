@ECHO OFF & SETLOCAL ENABLEEXTENSIONS DISABLEDELAYEDEXPANSION

CD %~dp0

REM # relative location of the saves folder (where user-configs are stored)
SET "SAVES=..\saves"
REM # relative path to doom.bat
SET "DOOM=..\doom.bat"
REM # relative path for doom.bat to get to the config folder
SET "CONFIG=..\..\..\config"

CLS
ECHO:

REM # Chocolate Doom / Crispy Doom
REM ----------------------------------------------------------------------------
REM # delete the default config files
DEL "default.choco-doom.cfg"         >NUL 2>&1
DEL "default.choco-doom.extra.cfg"   >NUL 2>&1
DEL "default.crispy-doom.cfg"        >NUL 2>&1
DEL "default.crispy-doom.extra.cfg"  >NUL 2>&1

ECHO Chocolate Doom             DOOM.WAD
CALL :start "choco-doom" "DOOM.WAD"

ECHO Chocolate Heretic          HERETIC.WAD
CALL :start "choco-heretic" "HERETIC.WAD"

ECHO Chocolate Hexen            HEXEN.WAD
CALL :start "choco-hexen" "HEXEN.WAD"

ECHO Chocolate Strife           STRIFE1.WAD
CALL :start "choco-strife" "STRIFE1.WAD"

ECHO Crispy Doom                DOOM.WAD
CALL :start "crispy-doom" "DOOM.WAD"

REM # PrBoom+ (hardware / software)
REM ----------------------------------------------------------------------------
REM # delete the default config files
DEL "default.glboom-plus.cfg"        >NUL 2>&1
DEL "default.prboom-plus.cfg"        >NUL 2>&1

ECHO PrBoom+ ^(hardware^)         DOOM.WAD
CALL :start "prboom" "DOOM.WAD"

ECHO PrBoom+ ^(software^)         DOOM.WAD
CALL :start_sw "prboom" "DOOM.WAD"

REM # Zandronum
REM ----------------------------------------------------------------------------
REM # delete the default config files
DEL "default.zandronum-2.cfg"        >NUL 2>&1
DEL "default.zandronum-3.cfg"        >NUL 2>&1

ECHO Zandronum-2                DOOM.WAD
CALL :start "zandronum-2" "DOOM.WAD"

ECHO Zandronum-2                HERETIC.WAD
CALL :start "zandronum-2" "HERETIC.WAD"

ECHO Zandronum-2                HEXEN.WAD
CALL :start "zandronum-2" "HEXEN.WAD"

ECHO Zandronum-2                STRIFE1.WAD
CALL :start "zandronum-2" "STRIFE1.WAD"

ECHO Zandronum-3                DOOM.WAD
CALL :start "zandronum-3" "DOOM.WAD"

ECHO Zandronum-3                HERETIC.WAD
CALL :start "zandronum-3" "HERETIC.WAD"

ECHO Zandronum-3                HEXEN.WAD
CALL :start "zandronum-3" "HEXEN.WAD"

ECHO Zandronum-3                STRIFE1.WAD
CALL :start "zandronum-3" "STRIFE1.WAD"

ECHO:
PAUSE
EXIT /B

:start
REM #
REM #    %1 = engine-name
REM #    %2 = IWAD
REM ----------------------------------------------------------------------------
REM # launch the engine to generate new default config files
START "" /WAIT "%DOOM%" "/WAIT /USE "%~1" /DEFAULT /IWAD "%~2" & EXIT"
GOTO:EOF

:start_sw
REM #
REM #    %1 = engine-name
REM #    %2 = IWAD
REM ----------------------------------------------------------------------------
REM # launch the engine to generate new default config files
START "" /WAIT "%DOOM%" "/WAIT /USE "%~1" /SW /DEFAULT /IWAD "%~2" & EXIT"
GOTO:EOF
