@ECHO OFF & SETLOCAL ENABLEEXTENSIONS DISABLEDELAYEDEXPANSION

REM # any parameters?
REM # whilst all parameters would be optional (and DOOM2 would be launched by
REM # default), we do want to echo the help text
IF NOT "%~1" == "" GOTO :init

ECHO:
ECHO  "play.bat" is a command-line utility for selecting and launching DOOM engines.
ECHO  Given a set of requirements for a DOOM WAD, "play.bat" will present you with
ECHO  choices available (if any) and launch the game with the correct configuration
ECHO  through its sister script "doom.bat".
ECHO:
ECHO  Usage:
ECHO:
ECHO     play.bat [/REQ ^<engines^>]
ECHO              [/IWAD ^<iwad^>] [/PWAD ^<file^>]
ECHO              [/DEH ^<file^>] [/BEX ^<file^>]
ECHO              [/WARP ^<map-number^>] [/SKILL ^<skill-level^>]
ECHO              [/CMPLVL ^<complevel^>] [/EXEC ^<file^>]
ECHO              [-- ^<files^>...]
ECHO:
ECHO  /REQ ^<tags^>
REM ---------------------------------------------------------------------------------
ECHO:
ECHO     Specifies the engine requirements for the game; play.bat will select the
ECHO     compatible engines and present the user with choices. Multiple tags can be
ECHO     included ^(up to 6^) if separated by colons ^(without spaces^),
ECHO     e.g. "boom:mbf".
ECHO:
ECHO     Feature-set / tag   Description
ECHO     -----------------------------------------------------------------------------
ECHO     "vanilla"           The original DOOM executable is limited to 32K segments,
ECHO                         128 visplanes and about 180KB save files. Only DOOM 64 EX
ECHO                         is a non-vanilla engine ^(i.e. cannot play DOOM 1/2^)
ECHO:
ECHO     "DEH", "DeHackEd"   The earliest mod system for DOOM. ".DEH" files would be
ECHO                         live-patched onto the DOOM executable, allowing a number
ECHO                         of game ^& enemy properties to be changed. Still common
ECHO                         today as a "lowest common denominator" mod system;
ECHO                         most modern engines have built-in DeHackEd support.
ECHO:
ECHO     "no-limit"          A.k.a. limit-removing engine. Only Chocolate Doom
ECHO                         retains the original DOOM limits, all other engines
ECHO                         support ^>128 visplanes, and some support more than
ECHO                         32K segments.
ECHO:
ECHO     "boom"              The Boom engine, released in 1998, raised limits and
ECHO                         added a number of new map capabilities. Boom-compatible
ECHO                         maps are still common today.
ECHO:
ECHO     "BEX"               "Boom-Extended DeHackEd". Further improvements to
ECHO                         DeHackEd were made by Boom. Uses ".BEX" files.
ECHO:
ECHO     "MBF"               "Marine's Best Friend", a continuation of Boom. Added
ECHO                         "friendly monsters" and a few extra map-enhancements,
ECHO                         nowadays considered part of "boom" compatibility.
ECHO:
ECHO     "UDMF"              "Universal Doom Map Format", 2008, a specification for
ECHO                         text-based map data. Supported by many engines today.
ECHO:
ECHO     "ACS"               "Action Code Script", script originally created for
ECHO                         Hexen and extended by ZDoom.
ECHO:
ECHO     "DECORATE"          Scripting and definition language from ZDoom.
ECHO                         Implemented by a few engines.
ECHO:
ECHO     "ZScript"           Brand-new scripting language to replace DECORATE in
ECHO                         GZDoom-based engines. Present from GZDoom v3+
ECHO:
REM ECHO     chocolate-doom/heretic/hexen/strife     original DOOM-engine limits
REM ECHO     prboom+                                 no-limits, boom and MBF extensions
REM ECHO:
REM ECHO     choco       chocolate-doom/heretic/hexen ONLY
REM ECHO     zdoom       
REM ECHO:

ECHO     This is a list of the tags associated with each engine:
ECHO:
ECHO       choco-doom        vanilla,deh
ECHO       choco-heretic     vanilla,deh
ECHO       choco-hexen       vanilla,deh
ECHO       choco-strife      vanilla,deh
ECHO       crispy-doom       vanilla,deh,no-limit
ECHO       doomretro         vanilla,deh,no-limit,boom
ECHO       doom64ex          doom64
ECHO       zdoom             vanilla,deh,no-limit,boom,mbf,acs,decorate,udmf
ECHO:

ECHO  /IWAD ^<iwad^>
ECHO:
ECHO     Specifies the IWAD to use. Note that unlike "doom.bat", some shorthand terms
ECHO     are available and "play.bat" will provide the file path for you. These are:
ECHO:
ECHO     ^<iwad^>      Description          File path "wads\*"
ECHO     ----------------------------------------------------------------------------
ECHO     "DOOM"      Registerd DOOM       DOOM.WAD
ECHO     "DOOM1"     DOOM Shareware       SHAREWARE\DOOM1.WAD
ECHO     "DOOM2"     DOOM II              DOOM2.WAD
ECHO     "FREEDOOM1" FreeDOOM Phase I     conversions\freedoom\FREEDOOM1.WAD
ECHO     "FREEDOOM2" FreeDOOM Phase II    conversions\freedoom\FREEDOOM2.WAD
ECHO     "HERETIC"   Registered Heretic   HERETIC.WAD
ECHO     "HERETIC1"  Heretic Shareware    SHAREWARE\HERETIC1.WAD
ECHO     "HEXEN"     Hexen                HEXEN.WAD"
ECHO     "SQUARE1"   Adventures of Square SHAREWARE\adventures_of_square\square1.pk3
ECHO     "HARM1"     Harmony              conversions\harmony\harm1.wad
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
PAUSE & EXIT /B 0

REM #	choco		- ONLY chocolate-doom/heretic/hexen
REM #	prboom		- requires prboom+ specifically (either HW or SW); e.g. "Comatose.wad"
REM #	hw		- requires a hardware renderer; glboom+, gzdoom, zandronum
REM #	sw		- requires a software renderer; choco-doom, prboom+, zdoom
REM #	z		- requires a z-based engine; zdoom, gzdoom, zandronum
REM #	zdoom		- zdoom based engines, i.e. zdoom, gzdoom (but not zandronum)
REM #	gzdoom		- gzdoom only
REM #	gzdoom-??	- gzdoom version ?? only, e.g. gzdoom-22
REM #	doom64		- DOOM 64 EX only
REM #	zandronum	- zandronum only (latest version)
REM #	zandronum-2	- zandronum v2 only 
REM #	zandronum-3	- zandronum v3 only


:init
REM # path of this script
REM # (do this before using `SHIFT`)
SET "HERE=%~dp0"
IF "%HERE:~-1,1%" == "\" SET "HERE=%HERE:~0,-1%"

REM # the list of available engines;
REM # the provided requirements will narrow this list down
SET "ENGINE_CHOCODOOM=1"	& REM # vanilla, dehacked
SET "ENGINE_CRISPYDOOM=1"	& REM # vanilla, dehacked, no-limit
SET "ENGINE_DOOMRETRO=1"	& REM # vanilla, dehacked, boom, BEX
SET "ENGINE_PRBOOM=1"		& REM # vanilla, dehacked, boom, BEX, MBF
SET "ENGINE_ZANDRONUM=1"	& REM # vanilla, dehacked, boom, BEX, MBF, ACS, DECORATE, UDMF
SET "ENGINE_GZDOOM=1"		& REM # vanilla, dehacked, boom, BEX, MBF, ACS, DECORATE, UDMF, ZScript
SET "ENGINE_DOOM64EX=1"		& REM # doom64

REM # if software-rendering is required
SET SW=0

REM # when a specific version of a particular engine is required
SET "VER_GZDOOM=gzdoom"
SET "VER_ZANDRONUM=zandronum"

