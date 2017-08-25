@ECHO OFF & SETLOCAL ENABLEEXTENSIONS DISABLEDELAYEDEXPANSION

REM # doom batch launcher - (c) copyright Kroc Camen 2016-2017

REM # features:
REM # - automatic portable config files so that you get the same configuration (per-engine) everywhere
REM # - searches GOG & Steam installs if WAD is missing
REM # - FreeDOOM substituted if commercial DOOM.WAD / DOOM2.WAD missing
REM # - will search the engine's folder for WADs if not found elsewhere
REM # - WAD file extensions can be omitted (".wad" / ".pk3" / ".pk7")
REM # - DeHackEd extension loading (".deh", ".bex" files)
REM # - files are checked to exist before being passed on to the engine
REM # - arbitrary parameters can be passed on to the engine
REM # - launches the engine in the native resolution of the current machine (portable)
REM # - coloured usage text in Windows 10

REM # todo:
REM # - option to launch windowed -- will need to choose reasonable window size
REM # - Heretic, Hexen & Strife sharewares & GOG/Steam detection

REM # default folder names
SET "CONFIGS=config"
SET "IWADS=iwads"
SET "PWADS=pwads"
SET "PORTS=ports"
SET "SAVES=saves"


:esc
REM ====================================================================================================================
REM # escape codes are supported in Windows 10; support in this script made possible by:
REM # https://gist.github.com/mlocati/fdabcaeb8071d5c75a2d51712db24011#file-win10colors-cmd

REM # split the Windows version string and look for the number
FOR /F "tokens=4-5 delims=. " %%V IN ('VER') DO SET WINVER=%%V.%%W
REM # TODO: 10, and above?
IF NOT "%WINVER%" == "10.0" GOTO :esc_none

REM --------------------------------------------------------------------------------------------------------------------
REM # !IMPORTANT! THIS IS AN 0x1B BYTE!
REM # many editors may display a space or nothing at all!
SET "X1B="
REM # escape code opening sequence
SET "ESC=%X1B%["
REM # resets a previous escape, e.g. underline off
SET "ESC_OFF=%ESC%0m"

REM # these are the escape code sequences for various effects;
REM # use an opening escape code (`%ESC%`), one of the following, and "m" to terminate.
REM # multiple effects can be combined by separating these with ";", for example:
REM # `%ESC%%ESC_U%;%ESC_FGRD%m...your text...%ESC_OFF%`
SET "ESC_B=1"           & REM # bold
SET "ESC_U=4"           & REM # underline
SET "ESC_I=7"           & REM # inverse
SET "ESC_FGBK=30"       & REM # "foreground black"
SET "ESC_FGRD=31"       & REM # "foreground red"
SET "ESC_FGGN=32"       & REM # "foregorund green"
SET "ESC_FGYW=33"       & REM # "foreground yellow"
SET "ESC_FGBL=34"       & REM # "foreground blue"
SET "ESC_FGMG=35"       & REM # "foreground magenta"
SET "ESC_FGCY=36"       & REM # "foreground cyan"
SET "ESC_FGWH=37"       & REM # "foreground white" (grey)
SET "ESC_FGBBK=90"      & REM # "foreground bright-black" (dark grey)
SET "ESC_FGBRD=91"      & REM # "foreground bright-red"
SET "ESC_FGBGN=92"      & REM # "foreground bright-green"
SET "ESC_FGBYW=93"      & REM # "foreground bright-yellow"
SET "ESC_FGBBL=94"      & REM # "foreground bright-blue"
SET "ESC_FGBMG=95"      & REM # "foreground bright-magenta"
SET "ESC_FGBCY=96"      & REM # "foreground bright-cyan"
SET "ESC_FGBWH=97"      & REM # "foreground bright-white"

REM # build some common styles for use by doom.bat
SET "_=%ESC_OFF%"                       & REM # shorthand for the escape reset sequence
SET "_HEADING_=%ESC%%ESC_B%;%ESC_U%m"
SET "_MISC_=%ESC%%ESC_FGBBK%m"
SET "_OPTIONS_=%ESC%%ESC_FGBYW%m"
SET "_ENGINE_=%ESC%%ESC_FGBMG%m"
SET "_IWAD_=%ESC%%ESC_FGBRD%m"
SET "_PWAD_=%ESC%%ESC_FGBGN%m"
SET "_PARAMS_=%ESC%%ESC_FGBBL%m"
SET "_--_=%ESC%%ESC_FGCY%m--%ESC_OFF%"  & REM # The 'stop processing switches' mark "--"
SET "_FILES_=%ESC%%ESC_FGBCY%m"         & REM # anything in the files list
SET "_FDIR_=%ESC%%ESC_FGCY%m"           & REM # a directory command in the files list

GOTO :usage

:esc_none
REM # not Windows 10, set all these to nullstrings
SET "X1B="   & SET "ESC="   & SET "ESC_OFF="
SET "ESC_B=" & SET "ESC_U=" & SET "ESC_I="
SET "ESC_FGBK="  & SET "ESC_FGRD="  & SET "ESC_FGGN="  & SET "ESC_FGYW=" 
SET "ESC_FGBL="  & SET "ESC_FGMG="  & SET "ESC_FGCY="  & SET "ESC_FGWH="
SET "ESC_FGBBK=" & SET "ESC_FGBRD=" & SET "ESC_FGBGN=" & SET "ESC_FGBYW=" 
SET "ESC_FGBBL=" & SET "ESC_FGBMG=" & SET "ESC_FGBCY=" & SET "ESC_FGBWH="

SET "_="
SET "_HEADING_="
SET "_MISC_=" & SET "_OPTIONS_=" & SET "_ENGINE_=" & SET "_IWAD_=" & SET "_PWAD_=" & SET "_PARAMS_="
SET "_--_=" & SET "_FILES_=" & SET "_FDIR_="


:usage
REM ====================================================================================================================
REM # if no command line parameters are given, show the instructions

REM # create the usage format string (coloured on Windows 10)
SET "USAGE=%_MISC_%doom.bat%_%"
SET "USAGE=%USAGE% %_MISC_%[%_%%_OPTIONS_%options%_%%_MISC_%]%_%"
SET "USAGE=%USAGE% %_MISC_%[%_%%_ENGINE_%engine%_%%_MISC_%]%_%"
SET "USAGE=%USAGE% %_MISC_%[%_%"
SET     "USAGE=%USAGE%%_IWAD_%IWAD%_%"
SET     "USAGE=%USAGE% %_MISC_%[%_%%_PWAD_%PWAD%_%%_MISC_%]%_%"
SET     "USAGE=%USAGE% %_MISC_%[%_%%_PARAMS_%params%_%%_MISC_%]%_%"
SET     "USAGE=%USAGE% %_MISC_%[%_% %_--_% %_FILES_%files%_%%_MISC_%...]%_%
SET "USAGE=%USAGE%%_MISC_%]%_%"

