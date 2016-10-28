@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

REM # doom batch launcher - (c) copyright Kroc Camen 2016

REM # v4
REM # - allow choco-* engines to be called with or without their pre-setup
REM # - different engines can share save folders

REM # v3
REM # - accept config files (.cfg / .ini)

REM # v2
REM # - accept arbitrary options to pass on to the engine as-is

REM # v1
REM # - DeHackEd extensions "-deh", "-bex"

REM # v0:
REM # - multiple engines
REM # - "-file" support
REM # - "-savedir" is based on PWAD/IWAD
REM # - FreeDOOM substitution

:usage
REM ====================================================================================================================
REM # if no parameters are given, show the instructions

SET "USAGE=doom.bat [^<engine^>] [^<IWAD^> [^<PWAD^>] [^<options^>] [ -- ^<files^>...]]"

IF [%~1] == [] (
        ECHO:
        ECHO  "doom.bat" is a command-line launcher for DOOM-based games.
        ECHO  It makes it easier to create shortcuts to run a particular
        ECHO  source-port with a particular WAD and particular mods etc.
        ECHO:
        ECHO Usage:
        ECHO:
        ECHO     %USAGE%
        ECHO:
        ECHO Example:
        ECHO:
        ECHO     doom.bat gzdoom DOOM2 -- brutalv20b.pk3
        ECHO:
        ECHO Engines:
        ECHO:		
        ECHO     gzdoom              : Stable version of GZDoom
        ECHO     zdoom               : ZDoom
        ECHO     zandronum           : Zandronum current ^(2.x^)
        ECHO     zandronum-dev       : Zandronum in development ^(3.0^)
        ECHO     prboom              : PRBoom+ ^(software renderer^)
        ECHO     glboom              : PRBoom+ ^(OpenGL renderer^)
        ECHO     choco-doom          : ChocolateDOOM ^(very vanilla, 320x200^)
        ECHO     choco-doom-setup    : Displays ChocolateDOOM's configuration program first
        ECHO     choco-heretic       : As with choco-doom, but for Heretic WADs
        ECHO     choco-heretic-setup : As above, but displays configuration first
        ECHO     choco-hexen         : As with choco-doom, but for Hexen WADs
        ECHO     choco-hexen-setup   : As above, but displays configuration first
        ECHO     choco-strife        : As with choco-doom, but for Strife WADs
        ECHO     choco-strife-setup  : As above, but displays configuration first
        ECHO:
        ECHO IWAD:
        ECHO:
        ECHO     The IWAD ^(internal WAD^) is the base WAD to use. This will be one of the
        ECHO     original game's WAD files which maps, mods and total conversions extend.
        ECHO     If uncertain, use "DOOM2", it's the most common one used for community
        ECHO     content. The ".WAD" / ".PK3" extension can be ommitted.
        ECHO:
        ECHO     IWADs are located in the "iwads" folder.
        ECHO:
        ECHO PWAD:
        ECHO:
        ECHO     The PWAD ^(patch-WAD^) is the community map / megawad you want to play.
        ECHO     These are assumed to be in the "pwads" folder, not "iwads".
        ECHO     E.g.
        ECHO:
        ECHO            doom.bat gzdoom DOOM2 wolfendoom.pk3
        ECHO:
        ECHO     If you just want to play an original game ^(e.g. DOOM, Hexen^)
        ECHO     then the PWAD is not required.
        ECHO:
        ECHO Options:
        ECHO:
        ECHO     You can include any command line parameters here and they will be
        ECHO     passed on to the engine. Example:
        ECHO:
        ECHO            doom.bat choco-doom DOOM2 -warp 21
        ECHO:
        ECHO     Note that what parameters are supported will vary between engines.
        ECHO:
        ECHO Files:
        ECHO:
        ECHO     A list of additional files to include ^(from the "pwads" directory^).
        ECHO     Unlike when creating Windows shortcuts, the "pwads" folder is assumed,
        ECHO     so that you don't need to include the base path on each file added.
        ECHO:
        ECHO     NOTE: The "--" is required to separate the options from the list of files.
        ECHO:   
        ECHO     DeHackEd extensions ^(".deh" / ".bex"^) can be included in the files list,
        ECHO     and will be loaded using the correct "-deh" or "-bex" engine parameter.
        ECHO:
        ECHO     Config files ^(".cfg" / ".ini"^) will likewise be loaded using the
        ECHO     correct engine parameter ^("-config"^).
        ECHO:
        ECHO Savegames:
        ECHO:
        ECHO     Savegames are not saved alongside the engine as is default, but rather
        ECHO     in a "saves" folder. To prevent incompatibilites and potential data-loss
        ECHO     between engines, savegames are first separated by engine ^("gzdoom" /
        ECHO     "zandronum" etc.^) and then by the PWAD name ^(or IWAD name if no PWAD
        ECHO     is specified^). I.e. for the command:
        ECHO:
        ECHO            doom.bat zdoom DOOM2 breach.wad
        ECHO:
        ECHO     the savegames will be located in "saves\zdoom\breach\".
        
        ECHO: & PAUSE
        EXIT /B 0
)

