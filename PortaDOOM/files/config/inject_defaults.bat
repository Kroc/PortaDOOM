@ECHO OFF & SETLOCAL ENABLEEXTENSIONS DISABLEDELAYEDEXPANSION

CD %~dp0

REM # how to store a newline character in a string, thanks to
REM # <https://stackoverflow.com/a/5552995>
SET NEWLINE=^& ECHO:

SET BIN_INIFILE=..\tools\inifile\inifile.exe
SET BIN_FART=..\tools\fart\fart.exe --count --word --c-style --ignore-case --adapt --

REM # Chocolate / Crispy Doom:
REM ====================================================================================================================

REM # main keys
%BIN_FART% "default.*.cfg" "key_up                        72"		"key_up                        17"
%BIN_FART% "default.*.cfg" "key_down                      80"		"key_down                      31"
%BIN_FART% "default.*.cfg" "key_strafeleft                51"		"key_strafeleft                30"
%BIN_FART% "default.*.cfg" "key_straferight               52"		"key_straferight               32"
%BIN_FART% "default.*.cfg" "key_use                       57"		"key_use                       18"

REM # mouse-movement off
%BIN_FART% "default.*.extra.cfg" "novert                        0"	"novert                        1"
%BIN_FART% "default.*.cfg" "mouseb_strafe                 1"		"mouseb_strafe                 -1"
%BIN_FART% "default.*.cfg" "mouseb_forward                2"		"mouseb_forward                -1"
REM # mouse controls
%BIN_FART% "default.*.extra.cfg" "mouseb_prevweapon             -1"	"mouseb_prevweapon             4"
%BIN_FART% "default.*.extra.cfg" "mouseb_nextweapon             -1"	"mouseb_nextweapon             3"
%BIN_FART% "default.*.extra.cfg" "dclick_use                    1"	"dclick_use                    0"

REM # always run
%BIN_FART% "default.*.cfg" "joyb_speed                    2"		"joyb_speed                    29"

REM # compatibility
%BIN_FART% "default.*.extra.cfg" "show_endoom                   1"	"show_endoom                   0"
%BIN_FART% "default.*.extra.cfg" "vanilla_savegame_limit        1"	"vanilla_savegame_limit        0"
%BIN_FART% "default.*.extra.cfg" "vanilla_demo_limit            1"	"vanilla_demo_limit            0"
%BIN_FART% "default.*.extra.cfg" "png_screenshots               0"	"png_screenshots               1"

REM # use F12 for screen-shot
%BIN_FART% "default.*.extra.cfg" "key_spy                       88"	"key_spy                       0"
%BIN_FART% "default.*.extra.cfg" "key_menu_screenshot           0"	"key_menu_screenshot           88"

REM # user-name for multi-player
%BIN_FART% "default.*.extra.cfg" "player_name                   \"%USERNAME%\"" "player_name                   \"PortaDOOM\""

REM # PrBoom+:
REM ====================================================================================================================

REM # turn off texture filtering
%BIN_FART% "default.*-plus.cfg" "gl_texture_filter             5"	"gl_texture_filter             3"
%BIN_FART% "default.*-plus.cfg" "gl_sprite_filter              1"	"gl_sprite_filter              3"
%BIN_FART% "default.*-plus.cfg" "gl_patch_filter               1"	"gl_patch_filter               0"
%BIN_FART% "default.*-plus.cfg" "gl_texture_filter_anisotropic     3"	"gl_texture_filter_anisotropic     4"

%BIN_FART% "default.*-plus.cfg" "key_use                   0x20"	"key_use                   0x65"

%BIN_FART% "default.*-plus.cfg" "key_spy                   0xd8"	"key_spy                   0x2a"
%BIN_FART% "default.*-plus.cfg" "key_screenshot            0x2a"	"key_screenshot            0xd8"

%BIN_FART% "default.*-plus.cfg" "hudadd_crosshair              0"	"hudadd_crosshair              1"
%BIN_FART% "default.*-plus.cfg" "mouse_doubleclick_as_use      1"	"mouse_doubleclick_as_use      0"
%BIN_FART% "default.*-plus.cfg" "movement_mouselook            0"	"movement_mouselook            1"

REM # GZDoom
REM ====================================================================================================================
REM # VSync ON
%BIN_FART% "default.gzdoom*.ini" "vid_vsync=false" "vid_vsync=true"

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

