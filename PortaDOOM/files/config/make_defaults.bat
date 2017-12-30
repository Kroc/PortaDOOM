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
:choco-doom
REM # delete the file in order to re-build it
IF EXIST "default.choco-doom.cfg" GOTO :choco-heretic

ECHO Chocolate Doom             DOOM.WAD
CALL :start "choco-doom" "DOOM.WAD"

:choco-heretic
REM # delete the file in order to re-build it
IF EXIST "default.choco-heretic.cfg" GOTO :choco-hexen

ECHO Chocolate Heretic          HERETIC.WAD
CALL :start "choco-heretic" "HERETIC.WAD"

:choco-hexen
REM # delete the file in order to re-build it
IF EXIST "default.choco-hexen.cfg" GOTO :choco-strife

ECHO Chocolate Hexen            HEXEN.WAD
CALL :start "choco-hexen" "HEXEN.WAD"

:choco-strife
REM # delete the file in order to re-build it
IF EXIST "default.choco-strife.cfg" GOTO :crispy-doom

ECHO Chocolate Strife           STRIFE1.WAD
CALL :start "choco-strife" "STRIFE1.WAD"

:crispy-doom
REM # delete the file in order to re-build it
IF EXIST "default.crispy-doom.cfg" GOTO :glboom-plus

ECHO Crispy Doom                DOOM.WAD
CALL :start "crispy-doom" "DOOM.WAD"

REM # PrBoom+ (hardware / software)
REM ----------------------------------------------------------------------------
:glboom-plus
REM # delete the file in order to re-build it
IF EXIST "default.glboom-plus.cfg" GOTO :prboom-plus

ECHO PrBoom+ ^(hardware^)         DOOM.WAD
CALL :start "prboom" "DOOM.WAD"

:prboom-plus
REM # delete the file in order to re-build it
IF EXIST "default.prboom-plus.cfg" GOTO :zandronum-2

ECHO PrBoom+ ^(software^)         DOOM.WAD
CALL :start_sw "prboom" "DOOM.WAD"

REM # Zandronum
REM ----------------------------------------------------------------------------
:zandronum-2
REM # delete the file in order to re-build it
IF EXIST "default.zandronum-2.ini" GOTO :zandronum-3

ECHO Zandronum-2                DOOM.WAD
CALL :start "zandronum-2" "DOOM.WAD"

ECHO Zandronum-2                HERETIC.WAD
CALL :start "zandronum-2" "HERETIC.WAD"

ECHO Zandronum-2                HEXEN.WAD
CALL :start "zandronum-2" "HEXEN.WAD"

ECHO Zandronum-2                STRIFE1.WAD
CALL :start "zandronum-2" "STRIFE1.WAD"

:zandronum-3
REM # delete the file in order to re-build it
IF EXIST "default.zandronum-3.ini" GOTO :gzdoom-09

ECHO Zandronum-3                DOOM.WAD
CALL :start "zandronum-3" "DOOM.WAD"

ECHO Zandronum-3                HERETIC.WAD
CALL :start "zandronum-3" "HERETIC.WAD"

ECHO Zandronum-3                HEXEN.WAD
CALL :start "zandronum-3" "HEXEN.WAD"

ECHO Zandronum-3                STRIFE1.WAD
CALL :start "zandronum-3" "STRIFE1.WAD"

REM # GZDoom
REM ----------------------------------------------------------------------------
:gzdoom-09
REM # delete the file in order to re-build it
IF EXIST "default.gzdoom-09.ini" GOTO :gzdoom-10

ECHO GZDoom v0.9                DOOM.WAD
CALL :start "gzdoom-09" "DOOM.WAD"

ECHO GZDoom v0.9                HERETIC.WAD
CALL :start "gzdoom-09" "HERETIC.WAD"

ECHO GZDoom v0.9                HEXEN.WAD
CALL :start "gzdoom-09" "HEXEN.WAD"