REM ====================================================================================================================

CLS

REM # change current directory to that of this script;
REM # ensures that shortcuts to this script don't end up looking elsewhere for files
CD %~dp0

ECHO:

: paths
REM ====================================================================================================================

REM # NOTE: many doom eninges save their config files in the 'current directory', which is typically expected to be
REM # that of the executable. However, we want to separate user-data (such as savegames) from the engines. Whilst we
REM # can change the save directory, config files will still be dumped in the 'current directory', which in the case
REM # of this script, will be right here! We therefore need to set the current directory to that of the save games,
REM # and rewrite all the WAD paths to be relative to the saves!

SET "FIX_PATH=..\.."

REM # default folder names
SET "IWADS=iwads"
SET "PWADS=pwads"
SET "PORTS=ports"
SET "SAVES=saves"

REM # reserve some variables
SET "PWAD="
SET "SAVE_WAD="


:ports
REM ====================================================================================================================

SET "PORT=gzdoom"
SET "SAVE_PORT=gzdoom"
SET "ENGINE=" 

IF /I [%~1] == [choco-doom] (
        SET "ENGINE=%PORTS%\chocolate-doom\chocolate-doom.exe"
        SET "SAVE_PORT=choco-doom"
        ECHO      port : chocolate doom
)
IF /I [%~1] == [choco-doom-setup] (
        SET "ENGINE=%PORTS%\chocolate-doom\chocolate-doom-setup.exe"
        SET "SAVE_PORT=choco-doom"
        ECHO      port : chocolate doom (setup)
)
IF /I [%~1] == [choco-heretic] (
        SET "ENGINE=%PORTS%\chocolate-heretic\chocolate-heretic.exe"
        SET "SAVE_PORT=choco-heretic"
        ECHO      port : chocolate heretic
)
IF /I [%~1] == [choco-heretic-setup] (
        SET "ENGINE=%PORTS%\chocolate-heretic\chocolate-heretic-setup.exe"
        SET "SAVE_PORT=choco-heretic"
        ECHO      port : chocolate heretic (setup)
)
IF /I [%~1] == [choco-hexen] (
        SET "ENGINE=%PORTS%\chocolate-hexen\chocolate-hexen.exe"
        SET "SAVE_PORT=choco-hexen"
        ECHO      port : chocolate hexen
)
IF /I [%~1] == [choco-hexen-setup] (
        SET "ENGINE=%PORTS%\chocolate-hexen\chocolate-hexen-setup.exe"
        SET "SAVE_PORT=choco-hexen"
        ECHO      port : chocolate hexen (setup)
)
IF /I [%~1] == [choco-strife] (
        SET "ENGINE=%PORTS%\chocolate-strife\chocolate-strife.exe"
        SET "SAVE_PORT=choco-strife"
        ECHO      port : chocolate strife
)
IF /I [%~1] == [choco-strife-setup] (
        SET "ENGINE=%PORTS%\chocolate-strife\chocolate-strife-setup.exe"
        SET "SAVE_PORT=choco-strife"
        ECHO      port : chocolate strife (setup)
)
IF /I [%~1] == [glboom] (
        SET "ENGINE=%PORTS%\prboom+\glboom-plus.exe"
        SET "SAVE_PORT=prboom"
        ECHO      port : prboom+ ^(OpenGL renderer^)
)
IF /I [%~1] == [gzdoom] (
        SET "ENGINE=%PORTS%\gzdoom\gzdoom.exe"
        SET "SAVE_PORT=gzdoom"
        ECHO      port : gzdoom (current)
)
IF /I [%~1] == [gzdoom-dev] (
        SET "ENGINE=%PORTS%\gzdoom-dev\gzdoom.exe"
        SET "SAVE_PORT=gzdoom"
        ECHO      port : gzdoom (development)
)
IF /I [%~1] == [prboom] (
        SET "ENGINE=%PORTS%\prboom+\prboom-plus.exe"
        SET "SAVE_PORT=prboom"
        ECHO      port : prboom+ ^(software renderer^)
)
IF /I [%~1] == [zandronum] (
        SET "SAVE_PORT=zandronum"
        SET "ENGINE=%PORTS%\zandronum\zandronum.exe"
        ECHO      port : zandronum (current)
)
IF /I [%~1] == [zandronum-dev] (
        SET "SAVE_PORT=zandronum"
        SET "ENGINE=%PORTS%\zandronum-dev\zandronum.exe"
        ECHO      port : zandronum (development)
)
IF /I [%~1] == [zdoom] (
        SET "ENGINE=%PORTS%\zdoom\zdoom.exe"
        SET "SAVE_PORT=zdoom"
        ECHO      port : zdoom
)

