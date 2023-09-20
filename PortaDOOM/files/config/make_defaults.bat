:: PortaDOOM, copyright (C) Kroc Camen 2016-2023, BSD 2-clause
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
ECHO  JUST QUIT (ALT+F4) EACH ENGINE FROM THE TITLE SCREEN AS IT APPEARS.
ECHO  This script will inject the config changes afterwards.
ECHO:
ECHO  When ready to begin, press any key.
ECHO:
PAUSE>NUL

PUSHD %~dp0

REM # relative location of the saves folder
REM # (where user-configs are stored)
SET "SAVES=..\saves"
REM # relative path to launcher.exe
SET "LAUNCHER=..\launcher.exe"

SET BIN_CFGINI=cfgini.exe
SET BIN_FART=fart.exe --quiet --word --c-style --ignore-case --adapt --


REM # Chocolate Doom / Crispy Doom
REM #===========================================================================
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
REM #===========================================================================
:doom-retro
REM # delete the file in order to re-build it
IF EXIST "default.doom-retro.cfg" GOTO :glboom-plus

ECHO * DOOM Retro                 DOOM.WAD
CALL :make_doomretro "doom-retro" "DOOM.WAD"
ECHO ----------------------------------------


REM # PrBoom+ (hardware / software)
REM #===========================================================================
:glboom-plus
REM # delete the file in order to re-build it
IF EXIST "default.glboom-plus.cfg" GOTO :prboom-plus

ECHO * PrBoom+ ^(hardware^)         DOOM.WAD
CALL :make_boom_hw "prboom-plus" "DOOM.WAD"

:prboom-plus
REM # delete the file in order to re-build it
IF EXIST "default.prboom-plus.cfg" GOTO :zandronum-2

ECHO * PrBoom+ ^(software^)         DOOM.WAD
CALL :make_boom_sw "prboom-plus" "DOOM.WAD"
ECHO ----------------------------------------


REM # Zandronum
REM #===========================================================================
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
IF EXIST "default.zandronum-3.ini" GOTO :gzdoom-all

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
REM #===========================================================================
:gzdoom-all
CALL :gzdoom_any 99
CALL :gzdoom_any 48
CALL :gzdoom_any 47
CALL :gzdoom_any 46
CALL :gzdoom_any 45
CALL :gzdoom_any 44
CALL :gzdoom_any 43
CALL :gzdoom_any 42
CALL :gzdoom_any 41
CALL :gzdoom_any 37
CALL :gzdoom_any 36
CALL :gzdoom_any 35
CALL :gzdoom_any 34
CALL :gzdoom_any 33
CALL :gzdoom_any 32
CALL :gzdoom_any 24
CALL :gzdoom_any 23
CALL :gzdoom_any 22
CALL :gzdoom_any 21
CALL :gzdoom_any 20
CALL :gzdoom_any 19
CALL :gzdoom_any 18
CALL :gzdoom_any 17
CALL :gzdoom_any 16
CALL :gzdoom_any 15
CALL :gzdoom_any 14
CALL :gzdoom_any 13
CALL :gzdoom_any 12
CALL :gzdoom_any 11
CALL :gzdoom_any 10


REM # ZDoom
REM #===========================================================================
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
REM #===========================================================================
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
REM #===========================================================================
REM #    %1 = engine-name
REM #    %2 = IWAD
REM #---------------------------------------------------------------------------
REM # launch the engine to generate new default config files
START "" /WAIT "%LAUNCHER%" /WAIT /AUTO /USE "%~1" /DEFAULT /IWAD "%~2"

SET DEFAULT_CFG="default.%~1.cfg"
SET CONFIG_DEFAULT=%BIN_CFGINI% %DEFAULT_CFG%

%CONFIG_DEFAULT% SET "alwaysrun" "on"
%CONFIG_DEFAULT% SET "messages" "on"
%CONFIG_DEFAULT% SET "am_rotatemode" "off"
%CONFIG_DEFAULT% SET "playername" """PortaDOOM"""
REM # TODO: is this relative to the EXE or to the current directory?
%CONFIG_DEFAULT% SET "iwadfolder" """..\..\wads"""
ECHO bind F12 +screenshot>>%DEFAULT_CFG%

