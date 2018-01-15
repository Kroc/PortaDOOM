@ECHO OFF & SETLOCAL ENABLEEXTENSIONS DISABLEDELAYEDEXPANSION

REM # doom batch launcher - (c) copyright Kroc Camen 2016-2018

REM # features:
REM # - automatic portable config files so that you get the same configuration (per-engine) everywhere
REM # - searches GOG & Steam installs if WAD is missing
REM # - automatically offers to generate DOOM64.WAD from an N64 ROM
REM # - automatically patches DOOM 3 BFG Edition WADs
REM # - FreeDOOM substituted if commercial DOOM.WAD / DOOM2.WAD missing
REM # - automatically includes "brightmaps.pk3" & "lights.pk3" (GZDoom) or "skulltag_actors.pk3" &
REM     "skulltag_data.pk3" (Zandronum), placing them before the PWAD
REM # - IWAD file extensions can be omitted: ".WAD" / ".PK3" / ".IWAD" / ".IPK3";
REM #   (PWAD and other WAD extensions are required due to the number of locations checked)
REM # - DeHackEd extension loading (".DEH", ".BEX" files)
REM # - demo playback support
REM # - files are checked to exist before being passed on to the engine
REM # - launches the engine in the native resolution of the current machine (portable)

REM # TODO:
REM # - option to launch windowed -- will need to choose reasonable window size
REM # - DOOM64.WAD handling

REM # default folder names
SET "DIR_CONFIGS=config"
SET "DIR_WADS=wads"
SET "DIR_PORTS=ports"
SET "DIR_SAVES=saves"

:usage
REM ====================================================================================================================
REM # if no command line parameters are given, show the instructions

REM # how to store a newline character in a string, thanks to
REM # <https://stackoverflow.com/a/5552995>
SET NEWLINE=^& ECHO:

REM # create the usage format string
SET "USAGE=    doom.bat
SET "USAGE=%USAGE% [/USE ^<engine^>]"
SET "USAGE=%USAGE% [/WAIT]"
SET "USAGE=%USAGE% [/CONSOLE]"
SET "USAGE=%USAGE% [/SW]"
SET "USAGE=%USAGE% [/32]"
SET "USAGE=%USAGE% [/DEFAULT]%NEWLINE%            "
SET "USAGE=%USAGE% [/IWAD ^<file^>]"
SET "USAGE=%USAGE% [/PWAD ^<file^>]"
SET "USAGE=%USAGE% [/DEH ^<file^>]"
SET "USAGE=%USAGE% [/BEX ^<file^>]%NEWLINE%            "
SET "USAGE=%USAGE% [/DEMO ^<file^>]"
SET "USAGE=%USAGE% [/WARP ^<map-number^>]"
SET "USAGE=%USAGE% [/SKILL ^<skill-level^>]%NEWLINE%            "
SET "USAGE=%USAGE% [/CMPLVL ^<complevel^>]"
SET "USAGE=%USAGE% [/EXEC ^<file^>]%NEWLINE%            "
SET "USAGE=%USAGE% [-- ^<files^>...]

IF NOT "%~1" == "" GOTO :begin

ECHO:
ECHO  "doom.bat" is a command-line launcher for DOOM-based games.
ECHO  It makes it easier to create shortcuts to run a particular
ECHO  source-port with a particular WAD and particular mods etc.
ECHO:
ECHO  Usage:
REM ---------------------------------------------------------------------------------
ECHO:
ECHO %USAGE%
ECHO:
ECHO  Example:
ECHO:
ECHO     doom.bat /USE gzdoom /IWAD DOOM2 /PWAD crumpets.wad
ECHO:
ECHO  ---------------------------------------------------------------------------------
ECHO:
ECHO  /USE ^<engine^>
ECHO:
ECHO     Which engine to use. Can be any of the following:
ECHO:
ECHO       choco-doom          : Chocolate Doom ^(very vanilla, 320x200^)
ECHO       choco-doom-setup    : Displays Chocolate Doom's configuration program first
ECHO       choco-heretic       : As with choco-doom, but for Heretic WADs
ECHO       choco-heretic-setup : As above, but displays configuration first
ECHO       choco-hexen         : As with choco-doom, but for Hexen WADs
ECHO       choco-hexen-setup   : As above, but displays configuration first
ECHO       choco-strife        : As with choco-doom, but for Strife WADs
ECHO       choco-strife-setup  : As above, but displays configuration first
ECHO       crispy-doom         : Fork of Chocolate Doom; 640x400, limits removed
ECHO       crispy-doom-setup   : As above, but displays configuration first
ECHO       prboom              : PRBoom+ defaults to OpenGL. Use `/SW` for software
ECHO       gzdoom              : GZDoom current. Use `/SW` for software rendering
ECHO       gzdoom-??           : Where ?? is a version number ^(see below^)
ECHO       zandronum           : Zandronum current ^(2.x^)
ECHO       zandronum-?         : Where ? is a version number, "2" or "3"
ECHO       doom64ex            : DOOM 64 EX, specifically for DOOM 64
ECHO       zdoom               : deprecated. use gzdoom with software `/SW` instead
ECHO:
ECHO     For GZDoom, specific versions can be invoked with the following:
ECHO:
ECHO       gzdoom-09           : GZDoom v0.9.28 ^(AUG-2005+^)
ECHO       gzdoom-10           : GZDoom v1.0.32 ^(FEB-2006+^)
ECHO       gzdoom-11           : GZDoom v1.1.06 ^(FEB-2008+^)
ECHO       gzdoom-12           : GZDoom v1.2.01 ^(MAR-2009+^)
ECHO       gzdoom-13           : GZDoom v1.3.17 ^(OCT-2009+^)
ECHO       gzdoom-14           : GZDoom v1.4.08 ^(JAN-2010+^)
ECHO       gzdoom-15           : GZDoom v1.5.06 ^(AUG-2010+^)
ECHO       gzdoom-16           : GZDoom v1.6.00 ^(JUL-2012+^)
ECHO       gzdoom-17           : GZDoom v1.7.01 ^(DEC-2012+^)
ECHO       gzdoom-18           : GZDoom v1.8.10 ^(JUN-2013+^)
ECHO       gzdoom-19           : GZDoom v1.9.1  ^(FEB-2016+^)
ECHO       gzdoom-20           : GZDoom v2.0.05 ^(SEP-2014+^)
ECHO       gzdoom-21           : GZDoom v2.1.1  ^(FEB-2016+^)
ECHO       gzdoom-22           : GZDoom v2.2.0  ^(SEP-2016+^)
ECHO       gzdoom-23           : GZDoom v2.3.0  ^(JAN-2017+^)
ECHO       gzdoom-24           : GZDoom v2.4.0  ^(MAR-2017+^)
ECHO       gzdoom-32           : GZDoom v3.2.4  ^(OCT-2017+^);
ECHO                             versions 3.0 ^(APR-2017+^), 3.1 ^(JUN-2017+^) and 3.2.0
ECHO                             ^(OCT-2017+^) are excluded due to a security concern
ECHO:
ECHO     NOTE: Additional engine resource files will be included automatically, that is
ECHO           "brightmaps.pk3" ^& "lights.pk3" for GZDoom versions 1.0 and above, or
ECHO           "skulltag_actors.pk3" ^& "skulltag_data.pk3" for Zandronum
ECHO:
ECHO  /WAIT
REM ---------------------------------------------------------------------------------
ECHO:
ECHO     Causes doom.bat to not immediately return once the engine is launched.
ECHO     Script execution will continue only once the engine has quit.
ECHO:
ECHO  /CONSOLE
REM ---------------------------------------------------------------------------------
ECHO:
ECHO     Causes the output of the engine to be echoed to the console.
ECHO     This implies `/WAIT`. Works only with Z-based engines:
ECHO     GZDoom, ZDoom and Zandronum.
ECHO:
ECHO  /SW
REM ---------------------------------------------------------------------------------
ECHO:
ECHO     Force software rendering. By default hardware rendering is used in
ECHO     GZDoom and PRBoom+ ^("glboom-plus"^).
ECHO:
ECHO  /32
REM ---------------------------------------------------------------------------------
ECHO:
ECHO     Always use 32-bit binaries, even on a 64-bit system.
ECHO:
ECHO  /DEFAULT
REM ---------------------------------------------------------------------------------
ECHO:
ECHO     Loads the engine with the default config file instead of the current user
ECHO     config file. Any changes you make to the engine's settings will be saved
ECHO     in the default configuration file.
ECHO:
ECHO  /IWAD ^<file^>
REM ---------------------------------------------------------------------------------
ECHO:
ECHO     The IWAD ^(Internal WAD^) is the base WAD to use. This will be one of the
ECHO     original game's WAD files which maps, mods and total conversions extend.
ECHO:
ECHO     IWADs are located in the "%DIR_WADS%" folder.
ECHO:
ECHO     If this option is ommitted the default IWAD will be based on the selected
ECHO     engine. Some engines support only a certain game, i.e.
ECHO:
ECHO         chocolate-heretic[-setup] : HERETIC.WAD
ECHO         chocolate-hexen[-setup]   : HEXEN.WAD
ECHO         chocolate-strife[-setup]  : STRIFE1.WAD
ECHO         doom64ex                  : DOOM64.WAD
ECHO:
ECHO     All other engines default to DOOM2.WAD as this is the most common one used
ECHO     for community content.
ECHO:
ECHO     Steam ^& GOG:
ECHO:
ECHO     If the given IWAD cannot be found in the "%DIR_WADS%" folder, doom.bat will
ECHO     try to locate them automatically for you in any relevant Steam or GOG
ECHO     installations:
ECHO:
ECHO             Steam : The Ultimate DOOM     - DOOM.WAD
ECHO             Steam : DOOM II               - DOOM2.WAD
ECHO             Steam : Final DOOM            - TNT.WAD ^& PLUTONIA.WAD
ECHO             Steam : DOOM Classic Complete - ^(all of the above^)
ECHO       GOG / Steam : DOOM 3 BFG Edition    - DOOM.WAD ^& DOOM2.WAD
ECHO               GOG : The Ultimate DOOM     - DOOM.WAD
ECHO               GOG : DOOM II + Final DOOM  - DOOM2.WAD, TNT.WAD ^& PLUTONIA.WAD
ECHO             Steam : Heretic               - HERETIC.WAD
ECHO             Steam : Hexen                 - HEXEN.WAD
ECHO       GOG / Steam : The Original Strife   - STRIFE1.WAD
ECHO:
ECHO     Shareware:
ECHO:
ECHO     If the given IWAD cannot be found and no PWAD is specified ^(see below^),
ECHO     i.e. you are trying to play an original game rather than a user-map/mod,
ECHO     then the equivalent shareware will be used instead, e.g.
ECHO:
ECHO         DOOM    : DOOM.WAD    ^> DOOM1.WAD    (episode 1 only)
ECHO         Heretic : HERETIC.WAD ^> HERETIC1.WAD (episode 1 only)
ECHO         Hexen   : HEXEN.WAD   ^> HEXEN.WAD    (shareware version)
ECHO         Strife  : STRIFE1.WAD ^> STRIFE0.WAD  (shareware version)
ECHO:
ECHO     NOTE: There was no shareware release for DOOM II.
ECHO:
ECHO  /PWAD ^<file^>
REM ---------------------------------------------------------------------------------
ECHO:
ECHO     The PWAD ^(patch-WAD^) is the community map / mod you want to play.
ECHO     These are assumed to be in the "%DIR_WADS%" folder. E.g.
ECHO:
ECHO            doom.bat /USE gzdoom /IWAD DOOM2 /PWAD wolfendoom.pk3
ECHO:
ECHO     If you just want to play an original game ^(e.g. DOOM, Hexen^) then the PWAD
ECHO     is not required.
ECHO:
ECHO     Steam ^& GOG:
ECHO:    
ECHO     If "NERVE.WAD" or any of the "Master Levels for DOOM II" are specified as
ECHO     the PWAD and cannot be found in the "%DIR_WADS%" folder, doom.bat will try to
ECHO     locate them for you in any relevant Steam or GOG installations:
ECHO:
ECHO       GOG / Steam : DOOM 3 BFG Edition    - NERVE.WAD
ECHO             Steam : DOOM Classic Complete - Master Levels for DOOM II
ECHO               GOG : DOOM II + Final DOOM  - Master Levels for DOOM II
ECHO:
ECHO     FreeDOOM:
ECHO:
ECHO     When using a PWAD, if an IWAD of "DOOM" or "DOOM2" is specified, but these
ECHO     WAD files are not present, FreeDOOM will be used instead, though a warning
ECHO     will be presented.
ECHO:
ECHO     Whilst DOOM gameplay mods and maps work off of DOOM.WAD or DOOM2.WAD,
ECHO     FreeDOOM is intended as a drop-in replacement, maintaining compatibility
ECHO     with DOOM.WAD ^& DOOM2.WAD allowing you to play most community content
ECHO     without having to actually purchase DOOM.
ECHO:
ECHO  /DEH ^<file^>
ECHO  /BEX ^<file^>
REM ---------------------------------------------------------------------------------
ECHO:
ECHO     Early DOOM modifications were done by way of a live patching system known as
ECHO     DeHackEd. These ".deh" files are common, even today, as the lowest-common-
ECHO     denominator of DOOM modding.
ECHO:
ECHO     Boom, a highly-influential early source-port, enhanced this format further
ECHO     with "Boom-EXtended" DeHackEd files.
ECHO:
ECHO     These parameters specify a DEH or BEX file to load alongside any WADs.
ECHO:
ECHO  /DEMO ^<file^>
REM ---------------------------------------------------------------------------------
ECHO:
ECHO     DOOM play sessions can be recorded and played back later. These are often
ECHO     distributed as ".lmp" files. The /DEMO option specifies the file to play.
ECHO:
ECHO     Unlike the -playdemo engine parameter that requires the path to be valid,
ECHO     doom.bat will look for the demo file in the 'current' directory from which
ECHO     doom.bat has been called, the "%DIR_WADS%" directory, and if a PWAD is given,
ECHO     in its directory too.
ECHO:
ECHO  /WARP ^<map-number^>
REM ---------------------------------------------------------------------------------
ECHO:
ECHO     Warp to the given map number. For games with episodes, such as DOOM and
ECHO     Heretic, this is in the format "e.m" where "e" is the Episode number and
ECHO     "m" is the Map number, e.g. "/WARP 2.4". For games without episodes like
ECHO     DOOM II, it's just a single number e.g. "/WARP 21"
ECHO:
ECHO  /SKILL ^<skill-level^>
REM ---------------------------------------------------------------------------------
ECHO:
ECHO     Set skill (difficulty) level. This is a number nominally 1 to 5, but this
ECHO     may vary with mods. A value of 0 disables monsters on some engines, but this
ECHO     can sometimes prevent a level from being compleatable.
ECHO:
ECHO  /CMPLVL ^<complevel^>
REM ---------------------------------------------------------------------------------
ECHO:
ECHO     Specifies the compatibility level, a feature provided by PrBoom+ to emulate
ECHO     the behaviour of different versions of the DOOM executable. The complevel
ECHO     can be:
ECHO:
ECHO         0     = Doom v1.2
ECHO         1     = Doom v1.666
ECHO         2     = Doom v1.9
ECHO         3     = Ultimate Doom ^& Doom95
ECHO         4     = Final Doom
ECHO         5     = DOSDoom
ECHO         6     = TASDOOM
ECHO         7     = Boom's inaccurate vanilla compatibility mode
ECHO         8     = Boom v2.01
ECHO         9     = Boom v2.02
ECHO         10    = LxDoom
ECHO         11    = MBF
ECHO         12-16 = PrBoom (old versions)
ECHO         17    = Current PrBoom 
ECHO:
ECHO  /EXEC ^<file^>
REM ---------------------------------------------------------------------------------
ECHO:
ECHO     Execute the script file.
ECHO:
ECHO  -- ^<files^>...
REM ---------------------------------------------------------------------------------
ECHO:
ECHO     NOTE: The "--" is required to separate the parameters from the list
ECHO     of files.
ECHO:
ECHO     A list of additional files to include ^(from the "%DIR_WADS%" directory^).
ECHO     Unlike when creating Windows shortcuts, the "%DIR_WADS%" folder is assumed,
ECHO     so that you don't need to include the base path on each file added.
ECHO:
ECHO     If a PWAD has been given, that file's folder will also be checked so that
ECHO     you do not have to give the path for both the PWAD, and any files within
ECHO     the same folder. E.g.
ECHO:
ECHO            doom.bat /PWAD doomrl_arsenal\doomrl_arsenal.wad
ECHO                                       -- doomrl_arsenal_hud.wad
ECHO:
ECHO     After one file is included, the same folder will be checked for the
ECHO     next file. This is handy for including multiple WADs located in the
ECHO     same folder, e.g.
ECHO:
ECHO            doom.bat -- BrutalDoom\Brutalv20b.pk3 ExtraTextures.wad
ECHO:
ECHO     Where "ExtraTextures.wad" is in the "BrutalDoom" folder, and if it isn't
ECHO     the base "%DIR_WADS%" folder will be checked and then the engine's folder.
ECHO:
ECHO  Config File:
REM ---------------------------------------------------------------------------------
ECHO:
ECHO     For portability doom.bat has default configuration files for each engine
ECHO     which will be copied to the save folder for that engine when one does not
ECHO     exist. doom.bat automatically launches the engine with this portable config
ECHO     file so that your settings are used regardless of which machine you use.
ECHO:
ECHO  Savegames:
REM ---------------------------------------------------------------------------------
ECHO:
ECHO     Savegames are not saved alongside the engine as is default, but rather
ECHO     in a "%DIR_SAVES%" folder. To prevent incompatibilites and potential data-loss
ECHO     between engines, savegames are first separated by engine ^("gzdoom" /
ECHO     "zandronum" etc.^) and then by the PWAD name ^(or IWAD name if no PWAD
ECHO     is specified^). I.e. for the command:
ECHO:
ECHO            doom.bat /USE gzdoom /IWAD DOOM2 /PWAD breach.wad
ECHO:
ECHO     the savegames will be located in "%DIR_SAVES%\gzdoom\breach\".
ECHO:

PAUSE & EXIT /B 0


:begin
REM ====================================================================================================================

CLS
ECHO:
ECHO      doom.bat
ECHO:

REM # remember the current directory before we change it;
REM # this will be used as an additional search location for finding PWADs
SET "DIR_CUR=%CD%"

REM # change current directory to that of this script;
REM # ensures that short-cuts to this script don't end up looking elsewhere for files
PUSHD "%~dp0"

REM # if the directory this script was called from is somewhere within
REM # the same hierarchy of this script, make the folder path relative
SETLOCAL ENABLEDELAYEDEXPANSION
SET "DIR_CUR=!DIR_CUR:%CD%\=!"
ENDLOCAL & SET "DIR_CUR=%DIR_CUR%"

REM # NOTE: many doom engines save their config files in the 'current directory', which is typically expected to be
REM # that of the executable. However, we want to separate user-data (such as savegames) from the engines. whilst we
REM # can change the save directory, config files will still be dumped in the 'current directory', which in the case
REM # of this script, will be right here! We therefore need to change the current directory and rewrite all the WAD /
REM # file paths to be relative from there!

REM # the saves folder will contain a sub-folder for each engine, and then another sub-folder for the IWAD or PWAD;
REM # this is the relative path from the WAD's save folder back to this script
SET "FIX_PATH=..\..\.."

REM # we will remember the directory of the last file
REM # (used for finding side-by-side WADs)
SET "DIR_PREV="
REM # other directories that will be remembered as we go
SET "DIR_IWAD="
SET "DIR_PWAD="

REM # this is where we'll build up the entire parameter string for the engine
SET "PARAMS="
REM # the list of files will be built here:
SET "FILES="

REM # any files included?
SET ANY_WAD=0

REM # which game to be played. defaults to "DOOM2",
REM # but can also be "DOOM", "DOOM64", "HERETIC", "HEXEN" or "STRIFE"
SET "GAME=DOOM2"

REM # default option values:
SET "USE="
SET CONSOLE=0
SET WAIT=0
SET SW=0
SET DEFAULT=0
SET "IWAD="
SET "PWAD="
SET "DEH="
SET "BEH="
SET "DEMO="
SET "WARP="
SET "SKILL="
SET "CMPLVL="
SET "EXEC="


:params
REM ====================================================================================================================
REM # select engine to use
IF /I "%~1" == "/USE" (
	REM # just capture the parameter, validation happens after all parameters are gathered
	SET "USE=%~2"
	REM # check for any other options
	SHIFT & SHIFT
	GOTO :params
)
REM # wait for engine before continuing execution
IF /I "%~1" == "/WAIT" (
	REM # set the feature flag, the launch section will handle it
	SET WAIT=1
	REM # check for any other options
	SHIFT & GOTO :params
)
REM # echo engine output to the console
IF /I "%~1" == "/CONSOLE" (
	REM # set the feature flag, the launch section will handle it
	SET CONSOLE=1
	REM # check for any other options
	SHIFT & GOTO :params
)
REM # force software rendering in engines that have that option
IF /I "%~1" == "/SW" (
	REM # enable the software-rendering flag
	SET SW=1
	REM # check for any other options
	SHIFT & GOTO :params
)
REM # always use 32-bit binaries on a 64-bit system?
IF /I "%~1" == "/32" (
	REM # force this script to believe the system is 32-bit
	SET WINBIT=32
	REM # check for any other options
	SHIFT & GOTO :params
)
REM # use default config?
IF /I "%~1" == "/DEFAULT" (
	REM # we only need to enable the flag to indicate it,
	REM # the config section will handle the specifics
	SET DEFAULT=1
	REM # check for any other options
	SHIFT & GOTO :params
)
REM # select IWAD to use
IF /I "%~1" == "/IWAD" (
	REM # just capture the parameter, validation happens after all parameters are gathered
	SET "IWAD=%~2"
	REM # check for any other options
	SHIFT & SHIFT
	GOTO :params
)
REM # select PWAD to use
IF /I "%~1" == "/PWAD" (
	REM # just capture the parameter, validation happens after all parameters are gathered
	SET "PWAD=%~2"
	REM # check for any other options
	SHIFT & SHIFT
	GOTO :params
)
REM # DeHackEd file?
IF /I "%~1" == "/DEH" (
	REM # just capture the parameter, validation happens after all parameters are gathered
	SET "DEH=%~2"
	REM # check for any other options
	SHIFT & SHIFT
	GOTO :params
)
REM # Boom-EXtended DeHackEd file?
IF /I "%~1" == "/BEX" (
	REM # just capture the parameter, validation happens after all parameters are gathered
	SET "BEX=%~2"
	REM # check for any other options
	SHIFT & SHIFT
	GOTO :params
)
REM # demo file playback?
IF /I "%~1" == "/DEMO" (
	REM # fetch the demo file
	SET "DEMO=%~2"
	REM # check for any other options;
	REM # we'll defer the validation of the demo file until we know the IWAD/PWAD
	SHIFT & SHIFT
	GOTO :params
)
REM # warp to a map number?
IF /I "%~1" == "/WARP" (
	REM # just capture the parameter, validation happens after all parameters are gathered
	SET "WARP=%~2"
	REM # check for any other options
	SHIFT & SHIFT
	GOTO :params
)
REM # set difficulty level?
IF /I "%~1" == "/SKILL" (
	REM # just capture the parameter, validation happens after all parameters are gathered
	SET "SKILL=%~2"
	REM # check for any other options
	SHIFT & SHIFT
	GOTO :params
)
REM # compatibility level?
IF /I "%~1" == "/CMPLVL" (
	REM # just capture the parameter, validation happens after all parameters are gathered
	SET "CMPLVL=%~2"
	REM # check for any other options
	SHIFT & SHIFT
	GOTO :params
)
REM # execute script file?
IF /I "%~1" == "/EXEC" (
	REM # just capture the parameter, validation happens after all parameters are gathered
	SET "EXEC=%~2"
	REM # check for any other options
	SHIFT & SHIFT
	GOTO :params
)
REM # no further parameters can follow the file list
IF "%~1" == "--" GOTO :validate
REM # end of parameter list, also continue
IF "%~1" == ""   GOTO :validate

REM # invalid parameter!
ECHO ERROR: Invalid parameter "%~1"
ECHO:
POPD
PAUSE & EXIT /B 1


:validate
REM ====================================================================================================================
REM # Engine:
REM ====================================================================================================================
REM # reserve some variables:
SET "ENGINE_DIR="	& REM # the engine directory is also used to check for PWADs
SET "ENGINE_EXE="	& REM # executable name in the engine folder
SET "ENGINE_INC="	& REM # default files to include for an engine (e.g. "brightmaps.pk3", "lights.pk3")
SET "VER_GZDOOM="	& REM # version number of GZDoom, if chosen engine

