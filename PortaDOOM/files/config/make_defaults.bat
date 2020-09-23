:: PortaDOOM, copyright (C) Kroc Camen 2016-2019, BSD 2-clause
@ECHO OFF & SETLOCAL ENABLEEXTENSIONS DISABLEDELAYEDEXPANSION

REM # how to store a newline character in a string, thanks to
REM # <https://stackoverflow.com/a/5552995>
SET NEWLINE=^& ECHO:


CLS & TITLE Make Default Config Files
ECHO:
ECHO  Make Default Config Files:
ECHO  ==========================
ECHO:
ECHO  Default settings for each engine are stored in "default.*.cfg/ini" files.
ECHO  Delete any of these files to re-generate them with this script.
ECHO:
ECHO  This script will launch each engine and game combination to populate the
ECHO  config files with defaults. YOU DO NOT NEED TO CHANGE ANY SETTINGS --
ECHO  JUST QUIT EACH ENGINE AS IT APPEARS. This script will inject the config
ECHO  changes afterward.
ECHO:
ECHO  When ready to begin, press any key.
ECHO:
PAUSE>NUL

PUSHD %~dp0

REM # relative location of the saves folder (where user-configs are stored)
SET "SAVES=..\saves"
REM # relative path to launcher.exe
SET "LAUNCHER=..\launcher.exe"

SET BIN_FART=..\tools\fart\fart.exe --quiet --word --c-style --ignore-case --adapt --
SET BIN_INIFILE=..\tools\inifile\inifile.exe


REM # Chocolate Doom / Crispy Doom
REM ============================================================================
:choco-doom
REM # delete the file in order to re-build it
IF EXIST "default.choco-doom.cfg" GOTO :choco-heretic

ECHO * Chocolate Doom             DOOM.WAD
CALL :make_vanilla "choco-doom" "DOOM.WAD"
ECHO * Chocolate Doom             CHEX.WAD
CALL :make_vanilla "choco-doom" "CHEX.WAD"
ECHO ----------------------------------------

:choco-heretic
REM # delete the file in order to re-build it
IF EXIST "default.choco-heretic.cfg" GOTO :choco-hexen

ECHO * Chocolate Heretic          HERETIC.WAD
CALL :make_vanilla "choco-heretic" "HERETIC.WAD"
ECHO ----------------------------------------

:choco-hexen
REM # delete the file in order to re-build it
IF EXIST "default.choco-hexen.cfg" GOTO :choco-strife

ECHO * Chocolate Hexen            HEXEN.WAD
CALL :make_vanilla "choco-hexen" "HEXEN.WAD"
ECHO ----------------------------------------

:choco-strife
REM # delete the file in order to re-build it
IF EXIST "default.choco-strife.cfg" GOTO :crispy-doom

ECHO * Chocolate Strife           STRIFE1.WAD
CALL :make_vanilla "choco-strife" "STRIFE1.WAD"
ECHO ----------------------------------------

:crispy-doom
REM # delete the file in order to re-build it
IF EXIST "default.crispy-doom.cfg" GOTO :doom-retro

ECHO * Crispy Doom                DOOM.WAD
CALL :make_vanilla "crispy-doom" "DOOM.WAD"
ECHO ----------------------------------------


REM # DOOM Retro
REM ============================================================================
:doom-retro
REM # delete the file in order to re-build it
IF EXIST "default.doom-retro.cfg" GOTO :glboom-plus

ECHO * DOOM Retro                 DOOM.WAD
CALL :make_doomretro "doom-retro" "DOOM.WAD"
ECHO ----------------------------------------


REM # PrBoom+ (hardware / software)
REM ============================================================================
:glboom-plus
REM # delete the file in order to re-build it
IF EXIST "default.glboom-plus.cfg" GOTO :prboom-plus

ECHO * PrBoom+ ^(hardware^)         DOOM.WAD
CALL :make_boom_hw "prboom-plus" "DOOM.WAD"
ECHO * PrBoom+ ^(hardware^)         CHEX.WAD
CALL :make_boom_hw "prboom-plus" "CHEX.WAD"

:prboom-plus
REM # delete the file in order to re-build it
IF EXIST "default.prboom-plus.cfg" GOTO :zandronum-2

ECHO * PrBoom+ ^(software^)         DOOM.WAD
CALL :make_boom_sw "prboom-plus" "DOOM.WAD"
ECHO * PrBoom+ ^(software^)         CHEX.WAD
CALL :make_boom_sw "prboom-plus" "CHEX.WAD"
ECHO ----------------------------------------


REM # Zandronum
REM ============================================================================
:zandronum-2
REM # delete the file in order to re-build it
IF EXIST "default.zandronum-2.ini" GOTO :zandronum-3

ECHO * Zandronum-2                DOOM.WAD
CALL :make_zandronum "zandronum-2" "DOOM.WAD"
ECHO * Zandronum-2                HERETIC.WAD
CALL :make_zandronum "zandronum-2" "HERETIC.WAD"
ECHO * Zandronum-2                HEXEN.WAD
CALL :make_zandronum "zandronum-2" "HEXEN.WAD"
ECHO * Zandronum-2                STRIFE1.WAD
CALL :make_zandronum "zandronum-2" "STRIFE1.WAD"
ECHO * Zandronum-2                CHEX.WAD
CALL :make_zandronum "zandronum-2" "CHEX.WAD"
ECHO ----------------------------------------

:zandronum-3
REM # delete the file in order to re-build it
IF EXIST "default.zandronum-3.ini" GOTO :gzdoom-10

ECHO * Zandronum-3                DOOM.WAD
CALL :make_zandronum "zandronum-3" "DOOM.WAD"
ECHO * Zandronum-3                HERETIC.WAD
CALL :make_zandronum "zandronum-3" "HERETIC.WAD"
ECHO * Zandronum-3                HEXEN.WAD
CALL :make_zandronum "zandronum-3" "HEXEN.WAD"
ECHO * Zandronum-3                STRIFE1.WAD
CALL :make_zandronum "zandronum-3" "STRIFE1.WAD"
ECHO * Zandronum-3                CHEX.WAD
CALL :make_zandronum "zandronum-3" "CHEX.WAD"
ECHO * Zandronum-3                HARM1.WAD
CALL :make_zandronum "zandronum-3" "HARM1.WAD"
ECHO ----------------------------------------


REM # GZDoom
REM ============================================================================
:gzdoom-10
REM # delete the file in order to re-build it
IF EXIST "default.gzdoom-10.ini" GOTO :gzdoom-11

ECHO * GZDoom v1.0                DOOM.WAD
CALL :make_gzdoom "gzdoom-10" "DOOM.WAD"
ECHO * GZDoom v1.0                HERETIC.WAD
CALL :make_gzdoom "gzdoom-10" "HERETIC.WAD"
ECHO * GZDoom v1.0                HEXEN.WAD
CALL :make_gzdoom "gzdoom-10" "HEXEN.WAD"
ECHO * GZDoom v1.0                STRIFE1.WAD
CALL :make_gzdoom "gzdoom-10" "STRIFE1.WAD"
ECHO ----------------------------------------

:gzdoom-11
REM # delete the file in order to re-build it
IF EXIST "default.gzdoom-11.ini" GOTO :gzdoom-12

ECHO * GZDoom v1.1                DOOM.WAD
CALL :make_gzdoom "gzdoom-11" "DOOM.WAD"
ECHO * GZDoom v1.1                HERETIC.WAD
CALL :make_gzdoom "gzdoom-11" "HERETIC.WAD"
ECHO * GZDoom v1.1                HEXEN.WAD
CALL :make_gzdoom "gzdoom-11" "HEXEN.WAD"
ECHO * GZDoom v1.1                STRIFE1.WAD
CALL :make_gzdoom "gzdoom-11" "STRIFE1.WAD"
ECHO * GZDoom v1.1                CHEX.WAD
CALL :make_gzdoom "gzdoom-11" "CHEX.WAD"
ECHO ----------------------------------------

:gzdoom-12
REM # delete the file in order to re-build it
IF EXIST "default.gzdoom-12.ini" GOTO :gzdoom-13

ECHO * GZDoom v1.2                DOOM.WAD
CALL :make_gzdoom "gzdoom-12" "DOOM.WAD"
ECHO * GZDoom v1.2                HERETIC.WAD
CALL :make_gzdoom "gzdoom-12" "HERETIC.WAD"
ECHO * GZDoom v1.2                HEXEN.WAD
CALL :make_gzdoom "gzdoom-12" "HEXEN.WAD"
ECHO * GZDoom v1.2                STRIFE1.WAD
CALL :make_gzdoom "gzdoom-12" "STRIFE1.WAD"
ECHO * GZDoom v1.2                CHEX.WAD
CALL :make_gzdoom "gzdoom-12" "CHEX.WAD"
ECHO ----------------------------------------