REM # TODO: reset the stats properties?
%CONFIG_DEFAULT% SET "runs" "0"

GOTO:EOF


:make_vanilla
REM #===========================================================================
REM #    %1 = engine-name
REM #    %2 = IWAD
REM #---------------------------------------------------------------------------
REM # launch the engine to generate new default config files
START "" /WAIT "%LAUNCHER%" /WAIT /AUTO /USE "%~1" /DEFAULT /IWAD "%~2"

SET DEFAULT_CFG="default.%~1.cfg"
SET CONFIG_DEFAULT=%BIN_CFGINI% %DEFAULT_CFG%
SET EXTRA_CFG="default.%~1.extra.cfg"
SET CONFIG_EXTRA=%BIN_CFGINI% %EXTRA_CFG%

REM # main keys
%CONFIG_DEFAULT% SET "key_up" "17"
%CONFIG_DEFAULT% SET "key_down" "31"
%CONFIG_DEFAULT% SET "key_strafeleft" "30"
%CONFIG_DEFAULT% SET "key_straferight" "32"
%CONFIG_DEFAULT% SET "key_use" "18"
REM # mouse-movement off
%CONFIG_EXTRA% SET "novert" "1"
%CONFIG_DEFAULT% SET "mouseb_strafe" "-1"
%CONFIG_DEFAULT% SET "mouseb_forward" "-1"
REM # mouse controls
%CONFIG_EXTRA% SET "mouseb_prevweapon" "4"
%CONFIG_EXTRA% SET "mouseb_nextweapon" "3"
%CONFIG_EXTRA% SET "dclick_use" "0"

REM # always run
%CONFIG_DEFAULT% SET "joyb_speed" "29"

REM # compatibility
%CONFIG_EXTRA% SET "fullscreen" "1"
%CONFIG_EXTRA% SET "show_endoom" "0"
%CONFIG_EXTRA% SET "vanilla_savegame_limit" "0"
%CONFIG_EXTRA% SET "vanilla_demo_limit" "0"
%CONFIG_EXTRA% SET "png_screenshots" "1"

REM # use F12 for screen-shot
%CONFIG_EXTRA% SET "key_spy" "0"
%CONFIG_EXTRA% SET "key_menu_screenshot" "88"

REM # user-name for multi-player
REM # (crispy-doom 5.6+ uses a randomly generated name)
%CONFIG_EXTRA% SET "player_name" """PortaDOOM"""
REM # in Chocolate Strife there's also nickname?
IF [%~1] == [choco-strife] %CONFIG_DEFAULT% SET "nickname" """PortaDOOM"""

SET "APPDATAESC=%APPDATA:\=\\%"

REM # Crispy Doom, annoyingly, adds these in
IF [%~1] == [crispy-doom] %CONFIG_EXTRA% SET "autoload_path" """autoload"""
IF [%~1] == [crispy-doom] %CONFIG_EXTRA% SET "music_pack_path" """music-packs"""

GOTO:EOF


:make_boom_hw
REM #===========================================================================
REM #    %1 = engine-name
REM #    %2 = IWAD
REM #---------------------------------------------------------------------------
REM # launch the engine to generate new default config files
START "" /WAIT "%LAUNCHER%" /WAIT /AUTO /USE "%~1" /DEFAULT /IWAD "%~2"

CALL :make_boom_inject "glboom-plus"

SET DEFAULT_CFG="default.glboom-plus.cfg"
SET CONFIG_DEFAULT=%BIN_CFGINI% %DEFAULT_CFG%

REM # turn off texture filtering
%CONFIG_DEFAULT% SET "gl_texture_filter" "2"
%CONFIG_DEFAULT% SET "gl_sprite_filter" "2"
%CONFIG_DEFAULT% SET "gl_patch_filter" "0"
%CONFIG_DEFAULT% SET "gl_texture_filter_anisotropic" "4"

GOTO:EOF