REM # detect 32-bit or 64-bit Windows for those engines that provide both
SET WINBIT=32
IF /I "%PROCESSOR_ARCHITECTURE%" == "EM64T" SET WINBIT=64	& REM # Itanium
IF /I "%PROCESSOR_ARCHITECTURE%" == "AMD64" SET WINBIT=64	& REM # Regular x64
IF /I "%PROCESSOR_ARCHITEW6432%" == "AMD64" SET WINBIT=64	& REM # 32-bit CMD on a 64-bit system (WOW64)

REM # for engines with both 32 and 64-bit executables, select the relevant one
IF %WINBIT% EQU 32 SET "ENGINE_BIT=x86"
IF %WINBIT% EQU 64 SET "ENGINE_BIT=x64"

REM # an identifier for config files used for an engine,
REM # i.e. "gzdoom" is expanded to "config.gzdoom.ini"
SET "ENGINE_CFG="

REM # engines are grouped together by common behaviour determined by their heritage,
REM # we use this to handle differences in command line parameters for engines:
REM # - V = Vanilla engine; uses DSG save format. Chocolate Doom fits this
REM # - B = Boom engine; compatible with the features added by Boom. PrBoom+ (and above). DSG saves
REM # - X = Kex engine -- DOOM 64 EX. Parameters are like Vanilla and Boom. DSG saves
REM # - Z = ZDoom engine; derived from ZDoom, i.e. GZDoom and Zandronum. ZDS saves
SET "ENGINE_KIN="

REM # the engine's folder within the "saves" folder; it's the place for the user's config file for that engine
REM # (variable left empty to begin with so as to detect the absence of the engine parameter)
SET "PORT_SAVE="

IF /I "%USE%" == "choco-doom" (
	SET "ENGINE_DIR=%DIR_PORTS%\chocolate-doom"
	SET "ENGINE_EXE=chocolate-doom.exe"
	SET "ENGINE_CFG=choco-doom"
	SET "ENGINE_KIN=V"
	SET "PORT_SAVE=choco-doom"
	SET "PORT_TITLE=Chocolate Doom"
)
IF /I "%USE%" == "choco-doom-setup" (
	SET "ENGINE_DIR=%DIR_PORTS%\chocolate-doom"
	SET "ENGINE_EXE=chocolate-doom-setup.exe"
	SET "ENGINE_CFG=choco-doom"
	SET "ENGINE_KIN=V"
	SET "PORT_SAVE=choco-doom"
	SET "PORT_TITLE=Chocolate Doom ^(Setup^)"
)
IF /I "%USE%" == "choco-heretic" (
	SET "ENGINE_DIR=%DIR_PORTS%\chocolate-heretic"
	SET "ENGINE_EXE=chocolate-heretic.exe"
	SET "ENGINE_CFG=choco-heretic"
	SET "ENGINE_KIN=V"
	SET "PORT_SAVE=choco-heretic"
	SET "PORT_TITLE=Chocolate Heretic"
	REM # game *has* to be HERETIC for this engine
	SET "GAME=HERETIC"
)
IF /I "%USE%" == "choco-heretic-setup" (
	SET "ENGINE_DIR=%DIR_PORTS%\chocolate-heretic"
	SET "ENGINE_EXE=chocolate-heretic-setup.exe"
	SET "ENGINE_CFG=choco-heretic"
	SET "ENGINE_KIN=V"
	SET "PORT_SAVE=choco-heretic"
	SET "PORT_TITLE=Chocolate Heretic ^(Setup^)"
	REM # game *has* to be HERETIC for this engine
	SET "GAME=HERETIC"
)
IF /I "%USE%" == "choco-hexen" (
	SET "ENGINE_DIR=%DIR_PORTS%\chocolate-hexen"
	SET "ENGINE_EXE=chocolate-hexen.exe"
	SET "ENGINE_CFG=choco-hexen"
	SET "ENGINE_KIN=V"
	SET "PORT_SAVE=choco-hexen"
	SET "PORT_TITLE=Chocolate Hexen"
	REM # game *has* to be HEXEN for this engine
	SET "GAME=HEXEN"
)
IF /I "%USE%" == "choco-hexen-setup" (
	SET "ENGINE_DIR=%DIR_PORTS%\chocolate-hexen"
	SET "ENGINE_EXE=chocolate-hexen-setup.exe"
	SET "ENGINE_CFG=choco-hexen"
	SET "ENGINE_KIN=V"
	SET "PORT_SAVE=choco-hexen"
	SET "PORT_TITLE=Chocolate Hexen ^(Setup^)"
	REM # game *has* to be HEXEN for this engine
	SET "GAME=HEXEN"
)
IF /I "%USE%" == "choco-strife" (
	SET "ENGINE_DIR=%DIR_PORTS%\chocolate-strife"
	SET "ENGINE_EXE=chocolate-strife.exe"
	SET "ENGINE_CFG=choco-strife"
	SET "ENGINE_KIN=V"
	SET "PORT_SAVE=choco-strife"
	SET "PORT_TITLE=Chocolate Strife"
	REM # game *has* to be STRIFE for this engine
	SET "GAME=STRIFE"
)
IF /I "%USE%" == "choco-strife-setup" (
	SET "ENGINE_DIR=%DIR_PORTS%\chocolate-strife"
	SET "ENGINE_EXE=chocolate-strife-setup.exe"
	SET "ENGINE_CFG=choco-strife"
	SET "ENGINE_KIN=V"
	SET "PORT_SAVE=choco-strife"
	SET "PORT_TITLE=Cocolate Strife ^(Setup^)"
	REM # game *has* to be STRIFE for this engine
	SET "GAME=STRIFE"
)
IF /I "%USE%" == "crispy-doom" (
	SET "ENGINE_DIR=%DIR_PORTS%\crispy-doom"
	SET "ENGINE_EXE=crispy-doom.exe"
	SET "ENGINE_CFG=crispy-doom"
	SET "ENGINE_KIN=V"
	SET "PORT_SAVE=crispy-doom"
	SET "PORT_TITLE=Crispy Doom"
)
IF /I "%USE%" == "crispy-doom-setup" (
	SET "ENGINE_DIR=%DIR_PORTS%\crispy-doom"
	SET "ENGINE_EXE=crispy-doom-setup.exe"
	SET "ENGINE_CFG=crispy-doom"
	SET "ENGINE_KIN=V"
	SET "PORT_SAVE=crispy-doom"
	SET "PORT_TITLE=Crispy Doom ^(Setup^)"
)
IF /I "%USE%" == "doomretro" (
	SET "ENGINE_DIR=%DIR_PORTS%\doomretro"
	SET "ENGINE_EXE=doomretro.exe"
	SET "ENGINE_CFG=doomretro"
	SET "ENGINE_KIN=B"
	SET "PORT_SAVE=doomretro"
	SET "PORT_TITLE=DOOM Retro"
)
IF /I "%USE%" == "prboom" (
	SET "ENGINE_DIR=%DIR_PORTS%\prboom+"
	REM # are we using software rendering?
	IF %SW% EQU 1 (
		REM # use software-rendering executable
		SET "ENGINE_EXE=prboom-plus.exe"
		SET "ENGINE_CFG=prboom-plus"
		SET "PORT_TITLE=PrBoom+ ^(Software Renderer^)"
	) ELSE (
		REM # use hardware-rendering executable
		SET "ENGINE_EXE=glboom-plus.exe"
		SET "ENGINE_CFG=glboom-plus"
		SET "PORT_TITLE=PrBoom+ ^(OpenGL Renderer^)"
	)
	SET "ENGINE_KIN=B"
	SET "PORT_SAVE=prboom"
)
IF /I "%USE%" == "gzdoom" (
	SET "ENGINE_DIR=%DIR_PORTS%\gzdoom-32_%ENGINE_BIT%"
	SET "ENGINE_INC=brightmaps.pk3 lights.pk3"
	SET "ENGINE_EXE=gzdoom.exe"
	SET "ENGINE_CFG=gzdoom"
	SET "ENGINE_KIN=Z"
	SET "PORT_SAVE=gzdoom"
	SET "PORT_TITLE=GZDoom ^(current^)"
)
IF /I "%USE%" == "gzdoom-32" (
	SET "ENGINE_DIR=%DIR_PORTS%\gzdoom-32_%ENGINE_BIT%"
	SET "ENGINE_INC=brightmaps.pk3 lights.pk3"
	SET "ENGINE_EXE=gzdoom.exe"
	SET "ENGINE_CFG=gzdoom-32"
	SET "ENGINE_KIN=Z"
	SET "PORT_SAVE=gzdoom"
	SET "PORT_TITLE=GZDoom ^(v3.2.x^)"
	SET VER_GZDOOM=32
)
IF /I "%USE%" == "gzdoom-24" (
	SET "ENGINE_DIR=%DIR_PORTS%\gzdoom-24_%ENGINE_BIT%"
	SET "ENGINE_INC=brightmaps.pk3 lights.pk3"
	SET "ENGINE_EXE=gzdoom.exe"
	SET "ENGINE_CFG=gzdoom-24"
	SET "ENGINE_KIN=Z"
	SET "PORT_SAVE=gzdoom"
	SET "PORT_TITLE=GZDoom ^(v2.4.x^)"
	SET VER_GZDOOM=24
)
IF /I "%USE%" == "gzdoom-23" (
	SET "ENGINE_DIR=%DIR_PORTS%\gzdoom-23_%ENGINE_BIT%"
	SET "ENGINE_INC=brightmaps.pk3 lights.pk3"
	SET "ENGINE_EXE=gzdoom.exe"
	SET "ENGINE_CFG=gzdoom-23"
	SET "ENGINE_KIN=Z"
	SET "PORT_SAVE=gzdoom"
	SET "PORT_TITLE=GZDoom ^(v2.3.x^)"
	SET VER_GZDOOM=23
)
IF /I "%USE%" == "gzdoom-22" (
	SET "ENGINE_DIR=%DIR_PORTS%\gzdoom-22_%ENGINE_BIT%"
	SET "ENGINE_INC=brightmaps.pk3 lights.pk3"
	SET "ENGINE_EXE=gzdoom.exe"
	SET "ENGINE_CFG=gzdoom-22"
	SET "ENGINE_KIN=Z"
	SET "PORT_SAVE=gzdoom"
	SET "PORT_TITLE=gzdoom ^(v2.2.x^)"
	SET VER_GZDOOM=22
)
IF /I "%USE%" == "gzdoom-21" (
	SET "ENGINE_DIR=%DIR_PORTS%\gzdoom-21_%ENGINE_BIT%"
	SET "ENGINE_INC=brightmaps.pk3 lights.pk3"
	SET "ENGINE_EXE=gzdoom.exe"
	SET "ENGINE_CFG=gzdoom-21"
	SET "ENGINE_KIN=Z"
	SET "PORT_SAVE=gzdoom"
	SET "PORT_TITLE=GZDoom ^(v2.1.x^)"
	SET VER_GZDOOM=21
)
IF /I "%USE%" == "gzdoom-20" (
	SET "ENGINE_DIR=%DIR_PORTS%\gzdoom-20"
	SET "ENGINE_INC=brightmaps.pk3 lights.pk3"
	SET "ENGINE_EXE=gzdoom.exe"
	SET "ENGINE_CFG=gzdoom-20"
	SET "ENGINE_KIN=Z"
	SET "PORT_SAVE=gzdoom"
	SET "PORT_TITLE=GZDoom ^(v2.0.x^)"
	SET VER_GZDOOM=20
)
IF /I "%USE%" == "gzdoom-19" (
	SET "ENGINE_DIR=%DIR_PORTS%\gzdoom-19"
	SET "ENGINE_INC=brightmaps.pk3 lights.pk3"
	SET "ENGINE_EXE=gzdoom.exe"
	SET "ENGINE_CFG=gzdoom-19"
	SET "ENGINE_KIN=Z"
	SET "PORT_SAVE=gzdoom"
	SET "PORT_TITLE=GZDoom ^(v1.9.x^)"
	SET VER_GZDOOM=19
)
IF /I "%USE%" == "gzdoom-18" (
	SET "ENGINE_DIR=%DIR_PORTS%\gzdoom-18"
	SET "ENGINE_INC=brightmaps.pk3 lights.pk3"
	SET "ENGINE_EXE=gzdoom.exe"
	SET "ENGINE_CFG=gzdoom-18"
	SET "ENGINE_KIN=Z"
	SET "PORT_SAVE=gzdoom"
	SET "PORT_TITLE=GZDoom ^(v1.8.x^)"
	SET VER_GZDOOM=18
)
IF /I "%USE%" == "gzdoom-17" (
	SET "ENGINE_DIR=%DIR_PORTS%\gzdoom-17"
	SET "ENGINE_INC=brightmaps.pk3 lights.pk3"
	SET "ENGINE_EXE=gzdoom.exe"
	SET "ENGINE_CFG=gzdoom-17"
	SET "ENGINE_KIN=Z"
	SET "PORT_SAVE=gzdoom"
	SET "PORT_TITLE=GZDoom ^(v1.7.x^)"
	SET VER_GZDOOM=17
)
IF /I "%USE%" == "gzdoom-16" (
	SET "ENGINE_DIR=%DIR_PORTS%\gzdoom-16"
	SET "ENGINE_INC=brightmaps.pk3 lights.pk3"
	SET "ENGINE_EXE=gzdoom.exe"
	SET "ENGINE_CFG=gzdoom-16"
	SET "ENGINE_KIN=Z"
	SET "PORT_SAVE=gzdoom"
	SET "PORT_TITLE=GZDoom ^(v1.6.x^)"
	SET VER_GZDOOM=16
)
IF /I "%USE%" == "gzdoom-15" (
	SET "ENGINE_DIR=%DIR_PORTS%\gzdoom-15"
	SET "ENGINE_INC=brightmaps.pk3 lights.pk3"
	SET "ENGINE_EXE=gzdoom.exe"
	SET "ENGINE_CFG=gzdoom-15"
	SET "ENGINE_KIN=Z"
	SET "PORT_SAVE=gzdoom"
	SET "PORT_TITLE=GZDoom ^(v1.5.x^)"
	SET VER_GZDOOM=15
)
IF /I "%USE%" == "gzdoom-14" (
	SET "ENGINE_DIR=%DIR_PORTS%\gzdoom-14"
	SET "ENGINE_INC=brightmaps.pk3 lights.pk3"
	SET "ENGINE_EXE=gzdoom.exe"
	SET "ENGINE_CFG=gzdoom-14"
	SET "ENGINE_KIN=Z"
	SET "PORT_SAVE=gzdoom"
	SET "PORT_TITLE=GZDoom ^(v1.4.x^)"
	SET VER_GZDOOM=14
)
IF /I "%USE%" == "gzdoom-13" (
	SET "ENGINE_DIR=%DIR_PORTS%\gzdoom-13"
	SET "ENGINE_INC=brightmaps.pk3 lights.pk3"
	SET "ENGINE_EXE=gzdoom.exe"
	SET "ENGINE_CFG=gzdoom-13"
	SET "ENGINE_KIN=Z"
	SET "PORT_SAVE=gzdoom"
	SET "PORT_TITLE=GZDoom ^(v1.3.x^)"
	SET VER_GZDOOM=13
)
IF /I "%USE%" == "gzdoom-12" (
	SET "ENGINE_DIR=%DIR_PORTS%\gzdoom-12"
	SET "ENGINE_INC=brightmaps.pk3 lights.pk3"
	SET "ENGINE_EXE=gzdoom.exe"
	SET "ENGINE_CFG=gzdoom-12"
	SET "ENGINE_KIN=Z"
	SET "PORT_SAVE=gzdoom"
	SET "PORT_TITLE=GZDoom ^(v1.2.x^)"
	SET VER_GZDOOM=12
)
IF /I "%USE%" == "gzdoom-11" (
	SET "ENGINE_DIR=%DIR_PORTS%\gzdoom-11"
	SET "ENGINE_INC=brightmaps.pk3 lights.pk3"
	SET "ENGINE_EXE=gzdoom.exe"
	SET "ENGINE_CFG=gzdoom-11"
	SET "ENGINE_KIN=Z"
	SET "PORT_SAVE=gzdoom"
	SET "PORT_TITLE=GZDoom ^(v1.1.x^)"
	SET VER_GZDOOM=11
)
IF /I "%USE%" == "gzdoom-10" (
	SET "ENGINE_DIR=%DIR_PORTS%\gzdoom-10"
	SET "ENGINE_INC=brightmaps.pk3 lights.pk3"
	SET "ENGINE_EXE=gzdoom.exe"
	SET "ENGINE_CFG=gzdoom-10"
	SET "ENGINE_KIN=Z"
	SET "PORT_SAVE=gzdoom"
	SET "PORT_TITLE=GZDoom ^(v1.0.x^)"
	SET VER_GZDOOM=10
)
IF /I "%USE%" == "gzdoom-09" (
	REM # GZDoom 0.9 does not have brightmaps/lights files
	SET "ENGINE_DIR=%DIR_PORTS%\gzdoom-09"
	SET "ENGINE_EXE=gzdoom.exe"
	SET "ENGINE_CFG=gzdoom-09"
	SET "ENGINE_KIN=Z"
	SET "PORT_SAVE=gzdoom"
	SET "PORT_TITLE=GZDoom ^(v0.9.x^)"
	SET VER_GZDOOM=9
)
IF /I "%USE%" == "gzdoom-dev" (
	REM # shh, this is a secret...
	REM # (but you'll have to supply your own copy)
	SET "ENGINE_DIR=%DIR_PORTS%\gzdoom-dev"
	SET "ENGINE_INC=brightmaps.pk3 lights.pk3"
	SET "ENGINE_EXE=gzdoom.exe"
	SET "ENGINE_CFG=gzdoom"
	SET "ENGINE_KIN=Z"
	SET "PORT_SAVE=gzdoom"
	SET "PORT_TITLE=GZDoom ^(Development^)"
	SET VER_GZDOOM=99
)
IF /I "%USE%" == "qzdoom" (
	SET "ENGINE_DIR=%DIR_PORTS%\qzdoom_%ENGINE_BIT%"
	SET "ENGINE_INC=brightmaps.pk3 lights.pk3"
	REM # shh, this is a secret...
	REM # (but you'll have to supply your own copy)
	SET "ENGINE_EXE=qzdoom.exe"
	SET "ENGINE_CFG=qzdoom"
	SET "ENGINE_KIN=Z"
	SET "PORT_SAVE=qzdoom"
	SET "PORT_TITLE=QZDoom"
)
IF /I "%USE%" == "zandronum" (
	SET "ENGINE_DIR=%DIR_PORTS%\zandronum-3"
	SET "ENGINE_INC=skulltag_actors.pk3 skulltag_data.pk3"
	SET "ENGINE_EXE=zandronum.exe"
	SET "ENGINE_CFG=zandronum-3"
	SET "ENGINE_KIN=Z"
	SET "PORT_SAVE=zandronum"
	SET "PORT_TITLE=Zandronum ^(Current^)"
)
IF /I "%USE%" == "zandronum-2" (
	SET "ENGINE_DIR=%DIR_PORTS%\zandronum-2"
	SET "ENGINE_INC=skulltag_actors.pk3"
	SET "ENGINE_EXE=zandronum.exe"
	SET "ENGINE_CFG=zandronum-2"
	SET "ENGINE_KIN=Z"
	SET "PORT_SAVE=zandronum"
	SET "PORT_TITLE=Zandronum ^(v2.x^)"
)
IF /I "%USE%" == "zandronum-3" (
	SET "ENGINE_DIR=%DIR_PORTS%\zandronum-3"
	SET "ENGINE_INC=skulltag_actors.pk3 skulltag_data.pk3"
	SET "ENGINE_EXE=zandronum.exe"
	SET "ENGINE_CFG=zandronum-3"
	SET "ENGINE_KIN=Z"
	SET "PORT_SAVE=zandronum"
	SET "PORT_TITLE=Zandronum ^(v3.x^)"
)
IF /I "%USE%" == "doom64ex" (
	SET "ENGINE_DIR=%DIR_PORTS%\doom64ex"
	SET "ENGINE_EXE=DOOM64.exe"
	SET "ENGINE_CFG=doom64ex"
	SET "ENGINE_KIN=X"
	SET "PORT_SAVE=doom64ex"
	SET "PORT_TITLE=DOOM 64 EX"
	REM # game *has* to be DOOM64 for this engine
	SET "GAME=DOOM64"
)
IF /I "%USE%" == "zdoom" (
	SET "ENGINE_DIR=%DIR_PORTS%\zdoom"
	SET "ENGINE_EXE=zdoom.exe"
	SET "ENGINE_CFG=zdoom"
	SET "ENGINE_KIN=Z"
	SET "PORT_SAVE=zdoom"
	SET "PORT_TITLE=ZDoom ^(v2.8.1^)"
)

