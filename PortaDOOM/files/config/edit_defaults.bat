:: PortaDOOM, copyright (C) Kroc Camen 2016-2023, BSD 2-clause
@ECHO OFF & SETLOCAL ENABLEEXTENSIONS DISABLEDELAYEDEXPANSION

REM # switch the current directory to that of this file
CD %~dp0
REM # relative location of the saves folder (where user-configs are stored)
SET "SAVES=..\saves"
REM # relative path to launcher.exe
SET "LAUNCHER=..\launcher.exe"

:menu
REM ============================================================================
CLS & TITLE Edit Engine Defaults
ECHO:
ECHO  Edit Engine Defaults:
ECHO  =====================
ECHO  Select IWAD:
ECHO:
ECHO     [D] DOOM / DOOM2 / TNT / PLUTONIA
ECHO     [H] HERETIC
ECHO     [X] HEXEN
ECHO     [S] STRIFE
ECHO     [C] CHEX
ECHO     [6] DOOM64 (Doom64ex)
ECHO     [M] HARM1
ECHO     [Q] SQUARE1 (GZDoom...)
ECHO:

SET "$="
SET /P "$=? "

IF "%$%" == "" EXIT /B

IF /I "%$%" == "D" CALL :menu_doom
IF /I "%$%" == "H" CALL :menu_heretic
IF /I "%$%" == "X" CALL :menu_hexen
IF /I "%$%" == "S" CALL :menu_strife
IF /I "%$%" == "C" CALL :menu_chex
REM # don't need a menu for DOOM 64, there's only one engine
IF /I "%$%" == "6" CALL :launch_engine "doom64ex" "DOOM64.WAD"
IF /I "%$%" == "M" CALL :menu_harm1
IF /I "%$%" == "Q" CALL :menu_gzdoom "square1.pk3"

GOTO :menu


:menu_doom
REM ============================================================================
CLS
ECHO:
ECHO  Edit DOOM Engine Defaults:
ECHO  ==========================
ECHO  Select engine:
ECHO:
ECHO     [C] Chocolate Doom             DOOM.WAD
ECHO     [P] Crispy Doom                DOOM.WAD
ECHO     [R] DOOM Retro                 DOOM.WAD
ECHO:
ECHO     [H] PrBoom+ Hardware           DOOM.WAD
ECHO     [S] PrBoom+ Software           DOOM.WAD
ECHO:
ECHO     [2] Zandronum v2               DOOM.WAD
ECHO     [3] Zandronum v3               DOOM.WAD
ECHO:
ECHO     [G] GZDoom ...                 DOOM.WAD
ECHO:
ECHO     [Z] ZDoom                      DOOM.WAD
ECHO:

SET "$="
SET /P "$=? "

IF "%$%" == "" GOTO:EOF

IF /I "%$%" == "C" CALL :launch_engine    "choco-doom-setup"     "DOOM.WAD"
IF /I "%$%" == "P" CALL :launch_engine    "crispy-doom-setup"    "DOOM.WAD"
IF /I "%$%" == "R" CALL :launch_engine    "doom-retro"           "DOOM.WAD"
IF /I "%$%" == "H" CALL :launch_engine    "prboom-plus"          "DOOM.WAD"
IF /I "%$%" == "S" CALL :launch_engine_sw "prboom-plus"          "DOOM.WAD"
IF /I "%$%" == "2" CALL :launch_engine    "zandronum-2"          "DOOM.WAD"
IF /I "%$%" == "3" CALL :launch_engine    "zandronum-3"          "DOOM.WAD"
IF /I "%$%" == "G" CALL :menu_gzdoom                             "DOOM.WAD"
IF /I "%$%" == "Z" CALL :launch_engine    "zdoom"                "DOOM.WAD"

GOTO :menu_doom