REM # use "Mipmapped" for earlier versions
%BIN_FART% "default.gzdoom-09.ini" "gl_texture_filter=4" "gl_texture_filter=1"
%BIN_FART% "default.gzdoom-10.ini" "gl_texture_filter=4" "gl_texture_filter=1"
%BIN_FART% "default.gzdoom-11.ini" "gl_texture_filter=4" "gl_texture_filter=1"
%BIN_FART% "default.gzdoom-12.ini" "gl_texture_filter=4" "gl_texture_filter=1"
%BIN_FART% "default.gzdoom-13.ini" "gl_texture_filter=4" "gl_texture_filter=1"
%BIN_FART% "default.gzdoom-14.ini" "gl_texture_filter=4" "gl_texture_filter=1"

REM # remove controls
%BIN_FART% "default.gzdoom*.ini" "mouse3=+forward\n" ""
%BIN_FART% "default.gzdoom*.ini" "e=+use\n" ""
%BIN_FART% "default.gzdoom*.ini" "q=+zoom\n" ""
%BIN_FART% "default.gzdoom*.ini" "r=+reload\n" ""
%BIN_FART% "default.gzdoom*.ini" "c=+crouch\n" ""
%BIN_FART% "default.gzdoom*.ini" "w=+forward\n" ""
%BIN_FART% "default.gzdoom*.ini" "a=+moveleft\n" ""
%BIN_FART% "default.gzdoom*.ini" "s=+back\n" ""
%BIN_FART% "default.gzdoom*.ini" "d=+moveright\n" ""

REM # insert new controls
%BIN_FART% "default.gzdoom*.ini" "1=slot 1" "e=+use\n1=slot 1"
%BIN_FART% "default.gzdoom*.ini" "1=slot 1" "q=+zoom\n1=slot 1"
%BIN_FART% "default.gzdoom*.ini" "1=slot 1" "r=+reload\n1=slot 1"
%BIN_FART% "default.gzdoom*.ini" "1=slot 1" "c=+crouch\n1=slot 1"
%BIN_FART% "default.gzdoom*.ini" "1=slot 1" "w=+forward\n1=slot 1"
%BIN_FART% "default.gzdoom*.ini" "1=slot 1" "a=+moveleft\n1=slot 1"
%BIN_FART% "default.gzdoom*.ini" "1=slot 1" "s=+back\n1=slot 1"
%BIN_FART% "default.gzdoom*.ini" "1=slot 1" "d=+moveright\n1=slot 1"

REM # change controls
%BIN_FART% "default.gzdoom*.ini" "space=+use" "space=+jump"
%BIN_FART% "default.gzdoom*.ini" "f12=spynext" "f12=screenshot"
%BIN_FART% "default.gzdoom*.ini" "mouse2=+strafe" "mouse2=+altattack"

%BIN_FART% "default.gzdoom*.ini" "freelook=false" "freelook=true"
%BIN_FART% "default.gzdoom*.ini" "cl_run=false" "cl_run=true"
%BIN_FART% "default.gzdoom*.ini" "queryiwad=true" "queryiwad=false"
%BIN_FART% "default.gzdoom*.ini" "gender=male" "gender=other"
%BIN_FART% "default.gzdoom*.ini" "name=Player" "name=PortaDOOM"
%BIN_FART% "default.gzdoom*.ini" "vid_cursor=None" "vid_cursor=-"

REM # full-screen HUD
%BIN_FART% "default.gzdoom*.ini" "screenblocks=10" "screenblocks=11"
REM # HUD auto-scale
%BIN_FART% "default.gzdoom*.ini" "hud_scale=0" "hud_scale=-1"
REM # status bar auto-scale
%BIN_FART% "default.gzdoom*.ini" "st_scale=0" "st_scale=-1"
REM # there's no auto message-scale, 2 makes it readable without being too big
%BIN_FART% "default.gzdoom*.ini" "con_scaletext=0" "con_scaletext=2"

REM # enable cross-hair (type 2)
%BIN_FART% "default.gzdoom*.ini" "crosshair=0" "crosshair=2"
REM # cross hair 1:1 pixels (no-scale)
%BIN_FART% "default.gzdoom*.ini" "crosshairscale=1" "crosshairscale=0"

PAUSE