:gzdoom-13
REM # delete the file in order to re-build it
IF EXIST "default.gzdoom-13.ini" GOTO :gzdoom-14

ECHO * GZDoom v1.3                DOOM.WAD
CALL :make_gzdoom "gzdoom-13" "DOOM.WAD"
ECHO * GZDoom v1.3                HERETIC.WAD
CALL :make_gzdoom "gzdoom-13" "HERETIC.WAD"
ECHO * GZDoom v1.3                HEXEN.WAD
CALL :make_gzdoom "gzdoom-13" "HEXEN.WAD"
ECHO * GZDoom v1.3                STRIFE1.WAD
CALL :make_gzdoom "gzdoom-13" "STRIFE1.WAD"
ECHO * GZDoom v1.3                CHEX.WAD
CALL :make_gzdoom "gzdoom-13" "CHEX.WAD"
ECHO ----------------------------------------

:gzdoom-14
REM # delete the file in order to re-build it
IF EXIST "default.gzdoom-14.ini" GOTO :gzdoom-15

ECHO * GZDoom v1.4                DOOM.WAD
CALL :make_gzdoom "gzdoom-14" "DOOM.WAD"
ECHO * GZDoom v1.4                HERETIC.WAD
CALL :make_gzdoom "gzdoom-14" "HERETIC.WAD"
ECHO * GZDoom v1.4                HEXEN.WAD
CALL :make_gzdoom "gzdoom-14" "HEXEN.WAD"
ECHO * GZDoom v1.4                STRIFE1.WAD
CALL :make_gzdoom "gzdoom-14" "STRIFE1.WAD"
ECHO * GZDoom v1.4                CHEX.WAD
CALL :make_gzdoom "gzdoom-14" "CHEX.WAD"
ECHO ----------------------------------------

:gzdoom-15
REM # delete the file in order to re-build it
IF EXIST "default.gzdoom-15.ini" GOTO :gzdoom-16

ECHO * GZDoom v1.5                DOOM.WAD
CALL :make_gzdoom "gzdoom-15" "DOOM.WAD"
ECHO * GZDoom v1.5                HERETIC.WAD
CALL :make_gzdoom "gzdoom-15" "HERETIC.WAD"
ECHO * GZDoom v1.5                HEXEN.WAD
CALL :make_gzdoom "gzdoom-15" "HEXEN.WAD"
ECHO * GZDoom v1.5                STRIFE1.WAD
CALL :make_gzdoom "gzdoom-15" "STRIFE1.WAD"
ECHO * GZDoom v1.5                CHEX.WAD
CALL :make_gzdoom "gzdoom-15" "CHEX.WAD"
REM # from GZDoom v1.5 we gain supprto for Harmony.
REM # technically v1.4 supports it, but it doesn't
REM # populate the config defaults as expected
ECHO * GZDoom v1.5                HARM1.WAD
CALL :make_gzdoom "gzdoom-15" "HARM1.WAD"
ECHO ----------------------------------------

:gzdoom-16
REM # delete the file in order to re-build it
IF EXIST "default.gzdoom-16.ini" GOTO :gzdoom-17

ECHO * GZDoom v1.6                DOOM.WAD
CALL :make_gzdoom "gzdoom-16" "DOOM.WAD"
ECHO * GZDoom v1.6                HERETIC.WAD
CALL :make_gzdoom "gzdoom-16" "HERETIC.WAD"
ECHO * GZDoom v1.6                HEXEN.WAD
CALL :make_gzdoom "gzdoom-16" "HEXEN.WAD"
ECHO * GZDoom v1.6                STRIFE1.WAD
CALL :make_gzdoom "gzdoom-16" "STRIFE1.WAD"
ECHO * GZDoom v1.6                CHEX.WAD
CALL :make_gzdoom "gzdoom-16" "CHEX.WAD"
ECHO * GZDoom v1.6                HARM1.WAD
CALL :make_gzdoom "gzdoom-16" "HARM1.WAD"
ECHO ----------------------------------------

:gzdoom-17
REM # delete the file in order to re-build it
IF EXIST "default.gzdoom-17.ini" GOTO :gzdoom-18

ECHO * GZDoom v1.7                DOOM.WAD
CALL :make_gzdoom "gzdoom-17" "DOOM.WAD"
ECHO * GZDoom v1.7                HERETIC.WAD
CALL :make_gzdoom "gzdoom-17" "HERETIC.WAD"
ECHO * GZDoom v1.7                HEXEN.WAD
CALL :make_gzdoom "gzdoom-17" "HEXEN.WAD"
ECHO * GZDoom v1.7                STRIFE1.WAD
CALL :make_gzdoom "gzdoom-17" "STRIFE1.WAD"
ECHO * GZDoom v1.7                CHEX.WAD
CALL :make_gzdoom "gzdoom-17" "CHEX.WAD"
ECHO * GZDoom v1.7                HARM1.WAD
CALL :make_gzdoom "gzdoom-17" "HARM1.WAD"
ECHO ----------------------------------------

:gzdoom-18
REM # delete the file in order to re-build it
IF EXIST "default.gzdoom-18.ini" GOTO :gzdoom-19

ECHO * GZDoom v1.8                DOOM.WAD
CALL :make_gzdoom "gzdoom-18" "DOOM.WAD"
ECHO * GZDoom v1.8                HERETIC.WAD
CALL :make_gzdoom "gzdoom-18" "HERETIC.WAD"
ECHO * GZDoom v1.8                HEXEN.WAD
CALL :make_gzdoom "gzdoom-18" "HEXEN.WAD"
ECHO * GZDoom v1.8                STRIFE1.WAD
CALL :make_gzdoom "gzdoom-18" "STRIFE1.WAD"
ECHO * GZDoom v1.8                CHEX.WAD
CALL :make_gzdoom "gzdoom-18" "CHEX.WAD"
ECHO * GZDoom v1.8                HARM1.WAD
CALL :make_gzdoom "gzdoom-18" "HARM1.WAD"
ECHO ----------------------------------------

:gzdoom-19
REM # delete the file in order to re-build it
IF EXIST "default.gzdoom-19.ini" GOTO :gzdoom-20

ECHO * GZDoom v1.9                DOOM.WAD
CALL :make_gzdoom "gzdoom-19" "DOOM.WAD"
ECHO * GZDoom v1.9                HERETIC.WAD
CALL :make_gzdoom "gzdoom-19" "HERETIC.WAD"
ECHO * GZDoom v1.9                HEXEN.WAD
CALL :make_gzdoom "gzdoom-19" "HEXEN.WAD"
ECHO * GZDoom v1.9                STRIFE1.WAD
CALL :make_gzdoom "gzdoom-19" "STRIFE1.WAD"
ECHO * GZDoom v1.9                CHEX.WAD
CALL :make_gzdoom "gzdoom-19" "CHEX.WAD"
ECHO * GZDoom v1.9                HARM1.WAD
CALL :make_gzdoom "gzdoom-19" "HARM1.WAD"
ECHO ----------------------------------------

:gzdoom-20
REM # delete the file in order to re-build it
IF EXIST "default.gzdoom-20.ini" GOTO :gzdoom-21

ECHO * GZDoom v2.0                DOOM.WAD
CALL :make_gzdoom "gzdoom-20" "DOOM.WAD"
ECHO * GZDoom v2.0                HERETIC.WAD
CALL :make_gzdoom "gzdoom-20" "HERETIC.WAD"
ECHO * GZDoom v2.0                HEXEN.WAD
CALL :make_gzdoom "gzdoom-20" "HEXEN.WAD"
ECHO * GZDoom v2.0                STRIFE1.WAD
CALL :make_gzdoom "gzdoom-20" "STRIFE1.WAD"
ECHO * GZDoom v2.0                CHEX.WAD
CALL :make_gzdoom "gzdoom-20" "CHEX.WAD"
ECHO * GZDoom v2.0                HARM1.WAD
CALL :make_gzdoom "gzdoom-20" "HARM1.WAD"
ECHO ----------------------------------------

:gzdoom-21
REM # delete the file in order to re-build it
IF EXIST "default.gzdoom-21.ini" GOTO :gzdoom-22