:menu_heretic
REM ============================================================================
CLS
ECHO:
ECHO  Edit HERETIC Engine Defaults:
ECHO  =============================
ECHO  Select engine:
ECHO:
ECHO     [C] Chocolate Heretic          HERETIC.WAD
ECHO     [P] Crispy Heretic             HERETIC.WAD
ECHO:
ECHO     [2] Zandronum v2               HERETIC.WAD
ECHO     [3] Zandronum v3               HERETIC.WAD
ECHO:
ECHO     [G] GZDoom ...                 HERETIC.WAD
ECHO:
ECHO     [Z] ZDoom                      HERETIC.WAD
ECHO:

SET "$="
SET /P "$=? "

IF "%$%" == "" GOTO:EOF

IF /I "%$%" == "C" CALL :launch_engine    "choco-heretic-setup"  "HERETIC.WAD"
IF /I "%$%" == "P" CALL :launch_engine    "crispy-heretic-setup" "HERETIC.WAD"
IF /I "%$%" == "2" CALL :launch_engine    "zandronum-2"          "HERETIC.WAD"
IF /I "%$%" == "3" CALL :launch_engine    "zandronum-3"          "HERETIC.WAD"
IF /I "%$%" == "G" CALL :menu_gzdoom                             "HERETIC.WAD"
IF /I "%$%" == "Z" CALL :launch_engine    "zdoom"                "HERETIC.WAD"

GOTO :menu_heretic


:menu_hexen
REM ============================================================================
CLS
ECHO:
ECHO  Edit HEXEN Engine Defaults:
ECHO  ===========================
ECHO  Select engine:
ECHO:
ECHO     [C] Chocolate Hexen            HEXEN.WAD
ECHO     [P] Crispy Hexen               HEXEN.WAD
ECHO:
ECHO     [2] Zandronum v2               HEXEN.WAD
ECHO     [3] Zandronum v3               HEXEN.WAD
ECHO:
ECHO     [G] GZDoom ...                 HEXEN.WAD
ECHO:
ECHO     [Z] ZDoom                      HEXEN.WAD
ECHO:

SET "$="
SET /P "$=? "

IF "%$%" == "" GOTO:EOF

IF /I "%$%" == "C" CALL :launch_engine    "choco-hexen-setup"    "HEXEN.WAD"
IF /I "%$%" == "P" CALL :launch_engine    "crispy-hexen-setup"   "HEXEN.WAD"
IF /I "%$%" == "2" CALL :launch_engine    "zandronum-2"          "HEXEN.WAD"
IF /I "%$%" == "3" CALL :launch_engine    "zandronum-3"          "HEXEN.WAD"
IF /I "%$%" == "G" CALL :menu_gzdoom                             "HEXEN.WAD"
IF /I "%$%" == "Z" CALL :launch_engine    "zdoom"                "HEXEN.WAD"

GOTO :menu_hexen


:menu_strife
REM ============================================================================
CLS
ECHO:
ECHO  Edit STRIFE Engine Defaults:
ECHO  ============================
ECHO  Select engine:
ECHO:
ECHO     [C] Chocolate Strife           STRIFE1.WAD
ECHO     [P] Crispy Strife              STRIFE1.WAD
ECHO:
ECHO     [2] Zandronum v2               STRIFE1.WAD
ECHO     [3] Zandronum v3               STRIFE1.WAD
ECHO:
ECHO     [G] GZDoom ...                 STRIFE1.WAD
ECHO:
ECHO     [Z] ZDoom                      STRIFE1.WAD
ECHO:

SET "$="
SET /P "$=? "

IF "%$%" == "" GOTO:EOF

IF /I "%$%" == "C" CALL :launch_engine    "choco-strife-setup"   "STRIFE1.WAD"
IF /I "%$%" == "P" CALL :launch_engine    "crispy-strife-setup"  "STRIFE1.WAD"
IF /I "%$%" == "2" CALL :launch_engine    "zandronum-2"          "STRIFE1.WAD"
IF /I "%$%" == "3" CALL :launch_engine    "zandronum-3"          "STRIFE1.WAD"
IF /I "%$%" == "G" CALL :menu_gzdoom                             "STRIFE1.WAD"
IF /I "%$%" == "Z" CALL :launch_engine    "zdoom"                "STRIFE1.WAD"