:make_boom_sw
REM #===========================================================================
REM #    %1 = engine-name
REM #    %2 = IWAD
REM #---------------------------------------------------------------------------
REM # launch the engine to generate new default config files
START "" /WAIT "%LAUNCHER%" /WAIT /AUTO /USE "%~1" /SW /DEFAULT /IWAD "%~2"
CALL :make_boom_inject "prboom-plus"

GOTO:EOF

:make_boom_inject
REM #---------------------------------------------------------------------------
SET DEFAULT_CFG="default.%~1.cfg"
SET CONFIG_DEFAULT=%BIN_CFGINI% %DEFAULT_CFG%

%CONFIG_DEFAULT% SET "key_use" "0x65"
%CONFIG_DEFAULT% SET "key_spy" "0x2a"
%CONFIG_DEFAULT% SET "key_screenshot" "0xd8"
%CONFIG_DEFAULT% SET "hudadd_crosshair" "1"
%CONFIG_DEFAULT% SET "hudadd_secretarea" "1"
%CONFIG_DEFAULT% SET "mouse_doubleclick_as_use" "0"
%CONFIG_DEFAULT% SET "movement_mouselook" "1"

GOTO:EOF


:make_zandronum
REM #===========================================================================
REM #    %1 = engine-name
REM #    %2 = IWAD
REM #---------------------------------------------------------------------------
REM # launch the engine to generate new default config files
START "" /WAIT "%LAUNCHER%" /WAIT /AUTO /USE "%~1" /DEFAULT /IWAD "%~2" /QUIT

SET DEFAULT_INI="default.%~1.ini"
SET CONFIG_DEFAULT=%BIN_CFGINI% %DEFAULT_INI%

REM # graphics
%CONFIG_DEFAULT% SET "[GlobalSettings]" "vid_vsync" "true"
%CONFIG_DEFAULT% SET "[GlobalSettings]" "vid_renderer" "1"

REM # in Zandronum 2, these settings are in global, rather than per-game
IF [%~1] == [zandronum-2] %CONFIG_DEFAULT% SET "[GlobalSettings]" "crosshair" "2"
IF [%~1] == [zandronum-2] %CONFIG_DEFAULT% SET "[GlobalSettings]" "crosshairscale" "false"

REM # from here, settings are separated per game IWAD
IF /I "%~2" == "DOOM.WAD"	SET "SECTION=Doom"
IF /I "%~2" == "HERETIC.WAD" 	SET "SECTION=Heretic"
IF /I "%~2" == "HEXEN.WAD" 	SET "SECTION=Hexen"
IF /I "%~2" == "STRIFE1.WAD" 	SET "SECTION=Strife"
IF /I "%~2" == "CHEX.WAD" 	SET "SECTION=Chex"
IF /I "%~2" == "HARM1.WAD" 	SET "SECTION=Harmony"
REM # shorthand for the game-specific section
SET CONSOLE_VARS="[%SECTION%.ConsoleVariables]"

REM # in Zandronum 3, these settings are per-game instead of global
IF [%~1] == [zandronum-3] %CONFIG_DEFAULT% SET %CONSOLE_VARS% "crosshair" "2"
IF [%~1] == [zandronum-3] %CONFIG_DEFAULT% SET %CONSOLE_VARS% "crosshairscale" "false"
IF [%~1] == [zandronum-3] %CONFIG_DEFAULT% SET %CONSOLE_VARS% "vid_cursor" "-"

REM # scaling of hud / message text
%CONFIG_DEFAULT% SET %CONSOLE_VARS% "hud_scale" "true"
%CONFIG_DEFAULT% SET %CONSOLE_VARS% "cl_stfullscreenhud" "false"
%CONFIG_DEFAULT% SET %CONSOLE_VARS% "con_scaletext" "true"
%CONFIG_DEFAULT% SET %CONSOLE_VARS% "con_scaletext_usescreenratio" "true"
%CONFIG_DEFAULT% SET %CONSOLE_VARS% "con_virtualwidth" "640"
%CONFIG_DEFAULT% SET %CONSOLE_VARS% "con_virtualheight" "368"
REM # automap, show item-count
%CONFIG_DEFAULT% SET %CONSOLE_VARS% "am_showitems" "true"