IF [%ENGINE%] == [] (
        REM # no engine specified, use default
        SET "ENGINE=%PORTS%\gzdoom\gzdoom.exe"
        SET "SAVE_PORT=gzdoom"
        ECHO      port : gzdoom ^(default^)
) ELSE (
        REM # the engine parameter can be discarded
        SHIFT
)

ECHO    engine : %ENGINE%


:iwad
REM ====================================================================================================================
REM # the save directory is based on the IWAD or PWAD.
REM # we default to DOOM2
SET "IWAD=DOOM2.WAD"
SET "SAVE_WAD=DOOM2"

REM # if second parameter is present, it'll be the IWAD to use;
REM # this can be a PK3 file only if the PK3 file contains full game resources (e.g. doom_complete.pk3).
REM # unless a PWAD is provided, the IWAD name (sans-extension) will be used for the savegames folder
IF NOT [%1] == [--] (
        SET "IWAD=%~1"
        SET "SAVE_WAD=%~n1"
        
        REM # some ports require the file extensions for WADs,
        REM # check if it's missing:
        IF [%~x1] == [] (
                REM # check if a PK3 version exists
                IF EXIST "%IWADS%\%~1.pk3" SET "IWAD=%~1.pk3"
                REM # check if a WAD version exists;
                REM # if both WAD & PK3 files exist with the same name,
                REM # the WAD will be preferred -- this is for broader source-port compatibility
                IF EXIST "%IWADS%\%~1.wad" SET "IWAD=%~1.wad"
        )
        
        REM # check if the IWAD actually exists
        IF NOT EXIST "%IWADS%\!IWAD!" (
                REM # if this was DOOM or DOOM2, we could use FreeDOOM instead
                SET "FREEDOOM="
                REM # TODO: check these files exist too
                IF /I [!SAVE_WAD!] == [DOOM] SET "FREEDOOM=freedoom\freedoom1.wad"
                IF /I [!SAVE_WAD!] == [DOOM2] SET "FREEDOOM=freedoom\freedoom2.wad"

                IF NOT [!FREEDOOM!] == [] (
                        ECHO:
                        ECHO   WARNING^^! COULD NOT FIND "%IWADS%\!IWAD!"
                        ECHO   -- USING FREEDOOM AS REPLACEMENT
                        ECHO:
                        ECHO      press any key to continue
                        PAUSE >NUL

                        SET "IWAD=!FREEDOOM!"
                        
                ) ELSE (
                        REM # no other choice
                        REM # TODO: support Blasphemer.wad
                        ECHO:
                        ECHO  ERROR: the IWAD "!IWAD!" doesn't exist in the "%IWADS%" folder.
                        ECHO  Command:
                        ECHO:
                        ECHO     doom.bat %*
                        ECHO:
                        PAUSE
                        EXIT /B 1
                )
        )
        
        REM # move to the next parameter
        SHIFT
)

SET PARAMS=%PARAMS% -iwad "%FIX_PATH%\%IWADS%\%IWAD%"


:pwad
REM ====================================================================================================================

REM # if no PWAD given, continue
IF [%~1] == [] GOTO :saves
IF [%~1] == [--] GOTO :saves
REM # if PWAD begins with "-", "+" or "/" then it's an option, not a PWAD
SET "NEXT=%~1"
IF [%NEXT:~0,1%] == [-] GOTO :options
IF [%NEXT:~0,1%] == [+] GOTO :options
IF [%NEXT:~0,1%] == [/] GOTO :options

SET "PWAD=%~1"
SET "SAVE_WAD=%~n1"
SHIFT

SET PARAMS=%PARAMS% -file "%FIX_PATH%\%PWADS%\%PWAD%"

ECHO      PWAD : %PWAD%


:options
REM ====================================================================================================================
REM # are there any options?
IF [%~1] == [] GOTO :saves
IF [%~1] == [--] GOTO :saves

REM # anything that isn't "--" is added to the command line for the engine
SET "OPTIONS="