REM # if an engine wasn't specified, provide a default
IF NOT DEFINED USE (
	SET "ENGINE_DIR=%DIR_PORTS%\gzdoom-32_%ENGINE_BIT%"
	SET "ENGINE_INC=brightmaps.pk3 lights.pk3"
	SET "ENGINE_EXE=gzdoom.exe"
	SET "ENGINE_CFG=gzdoom"
	SET "ENGINE_KIN=Z"
	SET "PORT_SAVE=gzdoom"
	SET "PORT_TITLE=GZDoom ^(Default^)"
)

REM # no recognized engine name?
IF NOT DEFINED PORT_SAVE (
	ECHO  ERROR: "%USE%" is not a valid engine name.
	ECHO:
	ECHO  Command:
	ECHO:
	ECHO     doom.bat %*
	ECHO:
	POPD & PAUSE & EXIT /B 1
)

REM # DOOM 64 EX: fix for Sound Font not being found
REM # (it's looking in the 'current directory' rather than the executable's directory?)
IF "%PORT_SAVE%" == "doom64ex" (
	SET PARAMS=%PARAMS% -setvars s_soundfont "%FIX_PATH%\%ENGINE_DIR%\DOOMSND.SF2"
)

REM # do we need to force software-mode in GZDoom?
REM # TODO: should we allow this for Zandronum?
IF "%PORT_SAVE%" == "gzdoom" (
	IF %SW% EQU 1 (
		REM # add the CCMD to switch to software-renderer
		SET PARAMS=%PARAMS% +vid_renderer 0
	) ELSE (
		REM # add the CCMD to switch to hardware-renderer
		REM # (GZDoom will save the last mode used, so we must force it in every instance)
		SET PARAMS=%PARAMS% +vid_renderer 1
	)
)

REM # the particular engine has finally been selected
SET "ENGINE=%ENGINE_DIR%\%ENGINE_EXE%"

REM # the user will never know how complicated this is
ECHO          port : %PORT_TITLE%
ECHO        engine : %ENGINE%

REM # include the default engine files?
IF NOT DEFINED ENGINE_INC GOTO :iwad

CALL :engine_inc %ENGINE_INC%
GOTO :iwad

:engine_inc
REM --------------------------------------------------------------------------------------------------------------------
IF "%~1" == "" GOTO:EOF

SET FILES=%FILES% "%FIX_PATH%\%ENGINE_DIR%\%1"
REM # ensure that the files section is included in the end
REM # (i.e. if no other files are included)
SET ANY_WAD=1

ECHO  ^(auto^) -file : %ENGINE_DIR%\%1

SHIFT
GOTO :engine_inc


REM ====================================================================================================================
REM # IWAD:
REM ====================================================================================================================
:iwad
REM # if no IWAD was specified, select the default
IF NOT DEFINED IWAD (
	REM # The default IWAD depends on engine selection
	IF "%GAME%" == "DOOM"    SET "IWAD=DOOM.WAD"
	IF "%GAME%" == "DOOM2"   SET "IWAD=DOOM2.WAD"
	IF "%GAME%" == "DOOM64"  SET "IWAD=DOOM64.WAD"
	IF "%GAME%" == "HERETIC" SET "IWAD=HERETIC.WAD"
	IF "%GAME%" == "HEXEN"   SET "IWAD=HEXEN.WAD"
	IF "%GAME%" == "STRIFE"  SET "IWAD=STRIFE1.WAD"
)