REM # player set up
%CONFIG_DEFAULT% SET "[%SECTION%.Player]" "gender" "other"
%CONFIG_DEFAULT% SET "[%SECTION%.Player]" "name" "PortaDOOM"

REM # controls
%CONFIG_DEFAULT% SET "[%SECTION%.Bindings]" "mouse2" "+altattack"
%CONFIG_DEFAULT% SET "[%SECTION%.Bindings]" "space" "+jump"
%CONFIG_DEFAULT% SET "[%SECTION%.Bindings]" "f12" "screenshot"
%CONFIG_DEFAULT% SET "[%SECTION%.Bindings]" "e" "+use"
%CONFIG_DEFAULT% SET "[%SECTION%.Bindings]" "q" "+zoom"
%CONFIG_DEFAULT% SET "[%SECTION%.Bindings]" "r" "+reload"
%CONFIG_DEFAULT% SET "[%SECTION%.Bindings]" "c" "+crouch"
%CONFIG_DEFAULT% DEL "[%SECTION%.Bindings]" "mouse3"

GOTO:EOF


:gzdoom_any
REM #===========================================================================
REM #    %1 = version-number (i.e. "gzdoom-nn.ini")
REM #	      99 = default (i.e. "gzdoom.ini")
REM #---------------------------------------------------------------------------
IF %~1 EQU 99 SET "INI=gzdoom"
IF %~1 LSS 99 SET "INI=gzdoom-%~1"
SET DEFAULT_INI="default.%INI%.ini"

SET "VER=%~1"
IF %~1 EQU 99 SET "VER=    "
IF %~1 LSS 99 SET "VER=v%VER:~0,1%.%VER:~1,1%"

REM # delete the file in order to re-build it
IF EXIST %DEFAULT_INI% GOTO:EOF

ECHO * GZDoom %VER%                DOOM.WAD
CALL :make_gzdoom %~1 "DOOM.WAD"
ECHO * GZDoom %VER%                HERETIC.WAD
CALL :make_gzdoom %~1 "HERETIC.WAD"
ECHO * GZDoom %VER%                HEXEN.WAD
CALL :make_gzdoom %~1 "HEXEN.WAD"
ECHO * GZDoom %VER%                STRIFE1.WAD
CALL :make_gzdoom %~1 "STRIFE1.WAD"
REM # Chex support first appears in v1.1
IF %~1 GEQ 11 (
	ECHO * GZDoom %VER%                CHEX.WAD
	CALL :make_gzdoom %~1 "CHEX.WAD"
)
REM # from GZDoom v1.5 we gain support for Harmony.
REM # technically v1.4 supports it, but it doesn't
REM # populate the config defaults as expected
IF %~1 GEQ 15 (
	ECHO * GZDoom %VER%                HARM1.WAD
	CALL :make_gzdoom %~1 "HARM1.WAD"
)
REM # Rise Of The Wool Ball support from v3.2 onwards
IF %~1 GEQ 32 (
	ECHO * GZDoom %VER%                ROTWB.WAD
	CALL :make_gzdoom %~1 "ROTWB.WAD"
)
REM # Adventures of Square support from v3.3 onwards
IF %~1 GEQ 33 (
	ECHO * GZDoom %VER%                SQUARE1.PK3
	CALL :make_gzdoom %~1 "SQUARE1.PK3"
)
ECHO ----------------------------------------
GOTO:EOF


:make_gzdoom
REM #===========================================================================
REM #    %1 = version-number (i.e. "gzdoom-nn.ini")
REM #	      99 = default (i.e. "gzdoom.ini")
REM #    %2 = IWAD
REM #---------------------------------------------------------------------------
IF %~1 EQU 99 SET "INI=gzdoom"
IF %~1 LSS 99 SET "INI=gzdoom-%~1"
SET DEFAULT_INI="default.%INI%.ini"
SET CONFIG_DEFAULT=%BIN_CFGINI% %DEFAULT_INI%

REM # launch the engine to generate new default config files
START "" /WAIT "%LAUNCHER%" /WAIT /AUTO /USE %INI% /DEFAULT /IWAD "%~2" /QUIT