:options_loop
        REM # no more parameters remaining?
        IF [%~1] == [] GOTO :options_continue
        IF [%~1] == [--] GOTO :options_continue
        REM # add to the options list
        SET OPTIONS=!OPTIONS! %1
        SHIFT
        GOTO :options_loop

:options_continue
IF NOT [!OPTIONS!] == [] (
        ECHO   options : !OPTIONS!
        REM # add the options to the final command line
        SET PARAMS=%PARAMS% !OPTIONS!
)


:saves
REM ====================================================================================================================
REM # savegames are separated by port (gzdoom / zandronum &c.) and then by IWAD (e.g. DOOM / DOOM2 / HEXEN) 

ECHO:
ECHO     -iwad : %IWAD%

REM # check if the base saves directory even exists? (it's not intended to be distributed)
IF NOT EXIST "%SAVES%" MKDIR "%SAVES%"
REM # check if the save directory for the port exists
IF NOT EXIST "%SAVES%\%SAVE_PORT%" MKDIR "%SAVES%\%SAVE_PORT%"
REM # check if the save directory for the PWAD/IWAD name exists
IF NOT EXIST "%SAVES%\%SAVE_PORT%\%SAVE_WAD%" MKDIR "%SAVES%\%SAVE_PORT%\%SAVE_WAD%"
 
REM # since the current directory will be changed to the port's save directory,
REM # we can specify this parameter as just the IWAD/PWAD name
SET PARAMS=%PARAMS% -savedir "%SAVE_WAD%"

ECHO  -savedir : %SAVES%\%SAVE_PORT%\%SAVE_WAD%

:files
REM ====================================================================================================================

REM # are there any files to add?
IF [%~1] == [] GOTO :launch

REM # the files list must be separated by "--"
IF NOT [%~1] == [--] (
        ECHO:
        ECHO  ERROR: too many parameters; "--" expected:
        ECHO:
        ECHO     doom.bat %*
        ECHO:
        ECHO  Usage:
        ECHO:
        ECHO     %USAGE%
        ECHO:
        PAUSE
        EXIT /B 1
)
SHIFT

REM # the list of files will be built here
SET "FILES="
REM # any DeHackEd patches?
SET "DEH="
SET "BEX="
REM # any config files?
SET "CONFIG="
        
:files_loop
        REM # no more parameters remaining?
        IF [%~1] == [] GOTO :files_continue

        REM # check file extension:
        IF /I [%~x1] == [.deh] (
                REM # load a DeHackEd extension
                SET DEH=%DEH% "%FIX_PATH%\%PWADS%\%~1"
                ECHO      -deh : %~1
                SHIFT
                GOTO :files_loop 
        )
        IF /I [%~x1] == [.bex] (
                REM # load a Boom-enhanced DeHackEd extension
                SET BEX=%BEX% "%FIX_PATH%\%PWADS%\%~1"
                ECHO      -bex : %~1
                SHIFT
                GOTO :files_loop
        )
        IF /I [%~x1] == [.cfg] (
                REM # load a config file (.cfg extension -- original DOOM / chocolate-doom)
                SET CONFIG=%CONFIG% -config "%FIX_PATH%\%PORTS%\%~1"
                ECHO    -config: %~1
                SHIFT
                GOTO :files_loop
        )
        IF /I [%~x1] == [.ini] (
                REM # load a config file (.ini -- g/zdoom / zandronum)
                SET CONFIG=%CONFIG% -config "%FIX_PATH%\%PORTS%\%~1"
                ECHO    -config: %~1
                SHIFT
                GOTO :files_loop
        )         

        REM # if file extension missing, check for PK3, PK7, WAD
        SET FILES=%FILES% "%FIX_PATH%\%PWADS%\%~1"
        ECHO     -file : %~1
        SHIFT
        GOTO :files_loop

:files_continue
REM # config files?
IF NOT [!CONFIG!] == [] (
        SET "PARAMS=!PARAMS!!CONFIG!"
)
REM # were any files added?
IF NOT [!FILES!] == [] (
        SET "PARAMS=!PARAMS! -file !FILES!"
)
REM # DeHackEd extensions?
IF NOT [!DEH!] == [] (
        SET "PARAMS=!PARAMS! -deh !DEH!"
)
IF NOT [!BEX!] == [] (
        SET "PARAMS=!PARAMS! -bex !BEX!"
)


:launch
REM ====================================================================================================================

ECHO:
ECHO  Get Psyched!
ECHO:
START "doom.bat" /D "%SAVES%\%SAVE_PORT%" %FIX_PATH%\%ENGINE%%PARAMS%

REM # TODO: -shotdir to set screenshots?
REM # TODO: chdir in files?
REM # TODO: search for WAD?
REM # TODO: -noautoload?