REM # some ports require the file extensions for IWADs:
REM # get just the file name / extension from the IWAD (ignore any path)
FOR %%G IN ("%IWAD%") DO SET "IWAD_EXT=%%~xG"
REM # check if the extension is missing
IF NOT DEFINED IWAD_EXT (
	REM # GZDoom v3.2+ supports ".ipk3"...
	IF EXIST "%DIR_WADS%\%IWAD%.ipk3" SET "IWAD=%IWAD%.ipk3"
	REM # ... and ".IWAD"
	IF EXIST "%DIR_WADS%\%IWAD%.IWAD" SET "IWAD=%IWAD%.IWAD"
	REM # all ZDoom-based engines support ".pk3"
	IF EXIST "%DIR_WADS%\%IWAD%.pk3"  SET "IWAD=%IWAD%.pk3"
	REM # lastly, the most common is ".WAD"
	SET "IWAD=%IWAD%.WAD"
	REM # if the IWAD extension was omitted, and it wasn't found in the "wads" folder,
	REM # then it will now have a ".WAD" extension required for searching GOG / Steam for it
)

REM # common IWADs will determine the type of game being played
REM # (this includes launching the sharewares directly)
FOR %%G IN ("%IWAD%") DO SET "IWAD_NAME=%%~nxG"
IF /I "%IWAD_NAME%" == "DOOM.WAD"     SET "GAME=DOOM"
IF /I "%IWAD_NAME%" == "DOOM1.WAD"    SET "GAME=DOOM"
IF /I "%IWAD_NAME%" == "DOOM2.WAD"    SET "GAME=DOOM2"
IF /I "%IWAD_NAME%" == "TNT.WAD"      SET "GAME=DOOM2"
IF /I "%IWAD_NAME%" == "PLUTONIA.WAD" SET "GAME=DOOM2"
IF /I "%IWAD_NAME%" == "DOOM64.WAD"   SET "GAME=DOOM64"
IF /I "%IWAD_NAME%" == "HERETIC.WAD"  SET "GAME=HERETIC"
IF /I "%IWAD_NAME%" == "HERETIC1.WAD" SET "GAME=HERETIC"
IF /I "%IWAD_NAME%" == "HEXEN.WAD"    SET "GAME=HEXEN"
IF /I "%IWAD_NAME%" == "STRIFE1.WAD"  SET "GAME=STRIFE"
IF /I "%IWAD_NAME%" == "STRIFE0.WAD"  SET "GAME=STRIFE"

REM # search for the IWAD:
SET "FILE=%IWAD%"
CALL :find_file
REM # found?
IF %ERRORLEVEL% EQU 0 (
	SET IWAD_PATH=%FILE%
	GOTO :iwad_found
)

REM # IWAD is missing,
REM # now search GOG / Steam for the IWAD:
REM # (or DOOM 64 ROM in the case of DOOM 64)

IF /I "%IWAD_NAME%" == "DOOM.WAD"     GOTO :iwad_doomu
IF /I "%IWAD_NAME%" == "DOOM2.WAD"    GOTO :iwad_doom2
IF /I "%IWAD_NAME%" == "TNT.WAD"      GOTO :iwad_tnt
IF /I "%IWAD_NAME%" == "PLUTONIA.WAD" GOTO :iwad_plutonia
IF /I "%IWAD_NAME%" == "DOOM64.WAD"   GOTO :iwad_doom64
IF /I "%IWAD_NAME%" == "HERETIC.WAD"  GOTO :iwad_heretic
IF /I "%IWAD_NAME%" == "HEXEN.WAD"    GOTO :iwad_hexen
IF /I "%IWAD_NAME%" == "STRIFE1.WAD"  GOTO :iwad_strife

REM # not a known commercial IWAD
GOTO :iwad_missing

:iwad_doomu
	REM ------------------------------------------------------------------------------------------------------------
	REM # this implies the type of game being played is DOOM
	SET "GAME=DOOM"
	
	REM # is Steam : The Ultimate DOOM installed?
	CALL :reg "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 2280" "InstallLocation"
	IF DEFINED REG (
		REM # check if DOOM.WAD can be found there
		IF EXIST "%REG%\base\DOOM.WAD" SET "IWAD_PATH=%REG%\base\DOOM.WAD" & GOTO :iwad_found
	)
	REM # is GOG : The Ultimate DOOM installed?
	CALL :reg "HKLM\SOFTWARE\GOG.com\Games\1435827232" "Path"
	IF DEFINED REG (
		REM # check if DOOM.WAD can be found there
		IF EXIST "%REG%\DOOM.WAD" SET "IWAD_PATH=%REG%\DOOM.WAD" & GOTO :iwad_found
	)
	REM # is Steam : DOOM 3 BFG Edition installed?
	CALL :reg "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 208200" "InstallLocation"
	IF DEFINED REG (
		REM # check if DOOM.WAD can be found there
		REM # NOTE: this WAD is broken and censored and we will patch it automatically
		IF EXIST "%REG%\base\wads\DOOM.WAD" SET "IWAD_PATH=%REG%\base\wads\DOOM.WAD" & GOTO :iwad_patchbfg
	)
	REM # is GOG : DOOM 3 BFG Edition installed?
	CALL :reg "HKLM\SOFTWARE\GOG.com\Games\1135892318" "Path"
	IF DEFINED REG (
		REM # check if DOOM.WAD can be found there
		REM # NOTE: this WAD is broken and censored and we will patch it automatically
		IF EXIST "%REG%\base\wads\DOOM.WAD" SET "IWAD_PATH=%REG%\base\wads\DOOM.WAD" & GOTO :iwad_patchbfg
	)
	GOTO :iwad_check

:iwad_doom2
	REM ------------------------------------------------------------------------------------------------------------
	REM # this implies the type of game being played is DOOM2
	SET "GAME=DOOM2"
	
	REM # is Steam : DOOM II installed?
	CALL :reg "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 2300" "InstallLocation"
	IF DEFINED REG (
		REM # check if DOOM2.WAD can be found there
		IF EXIST "%REG%\base\DOOM2.WAD" SET "IWAD_PATH=%REG%\base\DOOM2.WAD" & GOTO :iwad_found
	)
	REM # is GOG : DOOM II installed?
	CALL :reg "HKLM\SOFTWARE\GOG.com\Games\1435848814" "Path"
	IF DEFINED REG (
		REM # check if DOOM2.WAD can be found there
		IF EXIST "%REG%\doom2\DOOM2.WAD" SET "IWAD_PATH=%REG%\doom2\DOOM2.WAD" & GOTO :iwad_found
	)
	REM # is Steam : DOOM 3 BFG Edition installed?
	CALL :reg "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 208200" "InstallLocation"
	IF DEFINED REG (
		REM # check if DOOM2.WAD can be found there
		REM # TODO: this WAD is broken and censored and we should patch it automatically
		IF EXIST "%REG%\base\wads\DOOM2.WAD" SET "IWAD_PATH=%REG%\base\wads\DOOM2.WAD" & GOTO :iwad_patchbfg
	)
	REM # is GOG : DOOM 3 BFG Edition installed?
	CALL :reg "HKLM\SOFTWARE\GOG.com\Games\1135892318" "Path"
	IF DEFINDE REG (
		REM # check if DOOM2.WAD can be found there
		REM # TODO: this WAD is broken and censored and we should patch it automatically
		IF EXIST "%REG%\base\wads\DOOM2.WAD" SET "IWAD_PATH=%REG%\base\wads\DOOM2.WAD" & GOTO :iwad_patchbfg
	)
	GOTO :iwad_check

:iwad_tnt
	REM ------------------------------------------------------------------------------------------------------------
	REM # this implies the type of game being played is DOOM2
	SET "GAME=DOOM2"
	
	REM # is Steam : Final DOOM installed?
	CALL :reg "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 2290" "InstallLocation"
	IF DEFINED REG (
		REM # check if TNT.WAD can be found there
		IF EXIST "%REG%\base\TNT.WAD" SET "IWAD_PATH=%REG%\base\TNT.WAD" & GOTO :iwad_found
	)
	REM # is GOG : Final DOOM installed?
	CALL :reg "HKLM\SOFTWARE\GOG.com\Games\1435848742" "Path"
	IF DEFINED REG (
		REM # check if TNT.WAD can be found there
		IF EXIST "%REG%\TNT\TNT.WAD" SET "IWAD_PATH=%REG%\TNT\TNT.WAD" & GOTO :iwad_found
	)
	GOTO :iwad_check

:iwad_plutonia
	REM ------------------------------------------------------------------------------------------------------------
	REM # this implies the type of game being played is DOOM2
	SET "GAME=DOOM2"
	
	REM # is Steam : Final DOOM installed?
	CALL :reg "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 2290" "InstallLocation"
	IF DEFINED REG (
		REM # check if PLUTONIA.WAD can be found there
		IF EXIST "%REG%\base\PLUTONIA.WAD" SET "IWAD_PATH=%REG%\base\PLUTONIA.WAD" & GOTO :iwad_found
	)
	REM # is GOG : Final DOOM installed?
	CALL :reg "HKLM\SOFTWARE\GOG.com\Games\1435848742" "Path"
	IF DEFINED REG (
		REM # check if PLUTONIA.WAD can be found there
		IF EXIST "%REG%\PLUTONIA\PLUTONIA.WAD" SET "IWAD_PATH=%REG%\PLUTONIA\PLUTONIA.WAD" & GOTO :iwad_found
	)
	GOTO :iwad_check

:iwad_doom64
	REM ------------------------------------------------------------------------------------------------------------
	REM # this implies the type of game being played is DOOM64
	SET "GAME=DOOM64"
	
	REM # if DOOM64.WAD is missing, assume it has not been generated from the ROM
	ECHO:
	ECHO   WARNING! DOOM64.WAD needs to be generated:
	ECHO:
	ECHO   -- To play DOOM 64, a DOOM64.WAD file will be generated from an N64 ROM image
	ECHO      of the game. After pressing any key, please select your ROM file, it can be
	ECHO      of the type ".N64", ".V64" or ".Z64".
	ECHO:
	ECHO      press any key to continue
	PAUSE >NUL
	
	REM # launch the DOOM64.WAD generator;
	REM # the current directory needs to be that of the engine for WadGen to reference the "Content" folder
	PUSHD "%ENGINE_DIR%"
	WadGen.exe
	POPD
	
	REM # try find DOOM64.WAD again
	CALL :find_file
	REM # found?
	IF %ERRORLEVEL% EQU 0 (
		SET IWAD_PATH=%FILE%
		GOTO :iwad_found
	)
	
	REM # DOOM64.WAD was not generated?
	ECHO:
	ECHO   ERROR! Could not locate DOOM64.WAD. The generation tool was cancelled or
	ECHO   failed. Please re-run this script and select your DOOM64 N64 ROM file,
	ECHO   or run "WadGen.exe" manually, located at:
	ECHO:
	ECHO       "%ENGINE_DIR%\WadGen.exe"
	ECHO:
	POPD
	PAUSE
	EXIT /B 1

:iwad_heretic
	REM ------------------------------------------------------------------------------------------------------------
	REM # this implies the type of game being played is HERETIC
	SET "GAME=HERETIC"
	
	REM # is Steam : Heretic installed?
	CALL :reg "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 2390" "InstallLocation"
	IF DEFINED REG (
		REM # check if HERETIC.WAD can be found there
		IF EXIST "%REG%\base\HERETIC.WAD" SET "IWAD_PATH=%REG%\base\HERETIC.WAD" & GOTO :iwad_found
	)
	GOTO :iwad_check

:iwad_hexen
	REM ------------------------------------------------------------------------------------------------------------
	REM # this implies the type of game being played is HEXEN
	SET "GAME=HEXEN"
	
	REM # is Steam : Hexen installed?
	CALL :reg "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 2360" "InstallLocation"
	IF DEFINED REG (
		REM # check if HEXEN.WAD can be found there
		IF EXIST "%REG%\base\HEXEN.WAD" SET "IWAD_PATH=%REG%\base\HEXEN.WAD" & GOTO :iwad_found
	)
	GOTO :iwad_check

:iwad_strife
	REM ------------------------------------------------------------------------------------------------------------
	REM # this implies the type of game being played is STRIFE
	SET "GAME=STRIFE"
	
	REM # is Steam : "The Original Strife: Veteran Edition" installed?
	CALL :reg "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 317040" "InstallLocation"
	IF DEFINED REG (
		REM # check if STRIFE1.WAD can be found there
		IF EXIST "%REG%\strife1.wad" SET "IWAD_PATH=%REG%\strife1.wad" & GOTO :iwad_found
	)
	REM # is GOG : "The Original Strife: Veteran Edition" installed?
	CALL :reg "HKLM\SOFTWARE\GOG.com\Games\1432899949" "Path"
	IF DEFINED REG (
		REM # check if STRIFE1.WAD can be found there
		IF EXIST "%REG%\strife1.wad" SET "IWAD_PATH=%REG%\strife1.wad" & GOTO :iwad_found
	)
	GOTO :iwad_check