IF "%~1" == "" (
        ECHO:
        ECHO  "doom.bat" is a command-line launcher for DOOM-based games.
        ECHO  It makes it easier to create shortcuts to run a particular
        ECHO  source-port with a particular WAD and particular mods etc.
        ECHO:
        ECHO %_HEADING_%Usage:%_%
	REM ---------------------------------------------------------------------------------
        ECHO:
        ECHO     %USAGE%
        ECHO:
        ECHO %_HEADING_%Example:%_%
	REM ---------------------------------------------------------------------------------
        ECHO:
        ECHO     %_MISC_%doom.bat%_% %_ENGINE_%gzdoom%_% %_IWAD_%DOOM2%_% %_--_% %_FILES_%brutalv20b.pk3%_%
        ECHO:
	ECHO %_HEADING_%Options:%_%
	REM ---------------------------------------------------------------------------------
	ECHO:
	ECHO    %_OPTIONS_%/WAIT%_%                : Causes doom.bat to not immediately return once the
	ECHO                           engine is launched. Script execution will continue
	ECHO                           only once the engine has quit
	ECHO:
	ECHO    %_OPTIONS_%/CONSOLE%_%             : Causes the output of the engine to be echoed to the
	ECHO                           console. This implies %_OPTIONS_%/WAIT%_%. Works only with Z-based
	ECHO                           engines: QZDoom, GZDoom, ZDoom and Zandronum
	ECHO:
	ECHO    %_OPTIONS_%/DEFAULT%_%             : Loads the engine with the default config file instead
	ECHO                           of the current user config file. Any changes you make
	ECHO                           to the engine's settings will be saved in the default
	ECHO                           configuration file
	ECHO:
	ECHO    %_OPTIONS_%/32%_%                  : Always use 32-bit binaries, even on a 64-bit system
	ECHO:
        ECHO %_HEADING_%Engines:%_%
	REM ---------------------------------------------------------------------------------
        ECHO:		
	ECHO     %_ENGINE_%choco-doom%_%          : ChocolateDOOM ^(very vanilla, 320x200^)
        ECHO     %_ENGINE_%choco-doom-setup%_%    : Displays ChocolateDOOM's configuration program first
        ECHO     %_ENGINE_%choco-heretic%_%       : As with choco-doom, but for Heretic WADs
        ECHO     %_ENGINE_%choco-heretic-setup%_% : As above, but displays configuration first
        ECHO     %_ENGINE_%choco-hexen%_%         : As with choco-doom, but for Hexen WADs
        ECHO     %_ENGINE_%choco-hexen-setup%_%   : As above, but displays configuration first
        ECHO     %_ENGINE_%choco-strife%_%        : As with choco-doom, but for Strife WADs
        ECHO     %_ENGINE_%choco-strife-setup%_%  : As above, but displays configuration first
        ECHO     %_ENGINE_%doom64ex%_%            : DOOM 64 EX, specifically for DOOM 64
	ECHO     %_ENGINE_%glboom%_%              : PRBoom+ ^(OpenGL renderer^)
        ECHO     %_ENGINE_%gzdoom%_%              : GZDoom current
	ECHO     %_ENGINE_%gzdoom-??%_%           : Where ?? is "22", "23", "24" or "31"
	ECHO     %_ENGINE_%prboom%_%              : PRBoom+ ^(software renderer^)
        ECHO     %_ENGINE_%zdoom%_%               : ZDoom
        ECHO     %_ENGINE_%zandronum%_%           : Zandronum current ^(2.x^)
	ECHO     %_ENGINE_%zandronum-?%_%         : Where ? is "2" or "3"
        ECHO:
        ECHO %_HEADING_%IWAD:%_%
	REM ---------------------------------------------------------------------------------
        ECHO:
        ECHO     The IWAD ^(Internal WAD^) is the base WAD to use. This will be one of the
        ECHO     original game's WAD files which maps, mods and total conversions extend.
        ECHO     If uncertain, use "DOOM2", it's the most common one used for community
        ECHO     content. The ".WAD" / ".PK3" extension can be ommitted.
        ECHO:
        ECHO     IWADs are located in the "%IWADS%" folder.
	ECHO:
	ECHO     %_HEADING_%Steam ^& GOG:%_%
	ECHO:
	ECHO     If "DOOM.WAD", "DOOM2.WAD", "TNT.WAD" or "PLUTONIA.WAD" are specified but
	ECHO     cannot be found in the "%IWADS%" folder, doom.bat will try to locate them
	ECHO     automatically for you in any relevant Steam or GOG installations:
	ECHO:
	ECHO             Steam : The Ultimate DOOM     - DOOM.WAD
	ECHO             Steam : DOOM II               - DOOM2.WAD
	ECHO             Steam : Final DOOM            - TNT.WAD ^& PLUTONIA.WAD
	ECHO             Steam : DOOM Classic Complete - ^(all of the above^)
	ECHO       GOG / Steam : DOOM 3 BFG Edition    - DOOM.WAD ^& DOOM2.WAD
	ECHO               GOG : The Ultimate DOOM     - DOOM.WAD
	ECHO               GOG : DOOM II + Final DOOM  - DOOM2.WAD, TNT.WAD ^& PLUTONIA.WAD 
        ECHO:
	ECHO     %_HEADING_%Shareware:%_%
	ECHO:
	ECHO     If the IWAD is "DOOM" and no PWAD is specified ^(see below^), i.e. you are
	ECHO     trying to play the the original DOOM rather than a user-map, and "DOOM.WAD"
	ECHO     cannot be found ^(inclduing in Steam or GOG, above^) then the DOOM shareware
	ECHO     will be used instead which is limited to the first episode.
        ECHO:
        ECHO %_HEADING_%PWAD:%_%
	REM ---------------------------------------------------------------------------------
        ECHO:
        ECHO     The PWAD ^(patch-WAD^) is the community map / megawad you want to play.
        ECHO     These are assumed to be in the "%PWADS%" folder, not "%IWADS%".
        ECHO     E.g.
        ECHO:
        ECHO            %_MISC_%doom.bat%_% %_ENGINE_%gzdoom%_% %_IWAD_%DOOM2%_% %_PWAD_%wolfendoom.pk3%_%
        ECHO:
        ECHO     If you just want to play an original game ^(e.g. DOOM, Hexen^) then the PWAD
        ECHO     is not required. The ".PK3" / ".PK7" / ".WAD" extension can be omitted but
        ECHO     if two files exist with the same name but different extensions then the
        ECHO     first file will be chosen using the order of extensions just mentioned.
	ECHO:
	ECHO     %_HEADING_%Steam ^& GOG:%_%
	ECHO:    
	ECHO     If "NERVE.WAD" or any of the "Master Levels for DOOM II" ^("MASTER\*.WAD"^)
	ECHO     are specified as the PWAD and cannot be found in the "%PWADS%" folder,
	ECHO     doom.bat will try to locate them for you in any relevant Steam or GOG
	ECHO     installations:
	ECHO:
	ECHO       GOG / Steam : DOOM 3 BFG Edition    - NERVE.WAD
	ECHO             Steam : DOOM Classic Complete - Master Levels for DOOM II
	ECHO               GOG : DOOM II + Final DOOM  - Master Levels for DOOM II
	ECHO:
	ECHO     %_HEADING_%FreeDOOM:%_%
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
        ECHO %_HEADING_%Params:%_%
	REM ---------------------------------------------------------------------------------
        ECHO:
        ECHO     You can include any command line parameters here and they will be
        ECHO     passed on to the engine. Example:
        ECHO:
        ECHO            %_MISC_%doom.bat%_% %_ENGINE_%choco-doom%_% %_IWAD_%DOOM2%_% %_PARAMS_%-warp 21%_%
        ECHO:
        ECHO     Note that what parameters are supported will vary between engines.
        ECHO:
        ECHO %_HEADING_%Files:%_%
	REM ---------------------------------------------------------------------------------
        ECHO:
	ECHO     NOTE: The "--" is required to separate the parameters from the list
        ECHO     of files.
        ECHO:
        ECHO     A list of additional files to include ^(from the "%PWADS%" directory^).
        ECHO     Unlike when creating Windows shortcuts, the "%PWADS%" folder is assumed,
        ECHO     so that you don't need to include the base path on each file added.
	ECHO:
	ECHO     If a PWAD has been given, that file's folder will also be checked so that
	ECHO     you do not have to give the path for both the PWAD, and any files within
	ECHO     the same folder. E.g.
	ECHO:
	ECHO		%_MISC_%doom.bat%_% %_ENGINE_%zdoom%_% %_IWAD_%DOOM2%_% %_PWAD_%doomrl_arsenal\doomrl_arsenal.wad%_%
	ECHO                                          %_--_% %_FILES_%doomrl_arsenal_hud.wad%_%
        ECHO:
        ECHO     The ".PK3" / ".PK7" / ".WAD" extension can be omitted but if two files
        ECHO     exist with the same name but different extensions then the first file
        ECHO     will be chosen using the order of extensions just mentioned.
	ECHO:
	ECHO     After one file is included, the same folder will be checked for the
	ECHO     next file. This is handy for including multiple WADs located in the
	ECHO     same folder, e.g.
	ECHO:
	ECHO		%_MISC_%doom.bat%_% %_ENGINE_%gzdoom%_% %_IWAD_%DOOM2%_% %_--_% %_FILES_%BrutalDoom\Brutalv20b.pk3 ExtraTextures.wad%_%
	ECHO:
	ECHO     Where "ExtraTextures.wad" is in the "BrutalDoom" folder, and if it isn't
	ECHO     the base "%PWADS%" folder will be checked and then the engine's folder.
        ECHO:
        ECHO     DeHackEd extensions ^(".deh" / ".bex"^) can be included in the files list,
        ECHO     and will be loaded using the correct "-deh" or "-bex" engine parameter.
        ECHO:
	ECHO %_HEADING_%Config File:%_%
	ECHO:
	ECHO     For portability doom.bat has default configuration files for each engine
	ECHO     which will be copied to the save folder for that engine when one does not
	ECHO     exist. doom.bat automatically launches the engine with this portable config
	ECHO     file so that your settings are used regardless of which machine you use.
	ECHO:
	ECHO     if a %_PARAMS_%-config%_% parameter has already been given then that config file will
	ECHO     be used as intended and doom.bat will not supply its own.
	
        ECHO:
        ECHO %_HEADING_%Savegames:%_%
        ECHO:
        ECHO     Savegames are not saved alongside the engine as is default, but rather
        ECHO     in a "%SAVES%" folder. To prevent incompatibilites and potential data-loss
        ECHO     between engines, savegames are first separated by engine ^("gzdoom" /
        ECHO     "zandronum" etc.^) and then by the PWAD name ^(or IWAD name if no PWAD
        ECHO     is specified^). I.e. for the command:
        ECHO:
        ECHO            %_MISC_%doom.bat%_% %_ENGINE_%zdoom%_% %_IWAD_%DOOM2%_% %_PWAD_%breach.wad%_%
        ECHO:
        ECHO     the savegames will be located in "%SAVES%\zdoom\breach\".
        
        ECHO %ESC_OFF%
        PAUSE & EXIT /B 0
)