REM # param values
SET "REQS="
SET "IWAD="
SET "PWAD="
SET "DEH="
SET "BEX="
SET "WARP="
SET "SKILL="
SET "PARAMS="
SET "FILES="
SET "ENGINE="
SET "CMPLVL="
SET "EXEC="


:params
REM ====================================================================================================================
REM # engine requirements?
IF /I "%~1" == "/REQ" (
	REM # this needs to be broken down into particles
	CALL :reqs "%~2"
	SHIFT & SHIFT
	GOTO :params
)
REM # WAD parameter?
IF /I "%~1" == "/IWAD" (
	REM # just capture the parameter, validation happens after all parameters are gathered
	SET IWAD=%~2
	REM # check for any other parameters
	SHIFT & SHIFT
	GOTO :params
)
IF /I "%~1" == "/PWAD" (
	REM # just capture the parameter
	SET PWAD=%~2
	REM # check for any other parameters
	SHIFT & SHIFT
	GOTO :params
)
IF /I "%~1" == "/DEH" (
	REM # just capture the parameter
	SET DEH=%~2
	REM # check for any other parameters
	SHIFT & SHIFT
	GOTO :params
)
IF /I "%~1" == "/BEX" (
	REM # just capture the parameter
	SET BEX=%~2
	REM # check for any other parameters
	SHIFT & SHIFT
	GOTO :params
)
REM # warp to a map number
IF /I "%~1" == "/WARP" (
	REM # just capture the parameter
	SET WARP=%~2
	REM # check for any other parameters
	SHIFT & SHIFT
	GOTO :params
)
REM # set skill (difficulty) level
IF /I "%~1" == "/SKILL" (
	REM # just capture the parameter
	SET SKILL=%~2
	REM # check for any other parameters
	SHIFT & SHIFT
	GOTO :params
)
REM # compatibility-level?
IF /I "%~1" == "/CMPLVL" (
	REM # just capture the parameter
	SET CMPLVL=%~2
	REM # check for any other parameters
	SHIFT & SHIFT
	GOTO :params
)
REM # execute script?
IF /I "%~1" == "/EXEC" (
	REM # just capture the parameter
	SET EXEC=%~2
	REM # check for any other parameters
	SHIFT & SHIFT
	GOTO :params
)

REM # end of parameters, a straight file-list will follow
IF "%~1" == "--" GOTO :files

REM # no more parameters
IF "%~1" == "" GOTO :validate

ECHO Invalid parameter!
ECHO "%~1"
EXIT /B 1

:files
REM --------------------------------------------------------------------------------------------------------------------
SHIFT

IF "%~1" == "" GOTO :validate

SET FILES=%FILES% "%~1"

GOTO :files


:validate
REM =====================================================================================================================

REM # The Ultimate DOOM
IF /I "%IWAD%" == "DOOM"	SET "IWAD=DOOM.WAD"
REM # DOOM II
IF /I "%IWAD%" == "DOOM2"	SET "IWAD=DOOM2.WAD"
REM # Final DOOM: TNT Evilution
IF /I "%IWAD%" == "TNT"		SET "IWAD=TNT.WAD"
REM # Final DOOM: The Plutonia Experiment
IF /I "%IWAD%" == "PLUTONIA"	SET "IWAD=PLUTONIA.WAD"
REM # Heretic, Hexen
IF /I "%IWAD%" == "HERETIC"	SET "IWAD=HERETIC.WAD"
IF /I "%IWAD%" == "HEXEN"	SET "IWAD=HEXEN.WAD"
REM # FreeDOOM: Phase 1 / 2
IF /I "%IWAD%" == "FREEDOOM1"	SET "IWAD=conversions\freedoom\freedoom1.wad"
IF /I "%IWAD%" == "FREEDOOM2"	SET "IWAD=conversions\freedoom\freedoom2.wad"
REM # Harmony
IF /I "%IWAD%" == "HARM1"	SET "IWAD=conversions\harmony\harm1.wad"

REM # shareware:
IF /I "%IWAD%" == "DOOM1"	SET "IWAD=SHARWARE\DOOM1.WAD"
IF /I "%IWAD%" == "HERETIC1"	SET "IWAD=SHAREWARE\HERETIC1.WAD"
IF /I "%IWAD%" == "SQUARE1"	SET "IWAD=SHAREWARE\adventures_of_square\square1.pk3"