:iwad_check
	REM ------------------------------------------------------------------------------------------------------------
	REM # did we find the IWAD in GOG / Steam?
	IF EXIST "%IWAD_PATH%" GOTO :iwad_found
	
	REM # IWAD really cannot be found,
	REM # substitute for shareware or FreeDOOM:
	
	REM # if the user is trying to play just DOOM as-is without a PWAD,
	REM # then the best thing to do is offer them the shareware version:
	IF "%GAME%-%PWAD%" == "DOOM-" (
		ECHO:
		ECHO   WARNING! Could not find registered DOOM.WAD:
		ECHO:
		ECHO   -- The shareware version will be launched instead which is limited to the
		ECHO      first episode. Please purchase either "The Ultimate DOOM", "DOOM Classic
		ECHO      Complete" or "DOOM 3 BFG Edition" on GOG / Steam, or place your own copy
		ECHO      of "DOOM.WAD" in the "%DIR_WADS%" folder.
		ECHO:
		ECHO      press any key to continue
		PAUSE >NUL
		
		SET "IWAD_PATH=SHAREWARE\DOOM1.WAD"
		
		GOTO :iwad_found
	)
	REM # likewise, Heretic
	IF "%GAME%-%PWAD%" == "HERETIC-" (
		ECHO:
		ECHO   WARNING! Could not find registered HERETIC.WAD:
		ECHO:
		ECHO   -- The shareware version will be launched instead which is limited to the
		ECHO      first episode. Please purchase "Heretic: Shadow of the Serpent Riders"
		ECHO      from Steam, or place your own copy of "HERETIC.WAD" in the
		ECHO      "%DIR_WADS%" folder.
		ECHO:
		ECHO      press any key to continue
		PAUSE >NUL
		
		SET "IWAD_PATH=SHAREWARE\HERETIC1.WAD"
		
		GOTO :iwad_found
	)
	REM # and Hexen
	IF "%GAME%-%PWAD%" == "HEXEN-" (
		ECHO:
		ECHO   WARNING! Could not find registered HEXEN.WAD:
		ECHO:
		ECHO   -- The shareware version will be launched instead which is limited to the
		ECHO      first episode. Please purchase "Hexen: Beyond Heretic" from Steam,
		ECHO      or place your own copy of "HEXEN.WAD" in the "%DIR_WADS%" folder.
		ECHO:
		ECHO      press any key to continue
		PAUSE >NUL
		
		REM # Hexen does not have different WAD names for shareware/registered
		SET "IWAD_PATH=SHAREWARE\HEXEN.WAD"
		
		GOTO :iwad_found
	)
	
	REM # and Strife
	IF "%GAME%-%PWAD%" == "STRIFE-" (
		ECHO:
		ECHO   WARNING! Could not find registered STRIFE1.WAD:
		ECHO:
		ECHO   -- The shareware version will be launched instead. Please purchase
		ECHO      "The Original Strife: Veteran Edition" from GOG or Steam,
		ECHO      or place your own copy of "STRIFE1.WAD" in the "%DIR_WADS%" folder.
		ECHO:
		ECHO      press any key to continue
		PAUSE >NUL
		
		SET "IWAD_PATH=SHAREWARE\STRIFE0.WAD"
		
		GOTO :iwad_found
	)
	
	REM # if this was DOOM or DOOM2, we could use FreeDOOM instead
	SET "FREEDOOM="
	REM # TODO: check these files exist too
	IF /I "%IWAD_NAME%" == "DOOM.WAD"  SET "FREEDOOM=%DIR_WADS%\conversions\freedoom\freedoom1.wad"
	IF /I "%IWAD_NAME%" == "DOOM2.WAD" SET "FREEDOOM=%DIR_WADS%\conversions\freedoom\freedoom2.wad"
	
	IF DEFINED FREEDOOM (
		ECHO:
		ECHO   WARNING! COULD NOT FIND "%DIR_WADS%\%IWAD%"
		ECHO   -- USING FREEDOOM AS REPLACEMENT
		ECHO:
		ECHO      press any key to continue
		PAUSE  >NUL
		ECHO:
		
		SET "IWAD_PATH=%FREEDOOM%"
		GOTO :wad_found
	)
	
	REM # TODO: this is where we'd substitute HERETIC.WAD for BLASPHEMER.WAD,
	REM # but that's not complete yet

REM # IWAD doesn't exist and there isn't a substitution
REM # TODO: DOOM2, Final DOOM specific error messages?
:iwad_missing
	ECHO:
	ECHO   ERROR! the file:
	ECHO:
	ECHO       "%DIR_WADS%\%IWAD%"
	ECHO:
	ECHO   doesn't exist.
	ECHO:
	ECHO   Command:
	ECHO:
	ECHO     doom.bat %*
	ECHO:
	POPD
	PAUSE
	EXIT /B 1

:iwad_patchbfg
	REM ------------------------------------------------------------------------------------------------------------
	REM # patch DOOM 3 BFG Edition IWADs
	SET "BFG_PATCH="
	ECHO:
	ECHO     DOOM 3 BFG Edition found -- automatically patching "%IWAD%"
	ECHO:
	
	REM # get the folder of the DOOM 3 BFG Edition WADs;
	REM # the patched file will be saved there to avoid
	REM # unintentional "stealing" of IWADs off of computers
	FOR %%G IN ("%IWAD_PATH%") DO SET "BFG_PATH=%%~dpG"
	
	REM # DOOM or DOOM2?
	IF /I "%GAME%" == "DOOM" (
		SET "BFG_PATCH=bfg-to-ud.vcdiff"
		SET "BFG_PATCH_WAD=DOOMU_BFG_PATCHED.WAD"
	)
	IF /I "%GAME%" == "DOOM2" (
		SET "BFG_PATCH=bfg-to-1.9.vcdiff"
		SET "BFG_PATCH_WAD=DOOM2_BFG_PATCHED.WAD"
	)
	
	REM # check if already patched
	SET "BFG_WADPATH=%BFG_PATH%%BFG_PATCH_WAD%"
	IF EXIST "%BFG_WADPATH%" SET "IWAD_PATH=%BFG_WADPATH%" & GOTO :iwad_found
	
	REM # run the patcher
	"tools\xdelta3\xdelta3-3.0.11-i686.exe" -d -s "%IWAD_PATH%" "tools\xdelta3\%BFG_PATCH%" "%BFG_WADPATH%"
	REM # now use the patched IWAD
	SET "IWAD_PATH=%BFG_WADPATH%"

:iwad_found
REM --------------------------------------------------------------------------------------------------------------------
REM # IWAD confirmed
ECHO         -iwad : %IWAD_PATH%

REM # is the IWAD path absolute?
REM # (i.e. begins with a drive letter, making ":" the second character)
IF NOT "%IWAD_PATH:~1,1%" == ":" SET "IWAD_PATH=%FIX_PATH%\%IWAD_PATH%"
SET PARAMS=%PARAMS% -iwad "%IWAD_PATH%"


REM ====================================================================================================================
REM # PWAD:
REM ====================================================================================================================
REM # if no PWAD was specified, skip ahead
IF NOT DEFINED PWAD GOTO :deh_bex

REM # get the PWAD file name (ignore any path)
FOR %%G IN ("%PWAD%") DO SET "PWAD_NAME=%%~nxG"

REM # search for the file
SET "FILE=%PWAD%"
CALL :find_file
REM # found?
IF %ERRORLEVEL% EQU 0 (
	SET "PWAD_PATH=%FILE%"
	GOTO :pwad_found
)

REM # PWAD is missing, check Steam / GOG
REM --------------------------------------------------------------------------------------------------------------------
REM # are we looking for "No Rest for the Living?"
REM # (part of DOOM 3 BFG Edition)
IF /I "%PWAD_NAME%" == "NERVE.WAD"    GOTO :pwad_nerve
IF /I "%PWAD_NAME%" == "NRFTL+.WAD"   GOTO :pwad_nerve
REM # are we looking for "Master Levels for DOOM II"?
IF /I "%PWAD_NAME%" == "ATTACK.WAD"   GOTO :pwad_master
IF /I "%PWAD_NAME%" == "BLACKTWR.WAD" GOTO :pwad_master
IF /I "%PWAD_NAME%" == "BLOODSEA.WAD" GOTO :pwad_master
IF /I "%PWAD_NAME%" == "CANYON.WAD"   GOTO :pwad_master
IF /I "%PWAD_NAME%" == "CATWALK.WAD"  GOTO :pwad_master
IF /I "%PWAD_NAME%" == "COMBINE.WAD"  GOTO :pwad_master
IF /I "%PWAD_NAME%" == "FISTULA.WAD"  GOTO :pwad_master
IF /I "%PWAD_NAME%" == "GARRISON.WAD" GOTO :pwad_master
IF /I "%PWAD_NAME%" == "GERYON.WAD"   GOTO :pwad_master
IF /I "%PWAD_NAME%" == "MANOR.WAD"    GOTO :pwad_master
IF /I "%PWAD_NAME%" == "MEPHISTO.WAD" GOTO :pwad_master
IF /I "%PWAD_NAME%" == "MINOS.WAD"    GOTO :pwad_master
IF /I "%PWAD_NAME%" == "NESSUS.WAD"   GOTO :pwad_master
IF /I "%PWAD_NAME%" == "PARADOX.WAD"  GOTO :pwad_master
IF /I "%PWAD_NAME%" == "SUBSPACE.WAD" GOTO :pwad_master
IF /I "%PWAD_NAME%" == "SUBTERRA.WAD" GOTO :pwad_master
IF /I "%PWAD_NAME%" == "TEETH.WAD"    GOTO :pwad_master
IF /I "%PWAD_NAME%" == "TTRAP.WAD"    GOTO :pwad_master
IF /I "%PWAD_NAME%" == "VESPERAS.WAD" GOTO :pwad_master
IF /I "%PWAD_NAME%" == "VIRGIL.WAD"   GOTO :pwad_master
REM # TODO: check HEXDD.WAD

REM # PWAD is missing and can't be substituted
ECHO:
ECHO  ERROR: the PWAD "%PWAD%" doesn't exist at "%PWAD_PATH%".
ECHO  Command:
ECHO:
ECHO     doom.bat %*
ECHO:
PAUSE
EXIT /B 1

:pwad_nerve
	REM ------------------------------------------------------------------------------------------------------------
	REM # is Steam : DOOM 3 BFG Edition installed?
	CALL :reg "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 208200" "InstallLocation"
	IF DEFINED REG (
		REM # check if NERVE.WAD can be found there
		IF EXIST "%REG%\base\wads\NERVE.WAD" SET "PWAD_PATH=%REG%\base\wads\NERVE.WAD" & GOTO :pwad_found
	)
	REM # is GOG : DOOM 3 BFG Edition installed?
	CALL :reg "HKLM\SOFTWARE\GOG.com\Games\1135892318" "Path"
	IF DEFINED REG (
		REM # check if NERVE.WAD can be found there
		IF EXIST "%REG%\base\wads\NERVE.WAD" SET "PWAD_PATH=%REG%\base\wads\NERVE.WAD" & GOTO :pwad_found
	)
	REM # if the WAD was not found, we cannot continue, the user does not have NERVE.WAD
	ECHO:
	ECHO   ERROR: "NERVE.WAD" missing:
	ECHO:
	ECHO   You must purchase "DOOM 3: BFG Edition" from Steam to get NERVE.WAD.
	ECHO   doom.bat automatically finds it, if installed. If you have NERVE.WAD
	ECHO   elsewhere, copy it to the "%DIR_WADS%" folder and try again.
	ECHO:
	POPD
	PAUSE & EXIT /B 1

:pwad_master
	REM ------------------------------------------------------------------------------------------------------------
	REM # is Steam : Master Levels for DOOM II installed?
	CALL :reg "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 9160" "InstallLocation"
	IF DEFINED REG (
		REM # check if the WAD can be found there
		IF EXIST "%REG%\master\wads\%PWAD_NAME%" SET "PWAD_PATH=%REG%\master\wads\%PWAD_NAME%" & GOTO :pwad_found
	)
	REM # is GOG : DOOM II + Final DOOM (including Master Levels) installed?
	CALL :reg "HKLM\SOFTWARE\GOG.com\Games\1435848814" "Path"
	IF DEFINED REG (
		REM # check if the WAD can be found there
		IF EXIST "%REG%\master\wads\%PWAD_NAME%" SET "PWAD_PATH=%REG%\master\wads\%PWAD_NAME%" & GOTO :pwad_found
	)
	
	REM # if the WAD was not found, we cannot continue
	ECHO:
	ECHO   ERROR: "%PWAD%" missing:
	ECHO:
	ECHO   You must purchase either "DOOM Classic Complete" from Steam or
	ECHO   "DOOM II + Final DOOM" from GOG to get "Master Levels for DOOM II";
	ECHO   doom.bat automatically finds it, if installed. If you have the Master Levels
	ECHO   WADs elsewhere, copy them to the "%DIR_WADS%\MASTER" folder and try again.
	ECHO:
	POPD
	PAUSE & EXIT /B 1