ECHO * GZDoom v2.1                DOOM.WAD
CALL :make_gzdoom "gzdoom-21" "DOOM.WAD"
ECHO * GZDoom v2.1                HERETIC.WAD
CALL :make_gzdoom "gzdoom-21" "HERETIC.WAD"
ECHO * GZDoom v2.1                HEXEN.WAD
CALL :make_gzdoom "gzdoom-21" "HEXEN.WAD"
ECHO * GZDoom v2.1                STRIFE1.WAD
CALL :make_gzdoom "gzdoom-21" "STRIFE1.WAD"
ECHO * GZDoom v2.1                CHEX.WAD
CALL :make_gzdoom "gzdoom-21" "CHEX.WAD"
ECHO * GZDoom v2.1                HARM1.WAD
CALL :make_gzdoom "gzdoom-21" "HARM1.WAD"
ECHO ----------------------------------------

:gzdoom-22
REM # delete the file in order to re-build it
IF EXIST "default.gzdoom-22.ini" GOTO :gzdoom-23

ECHO * GZDoom v2.2                DOOM.WAD
CALL :make_gzdoom "gzdoom-22" "DOOM.WAD"
ECHO * GZDoom v2.2                HERETIC.WAD
CALL :make_gzdoom "gzdoom-22" "HERETIC.WAD"
ECHO * GZDoom v2.2                HEXEN.WAD
CALL :make_gzdoom "gzdoom-22" "HEXEN.WAD"
ECHO * GZDoom v2.2                STRIFE1.WAD
CALL :make_gzdoom "gzdoom-22" "STRIFE1.WAD"
ECHO * GZDoom v2.2                CHEX.WAD
CALL :make_gzdoom "gzdoom-22" "CHEX.WAD"
ECHO * GZDoom v2.2                HARM1.WAD
CALL :make_gzdoom "gzdoom-22" "HARM1.WAD"
ECHO ----------------------------------------

:gzdoom-23
REM # delete the file in order to re-build it
IF EXIST "default.gzdoom-23.ini" GOTO :gzdoom-24

ECHO * GZDoom v2.3                DOOM.WAD
CALL :make_gzdoom "gzdoom-23" "DOOM.WAD"
ECHO * GZDoom v2.3                HERETIC.WAD
CALL :make_gzdoom "gzdoom-23" "HERETIC.WAD"
ECHO * GZDoom v2.3                HEXEN.WAD
CALL :make_gzdoom "gzdoom-23" "HEXEN.WAD"
ECHO * GZDoom v2.3                STRIFE1.WAD
CALL :make_gzdoom "gzdoom-23" "STRIFE1.WAD"
ECHO * GZDoom v2.3                CHEX.WAD
CALL :make_gzdoom "gzdoom-23" "CHEX.WAD"
ECHO * GZDoom v2.3                HARM1.WAD
CALL :make_gzdoom "gzdoom-23" "HARM1.WAD"
ECHO ----------------------------------------

:gzdoom-24
REM # delete the file in order to re-build it
IF EXIST "default.gzdoom-24.ini" GOTO :gzdoom-32

ECHO * GZDoom v2.4                DOOM.WAD
CALL :make_gzdoom "gzdoom-24" "DOOM.WAD"
ECHO * GZDoom v2.4                HERETIC.WAD
CALL :make_gzdoom "gzdoom-24" "HERETIC.WAD"
ECHO * GZDoom v2.4                HEXEN.WAD
CALL :make_gzdoom "gzdoom-24" "HEXEN.WAD"
ECHO * GZDoom v2.4                STRIFE1.WAD
CALL :make_gzdoom "gzdoom-24" "STRIFE1.WAD"
ECHO * GZDoom v2.4                CHEX.WAD
CALL :make_gzdoom "gzdoom-24" "CHEX.WAD"
ECHO * GZDoom v2.4                HARM1.WAD
CALL :make_gzdoom "gzdoom-24" "HARM1.WAD"
ECHO ----------------------------------------

:gzdoom-32
REM # delete the file in order to re-build it
IF EXIST "default.gzdoom-32.ini" GOTO :gzdoom-33

ECHO * GZDoom v3.2                DOOM.WAD
CALL :make_gzdoom "gzdoom-32" "DOOM.WAD"
ECHO * GZDoom v3.2                HERETIC.WAD
CALL :make_gzdoom "gzdoom-32" "HERETIC.WAD"
ECHO * GZDoom v3.2                HEXEN.WAD
CALL :make_gzdoom "gzdoom-32" "HEXEN.WAD"
ECHO * GZDoom v3.2                STRIFE1.WAD
CALL :make_gzdoom "gzdoom-32" "STRIFE1.WAD"
ECHO * GZDoom v3.2                CHEX.WAD
CALL :make_gzdoom "gzdoom-32" "CHEX.WAD"
ECHO * GZDoom v3.2                HARM1.WAD
CALL :make_gzdoom "gzdoom-32" "HARM1.WAD"
REM # Rise Of The Wool Ball detected as an IWAD here
ECHO * GZDoom v3.2                ROTWB.WAD
CALL :make_gzdoom "gzdoom-32" "ROTWB.WAD"
ECHO ----------------------------------------

:gzdoom-33
REM # delete the file in order to re-build it
IF EXIST "default.gzdoom-33.ini" GOTO :gzdoom-34

ECHO * GZDoom v3.3                DOOM.WAD
CALL :make_gzdoom "gzdoom-33" "DOOM.WAD"
ECHO * GZDoom v3.3                HERETIC.WAD
CALL :make_gzdoom "gzdoom-33" "HERETIC.WAD"
ECHO * GZDoom v3.3                HEXEN.WAD
CALL :make_gzdoom "gzdoom-33" "HEXEN.WAD"
ECHO * GZDoom v3.3                STRIFE1.WAD
CALL :make_gzdoom "gzdoom-33" "STRIFE1.WAD"
ECHO * GZDoom v3.3                CHEX.WAD
CALL :make_gzdoom "gzdoom-33" "CHEX.WAD"
ECHO * GZDoom v3.3                HARM1.WAD
CALL :make_gzdoom "gzdoom-33" "HARM1.WAD"
ECHO * GZDoom v3.3                ROTWB.WAD
CALL :make_gzdoom "gzdoom-33" "ROTWB.WAD"
REM # Adventures of Square support from here
ECHO * GZDoom v3.3                SQUARE1.PK3
CALL :make_gzdoom "gzdoom-33" "square1.pk3"
ECHO ----------------------------------------

:gzdoom-34
REM # delete the file in order to re-build it
IF EXIST "default.gzdoom-34.ini" GOTO :gzdoom-35

ECHO * GZDoom v3.4                DOOM.WAD
CALL :make_gzdoom "gzdoom-34" "DOOM.WAD"
ECHO * GZDoom v3.4                HERETIC.WAD
CALL :make_gzdoom "gzdoom-34" "HERETIC.WAD"
ECHO * GZDoom v3.4                HEXEN.WAD
CALL :make_gzdoom "gzdoom-34" "HEXEN.WAD"
ECHO * GZDoom v3.4                STRIFE1.WAD
CALL :make_gzdoom "gzdoom-34" "STRIFE1.WAD"
ECHO * GZDoom v3.4                CHEX.WAD
CALL :make_gzdoom "gzdoom-34" "CHEX.WAD"
ECHO * GZDoom v3.4                HARM1.WAD
CALL :make_gzdoom "gzdoom-34" "HARM1.WAD"
ECHO * GZDoom v3.4                ROTWB.WAD
CALL :make_gzdoom "gzdoom-34" "ROTWB.WAD"
ECHO * GZDoom v3.4                SQUARE1.PK3
CALL :make_gzdoom "gzdoom-34" "square1.pk3"
ECHO ----------------------------------------

:gzdoom-35
REM # delete the file in order to re-build it
IF EXIST "default.gzdoom-35.ini" GOTO :gzdoom-36

ECHO * GZDoom v3.5                DOOM.WAD
CALL :make_gzdoom "gzdoom-35" "DOOM.WAD"
ECHO * GZDoom v3.5                HERETIC.WAD
CALL :make_gzdoom "gzdoom-35" "HERETIC.WAD"
ECHO * GZDoom v3.5                HEXEN.WAD
CALL :make_gzdoom "gzdoom-35" "HEXEN.WAD"
ECHO * GZDoom v3.5                STRIFE1.WAD
CALL :make_gzdoom "gzdoom-35" "STRIFE1.WAD"
ECHO * GZDoom v3.5                CHEX.WAD
CALL :make_gzdoom "gzdoom-35" "CHEX.WAD"
ECHO * GZDoom v3.5                HARM1.WAD
CALL :make_gzdoom "gzdoom-35" "HARM1.WAD"
ECHO * GZDoom v3.5                ROTWB.WAD
CALL :make_gzdoom "gzdoom-35" "ROTWB.WAD"
ECHO * GZDoom v3.5                SQUARE1.PK3
CALL :make_gzdoom "gzdoom-35" "square1.pk3"
ECHO ----------------------------------------