REM # was an IWAD specified?
REM # it can be excluded so that doom.bat will do the selection based on engine used
IF NOT "%IWAD%" == "" (
	SET PARAMS=%PARAMS% /IWAD "%IWAD%"
)

REM # was a PWAD specified?
IF NOT "%PWAD%" == "" (
	SET PARAMS=%PARAMS% /PWAD "%PWAD%"
)

REM # was a DeHackEd / BEX script specified?
REM # TODO: limit this to engines that support it, select best option
IF NOT "%DEH%" == "" (
	SET PARAMS=%PARAMS% /DEH "%DEH%"
)
IF NOT "%BEX%" == "" (
	SET PARAMS=%PARAMS% /BEX "%BEX%"
)

:engine
REM --------------------------------------------------------------------------------------------------------------------
REM # check which engines are compatible and ask the user if more than one

REM # if software is required,
IF %SW% EQU 1 (
	REM # and there's a choice between PrBoom+ and GZDoom (software),
	REM # favour GZDoom. e.g. AA_E1.wad won't work with ZScript
	IF "%ENGINE_PRBOOM%-%ENGINE_GZDOOM%" == "1-1" SET ENGINE_PRBOOM=0
)

REM # count the number of compatible engines:
REM # TODO: DOOM Retro will be included later once the `-config` bug has been fixed (next release due)
SET /A ENGINE_COUNT=ENGINE_CHOCODOOM+ENGINE_DOOM64EX+ENGINE_PRBOOM+ENGINE_GZDOOM+ENGINE_ZANDRONUM
REM # no compatible engine?
IF %ENGINE_COUNT% EQU 0 (
	ECHO:
	ECHO  No compatible engine available.
	ECHO  Please check the REQuired parameter
	ECHO:
	ECHO      "/REQ %REQS%"
	ECHO:
	PAUSE & EXIT /B 1
)

REM # is there only one engine available?
IF %ENGINE_COUNT% EQU 1 (
	REM # set the engine name to pass on to the doom launcher
	IF %ENGINE_CHOCODOOM%  EQU 1 SET "ENGINE=choco-doom"
	IF %ENGINE_CRISPYDOOM% EQU 1 SET "ENGINE=crispy-doom"
	IF %ENGINE_PRBOOM%     EQU 1 SET "ENGINE=prboom"
	IF %ENGINE_ZANDRONUM%  EQU 1 SET "ENGINE=%VER_ZANDRONUM%"
	IF %ENGINE_GZDOOM%     EQU 1 SET "ENGINE=%VER_GZDOOM%"
	IF %ENGINE_DOOM64EX%   EQU 1 SET "ENGINE=doom64ex"
	REM # skip ahead
	GOTO :launch
)

REM # ask the user for a choice of engine
REM --------------------------------------------------------------------------------------------------------------------
ECHO:
ECHO   Please choose the option that best suits you:

IF "%ENGINE_GZDOOM%-%SW%" == "1-0" (
	ECHO:
	ECHO   [U]   Ultra: ^(gzdoom, hardware-rendering^)
	ECHO:
	ECHO         Play with greatly enhanced graphics and sound.
	ECHO         For high-end systems with a dedicated graphics-card
)

IF %ENGINE_PRBOOM% EQU 1 (
	ECHO:
	IF %SW% EQU 0 ECHO   [M]   Modern: ^(prboom-plus, hardware-rendering^)
	IF %SW% EQU 1 ECHO   [M]   Modern: ^(prboom-plus, software-rendering^)
	ECHO:
	ECHO         Play in modern resolutions and with conveniences such as mouse-look.
	ECHO         For weaker systems with integrated graphics ^(such as laptops^)
) ELSE (
	REM # if PrBoom+ is not available but GZDoom is, it will take the place of PrBoom+
	IF %ENGINE_GZDOOM% EQU 1 (
		ECHO:
		ECHO   [M]   Modern: ^(gzdoom, software-rendering^)
		ECHO:
		ECHO         A software renderer with modern resolutions and conveniences.
		ECHO         For weaker systems with integrated graphics ^(such as laptops^)
		ECHO:
		ECHO         NOTE: GZDoom's software-renderer is an exact replica of ZDoom,
		ECHO         and is offerred in cases where ZDoom compatibility is required.
	)
)