:pwad_found
REM --------------------------------------------------------------------------------------------------------------------
REM # remember the PWAD directory for looking for other files, including demos
SET "DIR_PWAD=%DIR_PREV%"

REM # with the IWAD/PWAD edge-cases handled we can finally print out the PWAD
ECHO          PWAD : %PWAD_PATH%

REM # is the PWAD path absolute?
REM # (i.e. begins with a drive letter, making ":" the second character)
IF NOT "%PWAD_PATH:~1,1%" == ":" SET "PWAD_PATH=%FIX_PATH%\%PWAD_PATH%"
REM # the PWAD should appear as the first in the `-file` list
SET FILES=%FILES% "%PWAD_PATH%"

REM # ensure that the files section is included in the end
REM # (i.e. if no other files are included)
SET ANY_WAD=1


REM ====================================================================================================================
REM # DEHACKED:
REM ====================================================================================================================
:deh_bex
REM # was there any /DEH or /BEX parameters?
IF "%DEH%-%BEX%" == "-" GOTO :saves

:deh
REM # was there a /DEH parameter?
IF NOT DEFINED DEH GOTO :bex

SET "FILE=%DEH%"
CALL :find_file_or_fail

REM # path confirmed, put on screen
SET "DEH_PATH=%FILE%"
ECHO          -deh : %DEH_PATH%

REM # if the DEH file is relative, we'll need to fix the relative path
REM # to account for what will be the current directory once we launch
IF NOT "%DEH_PATH:~1,1%" == ":" SET "DEH_PATH=%FIX_PATH%\%DEH_PATH%"
REM # add to the command line
SET PARAMS=%PARAMS% -deh "%DEH_PATH%"

:bex
REM # was there a /BEX parameter?
IF NOT DEFINED BEX GOTO :saves

SET "FILE=%BEX%"
CALL :find_file_or_fail

REM # path confirmed, put on screen
SET "BEX_PATH=%FILE%"
ECHO          -bex : %BEX_PATH%

REM # if the BEX file is relative, we'll need to fix the relative path
REM # to account for what will be the current directory once we launch
IF NOT "%BEX_PATH:~1,1%" == ":" SET "BEX_PATH=%FIX_PATH%\%BEX_PATH%"
REM # add to the command line
SET PARAMS=%PARAMS% -bex "%BEX_PATH%"


REM ====================================================================================================================
REM # SAVE FILES:
REM ====================================================================================================================
:saves
REM # savegames are separated by port (GZDoom / Zandronum &c.)
REM # and then by IWAD or PWAD (if present)
IF DEFINED PWAD (
	REM # remove extension from PWAD name
	FOR %%G IN ("%PWAD_NAME%") DO SET "SAVE_WAD=%%~nG"
) ELSE (
	REM # remove extension from IWAD name
	FOR %%G IN ("%IWAD_NAME%") DO SET "SAVE_WAD=%%~nG"
)

REM # check if the base saves directory even exists?
IF NOT EXIST "%DIR_SAVES%" MKDIR "%DIR_SAVES%"
REM # within the saves folder, there'll be a folder for each engine
REM # (not to be confused with %PORT_SAVE% which is the name of the folder, not the path)
SET "SAVES_PORT=%DIR_SAVES%\%PORT_SAVE%"
REM # check if the save directory for the port exists
IF NOT EXIST "%SAVES_PORT%" MKDIR "%SAVES_PORT%"
REM # savegames are separated by the IWAD or PWAD name so that you don't get 100 "DOOM2" saves
SET "SAVES_WAD=%SAVES_PORT%\%SAVE_WAD%"
REM # check if the save directory for the IWAD/PWAD name exists
IF NOT EXIST "%SAVES_WAD%" MKDIR "%SAVES_WAD%"

REM # since the current directory will be changed to the WAD's save directory,
REM # we can specify this parameter as just the 'current directory' (".").
REM # NOTE: DOOM 64 EX does not support a save directory parameter
REM # and will put savegames in the 'current directory'!

REM # PrBoom+ uses `-save`
IF "%PORT_SAVE%" == "prboom" (
	SET PARAMS=%PARAMS% -save "."
	ECHO         -save : %SAVES_WAD%
	
REM # All other engines use `-savedir`,
REM # except doom64x which has no support yet
) ELSE IF NOT "%PORT_SAVE%" == "doom64ex" (
	SET PARAMS=%PARAMS% -savedir "."
	ECHO      -savedir : %SAVES_WAD%
)


REM ====================================================================================================================
REM # CONFIG:
REM ====================================================================================================================
REM # ZDoom based engines (Q/G/ZDoom, Zandronum) use ".ini" config files,
REM # the other engines use ".cfg"
IF "%ENGINE_KIN%" == "Z" ( SET "CFG=ini" ) ELSE ( SET "CFG=cfg" )
REM # config file path/name as we build it
SET "CONFIG="

REM # if the option to use the default config (`/DEFAULT`) has been given:
IF %DEFAULT% EQU 1 (
	REM # we will launch the engine using the actual default config file rather than a copy
	REM # (note file extension omitted for now)
	SET "CONFIG=%DIR_CONFIGS%\default.%ENGINE_CFG%"
) ELSE (
	REM # if the default config file (for the engine) is missing,
	REM # launch the engine to create and set a new default configuration
	IF NOT EXIST "%DIR_CONFIGS%\default.%ENGINE_CFG%.%CFG%" (
		ECHO:
		ECHO       WARNING : The default configuration file ^(for this engine^) is missing.
		ECHO                 The engine will be launched with a new default configuration
		ECHO                 file; please configure the engine to desired defaults.
		ECHO:
		ECHO       press any key to continue
		ECHO:
		PAUSE >NUL
		
		REM # use the default config file instead of the user's personal copy
		REM # (does not include the file-extension so that we can append "extra" in there for choco-doom)
		SET "CONFIG=%DIR_CONFIGS%\default.%ENGINE_CFG%"
	) ELSE (
		REM # if a user-config is not yet present, copy over the default
		IF NOT EXIST "%SAVES_PORT%\config.%ENGINE_CFG%.%CFG%" (
			REM # copy across the default configuration (from "config" folder)
			COPY /Y "%DIR_CONFIGS%\default.%ENGINE_CFG%.%CFG%" ^
			          "%SAVES_PORT%\config.%ENGINE_CFG%.%CFG%"  >NUL
			REM # chocolate-doom's extra config file too
			IF "%ENGINE_KIN%" == "V" (
				COPY /Y "%DIR_CONFIGS%\default.%ENGINE_CFG%.extra.%CFG%" ^
				          "%SAVES_PORT%\config.%ENGINE_CFG%.extra.%CFG%"  >NUL
			)
		)
		REM # use the user's personal config file
		REM # (does not include the file-extension so that we can append "extra" in there for choco-doom)
		SET "CONFIG=%SAVES_PORT%\config.%ENGINE_CFG%"
	)
)

REM # add the config file to the command line and display its name
SET PARAMS=%PARAMS% -config "%FIX_PATH%\%CONFIG%.%CFG%"
ECHO       -config : %CONFIG%.%CFG%

REM # chocolate-doom engines use an extra config file for non-vanilla settings
IF "%ENGINE_KIN%" == "V" (
	SET PARAMS=%PARAMS% -extraconfig "%FIX_PATH%\%CONFIG%.extra.%CFG%"
	ECHO  -extraconfig : %CONFIG%.extra.%CFG%
)


REM ====================================================================================================================
REM # DEMO:
REM ====================================================================================================================
REM # demo playback?
IF NOT DEFINED DEMO GOTO :warp

SET "FILE=%DEMO%"
CALL :find_file_or_fail

REM # path confirmed, put on screen
SET "DEMO_PATH=%FILE%"
ECHO     -playdemo : %DEMO_PATH%

REM # if the demo file is relative, we'll need to fix the relative path
REM # to account for what will be the current directory once we launch
IF NOT "%DEMO_PATH:~1,1%" == ":" SET "DEMO_PATH=%FIX_PATH%\%DEMO_PATH%"
REM # add to the command line
SET PARAMS=%PARAMS% -playdemo "%DEMO_PATH%"


REM ====================================================================================================================
REM # WARP & SKILL:
REM ====================================================================================================================
:warp
REM # if no warp has been given, skip ahead
IF NOT DEFINED WARP GOTO :skill

REM # is this a DOOM.WAD "e.m" format map number?
REM # (replace the dot with a space for the engines)
SET "WARP=%WARP:.= %"
REM # add to the command line
ECHO         -warp : %WARP%
SET PARAMS=%PARAMS% -warp %WARP%

REM # if warping, and a skill-level is already given we don't need to ask the user
IF DEFINED SKILL GOTO :skill

REM # TODO: provide descriptions of the effects skill levels have?
REM #       see: https://doomwiki.org/wiki/Skill_level

ECHO:
ECHO -------------------------------------------------------------------------------
ECHO:
ECHO          CHOOSE YOUR SKILL LEVEL:
ECHO:
REM # DOOM 64 EX has different skill names:
IF "%GAME%" =="DOOM64" (
	ECHO          [1]  Be Gentle!
	ECHO          [2]  Bring It On!
	ECHO          [3]  I Own Doom!
	ECHO          [4]  Watch Me Die!
	
REM # Or Heretic:
REM # TODO: Hexen skill level names are based on class
) ELSE IF "%GAME%" == "HERETIC" (
	ECHO          [1] Thou needeth a wet-nurse
	ECHO          [2] Yellowbellies-r-us
	ECHO          [3] Bringest them oneth
	ECHO          [4] Thou art a smite-meister
	ECHO          [5] Black plague possesses thee

REM # Or Strife:
) ELSE IF "%GAME%" == "STRIFE" (
	ECHO          [1] Training
	ECHO          [2] Rookie
	ECHO          [3] Veteran
	ECHO          [4] Elite
	ECHO          [5] Bloodbath

REM # Lastly, DOOM:
) ELSE (
	ECHO          [1]  I'm Too Young To Die
	ECHO          [2]  Hey, Not Too Rough
	ECHO          [3]  Hurt Me Plenty
	ECHO          [4]  Ultra-Violence
	ECHO          [5]  Nightmare!
)
ECHO:
ECHO -------------------------------------------------------------------------------
ECHO:

REM # split the Windows version string and look for the number
FOR /F "tokens=4-5 delims=. " %%V IN ('VER') DO SET WINVER=%%V.%%W
REM # CHOICE is not available in Windows XP, detect this and use `SET /P` instead
IF "%WINVER%" == "5.1" GOTO :skill_xp

:skill_choice
	REM # Windows Vista and above include CHOICE again
	CHOICE /C 123450 >NUL
	REM # secret "disable all monsters" mode; can prevent levels
	REM # from being completable and doesn't work on all engines!
	IF %ERRORLEVEL% EQU 6 SET SKILL=0
	REM # standard skill levels
	IF %ERRORLEVEL% EQU 5 SET SKILL=5
	IF %ERRORLEVEL% EQU 4 SET SKILL=4
	IF %ERRORLEVEL% EQU 3 SET SKILL=3
	IF %ERRORLEVEL% EQU 2 SET SKILL=2
	IF %ERRORLEVEL% EQU 1 SET SKILL=1
	GOTO :skill

:skill_xp
	REM # assume a default in case the user types nonsense
	SET SKILL=3
	SET /P "CHOICE=? "
	REM # secret "disable all monsters" mode; can prevent levels
	REM # from being completable and doesn't work on all engines!
	IF "%CHOICE%" == "0" SET SKILL=0
	REM # standard skill levels
	IF "%CHOICE%" == "5" SET SKILL=5
	IF "%CHOICE%" == "4" SET SKILL=4
	IF "%CHOICE%" == "3" SET SKILL=3
	IF "%CHOICE%" == "2" SET SKILL=2
	IF "%CHOICE%" == "1" SET SKILL=1