REM # disable stats collection; this might be undesirable if PortaDOOM
REM # is being moved around multiple PCs intended for offline use
REM # (this first appeared in v4.2 and appears now and again)
IF %~1 GEQ 42 %CONFIG_DEFAULT% SET "[GlobalSettings]" "sys_statsenabled" "0"
REM # VSync ON
%CONFIG_DEFAULT% SET "[GlobalSettings]" "vid_vsync" "true"
REM # "fullscreen" field is used before v4.4
REM # (fullscreen isn't default from v2.2 to v3.4)
IF %~1 LSS 44 %CONFIG_DEFAULT% SET "[GlobalSettings]" "fullscreen" "true"
REM # from v4.4 the field has changed to "vid_fullscreen"
IF %~1 GEQ 44 %CONFIG_DEFAULT% SET "[GlobalSettings]" "vid_fullscreen" "true"

REM # Texture Filtering: Nearest (Linear Mipmap) is supported from v1.5 onwards;
REM # (graphics break if this is applied to earlier versions)
IF %~1 GEQ 15 %CONFIG_DEFAULT% SET "[GlobalSettings]" "gl_texture_filter" "5"
REM # use "Mipmapped" for earlier versions
IF %~1 LSS 15 %CONFIG_DEFAULT% SET "[GlobalSettings]" "gl_texture_filter" "1"
REM # enable cross-hair, type 2 (this is in GlobalSettings before v1.5)
IF %~1 LSS 15 %CONFIG_DEFAULT% SET "[GlobalSettings]" "crosshair" "2"
REM # full-screen HUD (this is in GlobalSettings before v1.3)
IF %~1 LSS 13 %CONFIG_DEFAULT% SET "[GlobalSettings]" "screenblocks" "11"
REM # cross hair 1:1 pixels (no-scale), added in v1.2
IF %~1 GEQ 12 (
	REM # moved from GlobalSettings to per-game in v.1.5
	IF %~1 LSS 15 %CONFIG_DEFAULT% SET "[GlobalSettings]" "crosshairscale" "false"
)

REM # mouse-look by default
%CONFIG_DEFAULT% SET "[GlobalSettings]" "freelook" "true"
REM # always run
%CONFIG_DEFAULT% SET "[GlobalSettings]" "cl_run" "true"
REM # do not attempt to locate IWAD (we always provide it)
%CONFIG_DEFAULT% SET "[GlobalSettings]" "queryiwad" "false"

REM # from here, settings are separated per game IWAD
IF /I "%~2" == "DOOM.WAD"	SET "SECTION=Doom"
IF /I "%~2" == "HERETIC.WAD" 	SET "SECTION=Heretic"
IF /I "%~2" == "HEXEN.WAD" 	SET "SECTION=Hexen"
IF /I "%~2" == "STRIFE1.WAD" 	SET "SECTION=Strife"
IF /I "%~2" == "CHEX.WAD" 	SET "SECTION=Chex"
IF /I "%~2" == "HARM1.WAD" 	SET "SECTION=Harmony"
IF /I "%~2" == "ROTWB.WAD" 	SET "SECTION=WoolBall"
IF /I "%~2" == "SQUARE1.PK3" 	SET "SECTION=Square"
REM # shorthand for the game-specific section
SET CONSOLE_VARS="[%SECTION%.ConsoleVariables]"