:gzdoom-36
REM # delete the file in order to re-build it
IF EXIST "default.gzdoom-36.ini" GOTO :gzdoom-37

ECHO * GZDoom v3.6                DOOM.WAD
CALL :make_gzdoom "gzdoom-36" "DOOM.WAD"
ECHO * GZDoom v3.6                HERETIC.WAD
CALL :make_gzdoom "gzdoom-36" "HERETIC.WAD"
ECHO * GZDoom v3.6                HEXEN.WAD
CALL :make_gzdoom "gzdoom-36" "HEXEN.WAD"
ECHO * GZDoom v3.6                STRIFE1.WAD
CALL :make_gzdoom "gzdoom-36" "STRIFE1.WAD"
ECHO * GZDoom v3.6                CHEX.WAD
CALL :make_gzdoom "gzdoom-36" "CHEX.WAD"
ECHO * GZDoom v3.6                HARM1.WAD
CALL :make_gzdoom "gzdoom-36" "HARM1.WAD"
ECHO * GZDoom v3.6                ROTWB.WAD
CALL :make_gzdoom "gzdoom-36" "ROTWB.WAD"
ECHO * GZDoom v3.6                SQUARE1.PK3
CALL :make_gzdoom "gzdoom-36" "square1.pk3"
ECHO ----------------------------------------

:gzdoom-37
REM # delete the file in order to re-build it
IF EXIST "default.gzdoom-37.ini" GOTO :gzdoom-41

ECHO * GZDoom v3.7                DOOM.WAD
CALL :make_gzdoom "gzdoom-37" "DOOM.WAD"
ECHO * GZDoom v3.7                HERETIC.WAD
CALL :make_gzdoom "gzdoom-37" "HERETIC.WAD"
ECHO * GZDoom v3.7                HEXEN.WAD
CALL :make_gzdoom "gzdoom-37" "HEXEN.WAD"
ECHO * GZDoom v3.7                STRIFE1.WAD
CALL :make_gzdoom "gzdoom-37" "STRIFE1.WAD"
ECHO * GZDoom v3.7                CHEX.WAD
CALL :make_gzdoom "gzdoom-37" "CHEX.WAD"
ECHO * GZDoom v3.7                HARM1.WAD
CALL :make_gzdoom "gzdoom-37" "HARM1.WAD"
ECHO * GZDoom v3.7                ROTWB.WAD
CALL :make_gzdoom "gzdoom-37" "ROTWB.WAD"
ECHO * GZDoom v3.7                SQUARE1.PK3
CALL :make_gzdoom "gzdoom-37" "square1.pk3"
ECHO ----------------------------------------

:gzdoom-41
REM # delete the file in order to re-build it
IF EXIST "default.gzdoom-41.ini" GOTO :gzdoom-42

ECHO * GZDoom v4.1                DOOM.WAD
CALL :make_gzdoom "gzdoom-41" "DOOM.WAD"
ECHO * GZDoom v4.1                HERETIC.WAD
CALL :make_gzdoom "gzdoom-41" "HERETIC.WAD"
ECHO * GZDoom v4.1                HEXEN.WAD
CALL :make_gzdoom "gzdoom-41" "HEXEN.WAD"
ECHO * GZDoom v4.1                STRIFE1.WAD
CALL :make_gzdoom "gzdoom-41" "STRIFE1.WAD"
ECHO * GZDoom v4.1                CHEX.WAD
CALL :make_gzdoom "gzdoom-41" "CHEX.WAD"
ECHO * GZDoom v4.1                HARM1.WAD
CALL :make_gzdoom "gzdoom-41" "HARM1.WAD"
ECHO * GZDoom v4.1                ROTWB.WAD
CALL :make_gzdoom "gzdoom-41" "ROTWB.WAD"
ECHO * GZDoom v4.1                SQUARE1.PK3
CALL :make_gzdoom "gzdoom-41" "square1.pk3"
ECHO ----------------------------------------

:gzdoom-42
REM # delete the file in order to re-build it
IF EXIST "default.gzdoom-42.ini" GOTO :gzdoom-43

ECHO * GZDoom v4.2                DOOM.WAD
CALL :make_gzdoom "gzdoom-42" "DOOM.WAD"
ECHO * GZDoom v4.2                HERETIC.WAD
CALL :make_gzdoom "gzdoom-42" "HERETIC.WAD"
ECHO * GZDoom v4.2                HEXEN.WAD
CALL :make_gzdoom "gzdoom-42" "HEXEN.WAD"
ECHO * GZDoom v4.2                STRIFE1.WAD
CALL :make_gzdoom "gzdoom-42" "STRIFE1.WAD"
ECHO * GZDoom v4.2                CHEX.WAD
CALL :make_gzdoom "gzdoom-42" "CHEX.WAD"
ECHO * GZDoom v4.2                HARM1.WAD
CALL :make_gzdoom "gzdoom-42" "HARM1.WAD"
ECHO * GZDoom v4.2                ROTWB.WAD
CALL :make_gzdoom "gzdoom-42" "ROTWB.WAD"
ECHO * GZDoom v4.2                SQUARE1.PK3
CALL :make_gzdoom "gzdoom-42" "square1.pk3"
ECHO ----------------------------------------

:gzdoom-43
REM # delete the file in order to re-build it
IF EXIST "default.gzdoom-43.ini" GOTO :gzdoom-44

ECHO * GZDoom v4.3                DOOM.WAD
CALL :make_gzdoom "gzdoom-43" "DOOM.WAD"
ECHO * GZDoom v4.3                HERETIC.WAD
CALL :make_gzdoom "gzdoom-43" "HERETIC.WAD"
ECHO * GZDoom v4.3                HEXEN.WAD
CALL :make_gzdoom "gzdoom-43" "HEXEN.WAD"
ECHO * GZDoom v4.3                STRIFE1.WAD
CALL :make_gzdoom "gzdoom-43" "STRIFE1.WAD"
ECHO * GZDoom v4.3                CHEX.WAD
CALL :make_gzdoom "gzdoom-43" "CHEX.WAD"
ECHO * GZDoom v4.3                HARM1.WAD
CALL :make_gzdoom "gzdoom-43" "HARM1.WAD"
ECHO * GZDoom v4.3                ROTWB.WAD
CALL :make_gzdoom "gzdoom-43" "ROTWB.WAD"
ECHO * GZDoom v4.3                SQUARE1.PK3
CALL :make_gzdoom "gzdoom-43" "square1.pk3"
ECHO ----------------------------------------

:gzdoom-44
REM # delete the file in order to re-build it
IF EXIST "default.gzdoom-44.ini" GOTO :gzdoom

ECHO * GZDoom v4.4                DOOM.WAD
CALL :make_gzdoom "gzdoom-44" "DOOM.WAD"
ECHO * GZDoom v4.4                HERETIC.WAD
CALL :make_gzdoom "gzdoom-44" "HERETIC.WAD"
ECHO * GZDoom v4.4                HEXEN.WAD
CALL :make_gzdoom "gzdoom-44" "HEXEN.WAD"
ECHO * GZDoom v4.4                STRIFE1.WAD
CALL :make_gzdoom "gzdoom-44" "STRIFE1.WAD"
ECHO * GZDoom v4.4                CHEX.WAD
CALL :make_gzdoom "gzdoom-44" "CHEX.WAD"
ECHO * GZDoom v4.4                HARM1.WAD
CALL :make_gzdoom "gzdoom-44" "HARM1.WAD"
ECHO * GZDoom v4.4                ROTWB.WAD
CALL :make_gzdoom "gzdoom-44" "ROTWB.WAD"
ECHO * GZDoom v4.4                SQUARE1.PK3
CALL :make_gzdoom "gzdoom-44" "square1.pk3"
ECHO ----------------------------------------

:gzdoom
REM # delete the file in order to re-build it
IF EXIST "default.gzdoom.ini" GOTO :zdoom