IF %ENGINE_CHOCODOOM% EQU 1 (
	ECHO:
	ECHO   [C]   Classic: ^(chocolate-doom^)
	ECHO:
	ECHO         Want to play DOOM as God / Carmack intended? ChocolateDOOM recreates
	ECHO         the exact behaviour ^(and misbehaviour^) of the original MS-DOS DOOM;
	ECHO         for the genuine '90s experience
)
ECHO:

REM # TODO: XP compatibility
CHOICE /C UMC /N  >NUL

IF ERRORLEVEL 3 SET "ENGINE=choco-doom" & GOTO :launch
IF ERRORLEVEL 2 (
	IF "%ENGINE_PRBOOM%-%ENGINE_GZDOOM%" == "0-1" (
		SET "ENGINE=gzdoom"
		SET SW=1
	) ELSE (
		SET "ENGINE=prboom"
	)
	GOTO :launch
)
IF ERRORLEVEL 1 SET "ENGINE=%VER_GZDOOM%"


:launch
REM ====================================================================================================================
:warp
REM --------------------------------------------------------------------------------------------------------------------
REM # if /WARP is specified, pass it on as is, doom.bat will handle the specifics
IF NOT "%WARP%" == "" SET PARAMS=%PARAMS% /WARP %WARP%

:skill
REM # if skill is specified, it can be set without asking user
IF NOT "%SKILL%" == "" SET PARAMS=%PARAMS% /SKILL %SKILL%

:exe
REM --------------------------------------------------------------------------------------------------------------------
REM # PrBoom+ requirements:
IF "%ENGINE%" == "prboom" (
	REM # if a compatibility-level is specified, include this for PRBoom engines
	IF NOT "%CMPLVL%" == "" SET PARAMS=%PARAMS% /CMPLVL %CMPLVL%
)
REM # execute script?
IF DEFINED EXEC SET PARAMS=%PARAMS% /EXEC %EXEC%

REM # hardware or software rendering?
REM # doom.bat will automatically handle using prboom & gzdoom's software renderer
IF %SW% EQU 1 SET PARAMS=%PARAMS% /SW

CALL "%HERE%\doom.bat" /USE %ENGINE% %PARAMS% -- %FILES%

EXIT /B



:reqs
REM ====================================================================================================================
SET REQS=%~1

REM # split the requirements list by "+" (up to three)
FOR /F "tokens=1-3 delims=:" %%A IN ("%~1") DO (
	IF NOT "%%A" == "" CALL :req "%%A"
	IF NOT "%%B" == "" CALL :req "%%B"
	IF NOT "%%C" == "" CALL :req "%%C"
	IF NOT "%%D" == "" CALL :req "%%D"
	IF NOT "%%E" == "" CALL :req "%%E"
	IF NOT "%%F" == "" CALL :req "%%F"
)
GOTO:EOF

