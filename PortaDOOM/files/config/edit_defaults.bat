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

SET "$="
SET /P "$=? "

IF "%$%" == "" GOTO:EOF

IF /I "%$%" == "A" CALL :launch_engine_cfg    "choco-doom-setup"  "DOOM.WAD"
IF /I "%$%" == "B" CALL :launch_engine_cfg    "crispy-doom-setup" "DOOM.WAD"
IF /I "%$%" == "C" CALL :launch_engine_cfg    "prboom"            "DOOM.WAD"
IF /I "%$%" == "D" CALL :launch_engine_cfg_sw "prboom"            "DOOM.WAD"

GOTO :menu_doom


:launch_engine_cfg
REM #
REM #    %1 = engine-name
REM #    %2 = IWAD
REM ============================================================================
REM # launch the engine using our default config file
CALL %DOOM% /DEFAULT /WAIT /USE %~1 /IWAD %~2
GOTO:EOF

:launch_engine_cfg_sw
REM #
REM #    %1 = engine-name
REM #    %2 = IWAD
REM ============================================================================
REM # launch the engine using our default config file
CALL %DOOM% /DEFAULT /WAIT /USE %~1 /SW /IWAD %~2
GOTO:EOF
