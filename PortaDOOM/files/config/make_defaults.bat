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
ECHO Chocolate Doom             DOOM.WAD
CALL :start "choco-doom" "DOOM.WAD"

ECHO Chocolate Doom             DOOM2.WAD
CALL :start "choco-doom" "DOOM2.WAD"

ECHO Chocolate Doom             TNT.WAD
CALL :start "choco-doom" "TNT.WAD"

ECHO Chocolate Doom             PLUTONIA.WAD
CALL :start "choco-doom" "PLUTONIA.WAD"

ECHO Chocolate Heretic          HERETIC.WAD
CALL :start "choco-heretic" "HERETIC.WAD"

ECHO Chocolate Hexen            HEXEN.WAD
CALL :start "choco-hexen" "HEXEN.WAD"

ECHO Chocolate Strife           STRIFE1.WAD
CALL :start "choco-strife" "STRIFE1.WAD"

ECHO Crispy Doom                DOOM.WAD
CALL :start "crispy-doom" "DOOM.WAD"

ECHO:
PAUSE
EXIT /B


:start
START "" /WAIT "%DOOM%" "/WAIT /USE %~1 /DEFAULT /IWAD %~2 & EXIT"
GOTO:EOF