REM # use "standard" light mode instead of "dark"
%CONFIG_DEFAULT% SET %CONSOLE_VARS% "gl_lightmode" "0"
REM # automap, show item-count
%CONFIG_DEFAULT% SET %CONSOLE_VARS% "am_showitems" "true"
REM # use system mouse cursor (cursor was added in v1.5)
IF %~1 GEQ 15 %CONFIG_DEFAULT% SET %CONSOLE_VARS% "vid_cursor" "-"
REM # full-screen HUD (this is per-game from v1.3)
IF %~1 GEQ 13 %CONFIG_DEFAULT% SET %CONSOLE_VARS% "screenblocks" "11"
REM # UI scale defaults to 2 between v2.2 & v3.x
REM # this is better set to 0 (auto), which is the default from v4+
IF %~1 GEQ 22 IF %~1 LSS 40 %CONFIG_DEFAULT% SET %CONSOLE_VARS% "uiscale" "0"
REM # HUD auto-scale (v2.1-)
IF %~1 LEQ 21 %CONFIG_DEFAULT% SET %CONSOLE_VARS% "hud_scale" "true"
REM # HUD auto-scale (v2.2+)
IF %~1 GEQ 22 %CONFIG_DEFAULT% SET %CONSOLE_VARS% "hud_scale" "-1"
REM # status bar auto-scale
%CONFIG_DEFAULT% SET %CONSOLE_VARS% "st_scale" "-1"
REM # there's no auto message-scale, 2 makes it readable without being too big
%CONFIG_DEFAULT% SET %CONSOLE_VARS% "con_scaletext" "2"
REM # enable cross-hair, type 2 (this is per-game from v1.5)
IF %~1 GEQ 15 %CONFIG_DEFAULT% SET %CONSOLE_VARS% "crosshair" "2"
REM # cross hair 1:1 pixels (no-scale), becomes per-game in v1.5
REM # from v1.2 to v2.1 it is a boolean true/false value
IF %~1 GEQ 15 IF %~1 LEQ 21 %CONFIG_DEFAULT% SET %CONSOLE_VARS% "crosshairscale" "false"
REM # in v2.2+ it becomes a value
IF %~1 GEQ 15 IF %~1 GEQ 22 %CONFIG_DEFAULT% SET %CONSOLE_VARS% "crosshairscale" "0"

REM # set controls:
REM # NOTE: from GZDoom v4.0+, fields are capitalised
IF %~1 GEQ 40 (
	%CONFIG_DEFAULT% SET "[%SECTION%.Bindings]" "E" "+use"
	%CONFIG_DEFAULT% SET "[%SECTION%.Bindings]" "Q" "+zoom"
	%CONFIG_DEFAULT% SET "[%SECTION%.Bindings]" "R" "+reload"
	%CONFIG_DEFAULT% SET "[%SECTION%.Bindings]" "C" "+crouch"
	%CONFIG_DEFAULT% SET "[%SECTION%.Bindings]" "W" "+forward"
	%CONFIG_DEFAULT% SET "[%SECTION%.Bindings]" "A" "+moveleft"
	%CONFIG_DEFAULT% SET "[%SECTION%.Bindings]" "S" "+back"
	%CONFIG_DEFAULT% SET "[%SECTION%.Bindings]" "D" "+moveright"
	%CONFIG_DEFAULT% SET "[%SECTION%.Bindings]" "Space" "+jump"
	%CONFIG_DEFAULT% SET "[%SECTION%.Bindings]" "F12" "screenshot"
	%CONFIG_DEFAULT% SET "[%SECTION%.Bindings]" "Mouse2" "+altattack"
) ELSE (
	%CONFIG_DEFAULT% SET "[%SECTION%.Bindings]" "e" "+use"
	%CONFIG_DEFAULT% SET "[%SECTION%.Bindings]" "q" "+zoom"
	%CONFIG_DEFAULT% SET "[%SECTION%.Bindings]" "r" "+reload"
	%CONFIG_DEFAULT% SET "[%SECTION%.Bindings]" "c" "+crouch"
	%CONFIG_DEFAULT% SET "[%SECTION%.Bindings]" "w" "+forward"
	%CONFIG_DEFAULT% SET "[%SECTION%.Bindings]" "a" "+moveleft"
	%CONFIG_DEFAULT% SET "[%SECTION%.Bindings]" "s" "+back"
	%CONFIG_DEFAULT% SET "[%SECTION%.Bindings]" "d" "+moveright"
	%CONFIG_DEFAULT% SET "[%SECTION%.Bindings]" "space" "+jump"
	%CONFIG_DEFAULT% SET "[%SECTION%.Bindings]" "f12" "screenshot"
	%CONFIG_DEFAULT% SET "[%SECTION%.Bindings]" "mouse2" "+altattack"
)
REM # unbind mouse-forward
%CONFIG_DEFAULT% DEL "[%SECTION%.Bindings]" "mouse3"