ECHO * GZDoom                     DOOM.WAD
CALL :make_gzdoom "gzdoom" "DOOM.WAD"
ECHO * GZDoom                     HERETIC.WAD
CALL :make_gzdoom "gzdoom" "HERETIC.WAD"
ECHO * GZDoom                     HEXEN.WAD
CALL :make_gzdoom "gzdoom" "HEXEN.WAD"
ECHO * GZDoom                     STRIFE1.WAD
CALL :make_gzdoom "gzdoom" "STRIFE1.WAD"
ECHO * GZDoom                     CHEX.WAD
CALL :make_gzdoom "gzdoom" "CHEX.WAD"
ECHO * GZDoom                     HARM1.WAD
CALL :make_gzdoom "gzdoom" "HARM1.WAD"
ECHO * GZDoom                     ROTWB.WAD
CALL :make_gzdoom "gzdoom" "ROTWB.WAD"
ECHO * GZDoom                     SQUARE1.PK3
CALL :make_gzdoom "gzdoom" "square1.pk3"
ECHO ----------------------------------------

REM # ZDoom
REM ============================================================================
:zdoom
REM # delete the file in order to re-build it
IF EXIST "default.zdoom.ini" GOTO :doom64

ECHO * ZDoom v2.8.1               DOOM.WAD
CALL :make_zdoom "zdoom" "DOOM.WAD"
ECHO * ZDoom v2.8.1               HERETIC.WAD
CALL :make_zdoom "zdoom" "HERETIC.WAD"
ECHO * ZDoom v2.8.1               HEXEN.WAD
CALL :make_zdoom "zdoom" "HEXEN.WAD"
ECHO * ZDoom v2.8.1               STRIFE1.WAD
CALL :make_zdoom "zdoom" "STRIFE1.WAD"
ECHO * ZDoom v2.8.1               CHEX.WAD
CALL :make_zdoom "zdoom" "CHEX.WAD"
ECHO * ZDoom v2.8.1               HARM1.WAD
CALL :make_zdoom "zdoom" "HARM1.WAD"
ECHO ----------------------------------------

REM # DOOM 64
REM ============================================================================
:doom64
REM # delete the file in order to re-build it
IF EXIST "default.doom64ex.cfg" GOTO :exit

ECHO * DOOM 64 EX                 DOOM64.WAD
CALL :make_doom64 "doom64ex" "DOOM64.WAD"
ECHO ----------------------------------------


REM ----------------------------------------------------------------------------

:exit
ECHO:
POPD
PAUSE
EXIT /B



:make_doomretro
REM #
REM #    %1 = engine-name
REM #    %2 = IWAD
REM ----------------------------------------------------------------------------
REM # launch the engine to generate new default config files
START "" /WAIT "%LAUNCHER%" /WAIT /AUTO /USE "%~1" /DEFAULT /IWAD "%~2"

%BIN_FART% "default.%~1.cfg" "alwaysrun off"		"alwaysrun on"
%BIN_FART% "default.%~1.cfg" "messages off"		"messages on"
%BIN_FART% "default.%~1.cfg" "am_rotatemode on"		"am_rotatemode off"
%BIN_FART% "default.%~1.cfg" "playername \"you\""	"playername \"PortaDOOM\""
ECHO bind 'f12' +screenshot>>"default.%~1.cfg"

%BIN_FART% "default.%~1.cfg" ^
	"iwadfolder \"C:\\GAMES\\GOG\\DOOM 2\\.\"" ^
	"iwadfolder \"\""

REM # TODO: reset the stats properties

GOTO:EOF


:make_vanilla
REM #
REM #    %1 = engine-name
REM #    %2 = IWAD
REM ----------------------------------------------------------------------------
REM # launch the engine to generate new default config files
START "" /WAIT "%LAUNCHER%" /WAIT /AUTO /USE "%~1" /DEFAULT /IWAD "%~2"

REM # main keys
%BIN_FART% "default.%~1.cfg" "key_up                        72"		"key_up                        17"
%BIN_FART% "default.%~1.cfg" "key_down                      80"		"key_down                      31"
%BIN_FART% "default.%~1.cfg" "key_strafeleft                51"		"key_strafeleft                30"
%BIN_FART% "default.%~1.cfg" "key_straferight               52"		"key_straferight               32"
%BIN_FART% "default.%~1.cfg" "key_use                       57"		"key_use                       18"

REM # mouse-movement off
%BIN_FART% "default.%~1.extra.cfg" "novert                        0"	"novert                        1"
%BIN_FART% "default.%~1.cfg" "mouseb_strafe                 1"		"mouseb_strafe                 -1"
%BIN_FART% "default.%~1.cfg" "mouseb_forward                2"		"mouseb_forward                -1"
REM # mouse controls
%BIN_FART% "default.%~1.extra.cfg" "mouseb_prevweapon             -1"	"mouseb_prevweapon             4"
%BIN_FART% "default.%~1.extra.cfg" "mouseb_nextweapon             -1"	"mouseb_nextweapon             3"
%BIN_FART% "default.%~1.extra.cfg" "dclick_use                    1"	"dclick_use                    0"

REM # always run
%BIN_FART% "default.%~1.cfg" "joyb_speed                    2"		"joyb_speed                    29"

REM # compatibility
%BIN_FART% "default.%~1.extra.cfg" "fullscreen                    0"	"fullscreen                    1"
%BIN_FART% "default.%~1.extra.cfg" "show_endoom                   1"	"show_endoom                   0"
%BIN_FART% "default.%~1.extra.cfg" "vanilla_savegame_limit        1"	"vanilla_savegame_limit        0"
%BIN_FART% "default.%~1.extra.cfg" "vanilla_demo_limit            1"	"vanilla_demo_limit            0"
%BIN_FART% "default.%~1.extra.cfg" "png_screenshots               0"	"png_screenshots               1"

REM # use F12 for screen-shot
%BIN_FART% "default.%~1.extra.cfg" "key_spy                       88"	"key_spy                       0"
%BIN_FART% "default.%~1.extra.cfg" "key_menu_screenshot           0"	"key_menu_screenshot           88"

REM # user-name for multi-player
REM # TODO: crispy-doom 5.6 now uses a randomly generated name
%BIN_FART% "default.%~1.extra.cfg" "player_name                   \"%USERNAME%\"" "player_name                   \"PortaDOOM\""
REM # in Chocolate Strife there's also nickname?
%BIN_FART% "default.choco-strife.cfg" "nickname                      \"(null)\"" "nickname                      \"PortaDOOM\""

REM # Crispy Doom, annoyingly, adds these in -- another reason why I need
REM # to make a specialised tool for programatically modifying CFG/INI files
%BIN_FART% "default.crispy-doom.extra.cfg" ^
	"autoload_path                 \"%APPDATA%\\crispy-doom\\autoload\"" ^
	"autoload_path                 \"\""
%BIN_FART% "default.crispy-doom.extra.cfg" ^
	"music_pack_path               \"%APPDATA%\\crispy-doom\\music-packs\"" ^
	"music_pack_path               \"\""

GOTO:EOF


:make_boom_hw
REM #
REM #    %1 = engine-name
REM #    %2 = IWAD
REM ----------------------------------------------------------------------------
REM # launch the engine to generate new default config files
START "" /WAIT "%LAUNCHER%" /WAIT /AUTO /USE "%~1" /DEFAULT /IWAD "%~2"
CALL :make_boom_inject "glboom-plus"
GOTO:EOF

:make_boom_sw
REM #
REM #    %1 = engine-name
REM #    %2 = IWAD
REM ----------------------------------------------------------------------------
REM # launch the engine to generate new default config files
START "" /WAIT "%LAUNCHER%" /WAIT /AUTO /USE "%~1" /SW /DEFAULT /IWAD "%~2"
CALL :make_boom_inject "prboom-plus"
GOTO:EOF

:make_boom_inject
REM ----------------------------------------------------------------------------
REM # turn off texture filtering
%BIN_FART% "default.%~1.cfg" "gl_texture_filter             5"		"gl_texture_filter             3"
%BIN_FART% "default.%~1.cfg" "gl_sprite_filter              1"		"gl_sprite_filter              3"
%BIN_FART% "default.%~1.cfg" "gl_patch_filter               1"		"gl_patch_filter               0"
%BIN_FART% "default.%~1.cfg" "gl_texture_filter_anisotropic     3"	"gl_texture_filter_anisotropic     4"

%BIN_FART% "default.%~1.cfg" "key_use                   0x20"		"key_use                   0x65"

%BIN_FART% "default.%~1.cfg" "key_spy                   0xd8"		"key_spy                   0x2a"
%BIN_FART% "default.%~1.cfg" "key_screenshot            0x2a"		"key_screenshot            0xd8"