:req
REM --------------------------------------------------------------------------------------------------------------------
REM # vanilla engines only:
IF /I "%~1" == "vanilla" (
	REM # disable non-vanilla engines
	SET ENGINE_DOOM64EX=0
)
REM # force Chocolate-* engine only:
IF /I "%~1" == "choco" (
	REM # disable non Chocolate-* engines
	SET ENGINE_CRISPYDOOM=0
	SET ENGINE_DOOMRETRO=0
	SET ENGINE_PRBOOM=0
	SET ENGINE_ZANDRONUM=0
	SET ENGINE_GZDOOM=0
	SET ENGINE_DOOM64EX=0
)
REM # DeHackEd capable engines only:
IF /I "%~1" == "deh" (
	REM # disable non-DeHackEd engines
	SET ENGINE_DOOM64EX=0
)
IF /I "%~1" == "dehacked" (
	REM # disable non-DeHackEd engines
	SET ENGINE_DOOM64EX=0
)
REM # requires a limit-removing engine:
IF /I "%~1" == "no-limit" (
	REM # disable Chocolate-* engines
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_DOOM64EX=0
)
REM # requires boom-compatible engine:
IF /I "%~1" == "boom" (
	REM # disable non-boom engines
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_CRISPYDOOM=0
	SET ENGINE_DOOM64EX=0
)
REM # requires BEX-capable engine:
REM # (note that Crispy Doom is BEX-compatible)
IF /I "%~1" == "bex" (
	REM # disable non-BEX-capable engines
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_DOOM64EX=0
)
REM # requires PRBoom+ specifically:
IF /I "%~1" == "prboom" (
	REM # disable non PRBoom+ engines
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_CRISPYDOOM=0
	SET ENGINE_DOOMRETRO=0
	SET ENGINE_ZANDRONUM=0
	SET ENGINE_GZDOOM=0
	SET ENGINE_DOOM64EX=0
)
REM # requires an MBF-compatible engine:
IF /I "%~1" == "mbf" (
	REM # whilst DOOM Retro is boom-compatible, it is not MBF-compatible like PrBoom+?
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_CRISPYDOOM=0
	SET ENGINE_DOOMRETRO=0
	SET ENGINE_DOOM64EX=0
)
REM # requires a UDMF-compatible engine:
IF /I "%~1" == "udmf" (
	REM # disable non-UDMF compatible engines:
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_CRISPYDOOM=0
	SET ENGINE_DOOMRETRO=0
	SET ENGINE_PRBOOM=0
	SET ENGINE_DOOM64EX=0
)
REM # requires an ACS-compatible engine:
IF /I "%~1" == "acs" (
	REM # disable non-ACS compatible engines:
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_CRISPYDOOM=0
	SET ENGINE_DOOMRETRO=0
	SET ENGINE_PRBOOM=0
	SET ENGINE_DOOM64EX=0
)
REM # requires a DECORATE-compatible engine:
IF /I "%~1" == "decorate" (
	REM # disable non-DECORATE compatible engines:
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_CRISPYDOOM=0
	SET ENGINE_DOOMRETRO=0
	SET ENGINE_PRBOOM=0
	SET ENGINE_DOOM64EX=0
)
REM # GZDoom only
IF /I "%~1" == "gzdoom" (
	REM # disable all non-GZDoom engines
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_CRISPYDOOM=0
	SET ENGINE_DOOMRETRO=0
	SET ENGINE_PRBOOM=0
	SET ENGINE_ZANDRONUM=0
	SET ENGINE_DOOM64EX=0
)
REM # Specific GZDoom version
IF /I "%~1" == "gzdoom-09" (
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_CRISPYDOOM=0
	SET ENGINE_DOOMRETRO=0
	SET ENGINE_PRBOOM=0
	SET ENGINE_ZANDRONUM=0
	SET ENGINE_DOOM64EX=0
	SET "VER_GZDOOM=gzdoom-09"
)
IF /I "%~1" == "gzdoom-10" (
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_CRISPYDOOM=0
	SET ENGINE_DOOMRETRO=0
	SET ENGINE_PRBOOM=0
	SET ENGINE_ZANDRONUM=0
	SET ENGINE_DOOM64EX=0
	SET "VER_GZDOOM=gzdoom-10"
)
IF /I "%~1" == "gzdoom-11" (
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_CRISPYDOOM=0
	SET ENGINE_DOOMRETRO=0
	SET ENGINE_PRBOOM=0
	SET ENGINE_ZANDRONUM=0
	SET ENGINE_DOOM64EX=0
	SET "VER_GZDOOM=gzdoom-11"
)
IF /I "%~1" == "gzdoom-12" (
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_CRISPYDOOM=0
	SET ENGINE_DOOMRETRO=0
	SET ENGINE_PRBOOM=0
	SET ENGINE_ZANDRONUM=0
	SET ENGINE_DOOM64EX=0
	SET "VER_GZDOOM=gzdoom-12"
)
IF /I "%~1" == "gzdoom-13" (
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_CRISPYDOOM=0
	SET ENGINE_DOOMRETRO=0
	SET ENGINE_PRBOOM=0
	SET ENGINE_ZANDRONUM=0
	SET ENGINE_DOOM64EX=0
	SET "VER_GZDOOM=gzdoom-13"
)
IF /I "%~1" == "gzdoom-14" (
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_CRISPYDOOM=0
	SET ENGINE_DOOMRETRO=0
	SET ENGINE_PRBOOM=0
	SET ENGINE_ZANDRONUM=0
	SET ENGINE_DOOM64EX=0
	SET "VER_GZDOOM=gzdoom-14"
)
IF /I "%~1" == "gzdoom-15" (
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_CRISPYDOOM=0
	SET ENGINE_DOOMRETRO=0
	SET ENGINE_PRBOOM=0
	SET ENGINE_ZANDRONUM=0
	SET ENGINE_DOOM64EX=0
	SET "VER_GZDOOM=gzdoom-15"
)
IF /I "%~1" == "gzdoom-16" (
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_CRISPYDOOM=0
	SET ENGINE_DOOMRETRO=0
	SET ENGINE_PRBOOM=0
	SET ENGINE_ZANDRONUM=0
	SET ENGINE_DOOM64EX=0
	SET "VER_GZDOOM=gzdoom-16"
)
IF /I "%~1" == "gzdoom-17" (
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_CRISPYDOOM=0
	SET ENGINE_DOOMRETRO=0
	SET ENGINE_PRBOOM=0
	SET ENGINE_ZANDRONUM=0
	SET ENGINE_DOOM64EX=0
	SET "VER_GZDOOM=gzdoom-17"
)
IF /I "%~1" == "gzdoom-18" (
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_CRISPYDOOM=0
	SET ENGINE_DOOMRETRO=0
	SET ENGINE_PRBOOM=0
	SET ENGINE_ZANDRONUM=0
	SET ENGINE_DOOM64EX=0
	SET "VER_GZDOOM=gzdoom-18"
)
IF /I "%~1" == "gzdoom-19" (
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_CRISPYDOOM=0
	SET ENGINE_DOOMRETRO=0
	SET ENGINE_PRBOOM=0
	SET ENGINE_ZANDRONUM=0
	SET ENGINE_DOOM64EX=0
	SET "VER_GZDOOM=gzdoom-19"
)
IF /I "%~1" == "gzdoom-20" (
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_CRISPYDOOM=0
	SET ENGINE_DOOMRETRO=0
	SET ENGINE_PRBOOM=0
	SET ENGINE_ZANDRONUM=0
	SET ENGINE_DOOM64EX=0
	SET "VER_GZDOOM=gzdoom-20"
)
IF /I "%~1" == "gzdoom-21" (
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_CRISPYDOOM=0
	SET ENGINE_DOOMRETRO=0
	SET ENGINE_PRBOOM=0
	SET ENGINE_ZANDRONUM=0
	SET ENGINE_DOOM64EX=0
	SET "VER_GZDOOM=gzdoom-21"
)
IF /I "%~1" == "gzdoom-22" (
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_CRISPYDOOM=0
	SET ENGINE_DOOMRETRO=0
	SET ENGINE_PRBOOM=0
	SET ENGINE_ZANDRONUM=0
	SET ENGINE_DOOM64EX=0
	SET "VER_GZDOOM=gzdoom-22"
)
IF /I "%~1" == "gzdoom-23" (
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_CRISPYDOOM=0
	SET ENGINE_DOOMRETRO=0
	SET ENGINE_PRBOOM=0
	SET ENGINE_ZANDRONUM=0
	SET ENGINE_DOOM64EX=0
	SET "VER_GZDOOM=gzdoom-23"
)
IF /I "%~1" == "gzdoom-24" (
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_CRISPYDOOM=0
	SET ENGINE_DOOMRETRO=0
	SET ENGINE_PRBOOM=0
	SET ENGINE_ZANDRONUM=0
	SET ENGINE_DOOM64EX=0
	SET "VER_GZDOOM=gzdoom-24"
)
IF /I "%~1" == "gzdoom-30" (
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_CRISPYDOOM=0
	SET ENGINE_DOOMRETRO=0
	SET ENGINE_PRBOOM=0
	SET ENGINE_ZANDRONUM=0
	SET ENGINE_DOOM64EX=0
	SET "VER_GZDOOM=gzdoom-32"
)
IF /I "%~1" == "gzdoom-31" (
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_CRISPYDOOM=0
	SET ENGINE_DOOMRETRO=0
	SET ENGINE_PRBOOM=0
	SET ENGINE_ZANDRONUM=0
	SET ENGINE_DOOM64EX=0
	SET "VER_GZDOOM=gzdoom-32"
)
IF /I "%~1" == "gzdoom-32" (
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_CRISPYDOOM=0
	SET ENGINE_DOOMRETRO=0
	SET ENGINE_PRBOOM=0
	SET ENGINE_ZANDRONUM=0
	SET ENGINE_DOOM64EX=0
	SET "VER_GZDOOM=gzdoom-32"
)
REM # hardware-renderers only:
IF /I "%~1" == "hw" (
	REM # disable all non-hardware renderers
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_CRISPYDOOM=0
	SET ENGINE_DOOMRETRO=0
	SET SW=0
)
REM # software-renderers only:
IF /I "%~1" == "sw" (
	REM # disable all non-software renderers
	SET ENGINE_ZANDRONUM=0
	SET ENGINE_DOOM64EX=0
	SET SW=1
)
REM # z-based engines; ZDoom, GZDoom, Zandronum
IF /I "%~1" == "z" (
	REM # disable all non-ZDoom-based engines
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_CRISPYDOOM=0
	SET ENGINE_DOOMRETRO=0
	SET ENGINE_PRBOOM=0
	SET ENGINE_DOOM64EX=0
)
REM # Zandronum only:
IF /I "%~1" == "zandronum" (
	REM # disable all non-Zandronum engines
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_CRISPYDOOM=0
	SET ENGINE_DOOMRETRO=0
	SET ENGINE_PRBOOM=0
	SET ENGINE_GZDOOM=0
	SET ENGINE_DOOM64EX=0
)
REM # Zandronum v2 only:
IF /I "%~1" == "zandronum-2" (
	REM # set Zandronum specific version number
	SET "VER_ZANDRONUM=zandronum-2"
	REM # disable all non-Zandronum engines
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_CRISPYDOOM=0
	SET ENGINE_DOOMRETRO=0
	SET ENGINE_PRBOOM=0
	SET ENGINE_GZDOOM=0
	SET ENGINE_DOOM64EX=0
)
REM # Zandronum v3 only:
IF /I "%~1" == "zandronum-3" (
	REM # set Zandronum specific version number
	SET "VER_ZANDRONUM=zandronum-3"
	REM # disable all non-Zandronum engines
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_CRISPYDOOM=0
	SET ENGINE_DOOMRETRO=0
	SET ENGINE_PRBOOM=0
	SET ENGINE_GZDOOM=0
	SET ENGINE_DOOM64EX=0
)
REM # ZDoom or GZDoom:
IF /I "%~1" == "zdoom" (
	REM # disable all non-ZDoom-based engines
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_CRISPYDOOM=0
	SET ENGINE_DOOMRETRO=0
	SET ENGINE_PRBOOM=0
	SET ENGINE_ZANDRONUM=0
	SET ENGINE_DOOM64EX=0
)
REM # requires Doom 64 capable engine; Doom 64 EX only at this time
IF /I "%~1" == "doom64" (
	REM # disable all non DOOM-64 engines
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_CRISPYDOOM=0
	SET ENGINE_DOOMRETRO=0
	SET ENGINE_PRBOOM=0
	SET ENGINE_ZANDRONUM=0
	SET ENGINE_GZDOOM=0
)
SET "REQ=%~1"
GOTO:EOF