@ECHO OFF & SETLOCAL ENABLEEXTENSIONS DISABLEDELAYEDEXPANSION

CD %~dp0

SET BIN_INIFILE=..\tools\inifile\inifile.exe
SET BIN_FART=..\tools\fart\fart.exe

REM # Chocolate / Crispy Doom:

%BIN_FART% -w "default.*.cfg" "key_up                        72" "key_up                        17"
%BIN_FART% -w "default.*.cfg" "key_down                      80" "key_down                      31"
%BIN_FART% -w "default.*.cfg" "key_strafeleft                51" "key_strafeleft                30"
%BIN_FART% -w "default.*.cfg" "key_straferight               52" "key_straferight               32"
%BIN_FART% -w "default.*.cfg" "key_use                       57" "key_use                       18"
%BIN_FART% -w "default.*.cfg" "mouseb_strafe                 1"  "mouseb_strafe                 -1"
%BIN_FART% -w "default.*.cfg" "mouseb_forward                2"  "mouseb_forward                -1"
%BIN_FART% -w "default.*.cfg" "joyb_speed                    2"  "joyb_speed                    29"

%BIN_FART% -w "default.*.extra.cfg" "novert                        0"  "novert                        1"
%BIN_FART% -w "default.*.extra.cfg" "show_endoom                   1"  "show_endoom                   0"
%BIN_FART% -w "default.*.extra.cfg" "vanilla_savegame_limit        1"  "vanilla_savegame_limit        0"
%BIN_FART% -w "default.*.extra.cfg" "vanilla_demo_limit            1"  "vanilla_demo_limit            0"
%BIN_FART% -w "default.*.extra.cfg" "png_screenshots               0" "png_screenshots               1"

%BIN_FART% -w "default.*.extra.cfg" "mouseb_prevweapon             -1" "mouseb_prevweapon             4"
%BIN_FART% -w "default.*.extra.cfg" "mouseb_nextweapon             -1" "mouseb_nextweapon             3"
%BIN_FART% -w "default.*.extra.cfg" "dclick_use                    1"  "dclick_use                    0"
%BIN_FART% -w "default.*.extra.cfg" "key_spy                       88" "key_spy                       0"
%BIN_FART% -w "default.*.extra.cfg" "key_menu_screenshot           0"  "key_menu_screenshot           88"

%BIN_FART% -w "default.*.extra.cfg" "player_name                   \"%USERNAME%\"" "player_name                   \"PortaDOOM\""

REM # PrBoom+:

%BIN_FART% -w "default.*-plus.cfg" "screen_resolution         \"640x480\"" "screen_resolution         \"1024x768\""

%BIN_FART% -w "default.*-plus.cfg" "gl_texture_filter             5"     "gl_texture_filter             3"
%BIN_FART% -w "default.*-plus.cfg" "gl_sprite_filter              1"     "gl_sprite_filter              3"
%BIN_FART% -w "default.*-plus.cfg" "gl_patch_filter               1"     "gl_patch_filter               0"
%BIN_FART% -w "default.*-plus.cfg" "gl_texture_filter_anisotropic     3" "gl_texture_filter_anisotropic     4"

%BIN_FART% -w "default.*-plus.cfg" "key_use                   0x20" "key_use                   0x65"
%BIN_FART% -w "default.*-plus.cfg" "key_spy                   0xd8" "key_spy                   0x2a"
%BIN_FART% -w "default.*-plus.cfg" "key_screenshot            0x2a" "key_screenshot            0xd8"

%BIN_FART% -w "default.*-plus.cfg" "hudadd_crosshair              0" "hudadd_crosshair              1"
%BIN_FART% -w "default.*-plus.cfg" "mouse_doubleclick_as_use      1" "mouse_doubleclick_as_use      0"
%BIN_FART% -w "default.*-plus.cfg" "movement_mouselook            0" "movement_mouselook            1"

REM # GZDoom

REM # Texture Filtering: Nearest (Linear Mipmap) is supported from v1.5 onwards;
REM # (graphics break if this is applied to earlier versions)
%BIN_FART% -w "default.gzdoom.ini" "gl_texture_filter=4" "gl_texture_filter=5"
%BIN_FART% -w "default.gzdoom-15.ini" "gl_texture_filter=4" "gl_texture_filter=5"
%BIN_FART% -w "default.gzdoom-16.ini" "gl_texture_filter=4" "gl_texture_filter=5"
%BIN_FART% -w "default.gzdoom-17.ini" "gl_texture_filter=4" "gl_texture_filter=5"
%BIN_FART% -w "default.gzdoom-18.ini" "gl_texture_filter=4" "gl_texture_filter=5"
%BIN_FART% -w "default.gzdoom-19.ini" "gl_texture_filter=4" "gl_texture_filter=5"
%BIN_FART% -w "default.gzdoom-2*.ini" "gl_texture_filter=4" "gl_texture_filter=5"
%BIN_FART% -w "default.gzdoom-3*.ini" "gl_texture_filter=4" "gl_texture_filter=5"

REM # use "Mipmapped" for earlier versions
%BIN_FART% -w "default.gzdoom-09.ini" "gl_texture_filter=4" "gl_texture_filter=1"
%BIN_FART% -w "default.gzdoom-10.ini" "gl_texture_filter=4" "gl_texture_filter=1"
%BIN_FART% -w "default.gzdoom-11.ini" "gl_texture_filter=4" "gl_texture_filter=1"
%BIN_FART% -w "default.gzdoom-12.ini" "gl_texture_filter=4" "gl_texture_filter=1"
%BIN_FART% -w "default.gzdoom-13.ini" "gl_texture_filter=4" "gl_texture_filter=1"
%BIN_FART% -w "default.gzdoom-14.ini" "gl_texture_filter=4" "gl_texture_filter=1"

%BIN_FART% -w "default.gzdoom*.ini" "mouse2=+strafe" "mouse2=+altattack"

%BIN_FART% -w "default.gzdoom*.ini" "vid_vsync=false" "vid_vsync=true"
%BIN_FART% -w "default.gzdoom*.ini" "freelook=false" "freelook=true"
%BIN_FART% -w "default.gzdoom*.ini" "cl_run=false" "cl_run=true"
%BIN_FART% -w "default.gzdoom*.ini" "queryiwad=true" "queryiwad=false"
%BIN_FART% -w "default.gzdoom*.ini" "gender=male" "gender=other"
%BIN_FART% -w "default.gzdoom*.ini" "name=Player" "name=PortaDOOM"
%BIN_FART% -w "default.gzdoom*.ini" "vid_cursor=None" "vid_cursor=-"

PAUSE