%BIN_FART% "default.%~1.cfg" "hudadd_crosshair              0"		"hudadd_crosshair              1"
%BIN_FART% "default.%~1.cfg" "hudadd_secretarea             0"		"hudadd_secretarea             1"
%BIN_FART% "default.%~1.cfg" "mouse_doubleclick_as_use      1"		"mouse_doubleclick_as_use      0"
%BIN_FART% "default.%~1.cfg" "movement_mouselook            0"		"movement_mouselook            1"

GOTO:EOF


:make_zandronum
REM #
REM #    %1 = engine-name
REM #    %2 = IWAD
REM ----------------------------------------------------------------------------
REM # launch the engine to generate new default config files
START "" /WAIT "%LAUNCHER%" /WAIT /AUTO /USE "%~1" /DEFAULT /IWAD "%~2" /QUIT

REM # graphics
%BIN_FART% "default.%~1.ini" "vid_vsync=false" "vid_vsync=true"
%BIN_FART% "default.%~1.ini" "crosshair=0" "crosshair=2"
%BIN_FART% "default.%~1.ini" "cl_stfullscreenhud=true" "cl_stfullscreenhud=false"
%BIN_FART% "default.%~1.ini" "con_scaletext_usescreenratio=false" "con_scaletext_usescreenratio=true"
%BIN_FART% "default.%~1.ini" "hud_scale=false" "hud_scale=true"
%BIN_FART% "default.%~1.ini" "vid_cursor=None" "vid_cursor=-"
%BIN_FART% "default.%~1.ini" "con_scaletext=false" "con_scaletext=true"
%BIN_FART% "default.%~1.ini" "con_virtualheight=480" "con_virtualheight=360"

REM # player set up
%BIN_FART% "default.%~1.ini" "gender=male" "gender=Other"
%BIN_FART% "default.%~1.ini" "name=Player" "name=PortaDOOM"

REM # controls
%BIN_FART% "default.%~1.ini" "mouse2=+strafe" "mouse2=+altattack"
%BIN_FART% "default.%~1.ini" "space=+use" "space=+jump"
%BIN_FART% "default.%~1.ini" "f12=spynext" "f12=screenshot"

IF /I "%~2" == "DOOM.WAD" (
	%BIN_INIFILE% "default.%~1.ini" [Doom.Bindings] e=+use
	%BIN_INIFILE% "default.%~1.ini" [Doom.Bindings] q=+zoom
	%BIN_INIFILE% "default.%~1.ini" [Doom.Bindings] r=+reload
	%BIN_INIFILE% "default.%~1.ini" [Doom.Bindings] c=+crouch
)
IF /I "%~2" == "HERETIC.WAD" (
	%BIN_INIFILE% "default.%~1.ini" [Heretic.Bindings] e=+use
	%BIN_INIFILE% "default.%~1.ini" [Heretic.Bindings] q=+zoom
	%BIN_INIFILE% "default.%~1.ini" [Heretic.Bindings] r=+reload
	%BIN_INIFILE% "default.%~1.ini" [Heretic.Bindings] c=+crouch
)
IF /I "%~2" == "HEXEN.WAD" (
	%BIN_INIFILE% "default.%~1.ini" [Hexen.Bindings] e=+use
	%BIN_INIFILE% "default.%~1.ini" [Hexen.Bindings] q=+zoom
	%BIN_INIFILE% "default.%~1.ini" [Hexen.Bindings] r=+reload
	%BIN_INIFILE% "default.%~1.ini" [Hexen.Bindings] c=+crouch
)
IF /I "%~2" == "STRIFE1.WAD" (
	%BIN_INIFILE% "default.%~1.ini" [Strife.Bindings] e=+use
	%BIN_INIFILE% "default.%~1.ini" [Strife.Bindings] q=+zoom
	%BIN_INIFILE% "default.%~1.ini" [Strife.Bindings] r=+reload
	%BIN_INIFILE% "default.%~1.ini" [Strife.Bindings] c=+crouch
)
IF /I "%~2" == "CHEX.WAD" (
	%BIN_INIFILE% "default.%~1.ini" [Chex.Bindings] e=+use
	%BIN_INIFILE% "default.%~1.ini" [Chex.Bindings] q=+zoom
	%BIN_INIFILE% "default.%~1.ini" [Chex.Bindings] r=+reload
	%BIN_INIFILE% "default.%~1.ini" [Chex.Bindings] c=+crouch
)
IF /I "%~2" == "HARM1.WAD" (
	%BIN_INIFILE% "default.%~1.ini" [Harmony.Bindings] e=+use
	%BIN_INIFILE% "default.%~1.ini" [Harmony.Bindings] q=+zoom
	%BIN_INIFILE% "default.%~1.ini" [Harmony.Bindings] r=+reload
	%BIN_INIFILE% "default.%~1.ini" [Harmony.Bindings] c=+crouch
)

REM # automap, show item-count
%BIN_FART% "default.%~1.ini" "am_showitems=false" "am_showitems=true"

GOTO:EOF


:make_gzdoom
REM #
REM #    %1 = engine-name
REM #    %2 = IWAD
REM ----------------------------------------------------------------------------
REM # launch the engine to generate new default config files
START "" /WAIT "%LAUNCHER%" /WAIT /AUTO /USE "%~1" /DEFAULT /IWAD "%~2" /QUIT

REM # disable stats collection; this might be undesirable if PortaDOOM
REM # is being moved around multiple PCs intended for offline use
%BIN_FART% "default.%~1.ini" "sys_statsenabled=1" "sys_statsenabled=0"

REM # VSync ON
%BIN_FART% "default.%~1.ini" "vid_vsync=false" "vid_vsync=true"

REM # Texture Filtering: Nearest (Linear Mipmap) is supported from v1.5 onwards;
REM # (graphics break if this is applied to earlier versions)
%BIN_FART% "default.gzdoom.ini" "gl_texture_filter=4" "gl_texture_filter=5"
%BIN_FART% "default.gzdoom-15.ini" "gl_texture_filter=4" "gl_texture_filter=5"
%BIN_FART% "default.gzdoom-16.ini" "gl_texture_filter=4" "gl_texture_filter=5"
%BIN_FART% "default.gzdoom-17.ini" "gl_texture_filter=4" "gl_texture_filter=5"
%BIN_FART% "default.gzdoom-18.ini" "gl_texture_filter=4" "gl_texture_filter=5"
%BIN_FART% "default.gzdoom-19.ini" "gl_texture_filter=4" "gl_texture_filter=5"
%BIN_FART% "default.gzdoom-2*.ini" "gl_texture_filter=4" "gl_texture_filter=5"
%BIN_FART% "default.gzdoom-3*.ini" "gl_texture_filter=4" "gl_texture_filter=5"
%BIN_FART% "default.gzdoom-4*.ini" "gl_texture_filter=4" "gl_texture_filter=5"

REM # use "Mipmapped" for earlier versions
%BIN_FART% "default.gzdoom-10.ini" "gl_texture_filter=4" "gl_texture_filter=1"
%BIN_FART% "default.gzdoom-11.ini" "gl_texture_filter=4" "gl_texture_filter=1"
%BIN_FART% "default.gzdoom-12.ini" "gl_texture_filter=4" "gl_texture_filter=1"
%BIN_FART% "default.gzdoom-13.ini" "gl_texture_filter=4" "gl_texture_filter=1"
%BIN_FART% "default.gzdoom-14.ini" "gl_texture_filter=4" "gl_texture_filter=1"

REM # use "standard" light mode instead of "dark"
%BIN_FART% "default.%~1.ini" "gl_lightmode=3" "gl_lightmode=0"