REM # define player:
%CONFIG_DEFAULT% SET "[%SECTION%.Player]" "name" "PortaDOOM"
%CONFIG_DEFAULT% SET "[%SECTION%.Player]" "gender" "other"

GOTO:EOF


:make_zdoom
REM #===========================================================================
REM #    %1 = engine-name
REM #    %2 = IWAD
REM #---------------------------------------------------------------------------
REM # launch the engine to generate new default config files
START "" /WAIT "%LAUNCHER%" /WAIT /AUTO /USE "%~1" /DEFAULT /IWAD "%~2" /QUIT

SET DEFAULT_INI="default.%~1.ini"
SET CONFIG_DEFAULT=%BIN_CFGINI% %DEFAULT_INI%

%CONFIG_DEFAULT% SET "[GlobalSettings]" "vid_vsync" "true"
%CONFIG_DEFAULT% SET "[GlobalSettings]" "queryiwad" "false"
%CONFIG_DEFAULT% SET "[GlobalSettings]" "cl_run" "true"

REM # from here, settings are separated per game IWAD
IF /I "%~2" == "DOOM.WAD"	SET "SECTION=Doom"
IF /I "%~2" == "HERETIC.WAD" 	SET "SECTION=Heretic"
IF /I "%~2" == "HEXEN.WAD" 	SET "SECTION=Hexen"
IF /I "%~2" == "STRIFE1.WAD" 	SET "SECTION=Strife"
IF /I "%~2" == "CHEX.WAD" 	SET "SECTION=Chex"
IF /I "%~2" == "HARM1.WAD" 	SET "SECTION=Harmony"
REM # shorthand for the game-specific section
SET CONSOLE_VARS="[%SECTION%.ConsoleVariables]"

REM # full-screen HUD
%CONFIG_DEFAULT% SET %CONSOLE_VARS% "screenblocks" "11"
%CONFIG_DEFAULT% SET %CONSOLE_VARS% "vid_cursor" "-"
REM # HUD auto-scale
%CONFIG_DEFAULT% SET %CONSOLE_VARS% "hud_scale" "true"
%CONFIG_DEFAULT% SET %CONSOLE_VARS% "con_scaletext" "1"
REM # automap, show item-count
%CONFIG_DEFAULT% SET %CONSOLE_VARS% "am_showitems" "true"

REM # define player:
%CONFIG_DEFAULT% SET "[%SECTION%.Player]" "name" "PortaDOOM"
%CONFIG_DEFAULT% SET "[%SECTION%.Player]" "gender" "other"

REM # change controls
%CONFIG_DEFAULT% SET "[%SECTION%.Bindings]" "space" "+jump"
%CONFIG_DEFAULT% SET "[%SECTION%.Bindings]" "f12" "screenshot"
%CONFIG_DEFAULT% SET "[%SECTION%.Bindings]" "mouse2" "+altattack"
%CONFIG_DEFAULT% SET "[%SECTION%.Bindings]" "e" "+use"
%CONFIG_DEFAULT% SET "[%SECTION%.Bindings]" "q" "+zoom"
%CONFIG_DEFAULT% SET "[%SECTION%.Bindings]" "r" "+reload"
%CONFIG_DEFAULT% SET "[%SECTION%.Bindings]" "c" "+crouch"
%CONFIG_DEFAULT% SET "[%SECTION%.Bindings]" "w" "+forward"
%CONFIG_DEFAULT% SET "[%SECTION%.Bindings]" "a" "+moveleft"
%CONFIG_DEFAULT% SET "[%SECTION%.Bindings]" "s" "+back"
%CONFIG_DEFAULT% SET "[%SECTION%.Bindings]" "d" "+moveright"
%CONFIG_DEFAULT% DEL "[%SECTION%.Bindings]" "mouse3"

GOTO:EOF


:make_doom64
REM #===========================================================================
REM #    %1 = engine-name
REM #    %2 = IWAD
REM #---------------------------------------------------------------------------
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