GOTO :menu_strife


:menu_chex
REM ============================================================================
CLS
ECHO:
ECHO  Edit CHEX Engine Defaults:
ECHO  ==========================
ECHO  Select engine:
ECHO:
ECHO     [C] Chocolate Doom             CHEX.WAD
ECHO     [R] DOOM Retro                 DOOM.WAD
ECHO:
ECHO     [H] PrBoom+ Hardware           CHEX.WAD
ECHO     [S] PrBoom+ Software           CHEX.WAD
ECHO:
ECHO     [2] Zandronum v2               CHEX.WAD
ECHO     [3] Zandronum v3               CHEX.WAD
ECHO:
ECHO     [G] GZDoom ...                 CHEX.WAD
ECHO:
ECHO     [Z] ZDoom                      CHEX.WAD
ECHO:

SET "$="
SET /P "$=? "

IF "%$%" == "" GOTO:EOF

IF /I "%$%" == "C" CALL :launch_engine    "choco-doom-setup"     "CHEX.WAD"
IF /I "%$%" == "R" CALL :launch_engine    "doom-retro"           "CHEX.WAD"
IF /I "%$%" == "H" CALL :launch_engine    "prboom-plus"          "CHEX.WAD"
IF /I "%$%" == "S" CALL :launch_engine_sw "prboom-plus"          "CHEX.WAD"
IF /I "%$%" == "2" CALL :launch_engine    "zandronum-2"          "CHEX.WAD"
IF /I "%$%" == "3" CALL :launch_engine    "zandronum-3"          "CHEX.WAD"
IF /I "%$%" == "G" CALL :menu_gzdoom                             "CHEX.WAD"
IF /I "%$%" == "Z" CALL :launch_engine    "zdoom"                "CHEX.WAD"

GOTO :menu_chex


:menu_harm1
REM ============================================================================
CLS
ECHO:
ECHO  Edit HARM1 Engine Defaults:
ECHO  ===========================
ECHO  Select engine:
ECHO:
ECHO     [3] Zandronum v3               HARM1.WAD
ECHO:
ECHO     [G] GZDoom ...                 HARM1.WAD
ECHO:
ECHO     [Z] ZDoom                      HARM1.WAD
ECHO:

SET "$="
SET /P "$=? "

IF "%$%" == "" GOTO:EOF

IF /I "%$%" == "3" CALL :launch_engine    "zandronum-3"          "HARM1.WAD"
IF /I "%$%" == "G" CALL :menu_gzdoom                             "HARM1.WAD"
IF /I "%$%" == "Z" CALL :launch_engine    "zdoom"                "HARM1.WAD"

GOTO :menu_harm1


:menu_gzdoom
REM ============================================================================
CLS
ECHO:
ECHO  Edit DOOM Engine Defaults:
ECHO  ==========================
ECHO  Select GZDoom engine:
ECHO:
ECHO  [Z] GZDoom, current
ECHO:
ECHO  [0] v1.0		[1] v1.1	[2] v1.2
ECHO  [3] v1.3		[4] v1.4	[5] v1.5
ECHO  [6] v1.6		[7] v1.7	[8] v1.8
ECHO  [9] v1.9		[A] v2.0	[B] v2.1
ECHO  [C] v2.2		[D] v2.3	[E] v2.4
ECHO  [F] v3.2		[G] v3.3	[H] v3.4
ECHO  [I] v3.5		[J] v3.6	[K] v3.7
ECHO  [L] v4.1		[M] v4.2	[N] v4.3
ECHO  [O] v4.4		[P] v4.5	[Q] v4.6
ECHO  [R] v4.7		[S] v4.8	[T] v4.9
ECHO  [U] v4.10		[V] v4.11
ECHO:

SET "$="
SET /P "$=? "

IF "%$%" == "" GOTO:EOF

IF /I "%$%" == "Z" CALL :launch_engine    "gzdoom"      "%~1"
IF /I "%$%" == "0" CALL :launch_engine    "gzdoom-100"  "%~1"
IF /I "%$%" == "1" CALL :launch_engine    "gzdoom-101"  "%~1"
IF /I "%$%" == "2" CALL :launch_engine    "gzdoom-102"  "%~1"
IF /I "%$%" == "3" CALL :launch_engine    "gzdoom-103"  "%~1"
IF /I "%$%" == "4" CALL :launch_engine    "gzdoom-104"  "%~1"
IF /I "%$%" == "5" CALL :launch_engine    "gzdoom-105"  "%~1"
IF /I "%$%" == "6" CALL :launch_engine    "gzdoom-106"  "%~1"
IF /I "%$%" == "7" CALL :launch_engine    "gzdoom-107"  "%~1"
IF /I "%$%" == "8" CALL :launch_engine    "gzdoom-108"  "%~1"
IF /I "%$%" == "9" CALL :launch_engine    "gzdoom-109"  "%~1"
IF /I "%$%" == "A" CALL :launch_engine    "gzdoom-200"  "%~1"
IF /I "%$%" == "B" CALL :launch_engine    "gzdoom-201"  "%~1"
IF /I "%$%" == "C" CALL :launch_engine    "gzdoom-202"  "%~1"
IF /I "%$%" == "D" CALL :launch_engine    "gzdoom-203"  "%~1"
IF /I "%$%" == "E" CALL :launch_engine    "gzdoom-204"  "%~1"
IF /I "%$%" == "F" CALL :launch_engine    "gzdoom-302"  "%~1"
IF /I "%$%" == "G" CALL :launch_engine    "gzdoom-303"  "%~1"
IF /I "%$%" == "H" CALL :launch_engine    "gzdoom-304"  "%~1"
IF /I "%$%" == "I" CALL :launch_engine    "gzdoom-305"  "%~1"
IF /I "%$%" == "J" CALL :launch_engine    "gzdoom-306"  "%~1"
IF /I "%$%" == "K" CALL :launch_engine    "gzdoom-307"  "%~1"
IF /I "%$%" == "L" CALL :launch_engine    "gzdoom-401"  "%~1"
IF /I "%$%" == "M" CALL :launch_engine    "gzdoom-402"  "%~1"
IF /I "%$%" == "N" CALL :launch_engine    "gzdoom-403"  "%~1"
IF /I "%$%" == "O" CALL :launch_engine    "gzdoom-404"  "%~1"
IF /I "%$%" == "P" CALL :launch_engine    "gzdoom-405"  "%~1"
IF /I "%$%" == "Q" CALL :launch_engine    "gzdoom-406"  "%~1"
IF /I "%$%" == "R" CALL :launch_engine    "gzdoom-407"  "%~1"
IF /I "%$%" == "S" CALL :launch_engine    "gzdoom-408"  "%~1"
IF /I "%$%" == "T" CALL :launch_engine    "gzdoom-409"  "%~1"
IF /I "%$%" == "U" CALL :launch_engine    "gzdoom-410"  "%~1"
IF /I "%$%" == "V" CALL :launch_engine    "gzdoom-411"  "%~1"

GOTO :menu_gzdoom



:launch_engine
REM #
REM #    %1 = engine-name
REM #    %2 = IWAD
REM ============================================================================
REM # launch the engine using our default config file
"%LAUNCHER%" /AUTO /DEFAULT /WAIT /USE %~1 /IWAD %~2
GOTO:EOF

:launch_engine_sw
REM #
REM #    %1 = engine-name
REM #    %2 = IWAD
REM ============================================================================
REM # launch the engine using our default config file
"%LAUNCHER%" /AUTO /DEFAULT /WAIT /USE %~1 /SW /IWAD %~2
GOTO:EOF
