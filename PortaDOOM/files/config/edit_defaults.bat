@ECHO OFF

REM # switch the current directory to that of this file
CD %~dp0
REM # relative location of the saves folder (where user-configs are stored)
SET "SAVES=..\saves"
REM # relative path to doom.bat
SET "DOOM=..\doom.bat"
REM # relative path for doom.bat to get to the config folder
SET "CONFIG=..\..\..\config"

:menu
REM ============================================================================
CLS
ECHO:
ECHO  Edit Engine Defaults:
ECHO  =====================
ECHO  Select IWAD:
ECHO:
ECHO     [A] DOOM / DOOM II / TNT / PLUTONIA
ECHO     [B] HERETIC
ECHO     [C] HEXEN
ECHO     [D] STRIFE
ECHO:
ECHO     [E] DOOM 64 ^(DOOM 64 EX^)
ECHO:

SET "$="
SET /P "$=? "

IF "%$%" == "" EXIT /B

IF /I "%$%" == "A" CALL :menu_doom
IF /I "%$%" == "B" CALL :menu_heretic
IF /I "%$%" == "C" CALL :menu_hexen
IF /I "%$%" == "D" CALL :menu_strife

REM # don't need a menu for DOOM 64, there's only one engine
IF /I "%$%" == "E" CALL :launch_engine "doom64ex" "DOOM64.WAD"

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
IF /I "%$%" == "H" CALL :launch_engine    "prboom"               "DOOM.WAD"
IF /I "%$%" == "S" CALL :launch_engine_sw "prboom"               "DOOM.WAD"
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
IF /I "%$%" == "2" CALL :launch_engine    "zandronum-2"          "STRIFE1.WAD"
IF /I "%$%" == "3" CALL :launch_engine    "zandronum-3"          "STRIFE1.WAD"
IF /I "%$%" == "G" CALL :menu_gzdoom                             "STRIFE1.WAD"
IF /I "%$%" == "Z" CALL :launch_engine    "zdoom"                "STRIFE1.WAD"

GOTO :menu_strife


:menu_gzdoom
REM ============================================================================
CLS
ECHO:
ECHO  Edit DOOM Engine Defaults:
ECHO  ==========================
ECHO  Select GZDoom engine:
ECHO:
ECHO  [A] GZDoom, current
ECHO:
ECHO  [B] v0.9		[C] v1.0	[D] v1.1
ECHO  [E] v1.2		[F] v1.3	[G] v1.4
ECHO  [H] v1.5		[I] v1.6	[J] v1.7
ECHO  [K] v1.8		[L] v1.9	[M] v2.0
ECHO  [N] v2.1		[O] v2.2	[P] v2.3
ECHO  [Q] v2.4		[R] v3.2	[S] v3.3
ECHO:

SET "$="
SET /P "$=? "

IF "%$%" == "" GOTO:EOF

IF /I "%$%" == "A" CALL :launch_engine    "gzdoom"     "%~1"
IF /I "%$%" == "B" CALL :launch_engine    "gzdoom-09"  "%~1"
IF /I "%$%" == "C" CALL :launch_engine    "gzdoom-10"  "%~1"
IF /I "%$%" == "D" CALL :launch_engine    "gzdoom-11"  "%~1"
IF /I "%$%" == "E" CALL :launch_engine    "gzdoom-12"  "%~1"
IF /I "%$%" == "F" CALL :launch_engine    "gzdoom-13"  "%~1"
IF /I "%$%" == "G" CALL :launch_engine    "gzdoom-14"  "%~1"
IF /I "%$%" == "H" CALL :launch_engine    "gzdoom-15"  "%~1"
IF /I "%$%" == "I" CALL :launch_engine    "gzdoom-16"  "%~1"
IF /I "%$%" == "J" CALL :launch_engine    "gzdoom-17"  "%~1"
IF /I "%$%" == "K" CALL :launch_engine    "gzdoom-18"  "%~1"
IF /I "%$%" == "L" CALL :launch_engine    "gzdoom-19"  "%~1"
IF /I "%$%" == "M" CALL :launch_engine    "gzdoom-20"  "%~1"
IF /I "%$%" == "N" CALL :launch_engine    "gzdoom-21"  "%~1"
IF /I "%$%" == "O" CALL :launch_engine    "gzdoom-22"  "%~1"
IF /I "%$%" == "P" CALL :launch_engine    "gzdoom-23"  "%~1"
IF /I "%$%" == "Q" CALL :launch_engine    "gzdoom-24"  "%~1"
IF /I "%$%" == "R" CALL :launch_engine    "gzdoom-32"  "%~1"
IF /I "%$%" == "S" CALL :launch_engine    "gzdoom-33"  "%~1"

GOTO :menu_gzdoom





:launch_engine
REM #
REM #    %1 = engine-name
REM #    %2 = IWAD
REM ============================================================================
REM # launch the engine using our default config file
CALL %DOOM% /DEFAULT /WAIT /USE %~1 /IWAD %~2
GOTO:EOF

:launch_engine_sw
REM #
REM #    %1 = engine-name
REM #    %2 = IWAD
REM ============================================================================
REM # launch the engine using our default config file
CALL %DOOM% /DEFAULT /WAIT /USE %~1 /SW /IWAD %~2
GOTO:EOF