REM # controls
IF /I "%~2" == "DOOM.WAD" (
	%BIN_INIFILE% "default.%~1.ini" [Doom.Bindings] mouse3=
	%BIN_INIFILE% "default.%~1.ini" [Doom.Bindings] e=+use
	%BIN_INIFILE% "default.%~1.ini" [Doom.Bindings] q=+zoom
	%BIN_INIFILE% "default.%~1.ini" [Doom.Bindings] r=+reload
	%BIN_INIFILE% "default.%~1.ini" [Doom.Bindings] c=+crouch
	%BIN_INIFILE% "default.%~1.ini" [Doom.Bindings] w=+forward
	%BIN_INIFILE% "default.%~1.ini" [Doom.Bindings] a=+moveleft
	%BIN_INIFILE% "default.%~1.ini" [Doom.Bindings] s=+back
	%BIN_INIFILE% "default.%~1.ini" [Doom.Bindings] d=+moveright
)
IF /I "%~2" == "HERETIC.WAD" (
	%BIN_INIFILE% "default.%~1.ini" [Heretic.Bindings] mouse3=
	%BIN_INIFILE% "default.%~1.ini" [Heretic.Bindings] e=+use
	%BIN_INIFILE% "default.%~1.ini" [Heretic.Bindings] q=+zoom
	%BIN_INIFILE% "default.%~1.ini" [Heretic.Bindings] r=+reload
	%BIN_INIFILE% "default.%~1.ini" [Heretic.Bindings] c=+crouch
	%BIN_INIFILE% "default.%~1.ini" [Heretic.Bindings] w=+forward
	%BIN_INIFILE% "default.%~1.ini" [Heretic.Bindings] a=+moveleft
	%BIN_INIFILE% "default.%~1.ini" [Heretic.Bindings] s=+back
	%BIN_INIFILE% "default.%~1.ini" [Heretic.Bindings] d=+moveright
)
IF /I "%~2" == "HEXEN.WAD" (
	%BIN_INIFILE% "default.%~1.ini" [Hexen.Bindings] mouse3=
	%BIN_INIFILE% "default.%~1.ini" [Hexen.Bindings] e=+use
	%BIN_INIFILE% "default.%~1.ini" [Hexen.Bindings] q=+zoom
	%BIN_INIFILE% "default.%~1.ini" [Hexen.Bindings] r=+reload
	%BIN_INIFILE% "default.%~1.ini" [Hexen.Bindings] c=+crouch
	%BIN_INIFILE% "default.%~1.ini" [Hexen.Bindings] w=+forward
	%BIN_INIFILE% "default.%~1.ini" [Hexen.Bindings] a=+moveleft
	%BIN_INIFILE% "default.%~1.ini" [Hexen.Bindings] s=+back
	%BIN_INIFILE% "default.%~1.ini" [Hexen.Bindings] d=+moveright
)
IF /I "%~2" == "STRIFE1.WAD" (
	%BIN_INIFILE% "default.%~1.ini" [Strife.Bindings] mouse3=
	%BIN_INIFILE% "default.%~1.ini" [Strife.Bindings] e=+use
	%BIN_INIFILE% "default.%~1.ini" [Strife.Bindings] q=+zoom
	%BIN_INIFILE% "default.%~1.ini" [Strife.Bindings] r=+reload
	%BIN_INIFILE% "default.%~1.ini" [Strife.Bindings] c=+crouch
	%BIN_INIFILE% "default.%~1.ini" [Strife.Bindings] w=+forward
	%BIN_INIFILE% "default.%~1.ini" [Strife.Bindings] a=+moveleft
	%BIN_INIFILE% "default.%~1.ini" [Strife.Bindings] s=+back
	%BIN_INIFILE% "default.%~1.ini" [Strife.Bindings] d=+moveright
)
IF /I "%~2" == "CHEX.WAD" (
	%BIN_INIFILE% "default.%~1.ini" [Chex.Bindings] mouse3=
	%BIN_INIFILE% "default.%~1.ini" [Chex.Bindings] e=+use
	%BIN_INIFILE% "default.%~1.ini" [Chex.Bindings] q=+zoom
	%BIN_INIFILE% "default.%~1.ini" [Chex.Bindings] r=+reload
	%BIN_INIFILE% "default.%~1.ini" [Chex.Bindings] c=+crouch
	%BIN_INIFILE% "default.%~1.ini" [Chex.Bindings] w=+forward
	%BIN_INIFILE% "default.%~1.ini" [Chex.Bindings] a=+moveleft
	%BIN_INIFILE% "default.%~1.ini" [Chex.Bindings] s=+back
	%BIN_INIFILE% "default.%~1.ini" [Chex.Bindings] d=+moveright
)
IF /I "%~2" == "HARM1.WAD" (
	%BIN_INIFILE% "default.%~1.ini" [Harmony.Bindings] mouse3=
	%BIN_INIFILE% "default.%~1.ini" [Harmony.Bindings] e=+use
	%BIN_INIFILE% "default.%~1.ini" [Harmony.Bindings] q=+zoom
	%BIN_INIFILE% "default.%~1.ini" [Harmony.Bindings] r=+reload
	%BIN_INIFILE% "default.%~1.ini" [Harmony.Bindings] c=+crouch
	%BIN_INIFILE% "default.%~1.ini" [Harmony.Bindings] w=+forward
	%BIN_INIFILE% "default.%~1.ini" [Harmony.Bindings] a=+moveleft
	%BIN_INIFILE% "default.%~1.ini" [Harmony.Bindings] s=+back
	%BIN_INIFILE% "default.%~1.ini" [Harmony.Bindings] d=+moveright
)
IF /I "%~2" == "ROTWB.WAD" (
	%BIN_INIFILE% "default.%~1.ini" [WoolBall.Bindings] mouse3=
	%BIN_INIFILE% "default.%~1.ini" [WoolBall.Bindings] e=+use
	%BIN_INIFILE% "default.%~1.ini" [WoolBall.Bindings] q=+zoom
	%BIN_INIFILE% "default.%~1.ini" [WoolBall.Bindings] r=+reload
	%BIN_INIFILE% "default.%~1.ini" [WoolBall.Bindings] c=+crouch
	%BIN_INIFILE% "default.%~1.ini" [WoolBall.Bindings] w=+forward
	%BIN_INIFILE% "default.%~1.ini" [WoolBall.Bindings] a=+moveleft
	%BIN_INIFILE% "default.%~1.ini" [WoolBall.Bindings] s=+back
	%BIN_INIFILE% "default.%~1.ini" [WoolBall.Bindings] d=+moveright
)
IF /I "%~2" == "SQUARE1.PK3" (
	%BIN_INIFILE% "default.%~1.ini" [Square.Bindings] mouse3=
	%BIN_INIFILE% "default.%~1.ini" [Square.Bindings] e=+use
	%BIN_INIFILE% "default.%~1.ini" [Square.Bindings] q=+zoom
	%BIN_INIFILE% "default.%~1.ini" [Square.Bindings] r=+reload
	%BIN_INIFILE% "default.%~1.ini" [Square.Bindings] c=+crouch
	%BIN_INIFILE% "default.%~1.ini" [Square.Bindings] w=+forward
	%BIN_INIFILE% "default.%~1.ini" [Square.Bindings] a=+moveleft
	%BIN_INIFILE% "default.%~1.ini" [Square.Bindings] s=+back
	%BIN_INIFILE% "default.%~1.ini" [Square.Bindings] d=+moveright
)

REM # change controls
%BIN_FART% "default.%~1.ini" "space=+use" "space=+jump"
%BIN_FART% "default.%~1.ini" "f12=spynext" "f12=screenshot"
%BIN_FART% "default.%~1.ini" "mouse2=+strafe" "mouse2=+altattack"

%BIN_FART% "default.%~1.ini" "freelook=false" "freelook=true"
%BIN_FART% "default.%~1.ini" "cl_run=false" "cl_run=true"
%BIN_FART% "default.%~1.ini" "queryiwad=true" "queryiwad=false"
%BIN_FART% "default.%~1.ini" "gender=male" "gender=other"
%BIN_FART% "default.%~1.ini" "name=Player" "name=PortaDOOM"
%BIN_FART% "default.%~1.ini" "vid_cursor=None" "vid_cursor=-"

REM # automap, show item-count
%BIN_FART% "default.%~1.ini" "am_showitems=false" "am_showitems=true"

REM # full-screen HUD
%BIN_FART% "default.%~1.ini" "screenblocks=10" "screenblocks=11"
REM # HUD auto-scale (v2.1<)
%BIN_FART% "default.%~1.ini" "hud_scale=false" "hud_scale=true"
REM # HUD auto-scale (v2.2+)
%BIN_FART% "default.%~1.ini" "hud_scale=0" "hud_scale=-1"
REM # status bar auto-scale
%BIN_FART% "default.%~1.ini" "st_scale=0" "st_scale=-1"
REM # there's no auto message-scale, 2 makes it readable without being too big
%BIN_FART% "default.%~1.ini" "con_scaletext=0" "con_scaletext=2"

REM # enable cross-hair (type 2)
%BIN_FART% "default.%~1.ini" "crosshair=0" "crosshair=2"
REM # cross hair 1:1 pixels (no-scale)
%BIN_FART% "default.%~1.ini" "crosshairscale=1" "crosshairscale=0"

GOTO:EOF


:make_zdoom
REM #
REM #    %1 = engine-name
REM #    %2 = IWAD
REM ----------------------------------------------------------------------------
REM # launch the engine to generate new default config files
START "" /WAIT "%LAUNCHER%" /WAIT /AUTO /USE "%~1" /DEFAULT /IWAD "%~2" /QUIT