ECHO GZDoom v0.9                STRIFE1.WAD
CALL :start "gzdoom-09" "STRIFE1.WAD"

:gzdoom-10
REM # delete the file in order to re-build it
IF EXIST "default.gzdoom-10.ini" GOTO :gzdoom-11

ECHO GZDoom v1.0                DOOM.WAD
CALL :start "gzdoom-10" "DOOM.WAD"

ECHO GZDoom v1.0                HERETIC.WAD
CALL :start "gzdoom-10" "HERETIC.WAD"

ECHO GZDoom v1.0                HEXEN.WAD
CALL :start "gzdoom-10" "HEXEN.WAD"

ECHO GZDoom v1.0                STRIFE1.WAD
CALL :start "gzdoom-10" "STRIFE1.WAD"

:gzdoom-11
REM # delete the file in order to re-build it
IF EXIST "default.gzdoom-11.ini" GOTO :gzdoom-12

ECHO GZDoom v1.1                DOOM.WAD
CALL :start "gzdoom-11" "DOOM.WAD"

ECHO GZDoom v1.1                HERETIC.WAD
CALL :start "gzdoom-11" "HERETIC.WAD"

ECHO GZDoom v1.1                HEXEN.WAD
CALL :start "gzdoom-11" "HEXEN.WAD"

ECHO GZDoom v1.1                STRIFE1.WAD
CALL :start "gzdoom-11" "STRIFE1.WAD"

:gzdoom-12
REM # delete the file in order to re-build it
IF EXIST "default.gzdoom-12.ini" GOTO :gzdoom-13

ECHO GZDoom v1.2                DOOM.WAD
CALL :start "gzdoom-12" "DOOM.WAD"

ECHO GZDoom v1.2                HERETIC.WAD
CALL :start "gzdoom-12" "HERETIC.WAD"

ECHO GZDoom v1.2                HEXEN.WAD
CALL :start "gzdoom-12" "HEXEN.WAD"

ECHO GZDoom v1.2                STRIFE1.WAD
CALL :start "gzdoom-12" "STRIFE1.WAD"

:gzdoom-13
REM # delete the file in order to re-build it
IF EXIST "default.gzdoom-13.ini" GOTO :gzdoom-14

ECHO GZDoom v1.3                DOOM.WAD
CALL :start "gzdoom-13" "DOOM.WAD"

ECHO GZDoom v1.3                HERETIC.WAD
CALL :start "gzdoom-13" "HERETIC.WAD"

ECHO GZDoom v1.3                HEXEN.WAD
CALL :start "gzdoom-13" "HEXEN.WAD"

ECHO GZDoom v1.3                STRIFE1.WAD
CALL :start "gzdoom-13" "STRIFE1.WAD"

:gzdoom-14
REM # delete the file in order to re-build it
IF EXIST "default.gzdoom-14.ini" GOTO :gzdoom-15

ECHO GZDoom v1.4                DOOM.WAD
CALL :start "gzdoom-14" "DOOM.WAD"

ECHO GZDoom v1.4                HERETIC.WAD
CALL :start "gzdoom-14" "HERETIC.WAD"

ECHO GZDoom v1.4                HEXEN.WAD
CALL :start "gzdoom-14" "HEXEN.WAD"

ECHO GZDoom v1.4                STRIFE1.WAD
CALL :start "gzdoom-14" "STRIFE1.WAD"

:gzdoom-15
REM # delete the file in order to re-build it
IF EXIST "default.gzdoom-15.ini" GOTO :gzdoom-16

ECHO GZDoom v1.5                DOOM.WAD
CALL :start "gzdoom-15" "DOOM.WAD"

ECHO GZDoom v1.5                HERETIC.WAD
CALL :start "gzdoom-15" "HERETIC.WAD"

ECHO GZDoom v1.5                HEXEN.WAD
CALL :start "gzdoom-15" "HEXEN.WAD"

ECHO GZDoom v1.5                STRIFE1.WAD
CALL :start "gzdoom-15" "STRIFE1.WAD"