:skill
REM # was a skill-level given?
IF NOT DEFINED SKILL GOTO :exec

REM # set the skill-level
ECHO        -skill : %SKILL%
SET PARAMS=%PARAMS% -skill %SKILL%


REM ====================================================================================================================
REM # EXEC:
REM ====================================================================================================================
:exec
IF NOT DEFINED EXEC GOTO :files

SET "FILE=%EXEC%"
CALL :find_file_or_fail
SET "EXEC_PATH=%FILE%"

REM # if the exec file is relative, we'll need to fix the relative path
REM # to account for what will be the current directory once we launch
IF NOT "%EXEC_PATH:~1,1%" == ":" SET "EXEC_PATH=%FIX_PATH%\%EXEC_PATH%"
REM # add to the command line
ECHO         -exec : %EXEC_PATH%
SET PARAMS=%PARAMS% -exec "%EXEC_PATH%"


:files
REM ====================================================================================================================
REM # are there any files to add?
IF "%~1" == "" GOTO :launch
SHIFT

:files_loop
	REM # no more parameters remaining?
	IF "%~1" == "" GOTO :launch
	
	SET "FILE=%~1"
	CALL :find_file_or_fail
	
	REM # display on screen, before 'fixing' relative path
	ECHO         -file : %FILE%
	
	REM # if the file is relative, we'll need to fix the relative path
	REM # to account for what will be the current directory once we launch
	IF NOT "%FILE:~1,1%" == ":" SET "FILE=%FIX_PATH%\%FILE%"
	REM # add to the command line
	SET FILES=%FILES% "%FILE%"
	REM # ensure that the files section is included in the end
	REM # (i.e. if no other files are included)
	SET ANY_WAD=1
	SHIFT
	GOTO :files_loop

REM --------------------------------------------------------------------------------------------------------------------
:prev_dir
	SET "DIR_PREV=%~p1"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "DIR_PREV=!DIR_PREV:%~p0=!"
	SET "DIR_PREV=!DIR_PREV:~0,-1!"		& REM # strip trailing slash
	ENDLOCAL & SET "DIR_PREV=%DIR_PREV%"
	GOTO:EOF


:launch
REM ====================================================================================================================
REM # if a compatibility-level is specified, include this
IF DEFINED CMPLVL SET PARAMS=%PARAMS% -complevel %CMPLVL%

REM # were any files added?
IF %ANY_WAD% EQU 1 (
	REM # IMPORTANT NOTE: Chocolate-DOOM will not be able handle PWADs unless
	REM # the `-merge` switch is used, this is due to historical accuracy;
	REM # see <www.chocolate-doom.org/wiki/index.php/WAD_merging_capability>
	IF "%ENGINE_KIN%" == "V" (
		SET PARAMS=%PARAMS% -merge %FILES%
	) ELSE (
		SET PARAMS=%PARAMS% -file %FILES%
	)
)

:screenres
REM # get the desktop screen resolution:
REM --------------------------------------------------------------------------------------------------------------------
REM # Chocolate Doom v3 (and derivatives) default to screen display resolution
REM # and don't need this specified
IF "%ENGINE_KIN%" == "V" GOTO :fullscreen

REM # http://stackoverflow.com/questions/25532444/get-screen-resolution-as-a-variable-in-cmd
REM # note that this will be the 'primary monitor', which may not be desired by some users,
REM # but that's hardly our fault since many ports don't support fullscreen anywhere else anyway
FOR /F %%i IN (
	'wmic path Win32_VideoController get CurrentHorizontalResolution^,CurrentVerticalResolution /value ^| find "="'
) DO SET "%%i"

REM # TODO: how to handle failures here?
ECHO        -width : %CurrentHorizontalResolution%  -height : %CurrentVerticalResolution%

REM # command line parameters for setting screen resolution:
REM # this needs to be combined with fullscreen below, or you'll get a window bigger than the screen!
REM # TODO: get desktop size ("ActiveWorkspace") and use a window size that fills the screen correctly?
SET "SCREENRES=-width %CurrentHorizontalResolution% -height %CurrentVerticalResolution%"

:fullscreen
REM --------------------------------------------------------------------------------------------------------------------
REM # command line parameters for fullscreen:
IF "%ENGINE_KIN%" == "Z" (
	REM # `+fullscreen 1` for ZDoom-based ports
	SET "FULLSCREEN=+fullscreen 1"
) ELSE (
	REM # `-fullscreen` for Chocolate Doom / Crispy Doom, PRBoom+ and DOOM 64 EX
	SET "FULLSCREEN=-fullscreen"
)

REM --------------------------------------------------------------------------------------------------------------------
ECHO:
ECHO    Get Psyched!
ECHO:

REM # if you need to see what the final command will be:
REM ECHO  "doom.bat" /D "%SAVES_WAD%" "%FIX_PATH%\%ENGINE%" %SCREENRES% %FULLSCREEN% %PARAMS% & PAUSE

REM # outputting to console?
REM # (only has an effect on Z-based engines)
IF %CONSOLE% EQU 1 (
	ECHO ===============================================================================
	REM # change to the right save folder for the engine
	PUSHD "%SAVES_WAD%"
	REM # start the engine from this process
	"%FIX_PATH%\%ENGINE%" -stdout %SCREENRES% %FULLSCREEN% %PARAMS%
	REM # when it quits, return to the previous working directory
	POPD
) ELSE (
	REM # check for `/WAIT` option
	IF %WAIT% EQU 1 (
		REM # start the engine but wait here until it quits
		START "doom.bat" /D "%SAVES_WAD%" /WAIT "%FIX_PATH%\%ENGINE%" %SCREENRES% %FULLSCREEN% %PARAMS%
	) ELSE (
		REM # start the engine but continue executing script code
		START "doom.bat" /D "%SAVES_WAD%" "%FIX_PATH%\%ENGINE%" %SCREENRES% %FULLSCREEN% %PARAMS%
	)
)

REM # restore the current directory
POPD
EXIT /B




:find_file_or_fail
REM ====================================================================================================================
CALL :find_file
IF ERRORLEVEL 1 (
	ECHO:
	ECHO  ERROR: The specified file does not exist:
	ECHO:
	ECHO     "%FILE%"
	ECHO:
	REM # if it was not an absolute path, list the places checked
	IF NOT "%FILE:~1,1%" == ":" (
		ECHO  The following locations were checked:
		ECHO:
		IF DEFINED DIR_PREV (
			ECHO 	 "%DIR_PREV%\%~1"
		)
		ECHO 	 "%DIR_CUR%\%~1"
		IF DEFINED DIR_PWAD (
			ECHO 	 "%DIR_PWAD%\%~1"
		)
		IF DEFINED DIR_IWAD (
			ECHO 	 "%DIR_IWAD%\%~1"
		)
		ECHO 	 "%DIR_WADS%\%~1"
		ECHO 	 "%ENGINE_DIR%\%~1"
		ECHO:
	)
	ECHO  Command:
	ECHO:
	ECHO     doom.bat %*
	ECHO:
	POPD
	PAUSE
	EXIT /B 1
)
EXIT /B 0

:find_file
REM ====================================================================================================================
REM # given a `FILE` path, checks possible locations for it:
REM #
REM #    1. the 'previous directory' used, e.g. WADs in the same folder
REM #    2. the 'current directory' that doom.bat was called from
REM #    3. the PWAD's directory, if a PWAD was selected
REM #    4. the IWAD's directory
REM #    5. the base WAD directory
REM #    6. the selected engine's directory
REM #
REM # returns the following ERRORLEVELs
REM # 
REM #    0 = file wad found at one of the locations, `FILE` updated to match
REM #    1 = file not found

REM # is the file path absolute?
IF "%FILE:~1,1%" == ":" (
	REM # check if the file exists at the absolute location
	IF EXIST "%FILE%" EXIT /B 0
	REM # an absolute path file cannot be searched for elsewhere
	GOTO :find_file__missing
)

REM # [1] check 'previous directory'
IF DEFINED DIR_PREV (
	IF EXIST "%DIR_PREV%\%FILE%" (
		SET "FILE=%DIR_PREV%\%FILE%"
		CALL :find_file__rel
		CALL :prev_dir "%DIR_PREV%\%FILE%"
		EXIT /B 0
	)
)

REM # [2] check 'current directory' that doom.bat was called from
IF EXIST "%DIR_CUR%\%FILE%" (
	SET "FILE=%DIR_CUR%\%FILE%"
	CALL :find_file__rel
	CALL :prev_dir "%DIR_CUR%\%FILE%"
	EXIT /B 0
)

REM # [3] check the PWAD's directory if one was specified
IF DEFINED DIR_PWAD (
	IF EXIST "%DIR_PWAD%\%FILE%" (
		SET "FILE=%DIR_PWAD%\%FILE%"
		CALL :find_file__rel
		CALL :prev_dir "%DIR_PWAD%\%FILE%"
		EXIT /B 0
	)
)

REM # [4] check the IWAD's directory (if we've got that far yet)
IF DEFINED DIR_IWAD (
	IF EXIST "%DIR_IWAD%\%FILE%" (
		SET FILE=%DIR_IWAD%\%FILE%
		CALL :find_file__rel
		CALL :prev_dir "%DIR_IWAD%\%FILE%"
		EXIT /B 0
	)
)

REM # [5] check the base WADs directory
IF EXIST "%DIR_WADS%\%FILE%" (
	SET "FILE=%DIR_WADS%\%FILE%"
	CALL :find_file__rel
	CALL :prev_dir "%DIR_WADS%\%FILE%"
	EXIT /B 0
)

REM # [6] check the engine's directory (if we've got that far yet)
IF DEFINED ENGINE_DIR (
	IF EXIST "%ENGINE_DIR%\%FILE%" (
		SET "FILE=%ENGINE_DIR%\%FILE%"
		CALL :find_file__rel
		CALL :prev_dir "%ENGINE_DIR%\%FILE%"
		EXIT /B 0
	)
)

REM # nope, cannot find it
EXIT /B 1

:find_file__rel
REM # if the final path is below this script, clip the path to relative
SETLOCAL ENABLEDELAYEDEXPANSION
SET "FILE=!FILE:%CD%\=!"
ENDLOCAL & SET "FILE=%FILE%"
GOTO:EOF


:reg
REM ====================================================================================================================
REM # a function to read a registry key and account for 32 / 64-bit differences
REM # %1 = registry key | %2 = value name | returns %REG%, containing the value

REM # SUPER IMPORTANT NOTE:
REM # 1. if you are on a 64-bit machine, things get real screwy with the registry --
REM #    a 64-bit process launching this batch script will access the registry as 64-bit,
REM #    meaning that 32-bit keys will not be where you expect them to be!
REM # 2. a 32-bit process launching this batch script will access ONLY the 32-bit registry;
REM #    a secret route (a "sysnative" junction) will allow us to launch the 64-bit version of REG
REM #    from a 32-bit process, granting a 64-bit view of the registry

REM # check the native registry, for a native key:
REM # -- i.e. 32-bit system, accessing 32-bit software keys or
REM #         64-bit system, accessing 64-bit software keys
FOR /F "tokens=2*" %%A IN (
	'REG QUERY "%~1" /V "%~2" 2^>^&1 ^| FIND "REG_"'
) DO (
	SET "REG=%%B"
	GOTO:EOF
)
REM # check 32-bits keys on a 64-bit system & process:
REM # (note: this batch script could be running as a 32-bit or 64-bit process, so we need to forcefully invoke
REM          a 32-bit REG process. on 64-bit Windows, "SYSTEM32" is actually the 64-bit software and is rewritten to
REM          to "WINDOWS\SYSWOW64" where the 32-bit "SYSTEM32" is -- what a confusing mess)
FOR /F "tokens=2*" %%A IN (
	'%WINDIR%\SYSWOW64\REG QUERY "%~1" /V "%~2" 2^>^&1 ^| FIND "REG_"'
) DO (
	SET "REG=%%B"
	GOTO:EOF
)
REM # check 64-bits keys on a 32-bit system or a 32-bit process on a 64-bit system:
REM # thanks goes to https://ovidiupl.wordpress.com/2008/07/11/useful-wow64-file-system-trick/
REM # for the solution to this mess!
FOR /F "tokens=2*" %%A IN (
	'%WINDIR%\SYSNATIVE\REG QUERY "%~1" /V "%~2" 2^>^&1 ^| FIND "REG_"'
) DO (
	SET "REG=%%B"
	GOTO:EOF
)
REM # key not found
SET "REG="
GOTO:EOF