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
ECHO  Note that this will delete your current user-config for an engine!
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
ECHO  Note that this will delete your current user-config for an engine!
ECHO  Select engine:
ECHO:
ECHO     [A] Chocolate Doom             DOOM.WAD
ECHO     [B] Crispy Doom                DOOM.WAD
ECHO:
ECHO     [C] PrBoom+ Hardware           DOOM.WAD
ECHO     [D] PrBoom+ Software           DOOM.WAD

SET "$="
SET /P "$=? "

IF "%$%" == "" GOTO:EOF

IF /I "%$%" == "A" CALL :launch_engine_cfg    "choco-doom-setup"  "choco-doom"  "DOOM.WAD"
IF /I "%$%" == "B" CALL :launch_engine_cfg    "crispy-doom-setup" "crispy-doom" "DOOM.WAD"
IF /I "%$%" == "C" CALL :launch_engine_cfg    "prboom"            "glboom-plus" "DOOM.WAD"
IF /I "%$%" == "D" CALL :launch_engine_cfg_sw "prboom"            "prboom-plus" "DOOM.WAD"

GOTO :menu_doom


:launch_engine_cfg
REM #
REM #    %1 = engine-name
REM #    %2 = config-file id
REM #    %3 = IWAD
REM ============================================================================
REM # delete the user's config that would override the default
IF EXIST "%SAVES%\%~1\config.%~2.cfg"       DEL "%SAVES%\%~1\config.%~2.cfg"        >NUL 2>&1
IF EXIST "%SAVES%\%~1\config.%~2.extra.cfg" DEL "%SAVES%\%~1\config.%~2.extra.cfg"  >NUL 2>&1
REM # launch the engine using our default config file
CALL %DOOM% /DEFAULT /WAIT /USE %~1 /IWAD %~3
GOTO:EOF

:launch_engine_cfg_sw
REM #
REM #    %1 = engine-name
REM #    %2 = config-file id
REM #    %3 = IWAD
REM ============================================================================
REM # delete the user's config that would override the default
IF EXIST "%SAVES%\%~1\config.%~2.cfg"       DEL "%SAVES%\%~1\config.%~2.cfg"        >NUL 2>&1
REM # launch the engine using our default config file
CALL %DOOM% /DEFAULT /WAIT /USE %~1 /SW /IWAD %~3
GOTO:EOF