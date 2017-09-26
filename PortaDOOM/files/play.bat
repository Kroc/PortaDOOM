@ECHO OFF & SETLOCAL ENABLEEXTENSIONS DISABLEDELAYEDEXPANSION

REM # play.bat [/IWAD iwad] [/REQ engines] [/PWAD pwad] [options] [-- files...]

REM # [/IWAD iwad]	specifies IWAD to load, can be any of the following:
REM #			(defaults to DOOM2)
REM #
REM #			DOOM, DOOM1, DOOM2, TNT, PLUTONIA
REM #			HERETIC, HERETIC1, HEXEN
REM #			FREEDOOM1, FREEDOOM2
REM #			SQUARE1
REM #			HARM1
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


REM # path of this script
REM # (do this before using `SHIFT`)
SET "HERE=%~dp0"
IF "%HERE:~-1,1%" == "\" SET "HERE=%HERE:~0,-1%"

REM # the list of available engines; the provided requirements will narrow this list down
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
SET "IWAD="
SET "PWAD="
SET "PARAMS="
SET "FILES="
SET "ENGINE="
SET "CMPLVL="


:params
REM ====================================================================================================================
REM # WAD parameter?
IF /I "%~1" == "/IWAD" GOTO :iwad
IF /I "%~1" == "/PWAD" GOTO :pwad
REM # engine requirements?
IF /I "%~1" == "/REQ"  GOTO :reqs
REM # compatibility-level?
IF /I "%~1" == "/CMPLVL" GOTO :complevel
REM # warp to a level (will ask for difficulty)
IF /I "%~1" == "/LEVEL" GOTO :level

REM # end of options, a straight file-list will follow
IF "%~1" == "--" GOTO :files

REM # no more parameters
IF "%~1" == "" GOTO :engine

ECHO Invalid parameter!
ECHO "%~1"
EXIT /B 1

:files
REM --------------------------------------------------------------------------------------------------------------------
SHIFT

IF "%~1" == "" GOTO :engine

SET FILES=%FILES% "%~1"

GOTO :files

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
	ECHO      "/REQ %REQ%"
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
REM # IWAD parameter missing?
IF "%IWAD%" == "" (
	REM # default to DOOM2
	SET "IWAD=DOOM2.WAD"
)

IF "%ENGINE%" == "prboom" (
	REM # if a compatibility-level is specificed, include this for PRBoom engines
	IF NOT "%CMPLVL%" == "" SET "PARAMS=%PARAMS% -complevel %CMPLVL%"
)

:skill
REM --------------------------------------------------------------------------------------------------------------------
REM # warping to a level? ask for difficulty level
REM # TODO: if -skill is already provided, skip this?

IF "%LEVEL%" == "" GOTO :exe

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
SET "PARAMS=%PARAMS% -skill %SKILL%"

:exe
REM --------------------------------------------------------------------------------------------------------------------
SET "OPTIONS="

REM # GZDoom requirements:
IF "%ENGINE%" == "%VER_GZDOOM%" (
	REM # load the extra lighting information
	SET FILES=%FILES% lights.pk3 brightmaps.pk3
)
REM # hardware or software rendering?
REM # doom.bat will automatically handle using prboom & gzdoom's software renderer
IF %SW% EQU 1 SET "OPTIONS=/SW"

CALL "%HERE%\doom.bat" %OPTIONS% %ENGINE% %IWAD% %PWAD% %PARAMS% -- %FILES%

EXIT /B


:level
REM ====================================================================================================================
SHIFT

REM # the next parameter should be the level number
SET "LEVEL=%~1"

REM # is this a DOOM.WAD "e.m" format level number?
REM # (replace the dot with a space for the engines)
SET "LEVEL=%LEVEL:.= %"

REM # the option will occur first so that if another "-warp" parameters appears,
REM # it'll override this one
SET "PARAMS=%PARAMS% -warp %LEVEL%"

SHIFT
GOTO :params


:iwad
REM ====================================================================================================================
SHIFT

REM # The Ultimate DOOM
IF /I "%~1" == "DOOM" SET "IWAD=DOOM.WAD"
REM # DOOM II
IF /I "%~1" == "DOOM2" SET "IWAD=DOOM2.WAD"
REM # Final DOOM: TNT Evilution
IF /I "%~1" == "TNT" SET "IWAD=TNT.WAD"
REM # Final DOOM: The Plutonia Experiment
IF /I "%~1" == "PLUTONIA" SET "IWAD=PLUTONIA.WAD"
REM # Heretic, Hexen
IF /I "%~1" == "HERETIC" SET "IWAD=HERETIC.WAD"
IF /I "%~1" == "HEXEN" SET "IWAD=HEXEN.WAD"
REM # FreeDOOM: Phase 1 / 2
IF /I "%~1" == "FREEDOOM1" SET "IWAD=conversions\freedoom\freedoom1.wad"
IF /I "%~1" == "FREEDOOM2" SET "IWAD=conversions\freedoom\freedoom2.wad"
REM # Adventures of Square (shareware)
IF /I "%~1" == "SQUARE1" SET "IWAD=SHAREWARE\adventures_of_square\square1.pk3"
REM # Harmony
IF /I "%~1" == "HARM1" SET "IWAD=conversions\harmony\harm1.wad"

REM # shareware, for PWADs that don't need the full IWAD
REM # (this does not work for GZdoom)
IF /I "%~1" == "DOOM1"    SET "IWAD=SHARWARE\DOOM1.WAD"
IF /I "%~1" == "HERETIC1" SET "IWAD=SHAREWARE\HERETIC1.WAD"

SHIFT
GOTO :params


:pwad
REM ====================================================================================================================
SHIFT

SET "PWAD=%~1"

SHIFT
GOTO :params


:reqs
REM ====================================================================================================================
SHIFT

REM # split the requirements list by "+" (up to three)
FOR /F "tokens=1-3 delims=+" %%A IN ("%~1") DO (
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

:complevel
REM ====================================================================================================================
SHIFT

SET "CMPLVL=%~1"

SHIFT
GOTO :params
