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
ECHO:

SET "$="
SET /P "$=? "

IF "%$%" == "" EXIT /B

IF /I "%$%" == "A" CALL :menu_doom

GOTO :menu


:menu_doom
REM ============================================================================
CLS
ECHO:
ECHO  Edit DOOM Engine Defaults:
ECHO  ==========================
ECHO  Select engine:
ECHO:
ECHO     [A] Chocolate Doom             DOOM.WAD
ECHO     [B] Crispy Doom                DOOM.WAD
ECHO:
ECHO     [C] PrBoom+ Hardware           DOOM.WAD
ECHO     [D] PrBoom+ Software           DOOM.WAD
ECHO:
ECHO     [E] Zandronum v2               DOOM.WAD
ECHO     [F] Zandronum v3               DOOM.WAD
ECHO:
ECHO     [G] GZDoom ...                 DOOM.WAD
ECHO:

SET "$="
SET /P "$=? "

IF "%$%" == "" GOTO:EOF

IF /I "%$%" == "A" CALL :launch_engine    "choco-doom-setup"  "DOOM.WAD"
IF /I "%$%" == "B" CALL :launch_engine    "crispy-doom-setup" "DOOM.WAD"
IF /I "%$%" == "C" CALL :launch_engine    "prboom"            "DOOM.WAD"
IF /I "%$%" == "D" CALL :launch_engine_sw "prboom"            "DOOM.WAD"
IF /I "%$%" == "E" CALL :launch_engine    "zandronum-2"       "DOOM.WAD"
IF /I "%$%" == "F" CALL :launch_engine    "zandronum-3"       "DOOM.WAD"
IF /I "%$%" == "G" CALL :menu_gzdoom "DOOM.WAD"

GOTO :menu_doom


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
ECHO  [Q] v2.4		[R] v3.2
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
