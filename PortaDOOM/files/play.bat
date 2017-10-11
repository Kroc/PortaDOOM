@ECHO OFF & SETLOCAL ENABLEEXTENSIONS DISABLEDELAYEDEXPANSION

REM # any parameters?
REM # whilst all parameters would be optional (and DOOM2 would be launched by
REM # default, we do want to echo the help text)
IF NOT "%~1" == "" GOTO :init

ECHO:
ECHO  "play.bat" is a command-line utility for selecting and launching DOOM engines.
ECHO  Given a set of requirements for a DOOM WAD, "play.bat" will present you with
ECHO  choices available (if any) and launch the game with the correct configuration
ECHO  through its sister script "doom.bat".
ECHO:
ECHO  Usage:
ECHO:
ECHO     play.bat [/IWAD ^<iwad^>] [/REQ ^<engines^>]
ECHO              [/PWAD ^<file^>] [/DEH ^<file^>] [/BEX ^<file^>]
ECHO              [/WARP ^<map-number^>] [/SKILL ^<skill-level^>]
ECHO              [-- ^<files^>...]
ECHO:
ECHO  /IWAD ^<iwad^>
ECHO:
ECHO  Specifies the IWAD to use. Note that unlike "doom.bat", some shorthand terms
ECHO  are available and "play.bat" will provide the file path for you. These are:
ECHO:
ECHO    ^<iwad^>      Description          File path "wads\*"
ECHO    -----------------------------------------------------------------------------
ECHO    "DOOM"      Registerd DOOM       "DOOM.WAD"
ECHO    "DOOM1"     DOOM Shareware       "SHAREWARE\DOOM1.WAD"
ECHO    "DOOM2"     DOOM II              "DOOM2.WAD"
ECHO    "FREEDOOM1" FreeDOOM Phase I     "conversions\FreeDOOM\FREEDOOM1.WAD"
ECHO    "FREEDOOM2" FreeDOOM Phase II    "conversions\FreeDOOM\FREEDOOM2.WAD"
ECHO    "HERETIC"   Registered Heretic   "HERETIC.WAD"
ECHO    "HERETIC1"  Heretic Shareware    "SHAREWARE\HERETIC1.WAD"
ECHO    "HEXEN"     Hexen                "HEXEN.WAD"
ECHO    "SQUARE1"   Adventures of Square "SHAREWARE\adventures_of_square\square1.pk3"
ECHO    "HARM1"     Harmony              "conversions\harmony\harm1.wad"
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
PAUSE & EXIT /B 0

REM #
REM # [/REQ engines]	specify engine requirements,
REM #			can be any of the following:
REM # 
REM #			vanilla		- original DOOM with limits (visplane etc.) or above
REM #			choco		- ONLY chocolate-doom/heretic/hexen
REM #			no-limit 	- requires a limits-removing engine
REM #			boom		- requires boom-compatibility; prboom+ and above
REM #			prboom		- requires prboom+ specifically (either HW or SW); e.g. "Comatose.wad"
REM #			hw		- requires a hardware renderer; glboom+, gzdoom, zandronum
REM #			sw		- requires a software renderer; choco-doom, prboom+, zdoom
REM #			z		- requires a z-based engine; zdoom, gzdoom, zandronum
REM #			zdoom		- zdoom based engines, i.e. zdoom, gzdoom (but not zandronum)
REM #			gzdoom		- gzdoom only
REM #			gzdoom-??	- gzdoom version ?? only, e.g. gzdoom-22
REM #			doom64		- DOOM 64 EX only
REM #			zandronum	- zandronum only (latest version)
REM #			zandronum-2	- zandronum v2 only 
REM #			zandronum-3	- zandronum v3 only


:init
REM # path of this script
REM # (do this before using `SHIFT`)
SET "HERE=%~dp0"
IF "%HERE:~-1,1%" == "\" SET "HERE=%HERE:~0,-1%"

REM # the list of available engines;
REM # the provided requirements will narrow this list down
SET "ENGINE_CHOCODOOM=1"
SET "ENGINE_DOOM64EX=1"
SET "ENGINE_GZDOOM=1"
SET "ENGINE_PRBOOM=1"
SET "ENGINE_ZANDRONUM=1"

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