REM ====================================================================================================================

CLS
ECHO:
ECHO      doom.bat
ECHO:

REM # remember the current directory before we change it;
REM # this will be used as an additional search location for finding PWADs
SET "OLD_DIR=%CD%"

REM # change current directory to that of this script;
REM # ensures that shortcuts to this script don't end up looking elsewhere for files
PUSHD "%~dp0"

REM # if the directory this script was called from is somewhere within
REM # the same heirarchy of this script, make the folder path relative
SETLOCAL ENABLEDELAYEDEXPANSION
SET "OLD_DIR=!OLD_DIR:%CD%\=!"
ENDLOCAL & SET "OLD_DIR=%OLD_DIR%"

REM # NOTE: many doom engines save their config files in the 'current directory', which is typically expected to be
REM # that of the executable. However, we want to separate user-data (such as savegames) from the engines. whilst we
REM # can change the save directory, config files will still be dumped in the 'current directory', which in the case
REM # of this script, will be right here! We therefore need to change the current directory and rewrite all the WAD /
REM # file paths to be relative from there!

REM # the saves folder will contain a sub-folder for each engine, and then another sub-folder for the IWAD or PWAD;
REM # this is the relative path from the WAD's save folder back to this script
SET "FIX_PATH=..\..\.."

REM # this is where we'll build up the entire parameter string for the engine
SET "PARAMS="
REM # if a config file is provided in the parameters ("-config ..."),
REM # then it overrides the use of the user config files
SET HAS_CONFIG=0

REM # detect 32-bit or 64-bit Windows for those engines that provide both
SET WINBIT=32
IF /I "%PROCESSOR_ARCHITECTURE%" == "EM64T" SET WINBIT=64	& REM # Itanium
IF /I "%PROCESSOR_ARCHITECTURE%" == "AMD64" SET WINBIT=64	& REM # Regular x64
IF /I "%PROCESSOR_ARCHITEW6432%" == "AMD64" SET WINBIT=64	& REM # 32-bit CMD on a 64-bit system (WOW64)

REM # default option values:
SET CONSOLE=0
SET DEFAULT=0
SET WAIT=0


:options
REM ====================================================================================================================
REM # echo engine output to the console
IF /I "%~1" == "/CONSOLE" (
	REM # set the feature flag, the launch section will handle it
	SET CONSOLE=1
	REM # check for any other options
	SHIFT & GOTO :options
)

REM # use default config?
IF /I "%~1" == "/DEFAULT" (
	REM # we only need to enable the flag to indicate it,
	REM # the config section will handle the specifics
	SET DEFAULT=1
	REM # check for any other options
	SHIFT & GOTO :options
)

REM # wait for engine before continuing execution
IF /I "%~1" == "/WAIT" (
	REM # set the feature flag, the launch section will handle it
	SET WAIT=1
	REM # check for any other options
	SHIFT & GOTO :options
)

REM # always use 32-bit binaries on a 64-bit system?
IF /I "%~1" == "/32" (
	REM # force this script to believe the system is 32-bit
	SET WINBIT=32
	REM # check for any other options
	SHIFT & GOTO :options
)


:ports
REM ====================================================================================================================
REM # reserve some variables:
SET "ENGINE_DIR="	& REM # the engine directory is also used to check for PWADs
SET "ENGINE_EXE="	& REM # executable name in the engine folder

IF %WINBIT% EQU 32 SET "ENGINE_BIT=x86"
IF %WINBIT% EQU 64 SET "ENGINE_BIT=x64"

REM # an identifier for config files used for an engine,
REM # i.e. "zdoom" is expanded to "config.zdoom.ini"
SET "ENGINE_CFG="

REM # engines are grouped together by common behaviour determined by their heritage;
REM # we use this to handle differences in command line parameters for engines.
REM # - V = vanilla engine; uses DSG save format. chocolate-doom fits this
REM # - B = Boom engine; compatible with the features added by boom. prboom+ (and above). DSG saves
REM # - X = Kex engine -- DOOM 64 EX. Parameters are like Vanilla and Boom. DSG saves
REM # - Z = ZDoom engine; derived from ZDoom, i.e. ZDoom, GZDoom and Zandronum. ZDS saves
SET "ENGINE_KIN="

REM # the engine's folder within the "saves" folder; it's the place for the user's config file for that engine
REM # (variable left empty to begin with so as to detect the absence of the engine parameter)
SET "PORT_SAVE="