:gzdoom-16
REM # delete the file in order to re-build it
IF EXIST "default.gzdoom-16.ini" GOTO :gzdoom-17

ECHO GZDoom v1.6                DOOM.WAD
CALL :start "gzdoom-16" "DOOM.WAD"

ECHO GZDoom v1.6                HERETIC.WAD
CALL :start "gzdoom-16" "HERETIC.WAD"

ECHO GZDoom v1.6                HEXEN.WAD
CALL :start "gzdoom-16" "HEXEN.WAD"

ECHO GZDoom v1.6                STRIFE1.WAD
CALL :start "gzdoom-16" "STRIFE1.WAD"

:gzdoom-17
REM # delete the file in order to re-build it
IF EXIST "default.gzdoom-17.ini" GOTO :gzdoom-18

ECHO GZDoom v1.7                DOOM.WAD
CALL :start "gzdoom-17" "DOOM.WAD"

ECHO GZDoom v1.7                HERETIC.WAD
CALL :start "gzdoom-17" "HERETIC.WAD"

ECHO GZDoom v1.7                HEXEN.WAD
CALL :start "gzdoom-17" "HEXEN.WAD"

ECHO GZDoom v1.7                STRIFE1.WAD
CALL :start "gzdoom-17" "STRIFE1.WAD"

:gzdoom-18
REM # delete the file in order to re-build it
IF EXIST "default.gzdoom-18.ini" GOTO :gzdoom-19

ECHO GZDoom v1.8                DOOM.WAD
CALL :start "gzdoom-18" "DOOM.WAD"

ECHO GZDoom v1.8                HERETIC.WAD
CALL :start "gzdoom-18" "HERETIC.WAD"

ECHO GZDoom v1.8                HEXEN.WAD
CALL :start "gzdoom-18" "HEXEN.WAD"

ECHO GZDoom v1.8                STRIFE1.WAD
CALL :start "gzdoom-18" "STRIFE1.WAD"

:gzdoom-19
REM # delete the file in order to re-build it
IF EXIST "default.gzdoom-19.ini" GOTO :gzdoom-20

ECHO GZDoom v1.9                DOOM.WAD
CALL :start "gzdoom-19" "DOOM.WAD"

ECHO GZDoom v1.9                HERETIC.WAD
CALL :start "gzdoom-19" "HERETIC.WAD"

ECHO GZDoom v1.9                HEXEN.WAD
CALL :start "gzdoom-19" "HEXEN.WAD"

ECHO GZDoom v1.9                STRIFE1.WAD
CALL :start "gzdoom-19" "STRIFE1.WAD"

:gzdoom-20
REM # delete the file in order to re-build it
IF EXIST "default.gzdoom-20.ini" GOTO :gzdoom

ECHO GZDoom v2.0                DOOM.WAD
CALL :start "gzdoom-20" "DOOM.WAD"

ECHO GZDoom v2.0                HERETIC.WAD
CALL :start "gzdoom-20" "HERETIC.WAD"

ECHO GZDoom v2.0                HEXEN.WAD
CALL :start "gzdoom-20" "HEXEN.WAD"

ECHO GZDoom v2.0                STRIFE1.WAD
CALL :start "gzdoom-20" "STRIFE1.WAD"

:gzdoom
REM # delete the file in order to re-build it
IF EXIST "default.gzdoom.ini" GOTO :exit

ECHO GZDoom                     DOOM.WAD
CALL :start "gzdoom" "DOOM.WAD"

ECHO GZDoom                     HERETIC.WAD
CALL :start "gzdoom" "HERETIC.WAD"

ECHO GZDoom                     HEXEN.WAD
CALL :start "gzdoom" "HEXEN.WAD"

ECHO GZDoom                     STRIFE1.WAD
CALL :start "gzdoom" "STRIFE1.WAD"


REM ----------------------------------------------------------------------------

:exit
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