REM # VSync ON
%BIN_FART% "default.%~1.ini" "vid_vsync=false" "vid_vsync=true"

REM # controls
IF "%~2" == "DOOM.WAD" (
	%BIN_INIFILE% "default.%~1.ini" [Doom.Bindings] mouse3=
	%BIN_INIFILE% "default.%~1.ini" [Doom.Bindings] e=+use
	%BIN_INIFILE% "default.%~1.ini" [Doom.Bindings] q=+zoom
	%BIN_INIFILE% "default.%~1.ini" [Doom.Bindings] r=+reload
	%BIN_INIFILE% "default.%~1.ini" [Doom.Bindings] c=+crouch
	%BIN_INIFILE% "default.%~1.ini" [Doom.Bindings] w=+forward
	%BIN_INIFILE% "default.%~1.ini" [Doom.Bindings] a=+moveleft
	%BIN_INIFILE% "default.%~1.ini" [Doom.Bindings] s=+back
	%BIN_INIFILE% "default.%~1.ini" [Doom.Bindings] d=+moveright
)
IF "%~2" == "HERETIC.WAD" (
	%BIN_INIFILE% "default.%~1.ini" [Heretic.Bindings] mouse3=
	%BIN_INIFILE% "default.%~1.ini" [Heretic.Bindings] e=+use
	%BIN_INIFILE% "default.%~1.ini" [Heretic.Bindings] q=+zoom
	%BIN_INIFILE% "default.%~1.ini" [Heretic.Bindings] r=+reload
	%BIN_INIFILE% "default.%~1.ini" [Heretic.Bindings] c=+crouch
	%BIN_INIFILE% "default.%~1.ini" [Heretic.Bindings] w=+forward
	%BIN_INIFILE% "default.%~1.ini" [Heretic.Bindings] a=+moveleft
	%BIN_INIFILE% "default.%~1.ini" [Heretic.Bindings] s=+back
	%BIN_INIFILE% "default.%~1.ini" [Heretic.Bindings] d=+moveright
)
IF "%~2" == "HEXEN.WAD" (
	%BIN_INIFILE% "default.%~1.ini" [Hexen.Bindings] mouse3=
	%BIN_INIFILE% "default.%~1.ini" [Hexen.Bindings] e=+use
	%BIN_INIFILE% "default.%~1.ini" [Hexen.Bindings] q=+zoom
	%BIN_INIFILE% "default.%~1.ini" [Hexen.Bindings] r=+reload
	%BIN_INIFILE% "default.%~1.ini" [Hexen.Bindings] c=+crouch
	%BIN_INIFILE% "default.%~1.ini" [Hexen.Bindings] w=+forward
	%BIN_INIFILE% "default.%~1.ini" [Hexen.Bindings] a=+moveleft
	%BIN_INIFILE% "default.%~1.ini" [Hexen.Bindings] s=+back
	%BIN_INIFILE% "default.%~1.ini" [Hexen.Bindings] d=+moveright
)
IF "%~2" == "STRIFE1.WAD" (
	%BIN_INIFILE% "default.%~1.ini" [Strife.Bindings] mouse3=
	%BIN_INIFILE% "default.%~1.ini" [Strife.Bindings] e=+use
	%BIN_INIFILE% "default.%~1.ini" [Strife.Bindings] q=+zoom
	%BIN_INIFILE% "default.%~1.ini" [Strife.Bindings] r=+reload
	%BIN_INIFILE% "default.%~1.ini" [Strife.Bindings] c=+crouch
	%BIN_INIFILE% "default.%~1.ini" [Strife.Bindings] w=+forward
	%BIN_INIFILE% "default.%~1.ini" [Strife.Bindings] a=+moveleft
	%BIN_INIFILE% "default.%~1.ini" [Strife.Bindings] s=+back
	%BIN_INIFILE% "default.%~1.ini" [Strife.Bindings] d=+moveright
)
IF "%~2" == "CHEX.WAD" (
	%BIN_INIFILE% "default.%~1.ini" [Chex.Bindings] mouse3=
	%BIN_INIFILE% "default.%~1.ini" [Chex.Bindings] e=+use
	%BIN_INIFILE% "default.%~1.ini" [Chex.Bindings] q=+zoom
	%BIN_INIFILE% "default.%~1.ini" [Chex.Bindings] r=+reload
	%BIN_INIFILE% "default.%~1.ini" [Chex.Bindings] c=+crouch
	%BIN_INIFILE% "default.%~1.ini" [Chex.Bindings] w=+forward
	%BIN_INIFILE% "default.%~1.ini" [Chex.Bindings] a=+moveleft
	%BIN_INIFILE% "default.%~1.ini" [Chex.Bindings] s=+back
	%BIN_INIFILE% "default.%~1.ini" [Chex.Bindings] d=+moveright
)
IF "%~2" == "HARM1.WAD" (
	%BIN_INIFILE% "default.%~1.ini" [Harmony.Bindings] mouse3=
	%BIN_INIFILE% "default.%~1.ini" [Harmony.Bindings] e=+use
	%BIN_INIFILE% "default.%~1.ini" [Harmony.Bindings] q=+zoom
	%BIN_INIFILE% "default.%~1.ini" [Harmony.Bindings] r=+reload
	%BIN_INIFILE% "default.%~1.ini" [Harmony.Bindings] c=+crouch
	%BIN_INIFILE% "default.%~1.ini" [Harmony.Bindings] w=+forward
	%BIN_INIFILE% "default.%~1.ini" [Harmony.Bindings] a=+moveleft
	%BIN_INIFILE% "default.%~1.ini" [Harmony.Bindings] s=+back
	%BIN_INIFILE% "default.%~1.ini" [Harmony.Bindings] d=+moveright
)

REM # change controls
%BIN_FART% "default.%~1.ini" "space=+use" "space=+jump"
%BIN_FART% "default.%~1.ini" "f12=spynext" "f12=screenshot"
%BIN_FART% "default.%~1.ini" "mouse2=+strafe" "mouse2=+altattack"

%BIN_FART% "default.%~1.ini" "cl_run=false" "cl_run=true"
%BIN_FART% "default.%~1.ini" "queryiwad=true" "queryiwad=false"
%BIN_FART% "default.%~1.ini" "gender=male" "gender=other"
%BIN_FART% "default.%~1.ini" "name=Player" "name=PortaDOOM"
%BIN_FART% "default.%~1.ini" "vid_cursor=None" "vid_cursor=-"

REM # full-screen HUD
%BIN_FART% "default.%~1.ini" "screenblocks=10" "screenblocks=11"
REM # HUD auto-scale
%BIN_FART% "default.%~1.ini" "hud_scale=false" "hud_scale=true"
%BIN_FART% "default.%~1.ini" "con_scaletext=0" "con_scaletext=1"

REM # automap, show item-count
%BIN_FART% "default.%~1.ini" "am_showitems=false" "am_showitems=true"

GOTO:EOF


:make_doom64
REM #
REM #    %1 = engine-name
REM #    %2 = IWAD
REM ----------------------------------------------------------------------------
REM # launch the engine to generate new default config files
START "" /WAIT "%LAUNCHER%" /WAIT /AUTO /USE "%~1" /DEFAULT /IWAD "%~2"

%BIN_FART% "default.%~1.cfg" "seta \"p_usecontext\" \"0\""	"seta \"p_usecontext\" \"1\""
%BIN_FART% "default.%~1.cfg" "seta \"st_crosshair\" \"0\""	"seta \"st_crosshair\" \"1\""
%BIN_FART% "default.%~1.cfg" "seta \"st_drawhud\" \"0\""	"seta \"st_drawhud\" \"1\""
%BIN_FART% "default.%~1.cfg" "seta \"v_mlook\" \"0\""		"seta \"v_mlook\" \"1\""
%BIN_FART% "default.%~1.cfg" "seta \"r_anisotropic\" \"0\""	"seta \"r_anisotropic\" \"1\""
%BIN_FART% "default.%~1.cfg" "seta \"r_filter\" \"0\""		"seta \"r_filter\" \"1\""
REM # mouse-sensitivity is way too slow by default
%BIN_FART% "default.%~1.cfg" "seta \"v_msensitivityx\" \"5\""	"seta \"v_msensitivityx\" \"10\""
%BIN_FART% "default.%~1.cfg" "seta \"v_msensitivityy\" \"5\""	"seta \"v_msensitivityy\" \"10\""
%BIN_FART% "default.%~1.cfg" "seta \"p_autorun\" \"0\""		"seta \"p_autorun\" \"1\""

GOTO:EOF