IF /I "%~1" == "choco-doom" (
	REM ------------------------------------------------------------------------------------------------------------
        SET "ENGINE_DIR=%PORTS%\chocolate-doom"
        SET "ENGINE_EXE=chocolate-doom.exe"
	SET "ENGINE_CFG=choco-doom"
	SET "ENGINE_KIN=V"
        SET "PORT_SAVE=choco-doom"
        ECHO          port : chocolate doom
)
IF /I "%~1" == "choco-doom-setup" (
	REM ------------------------------------------------------------------------------------------------------------
        SET "ENGINE_DIR=%PORTS%\chocolate-doom"
        SET "ENGINE_EXE=chocolate-doom-setup.exe"
	SET "ENGINE_CFG=choco-doom"
	SET "ENGINE_KIN=V"
        SET "PORT_SAVE=choco-doom"
        ECHO          port : chocolate doom ^(setup^)
)
IF /I "%~1" == "choco-heretic" (
	REM ------------------------------------------------------------------------------------------------------------
        SET "ENGINE_DIR=%PORTS%\chocolate-heretic"
        SET "ENGINE_EXE=chocolate-heretic.exe"
	SET "ENGINE_CFG=choco-heretic"
	SET "ENGINE_KIN=V"
        SET "PORT_SAVE=choco-heretic"
        ECHO          port : chocolate heretic
)
IF /I "%~1" == "choco-heretic-setup" (
	REM ------------------------------------------------------------------------------------------------------------
        SET "ENGINE_DIR=%PORTS%\chocolate-heretic"
        SET "ENGINE_EXE=chocolate-heretic-setup.exe"
	SET "ENGINE_CFG=choco-doom"
	SET "ENGINE_KIN=V"
        SET "PORT_SAVE=choco-heretic"
        ECHO          port : chocolate heretic ^(setup^)
)
IF /I "%~1" == "choco-hexen" (
	REM ------------------------------------------------------------------------------------------------------------
        SET "ENGINE_DIR=%PORTS%\chocolate-hexen"
        SET "ENGINE_EXE=chocolate-hexen.exe"
	SET "ENGINE_CFG=choco-hexen"
	SET "ENGINE_KIN=V"
        SET "PORT_SAVE=choco-hexen"
        ECHO          port : chocolate hexen
)
IF /I "%~1" == "choco-hexen-setup" (
	REM ------------------------------------------------------------------------------------------------------------
        SET "ENGINE_DIR=%PORTS%\chocolate-hexen"
        SET "ENGINE_EXE=chocolate-hexen-setup.exe"
	SET "ENGINE_CFG=choco-hexen"
	SET "ENGINE_KIN=V"
        SET "PORT_SAVE=choco-hexen"
        ECHO          port : chocolate hexen ^(setup^)
)
IF /I "%~1" == "choco-strife" (
	REM ------------------------------------------------------------------------------------------------------------
        SET "ENGINE_DIR=%PORTS%\chocolate-strife"
        SET "ENGINE_EXE=chocolate-strife.exe"
	SET "ENGINE_CFG=choco-strife"
	SET "ENGINE_KIN=V"
        SET "PORT_SAVE=choco-strife"
        ECHO          port : chocolate strife
)
IF /I "%~1" == "choco-strife-setup" (
	REM ------------------------------------------------------------------------------------------------------------
        SET "ENGINE_DIR=%PORTS%\chocolate-strife"
        SET "ENGINE_EXE=chocolate-strife-setup.exe"
	SET "ENGINE_CFG=choco-strife"
	SET "ENGINE_KIN=V"
        SET "PORT_SAVE=choco-strife"
        ECHO          port : chocolate strife ^(setup^)
)
IF /I "%~1" == "doom64ex" (
	REM ------------------------------------------------------------------------------------------------------------
        SET "ENGINE_DIR=%PORTS%\doom64ex"
        SET "ENGINE_EXE=DOOM64.exe"
	SET "ENGINE_CFG=doom64ex"
	SET "ENGINE_KIN=X"
        SET "PORT_SAVE=doom64ex"
        ECHO          port : DOOM 64 EX
)
IF /I "%~1" == "glboom" (
	REM ------------------------------------------------------------------------------------------------------------
        SET "ENGINE_DIR=%PORTS%\prboom+"
        SET "ENGINE_EXE=glboom-plus.exe"
	SET "ENGINE_CFG=glboom-plus"
	SET "ENGINE_KIN=B"
        SET "PORT_SAVE=prboom"
        ECHO          port : prboom+ ^(OpenGL renderer^)
)
IF /I "%~1" == "gzdoom" (
	REM ------------------------------------------------------------------------------------------------------------
	SET "ENGINE_DIR=%PORTS%\gzdoom-31_%ENGINE_BIT%"
        SET "ENGINE_EXE=gzdoom.exe"
	SET "ENGINE_CFG=gzdoom"
	SET "ENGINE_KIN=Z"
        SET "PORT_SAVE=gzdoom"
        ECHO          port : gzdoom ^(current^)
)
IF /I "%~1" == "gzdoom-31" (
	REM ------------------------------------------------------------------------------------------------------------
	SET "ENGINE_DIR=%PORTS%\gzdoom-31_%ENGINE_BIT%"
        SET "ENGINE_EXE=gzdoom.exe"
	SET "ENGINE_CFG=gzdoom"
	SET "ENGINE_KIN=Z"
        SET "PORT_SAVE=gzdoom"
        ECHO          port : gzdoom ^(v3.1.x^)
)
IF /I "%~1" == "gzdoom-24" (
	REM ------------------------------------------------------------------------------------------------------------
	SET "ENGINE_DIR=%PORTS%\gzdoom-24_%ENGINE_BIT%"
        SET "ENGINE_EXE=gzdoom.exe"
	SET "ENGINE_CFG=gzdoom"
	SET "ENGINE_KIN=Z"
        SET "PORT_SAVE=gzdoom"
        ECHO          port : gzdoom ^(v2.4.x^)
)
IF /I "%~1" == "gzdoom-23" (
	REM ------------------------------------------------------------------------------------------------------------
	SET "ENGINE_DIR=%PORTS%\gzdoom-23_%ENGINE_BIT%"
        SET "ENGINE_EXE=gzdoom.exe"
	SET "ENGINE_CFG=gzdoom"
	SET "ENGINE_KIN=Z"
        SET "PORT_SAVE=gzdoom"
        ECHO          port : gzdoom ^(v2.3.x^)
)
IF /I "%~1" == "gzdoom-22" (
	REM ------------------------------------------------------------------------------------------------------------
	SET "ENGINE_DIR=%PORTS%\gzdoom-22_%ENGINE_BIT%"
        SET "ENGINE_EXE=gzdoom.exe"
	SET "ENGINE_CFG=gzdoom"
	SET "ENGINE_KIN=Z"
        SET "PORT_SAVE=gzdoom"
        ECHO          port : gzdoom ^(v2.2.x^)
)
IF /I "%~1" == "gzdoom-dev" (
	REM ------------------------------------------------------------------------------------------------------------
        REM # shh, this is a secret...
        REM # (but you'll have to supply your own copy)
        SET "ENGINE_DIR=%PORTS%\gzdoom-dev"
        SET "ENGINE_EXE=gzdoom.exe"
	SET "ENGINE_CFG=gzdoom"
	SET "ENGINE_KIN=Z"
        SET "PORT_SAVE=gzdoom"
        ECHO          port : gzdoom ^(development^)
)
IF /I "%~1" == "prboom" (
	REM ------------------------------------------------------------------------------------------------------------
        SET "ENGINE_DIR=%PORTS%\prboom+"
        SET "ENGINE_EXE=prboom-plus.exe"
	SET "ENGINE_CFG=prboom-plus"
	SET "ENGINE_KIN=B"
        SET "PORT_SAVE=prboom"
        ECHO          port : prboom+ ^(software renderer^)
)
IF /I "%~1" == "qzdoom" (
	REM ------------------------------------------------------------------------------------------------------------
	SET "ENGINE_DIR=%PORTS%\qzdoom_%ENGINE_BIT%"
	REM # shh, this is a secret...
        REM # (but you'll have to supply your own copy)
        SET "ENGINE_EXE=qzdoom.exe"
	SET "ENGINE_CFG=qzdoom"
	SET "ENGINE_KIN=Z"
        SET "PORT_SAVE=qzdoom"
        ECHO          port : qzdoom
)
IF /I "%~1" == "zandronum" (
	REM ------------------------------------------------------------------------------------------------------------
        SET "ENGINE_DIR=%PORTS%\zandronum-3"
        SET "ENGINE_EXE=zandronum.exe"
	SET "ENGINE_CFG=zandronum-3"
	SET "ENGINE_KIN=Z"
        SET "PORT_SAVE=zandronum"
        ECHO          port : zandronum ^(current^)
)
IF /I "%~1" == "zandronum-2" (
	REM ------------------------------------------------------------------------------------------------------------
        SET "ENGINE_DIR=%PORTS%\zandronum-2"
        SET "ENGINE_EXE=zandronum.exe"
	SET "ENGINE_CFG=zandronum-2"
	SET "ENGINE_KIN=Z"
        SET "PORT_SAVE=zandronum"
        ECHO          port : zandronum ^(v2.x^)
)
IF /I "%~1" == "zandronum-3" (
	REM ------------------------------------------------------------------------------------------------------------
        SET "ENGINE_DIR=%PORTS%\zandronum-3"
        SET "ENGINE_EXE=zandronum.exe"
	SET "ENGINE_CFG=zandronum-3"
	SET "ENGINE_KIN=Z"
        SET "PORT_SAVE=zandronum"
        ECHO          port : zandronum ^(v3.x^)
)
IF /I "%~1" == "zdoom" (
	REM ------------------------------------------------------------------------------------------------------------
        SET "ENGINE_DIR=%PORTS%\zdoom"
        SET "ENGINE_EXE=zdoom.exe"
	SET "ENGINE_CFG=zdoom"
	SET "ENGINE_KIN=Z"
        SET "PORT_SAVE=zdoom"
        ECHO          port : zdoom
)
IF /I "%~1" == "zdoom-dev" (
	REM ------------------------------------------------------------------------------------------------------------
	SET "ENGINE_DIR=%PORTS%\zdoom-dev_%ENGINE_BIT%"
        SET "ENGINE_EXE=zdoom.exe"
	SET "ENGINE_CFG=zdoom"
	SET "ENGINE_KIN=Z"
        SET "PORT_SAVE=zdoom"
        ECHO          port : zdoom ^(development^)
)

REM # no engine specified? use default
IF "%PORT_SAVE%" == "" (        
	SET "ENGINE_DIR=%PORTS%\gzdoom-31_%ENGINE_BIT%"
	SET "ENGINE_EXE=gzdoom.exe"
	SET "ENGINE_CFG=gzdoom"
	SET "ENGINE_KIN=Z"
        SET "PORT_SAVE=gzdoom"
        ECHO          port : gzdoom ^(default^)
) ELSE (
        REM # the engine parameter can be discarded
        SHIFT
)

SET "ENGINE=%ENGINE_DIR%\%ENGINE_EXE%"
ECHO        engine : %ENGINE%