:params
REM ====================================================================================================================
REM # engine requirements?
IF /I "%~1" == "/REQ" (
	REM # this needs to be broken down into particles
	SET REQS=%~2
	GOTO :reqs
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
REM # compatibility-level?
IF /I "%~1" == "/CMPLVL" (
	REM # just capture the parameter
	SET CMPLVL=%~2
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
	REM # and there's a choice between prboom and gzdoom (software),
	REM # favour gzdoom. e.g. AA_E1.wad won't work with ZScript
	IF "%ENGINE_PRBOOM%-%ENGINE_GZDOOM%" == "1-1" SET ENGINE_PRBOOM=0
)

REM # count the number of compatible engines:
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
	IF %ENGINE_CHOCODOOM% EQU 1 SET "ENGINE=choco-doom"
	IF %ENGINE_DOOM64EX%  EQU 1 SET "ENGINE=doom64ex"
	IF %ENGINE_GZDOOM%    EQU 1 SET "ENGINE=%VER_GZDOOM%"
	IF %ENGINE_PRBOOM%    EQU 1 SET "ENGINE=prboom"
	IF %ENGINE_ZANDRONUM% EQU 1 SET "ENGINE=%VER_ZANDRONUM%"
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
	REM # if prboom is not available but gzdoom is, it will take the place of prboom
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
IF NOT "%WARP%" == "" (
	SET PARAMS=%PARAMS% /WARP %WARP%
)

:skill
REM # if skill is specified, it can be set without asking user
IF NOT "%SKILL%" == "" (
	SET PARAMS=%PARAMS% /SKILL %SKILL%
	GOTO :exe
)

REM # if /WARP is specified, but not a skill-level we ask the user for it
IF "%WARP%" == "" GOTO :exe

REM # TODO: provide descriptions of the effects skill levels have;
REM #       see: https://doomwiki.org/wiki/Skill_level

ECHO:
ECHO -------------------------------------------------------------------------------
ECHO:
ECHO          CHOOSE YOUR SKILL LEVEL:
ECHO:
REM # DOOM 64 EX has different skill names:
IF "%ENGINE%" =="doom64ex" (
	ECHO          [1]  Be Gentle!
	ECHO          [2]  Bring It On!
	ECHO          [3]  I Own Doom!
	ECHO          [4]  Watch Me Die!
	
REM # Or Heretic:
REM # TODO: Also recognise HERETIC1.WAD (shareware)
REM # TODO: Hexen skill level names are based on class
) ELSE IF /I "%IWAD%" == "HERETIC.WAD" (
	ECHO          [1] Thou needeth a wet-nurse
	ECHO          [2] Yellowbellies-r-us
	ECHO          [3] Bringest them oneth
	ECHO          [4] Thou art a smite-meister
	ECHO          [5] Black plague possesses thee

REM # Or Strife:
REM # TODO: Also recognise STRIFE0.WAD (shareware)
) ELSE IF /I "%IWAD%" == "STRIFE1.WAD" (
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
	GOTO :skill_set

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

:skill_set
REM # add the skill to the command line
REM # (this will override any `-skill` parameter previously provided)
SET PARAMS=%PARAMS% /SKILL %SKILL%

:exe
REM --------------------------------------------------------------------------------------------------------------------
REM # prboom+ requirements:
IF "%ENGINE%" == "prboom" (
	REM # if a compatibility-level is specificed, include this for PRBoom engines
	IF NOT "%CMPLVL%" == "" SET PARAMS=%PARAMS% /CMPLVL %CMPLVL%
)

REM # GZDoom requirements:
IF "%ENGINE%" == "%VER_GZDOOM%" (
	REM # load the extra lighting information
	SET FILES=%FILES% lights.pk3 brightmaps.pk3
)

REM # hardware or software rendering?
REM # doom.bat will automatically handle using prboom & gzdoom's software renderer
IF %SW% EQU 1 SET PARAMS=%PARAMS% /SW

CALL "%HERE%\doom.bat" /USE %ENGINE% %PARAMS% -- %FILES%

EXIT /B



:reqs
REM ====================================================================================================================
SHIFT

REM # split the requirements list by "+" (up to three)
FOR /F "tokens=1-3 delims=+" %%A IN ("%REQS%") DO (
	IF NOT "%%A" == "" CALL :req "%%A"
	IF NOT "%%B" == "" CALL :req "%%B"
	IF NOT "%%C" == "" CALL :req "%%C"
)

SHIFT
GOTO :params

:req
REM --------------------------------------------------------------------------------------------------------------------
REM # force chocolate-* engine only:
IF /I "%~1" == "choco" (
	REM # disable non Chocolate-* engines
	SET "ENGINE_DOOM64EX=0"
	SET "ENGINE_GZDOOM=0"
	SET "ENGINE_PRBOOM=0"
	SET "ENGINE_ZANDRONUM=0"
)
REM # requires a limit-removing engine:
IF /I "%~1" == "no-limit" (
	REM # disable Chocolate-* engines
	SET ENGINE_CHOCODOOM=0
)
REM # requires boom-compatible engine:
IF /I "%~1" == "boom" (
	REM # disable non-boom engines
	SET ENGINE_CHOCODOOM=0
)
REM # requires prboom+ specifically:
IF /I "%~1" == "prboom" (
	REM # disable non prboom+ engines
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_DOOM64EX=0
	SET ENGINE_GZDOOM=0
	SET ENGINE_ZANDRONUM=0
)
REM # requires doom 64 capable engine; doom 64 ex only at this time
IF /I "%~1" == "doom64" (
	REM # disable all non DOOM-64 engines
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_GZDOOM=0
	SET ENGINE_PRBOOM=0
	SET ENGINE_ZANDRONUM=0
)
REM # gzdoom only
IF /I "%~1" == "gzdoom" (
	REM # disable all non-GZDoom engines
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_DOOM64EX=0
	SET ENGINE_PRBOOM=0
	SET ENGINE_ZANDRONUM=0
)
IF /I "%~1" == "gzdoom-22" (
	REM # disable all non-GZDoom engines
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_DOOM64EX=0
	SET ENGINE_PRBOOM=0
	SET ENGINE_ZANDRONUM=0
	SET "VER_GZDOOM=gzdoom-22"
)
IF /I "%~1" == "gzdoom-23" (
	REM # disable all non-GZDoom engines
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_DOOM64EX=0
	SET ENGINE_PRBOOM=0
	SET ENGINE_ZANDRONUM=0
	SET "VER_GZDOOM=gzdoom-23"
)
IF /I "%~1" == "gzdoom-24" (
	REM # disable all non-GZDoom engines
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_DOOM64EX=0
	SET ENGINE_PRBOOM=0
	SET ENGINE_ZANDRONUM=0
	SET "VER_GZDOOM=gzdoom-24"
)
IF /I "%~1" == "gzdoom-31" (
	REM # disable all non-GZDoom engines
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_DOOM64EX=0
	SET ENGINE_PRBOOM=0
	SET ENGINE_ZANDRONUM=0
	SET "VER_GZDOOM=gzdoom-31"
)
IF /I "%~1" == "gzdoom-32" (
	REM # disable all non-GZDoom engines
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_DOOM64EX=0
	SET ENGINE_PRBOOM=0
	SET ENGINE_ZANDRONUM=0
	SET "VER_GZDOOM=gzdoom-32"
)
REM # hardware-renderers only:
IF /I "%~1" == "hw" (
	REM # disable all non-hardware renderers
	SET ENGINE_CHOCODOOM=0
	SET SW=0
)
REM # software-renderers only:
IF /I "%~1" == "sw" (
	REM # disable all non-software renderers
	SET ENGINE_DOOM64EX=0
	SET ENGINE_ZANDRONUM=0
	SET SW=1
)
REM # z-based engines; zdoom, gzdoom, zandronum
IF /I "%~1" == "z" (
	REM # disable all non-zdoom-based engines
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_DOOM64EX=0
	SET ENGINE_PRBOOM=0
)
REM # zandronum only:
IF /I "%~1" == "zandronum" (
	REM # disable all non-Zandronum engines
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_DOOM64EX=0
	SET ENGINE_GZDOOM=0
	SET ENGINE_PRBOOM=0
)
REM # zandronum v2 only:
IF /I "%~1" == "zandronum-2" (
	REM # set zandronum specific version number
	SET "VER_ZANDRONUM=zandronum-2"
	REM # disable all non-Zandronum engines
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_DOOM64EX=0
	SET ENGINE_GZDOOM=0
	SET ENGINE_PRBOOM=0
)
REM # zandronum v3 only:
IF /I "%~1" == "zandronum-3" (
	REM # set zandronum specific version number
	SET "VER_ZANDRONUM=zandronum-3"
	REM # disable all non-Zandronum engines
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_DOOM64EX=0
	SET ENGINE_GZDOOM=0
	SET ENGINE_PRBOOM=0
)
REM # zdoom or gzdoom:
IF /I "%~1" == "zdoom" (
	REM # disable all non-ZDoom engines
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_DOOM64EX=0
	SET ENGINE_PRBOOM=0
	SET ENGINE_ZANDRONUM=0
)
SET "REQ=%~1"
GOTO:EOF