REM # IWAD & PWAD:
REM ====================================================================================================================
REM # the save directory is based on the IWAD or PWAD.
REM # we default to DOOM2
SET "IWAD=DOOM2.WAD"
SET "SAVE_WAD=DOOM2"
SET "PWAD="

REM # remember the directory of the last file
REM # (used for finding side-by-side WADs)
SET "PREV_DIR="

REM # read the IWAD first; the interpretation of the PWAD will depend upon the IWAD:

REM # if no IWAD given, assume the default;
REM # you cannot have a PWAD without an IWAD
IF "%~1" == "" GOTO :iwad
IF "%~1" == "--" GOTO :iwad
REM # if parameter begins with "-", "+" or "/" then it's an engine param, not an IWAD,
REM # but we still need to validate the default IWAD
SET "NEXT=%~1"
IF "%NEXT:~0,1%" == "-" GOTO :iwad
IF "%NEXT:~0,1%" == "+" GOTO :iwad
IF "%NEXT:~0,1%" == "/" GOTO :iwad

REM # the IWAD can be a PK3 file only if the PK3 file contains full game resources (e.g. "doom_complete.pk3").
REM # unless a PWAD is provided, the IWAD name (sans-extension) will be used for the savegames folder
SET "IWAD=%~1"
SET "IWAD_EXT=%~x1"	& REM # remember the file extension (if any) for later
SET "SAVE_WAD=%~n1"	& REM # the save games will be separated by IWAD/PWAD names

REM # we delay checking the IWAD exists until we know the PWAD
REM # -- if playing DOOM without a PWAD, we can offer the DOOM shareware instead of FreeDOOM

REM # move to the next parameter
SHIFT
GOTO :pwad


:reg
REM --------------------------------------------------------------------------------------------------------------------
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


:pwad
REM ====================================================================================================================

REM # if no PWAD given, continue and validate the IWAD
IF "%~1" == ""   GOTO :iwad
IF "%~1" == "--" GOTO :iwad
REM # if parameter begins with "-", "+" or "/" then it's an engine param, not a PWAD,
REM # but we will still need to validate the IWAD
SET "NEXT=%~1"
IF "%NEXT:~0,1%" == "-" GOTO :iwad
IF "%NEXT:~0,1%" == "+" GOTO :iwad
IF "%NEXT:~0,1%" == "/" GOTO :iwad

REM --------------------------------------------------------------------------------------------------------------------

REM # read the PWAD parameter
SET "PWAD=%~1"
SET "SAVE_WAD=%~n1"
SHIFT

REM # has the PWAD file extension been omitted?
IF NOT "%~x1" == "" GOTO :pwad_check

REM # check if a WAD version exists
IF EXIST "%PWADS%\%~1.wad" SET "PWAD=%~1.wad"
REM # check if a PK7 version exists
IF EXIST "%PWADS%\%~1.pk7" SET "PWAD=%~1.pk7"
REM # check if a PK3 version exists
REM # (PK7s are slower and more resource-intensive,
REM #  so if a user converts these to PK3, we want to prefer those)
IF EXIST "%PWADS%\%~1.pk3" SET "PWAD=%~1.pk3"

REM # if none of those are found, default to a ".WAD" extension for the Steam / GOG search
If "%PWAD%" == "%~1" SET "PWAD=%~1.wad"

:pwad_check
REM --------------------------------------------------------------------------------------------------------------------
REM # if the PWAD exists go validate the IWAD, as the action taken when the IWAD is missing is affected by the presence
REM # of a PWAD. if the PWAD is missing, the next section searches for known Steam / GOG PWADs

SET "PWAD_PATH=%PWADS%\%PWAD%"
IF EXIST "%PWAD_PATH%" GOTO :iwad

SET "PWAD_PATH=%OLD_DIR%\%PWAD%"
IF EXIST "%PWAD_PATH%" GOTO :iwad

:pwad_nerve
REM --------------------------------------------------------------------------------------------------------------------
REM # are we looking for "No Rest for the Living"?
IF /I NOT "%PWAD%" == "NERVE.WAD" GOTO :pwad_master
	
REM # is Steam : DOOM 3 BFG Edition installed?
CALL :reg "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 208200" "InstallLocation"
IF NOT "%REG%" == "" (
	REM # check if NERVE.WAD can be found there
	IF EXIST "%REG%\base\wads\NERVE.WAD" SET "PWAD_PATH=%REG%\base\wads\NERVE.WAD" & GOTO :iwad
)
REM # is GOG : DOOM 3 BFG Edition installed?
CALL :reg "HKLM\SOFTWARE\GOG.com\Games\1135892318" "Path"
IF NOT "%REG%" == "" (
	REM # check if NERVE.WAD can be found there
	IF EXIST "%REG%\base\wads\NERVE.WAD" SET "PWAD_PATH=%REG%\base\wads\NERVE.WAD" & GOTO :iwad
)
REM # if the WAD was not found, we cannot continue, the user does not have NERVE.WAD
IF "%PWAD_PATH%" == "" (
	ECHO:
	ECHO   ERROR: "NERVE.WAD" missing:
	ECHO:
	ECHO   You must purchase "DOOM 3: BFG Edition" from Steam to get NERVE.WAD.
	ECHO   doom.bat automatically finds it, if installed. If you have NERVE.WAD
	ECHO   elsewhere, copy it to the "%IWADS%" folder and try again.
	ECHO:
	POPD
	PAUSE
	EXIT /B 1
)
REM # PWAD found, skip ahead
GOTO :iwad

:pwad_master
REM --------------------------------------------------------------------------------------------------------------------
REM # are we looking for "Master Levels for DOOM II"?
IF /I NOT "%PWAD:~0,7%" == "MASTER\" GOTO :pwad_missing

REM # extract the WAD name from that
SET "WAD=%PWAD:~8%"

REM # is Steam : Master Levels for DOOM II installed?
CALL :reg "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 9160" "InstallLocation"
IF NOT "%REG%" == "" (
	REM # check if the WAD can be found there
	IF EXIST "%REG%\master\wads\%WAD%" SET "PWAD_PATH=%REG%\master\wads\%WAD%"
)
REM # is GOG : DOOM II + Final DOOM (including Master Levels) installed?
CALL :reg "HKLM\SOFTWARE\GOG.com\Games\1435848814" "Path"
IF NOT "%REG%" == "" (
	REM # check if the WAD can be found there
	IF EXIST "%REG%\master\wads\%WAD%" SET "PWAD_PATH=%REG%\master\wads\%WAD%"
)

REM # if the WAD was not found, we cannot continue, the user does not have Master Levels
IF "%PWAD_PATH%" == "" (
	ECHO:
	ECHO   ERROR: "%WAD%" missing:
	ECHO:
	ECHO   You must purchase either "DOOM Classic Complete" from Steam or
	ECHO   "DOOM II + Final DOOM" from GOG to get "Master Levels for DOOM II";
	ECHO   doom.bat automatically finds it, if installed. If you have the Master Levels
	ECHO   WADs elsewhere, copy them to the "%IWADS%\MASTER" folder and try again.
	ECHO:
	POPD
	PAUSE
	EXIT /B 1
)
REM # PWAD found, skip ahead
GOTO :iwad

:pwad_missing
REM --------------------------------------------------------------------------------------------------------------------

ECHO:
ECHO  ERROR: the PWAD "%PWAD%" doesn't exist in the "%PWAD_PATH%" folder.
ECHO  Command:
ECHO:
ECHO     doom.bat %*
ECHO:
POPD
PAUSE
EXIT /B 1


:iwad
REM ====================================================================================================================
REM # some ports require the file extensions for IWADs,
REM # check if it's missing:
IF "%IWAD_EXT%" == "" (
	REM # check if a PK3 version exists
	IF EXIST "%IWADS%\%IWAD%.pk3" (
		SET "IWAD=%IWAD%.pk3"
	) ELSE (
		REM # if both WAD & PK3 files exist with the same name, the WAD will be preferred
		REM # -- this is for broader source-port compatibility but we also need to presume
		REM #    ".WAD" going forward when searching for GOG / Steam installs
		REM # TODO: Could do an engine check for support of PK3 / WAD?
		SET "IWAD=%IWAD%.wad"
	)
)

REM # this is where the IWAD is assumed to be
SET "IWAD_PATH=%IWADS%\%IWAD%"
REM # the IWAD exists as-is and requires no special provisions,
REM # skip ahead; no edge-cases to handle
IF EXIST "%IWAD_PATH%" GOTO :iwad_found

REM # IWAD is missing,
REM # now search GOG / Steam for the IWAD:

:iwad_doomu
REM --------------------------------------------------------------------------------------------------------------------
REM # are we looking for "The Ultimate DOOM"?
REM # (if not, skip ahead to DOOM II)
IF /I NOT "%IWAD%" == "DOOM.WAD" GOTO :iwad_doom2

REM # is Steam : The Ultimate DOOM installed?
CALL :reg "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 2280" "InstallLocation"
IF NOT "%REG%" == "" (
	REM # check if DOOM.WAD can be found there
	IF EXIST "%REG%\base\DOOM.WAD" SET "IWAD_PATH=%REG%\base\DOOM.WAD" & GOTO :iwad_check
)
REM # is GOG : The Ultimate DOOM installed?
CALL :reg "HKLM\SOFTWARE\GOG.com\Games\1435827232" "Path"
IF NOT "%REG%" == "" (
	REM # check if DOOM.WAD can be found there
	IF EXIST "%REG%\DOOM.WAD" SET "IWAD_PATH=%REG%\DOOM.WAD" & GOTO :iwad_check
)
REM # is Steam : DOOM 3 BFG Edition installed?
CALL :reg "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 208200" "InstallLocation"
IF NOT "%REG%" == "" (
	REM # check if DOOM.WAD can be found there
	IF EXIST "%REG%\base\wads\DOOM.WAD" SET "IWAD_PATH=%REG%\base\wads\DOOM.WAD" & GOTO :iwad_check
)
REM # is GOG : DOOM 3 BFG Edition installed?
CALL :reg "HKLM\SOFTWARE\GOG.com\Games\1135892318" "Path"
IF NOT "%REG%" == "" (
	REM # check if DOOM.WAD can be found there
	IF EXIST "%REG%\base\wads\DOOM.WAD" SET "IWAD_PATH=%REG%\base\wads\DOOM.WAD" & GOTO :iwad_check
)

:iwad_doom2
REM --------------------------------------------------------------------------------------------------------------------
REM # are we looking for "DOOM II"?
REM # (if not, skip ahead to TNT)
IF /I NOT "%IWAD%" == "DOOM2.WAD" GOTO :iwad_tnt

REM # is Steam : DOOM II installed?
CALL :reg "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 2300" "InstallLocation"
IF NOT "%REG%" == "" (
	REM # check if DOOM2.WAD can be found there
	IF EXIST "%REG%\base\DOOM2.WAD" SET "IWAD_PATH=%REG%\base\DOOM2.WAD" & GOTO :iwad_check
)
REM # is GOG : DOOM II installed?
CALL :reg "HKLM\SOFTWARE\GOG.com\Games\1435848814" "Path"
IF NOT "%REG%" == "" (
	REM # check if DOOM2.WAD can be found there
	IF EXIST "%REG%\doom2\DOOM2.WAD" SET "IWAD_PATH=%REG%\doom2\DOOM2.WAD" & GOTO :iwad_check
)
REM # is Steam : DOOM 3 BFG Edition installed?
CALL :reg "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 208200" "InstallLocation"
IF NOT "%REG%" == "" (
	REM # check if DOOM2.WAD can be found there
	IF EXIST "%REG%\base\wads\DOOM2.WAD" SET "IWAD_PATH=%REG%\base\wads\DOOM2.WAD" & GOTO :iwad_check
)
REM # is GOG : DOOM 3 BFG Edition installed?
CALL :reg "HKLM\SOFTWARE\GOG.com\Games\1135892318" "Path"
IF NOT "%REG%" == "" (
	REM # check if DOOM2.WAD can be found there
	IF EXIST "%REG%\base\wads\DOOM2.WAD" SET "IWAD_PATH=%REG%\base\wads\DOOM2.WAD" & GOTO :iwad_check
)

:iwad_tnt
REM --------------------------------------------------------------------------------------------------------------------
REM # are we looking for "Final DOOM: Evilution"?
REM # (if not, skip ahead to Plutonia)
IF /I NOT "%IWAD%" == "TNT.WAD" GOTO :iwad_plutonia
	
REM # is Steam : Final DOOM installed?
CALL :reg "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 2290" "InstallLocation"
IF NOT "%REG%" == "" (
	REM # check if TNT.WAD can be found there
	IF EXIST "%REG%\base\TNT.WAD" SET "IWAD_PATH=%REG%\base\TNT.WAD" & GOTO :iwad_check
)
REM # is GOG : Final DOOM installed?
CALL :reg "HKLM\SOFTWARE\GOG.com\Games\1435848742" "Path"
IF NOT "%REG%" == "" (
	REM # check if TNT.WAD can be found there
	IF EXIST "%REG%\TNT\TNT.WAD" SET "IWAD_PATH=%REG%\TNT\TNT.WAD" & GOTO :iwad_check
)

:iwad_plutonia
REM --------------------------------------------------------------------------------------------------------------------
REM # are we looking for "Final DOOM: The Plutonia Experiment"?
IF /I NOT "%IWAD%" == "PLUTONIA.WAD" GOTO :iwad_check

REM # is Steam : Final DOOM installed?
CALL :reg "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 2290" "InstallLocation"
IF NOT "%REG%" == "" (
	REM # check if PLUTONIA.WAD can be found there
	IF EXIST "%REG%\base\PLUTONIA.WAD" SET "IWAD_PATH=%REG%\base\PLUTONIA.WAD" & GOTO :iwad_check
)
REM # is GOG : Final DOOM installed?
CALL :reg "HKLM\SOFTWARE\GOG.com\Games\1435848742" "Path"
IF NOT "%REG%" == "" (
	REM # check if PLUTONIA.WAD can be found there
	IF EXIST "%REG%\PLUTONIA\PLUTONIA.WAD" SET "IWAD_PATH=%REG%\PLUTONIA\PLUTONIA.WAD" & GOTO :iwad_check
)

:iwad_check
REM # did we find the IWAD in GOG / Steam?
REM # TODO: if IWAD was found in GOG / Steam, offer to copy it into PortaDOOM
IF EXIST "%IWAD_PATH%" GOTO :iwad_found

:iwad_missing
REM --------------------------------------------------------------------------------------------------------------------
REM # IWAD really cannot be found, substitute for shareware or FreeDOOM:

REM # if playing a PWAD, FreeDOOM can be substituted
IF NOT "%PWAD%" == "" GOTO :iwad_freedoom

:iwad_shareware
REM # if the user is trying to play just DOOM as-is without a PWAD,
REM # then the best thing to do is offer them the shareware version:
IF /I "%IWAD%" == "DOOM.WAD" (
	ECHO:
	ECHO   WARNING! Could not find registered DOOM.WAD:
	ECHO:
	ECHO   -- The shareware version will be launched instead which is limited to the
	ECHO      first episode. Please purchase either "The Ultimate DOOM", "DOOM Classic
	ECHO      Complete" or "DOOM 3 BFG Edition" on GOG / Steam, or place your own copy
	ECHO      of "DOOM.WAD" in the "%IWADS%" folder.
	ECHO:
	ECHO      press any key to continue
	PAUSE >NUL
	
	REM # we keep %SAVE_WAD% as "DOOM" so that save games from
	REM # shareware DOOM can be re-used in the full game
	SET "IWAD_PATH=SHAREWARE\DOOM1.WAD"
	
	GOTO :iwad_found
)

REM # TODO: Heretic, Hexen & Strife Sharewares

REM # IWAD doesn't exist and there isn't a substitution
REM # TODO: DOOM2, Final DOOM specific error messages...
ECHO:
ECHO   ERROR! the file:
ECHO:
IF "%IWAD_EXT%" == "" (
	ECHO       "%IWADS%\%IWAD%.WAD" or
	ECHO       "%IWADS%\%IWAD%.PK3"
) ELSE (
	ECHO       "%IWADS%\%IWAD%"
)
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

:iwad_freedoom
REM # if this was DOOM or DOOM2, we could use FreeDOOM instead
SET "FREEDOOM="
REM # TODO: check these files exist too
IF /I "%IWAD%" == "DOOM.WAD"  SET "FREEDOOM=%IWADS%\freedoom\freedoom1.wad"
IF /I "%IWAD%" == "DOOM2.WAD" SET "FREEDOOM=%IWADS%\freedoom\freedoom2.wad"

IF NOT "%FREEDOOM%" == "" (
	ECHO:
	ECHO   WARNING! COULD NOT FIND "%IWADS%\%IWAD%"
	ECHO   -- USING FREEDOOM AS REPLACEMENT
	ECHO:
	ECHO      press any key to continue
	PAUSE  >NUL
	ECHO:

	SET "IWAD_PATH=%FREEDOOM%"
	
) ELSE (
	REM # no other choice
	REM # TODO: support Blasphemer.wad
	ECHO:
	ECHO   ERROR! the file:
	ECHO:
	IF "%IWAD_EXT%" == "" (
		ECHO       "%IWADS%\%IWAD%.WAD" or
		ECHO       "%IWADS%\%IWAD%.PK3"
	) ELSE (
		ECHO       "%IWADS%\%IWAD%"
	)
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
)

:iwad_found
ECHO         -iwad : %IWAD_PATH%

REM # is the IWAD path absolute?
REM # (i.e. begins with a drive letter, making ":" the second character)
IF NOT "%IWAD_PATH:~1,1%" == ":" SET "IWAD_PATH="%FIX_PATH%\%IWAD_PATH%"
SET PARAMS=%PARAMS% -iwad "%IWAD_PATH%"


:params
REM ====================================================================================================================
REM # with the IWAD edge-cases handled we can finally print out the PWAD
REM # (if no PWAD present, skip over this)
IF "%PWAD%" == "" GOTO :params_begin

ECHO          PWAD : %PWAD_PATH%

REM # if a PWAD was given we can set that as the previous directory so that
REM # the first file in the files list will be checked for in the PWAD's directory
CALL :prev_dir "%PWAD_PATH%"

REM # is the PWAD path absolute?
REM # (i.e. begins with a drive letter, making ":" the second character)
IF NOT "%PWAD_PATH:~1,1%" == ":" SET "PWAD_PATH="%FIX_PATH%\%PWAD_PATH%"

REM # IMPORTANT NOTE: Chocolate-DOOM will not be able handle PWADs unless
REM # the `-merge` switch is used, this is due to historical accuracy,
REM # see <www.chocolate-doom.org/wiki/index.php/WAD_merging_capability>
IF "%ENGINE_KIN%" == "V" (
	SET PARAMS=%PARAMS% -merge "%PWAD_PATH%"
) ELSE (
	SET PARAMS=%PARAMS% -file "%PWAD_PATH%"
)

:params_begin
REM # are there any parameters?
IF "%~1" == ""   GOTO :saves
IF "%~1" == "--" GOTO :saves

REM # anything that isn't "--" is added to the command line for the engine
SET "ENGINE_PARAMS="

:params_loop
        REM # no more parameters remaining?
        IF "%~1" == "" GOTO :params_continue
        IF "%~1" == "--" GOTO :params_continue
	REM # is this a config parameter? (flag this so we don't use our own)
	IF /I "%~1" == "-config" SET HAS_CONFIG=1
        REM # add to the parameters list
        SET ENGINE_PARAMS=%ENGINE_PARAMS% %1
        SHIFT
        GOTO :params_loop

:params_continue
IF NOT "%ENGINE_PARAMS%" == "" (
        ECHO        params :%ENGINE_PARAMS%
        REM # add the parameters to the final command line
        SET PARAMS=%PARAMS% %ENGINE_PARAMS%
)


:saves
REM ====================================================================================================================
REM # savegames are separated by port (gzdoom / zandronum &c.) and then by IWAD or PWAD (if present)

REM # check if the base saves directory even exists?
IF NOT EXIST "%SAVES%" MKDIR "%SAVES%"
REM # within the saves folder, there'll be a folder for each engine
REM # (not to be confused with %PORT_SAVE% which is the name of the folder, not the path)
SET "SAVES_PORT=%SAVES%\%PORT_SAVE%"
REM # check if the save directory for the port exists
IF NOT EXIST "%SAVES_PORT%" MKDIR "%SAVES_PORT%"
REM # savegames are separated by the IWAD or PWAD name so that you don't get 100 "DOOM2" saves
SET "SAVES_WAD=%SAVES_PORT%\%SAVE_WAD%"
REM # check if the save directory for the IWAD/PWAD name exists
IF NOT EXIST "%SAVES_WAD%" MKDIR "%SAVES_WAD%"

REM # since the current directory will be changed to the WAD's save directory,
REM # we can specify this parameter as just the 'current directory' (".").
REM # NOTE: `-savedir` is for zdoom-based ports and `-save` for prboom+.
REM #       chocolate-doom & DOOM 64 EX do not support a save directory parameter
REM #       and will put savegames in the 'current directory'!
IF "%ENGINE_KIN%" ==  "Z" (
        SET PARAMS=%PARAMS% -savedir "."
        ECHO      -savedir : %SAVES_WAD%
)
IF "%ENGINE_KIN%" == "B" (
        SET PARAMS=%PARAMS% -save "."
        ECHO         -save : %SAVES_WAD%
)


:config
REM ====================================================================================================================
REM # if a config file has already been provided in the params, we won't supply our own
REM # (we don't check for `-extraconfig`, we're assuming the user knows what they're doing)
IF %HAS_CONFIG% EQU 1 GOTO :files

REM # zdoom based engines (q/g/zdoom, zandronum) use ".ini" config files,
REM # the other engines use ".cfg"
IF "%ENGINE_KIN%" == "Z" ( SET "CFG=ini" ) ELSE ( SET "CFG=cfg" )
	
SET "CONFIG="
	
REM # if the option to use the default config (`/DEFAULT`) has been given:
IF %DEFAULT% EQU 1 (
	REM # we will launch the engine using the actual default config file rather than a copy
	SET "CONFIG=%CONFIGS%\default.%ENGINE_CFG%"
) ELSE (
	REM # if the default config file (for the engine) is missing,
	REM # launch the engine to create and set a new default configuration
	IF NOT EXIST "%CONFIGS%\default.%ENGINE_CFG%.%CFG%" (
		ECHO:
		ECHO     WARNING: The default configuration file ^(for this engine^) is missing.
		ECHO              The engine will be launched with a new default configuration
		ECHO              file; please configure the engine to desired defaults.
		ECHO:
		ECHO     press any key to continue
		ECHO:
		PAUSE >NUL
		
		REM # use the default config file instead of the user's personal copy
		REM # (does not include the file-extension so that we can append "extra" in there for choco-doom)
		SET "CONFIG=%CONFIGS%\default.%ENGINE_CFG%"
	) ELSE (
		REM # if a user-config is not yet present, copy over the default
		IF NOT EXIST "%SAVES_PORT%\config.%ENGINE_CFG%.%CFG%" (
			REM # copy across the default configuration (from "config" folder)
			COPY /Y "%CONFIGS%\default.%ENGINE_CFG%.%CFG%" "%SAVES_PORT%\config.%ENGINE_CFG%.%CFG%" >NUL
			REM # chocolate-doom's extra config file too
			IF "%ENGINE_KIN%" == "V" (
				COPY /Y "%CONFIGS%\default.%ENGINE_CFG%.extra.%CFG%" ^
					"%SAVES_PORT%\config.%ENGINE_CFG%.extra.%CFG%" >NUL
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


:files
REM ====================================================================================================================
REM # keep track of which types of files have been added or not
SET ANY_WAD=0
SET ANY_DEH=0
SET ANY_BEX=0
SET ANY_CFG=0

REM # are there any files to add?
IF "%~1" == "" GOTO :launch

REM # the files list must be separated by "--"
IF NOT "%~1" == "--" (
        ECHO:
        ECHO  ERROR: too many parameters; "--" expected:
        ECHO:
        ECHO     doom.bat %*
        ECHO:
        ECHO  Usage:
        ECHO:
        ECHO     %USAGE%
        ECHO:
	POPD
        PAUSE
        EXIT /B 1
)
SHIFT

REM # the list of files will be built here:
SET "FILES="
REM # any DeHackEd patches?
SET "DEH="
SET "BEX="

:files_loop
        REM # no more parameters remaining?
        IF "%~1" == "" GOTO :files_continue

        REM # by default this is where we'll assume the file is
        SET "FILE=%PWADS%\%~1"
	
        REM # check file extension:
	IF /I "%~x1" == ".deh" GOTO :deh
	IF /I "%~x1" == ".bex" GOTO :bex
	IF    "%~x1" == ""     GOTO :noext
	
	REM ------------------------------------------------------------------------------------------------------------
	
	REM # check the previous directory used
	IF NOT "%PREV_DIR%" == "" (
		REM # this will fool the next few lines
		IF EXIST "%PREV_DIR%\%~1" SET "FILE=%PREV_DIR%\%~1"
	)
        REM # if the file doesn't exist, check the engine directory
        IF NOT EXIST "%FILE%" SET "FILE=%ENGINE_DIR%\%~1"
	REM # also check the directory that called this script
	IF NOT EXIST "%FILE%" SET "FILE=%OLD_DIR%\%~1"
        REM # finally, is it really there?
        IF NOT EXIST "%FILE%" (
                ECHO:
                ECHO  ERROR: the file "%~1" doesn't exist in either the "%PWADS%" folder,
                ECHO         or the "%ENGINE_DIR%" folder.
		ECHO:
                ECHO  Command:
                ECHO:
                ECHO     doom.bat %*
                ECHO:
		ECHO %CD%
		POPD
                PAUSE
                EXIT /B 1
        )
	
        SET FILES=%FILES% "%FIX_PATH%\%FILE%"
	CALL :prev_dir "%FILE%"
	SET ANY_WAD=1
        ECHO         -file : %FILE%
	SHIFT
        GOTO :files_loop
	
	:deh
	REM ------------------------------------------------------------------------------------------------------------
	REM # load a DeHackEd extension:
	
	REM # does it exist in the previously used directory?
	IF NOT "%PREV_DIR%" == "" (
		IF EXIST "%PREV_DIR%\%~1" SET "FILE=%PREV_DIR%\%~1"
	)
	REM # if the file doesn't exist, check the engine directory
	IF NOT EXIST "%FILE%" SET "FILE=%ENGINE_DIR%\%~1"
	REM # finally, is it really there?
	IF NOT EXIST "%FILE%" GOTO :deh_error
	
	REM # accept the file
	SET DEH=%DEH% "%FIX_PATH%\%FILE%"
	CALL :prev_dir "%FILE%"
	SET ANY_DEH=1
	ECHO          -deh : %FILE%
	SHIFT
	GOTO :files_loop 
	
	:bex
	REM ------------------------------------------------------------------------------------------------------------
	REM # load a Boom-enhanced DeHackEd extension:
	
	REM # does it exist in the previously used directory?
	IF NOT "%PREV_DIR%" == "" (
		IF EXIST "%PREV_DIR%\%~1" SET "FILE=%PREV_DIR%\%~1"
	)
	REM # if the file doesn't exist, check the engine directory
	IF NOT EXIST "%FILE%" SET "FILE=%ENGINE_DIR%\%~1"
	REM # finally, is it really there?
	IF NOT EXIST "%FILE%" GOTO :deh_error
	
	REM # accept the file
	SET BEX=%BEX% "%FIX_PATH%\%FILE%"
	CALL :prev_dir "%FILE%"
	SET ANY_BEX=1
	ECHO          -bex : %FILE%
	SHIFT
	GOTO :files_loop
        
	:noext
	REM ------------------------------------------------------------------------------------------------------------
	REM # if file extension missing, check for PK3, PK7, WAD
        
	REM # check if a WAD version exists
	IF EXIST "%PWADS%\%~1.wad" SET "FILE=%PWADS%\%~1.wad"
	REM # check if a PK7 version exists
	IF EXIST "%PWADS%\%~1.pk7" SET "FILE=%PWADS%\%~1.pk7"
	REM # check if a PK3 version exists
	REM # (PK7s are slower and more resource-intensive,
	REM #  so if a user converts these to PK3, we want to prefer those)
	IF EXIST "%PWADS%\%~1.pk3" SET "FILE=%PWADS%\%~1.pk3"
	
	REM # should we check the previous folder used?
	REM # NOTE : this implies that a WAD in the previous folder overrides one in pwads;
	REM # 	     is this preferred over favouring root first?
	IF NOT "%PREV_DIR%" == "" (
		REM # check if a WAD version exists
		IF EXIST "%PREV_DIR%\%~1.wad" SET "FILE=%PREV_DIR%\%~1.wad"
		REM # check if a PK7 version exists
		IF EXIST "%PREV_DIR%\%~1.pk7" SET "FILE=%PREV_DIR%\%~1.pk7"
		REM # check if a PK3 version exists
		REM # (PK7s are slower and more resource-intensive,
		REM #  so if a user converts these to PK3, we want to prefer those)
		IF EXIST "%PREV_DIR%\%~1.pk3" SET "FILE=%PREV_DIR%\%~1.pk3"
	)
	
	REM # did none of those exist?
	IF NOT "%FILE%" == "%PWADS%\%~1" GOTO :noext_found
	
	REM # since no extension was initially provided,
	REM # now recheck extensions in the engine directory
	IF EXIST "%ENGINE_DIR%\%~1.wad" SET "FILE=%ENGINE_DIR%\%~1.wad"
	REM # check if a PK7 version exists
	IF EXIST "%ENGINE_DIR%\%~1.pk7" SET "FILE=%ENGINE_DIR%\%~1.pk7"
	REM # check if a PK3 version exists
	REM # (PK7s are slower and more resource-intensive,
	REM #  so if a user converts these to PK3, we want to prefer those)
	IF EXIST "%ENGINE_DIR%\%~1.pk3" SET "FILE=%ENGINE_DIR%\%~1.pk3"

	REM # did none of those exist either?
	IF "%FILE%" == "%PWADS%\%~1" (
		ECHO:
		ECHO  ERROR: the file "%~1" doesn't exist in either the "%PWADS%" folder,
		ECHO         or the "%ENGINE_DIR%" folder.
		ECHO  Command:
		ECHO:
		ECHO     doom.bat %*
		ECHO:
		PAUSE
		EXIT /B 1
	)
	
	:noext_found
	REM # we found it!
	SET FILES=%FILES% "%FIX_PATH%\%FILE%"
	CALL :prev_dir "%FILE%"
	SET ANY_WAD=1
	ECHO         -file : %FILE%
	SHIFT
	GOTO :files_loop

REM --------------------------------------------------------------------------------------------------------------------
:prev_dir
	SET "PREV_DIR=%~p1"
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "PREV_DIR=!PREV_DIR:%~p0=!"
	SET "PREV_DIR=!PREV_DIR:~0,-1!"	& REM # strip trailing slash
	ENDLOCAL & SET "PREV_DIR=%PREV_DIR%"
	GOTO:EOF

:deh_error
	REM # DeHackEd (.deh / .bex) file missing:
	ECHO:
	ECHO  ERROR: The specified DeHackEd file does not exist:
	ECHO:
	ECHO     "%~1"
	ECHO:
	ECHO  The following locations were checked:
	ECHO:
	IF NOT "%PREV_DIR%" == "" (
		ECHO 	 "%PREV_DIR%\%~1"
	)
	ECHO 	 "%PWADS%\%~1"
	ECHO 	 "%ENGINE_DIR%\%~1"
	ECHO:
	ECHO  Command:
	ECHO:
	ECHO     doom.bat %*
	ECHO:
	POPD
	PAUSE
	EXIT /B 1
	
	
REM --------------------------------------------------------------------------------------------------------------------

:files_continue
REM # were any files added?
IF %ANY_WAD% EQU 1 (
        SET "PARAMS=%PARAMS% -file %FILES%"
)
REM # DeHackEd extensions?
IF %ANY_DEH% EQU 1 (
        SET "PARAMS=%PARAMS% -deh %DEH%"
)
IF %ANY_BEX% EQU 1 (
        SET "PARAMS=%PARAMS% -bex %BEX%"
)


:launch
REM ====================================================================================================================

REM # get the desktop screen resolution:
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

REM # command line parameters for fullscreen:
IF "%ENGINE_KIN%" == "Z" (
	REM # `+fullscreen 1` for ZDOOM-based ports
	SET "FULLSCREEN=+fullscreen 1"
) ELSE (
	REM # `-fullscreen` for Chocolate DOOM, PRBoom+ and DOOM 64 EX
	SET "FULLSCREEN=-fullscreen"
)

REM --------------------------------------------------------------------------------------------------------------------
ECHO:
ECHO    Get Psyched!
ECHO:

REM # if you need to see what the final command will be:
REM ECHO  "doom.bat" /D "%SAVES_WAD%" %FIX_PATH%\%ENGINE% %SCREENRES% %FULLSCREEN% %PARAMS% & PAUSE

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