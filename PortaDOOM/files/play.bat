@ECHO OFF & SETLOCAL ENABLEEXTENSIONS DISABLEDELAYEDEXPANSION

REM # play.bat [/IWAD iwad] [/REQ engines] [/PWAD pwad] [options] [-- files...]

REM # [/IWAD iwad]      specifies IWAD to load, can be any of the following:
REM #                   (defaults to DOOM2)
REM #
REM #                   DOOM, DOOM2, TNT, PLUTONIA
REM #			HERETIC, HEXEN
REM #			FREEDOOM1, FREEDOOM2
REM #			SQUARE1
REM #			HARM1
REM #
REM # [/REQ engines]    specify engine requirements,
REM #                   can be any of the following:
REM # 
REM #			no-limit 	- requires a limits-removing engine
REM #			boom		- requires boom-compatibility; prboom+ and above
REM #                   prboom          - requires prboom+ specifically (either HW or SW); e.g. "Comatose.wad"
REM #			sw		- requires a software renderer; choco-doom, prboom+, zdoom
REM #			z		- requires a z-based engine; zdoom, gzdoom, zandronum
REM #			zdoom		- zdoom and gzdoom. use `zdoom+sw` to infer zdoom only
REM #			gzdoom		- gzdoom only
REM #			gzdoom-??	- gzdoom version ?? only, e.g. gzdoom-22
REM #			doom64		- DOOM 64 EX only
REM #                   zandronum	- zandronum only (latest version)
REM #			zandronum-2	- zandronum v2 only 
REM #                   zandronum-3     - zandronum v3 only


REM # path of this script
REM # (do this before using `SHIFT`)
SET "HERE=%~dp0"
IF "%HERE:~-1,1%" == "\" SET "HERE=%HERE:~0,-1%"

REM # the list of available engines; the provided requirements will narrow this list down
SET "ENGINE_CHOCODOOM=1"
SET "ENGINE_DOOM64EX=1"
SET "ENGINE_GLBOOM=1"
SET "ENGINE_GZDOOM=1"
SET "ENGINE_PRBOOM=1"
SET "ENGINE_ZANDRONUM=1"
SET "ENGINE_ZDOOM=1"

REM # when a specific version of a particular engine is required
SET "VER_GZDOOM=gzdoom"
SET "VER_BOOM="
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

REM # count the number of compatible engines:
SET /A ENGINE_COUNT=ENGINE_CHOCODOOM+ENGINE_DOOM64EX+ENGINE_GLBOOM+ENGINE_GZDOOM+ENGINE_PRBOOM+ENGINE_ZANDRONUM ^
                   +ENGINE_ZDOOM
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
	IF %ENGINE_GLBOOM%    EQU 1 SET "ENGINE=glboom"
	IF %ENGINE_GZDOOM%    EQU 1 SET "ENGINE=%VER_GZDOOM%"
	IF %ENGINE_PRBOOM%    EQU 1 SET "ENGINE=prboom"
	IF %ENGINE_ZANDRONUM% EQU 1 SET "ENGINE=%VER_ZANDRONUM%"
	IF %ENGINE_ZDOOM%     EQU 1 SET "ENGINE=zdoom"
	REM # skip ahead
	GOTO :launch
)

REM # ask the user for a choice of engine
REM --------------------------------------------------------------------------------------------------------------------
ECHO:
ECHO   Please choose the option that best suits you:

IF %ENGINE_GZDOOM% EQU 1 (
	ECHO:
	ECHO   [U]   Ultra: ^(gzdoom^)
	ECHO:
	ECHO         Play with greatly enhanced graphics and sound.
	ECHO         For high-end systems with a dedicated graphics-card
)

REM # PRBoom+ can be either hardware or software engine
REM # (prefer the hardware engine if enabled)
IF %ENGINE_PRBOOM% EQU 1 SET "VER_BOOM=prboom"
IF %ENGINE_GLBOOM% EQU 1 SET "VER_BOOM=glboom"

IF NOT "%VER_BOOM%" == "" (
	ECHO:
	ECHO   [M]   Modern: ^(prboom-plus^)
	ECHO:
	ECHO         Play in modern resolutions and with conveniences such as mouse-look.
	ECHO         For weaker systems with integrated graphics ^(such as laptops^)
) ELSE (
	REM # if prboom is not available but zdoom is, it will take the place of prboom
	IF %ENGINE_ZDOOM% EQU 1 (
		SET "VER_BOOM=zdoom"
		ECHO:
		ECHO   [M]   Modern: ^(zdoom^)
		ECHO:
		ECHO         A software renderer with modern resolutions and conveniences.
		ECHO         For weaker systems with integrated graphics ^(such as laptops^)
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

IF ERRORLEVEL 1 SET "ENGINE=%VER_GZDOOM%"
IF ERRORLEVEL 2 SET "ENGINE=%VER_BOOM%"
IF ERRORLEVEL 3 SET "ENGINE=choco-doom"


:launch
REM ====================================================================================================================
REM # IWAD parameter missing?
IF "%IWAD%" == "" (
	REM # default to DOOM2
	SET "IWAD=DOOM2.WAD"
)

IF "%ENGINE%" == "%VER_BOOM%" (
	REM # if a compatibility-level is specificed, include this for PRBoom engines
	IF NOT "%CMPLVL%" == "" SET "PARAMS=%PARAMS% -complevel %CMPLVL%"
)

REM # customisations for gzdoom:
IF NOT "%ENGINE%" == "%VER_GZDOOM%" GOTO :skill

REM # load the extra lighting information
SET FILES=%FILES% lights.pk3 brightmaps.pk3
REM # add PK's sound effects
REM SET FILES=%FILES% mods\pk_doom_sfx\pk_doom_sfx_20120224.wad

:skill
REM --------------------------------------------------------------------------------------------------------------------
REM # warping to a level? ask for difficulty level
REM # TODO: if -skill is already provided, skip this?

IF "%LEVEL%" == "" GOTO :exe

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
CALL "%HERE%\doom.bat" %ENGINE% %IWAD% %PWAD% %PARAMS% -- %FILES%

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
IF /I "%~1" == "FREEDOOM1" SET "IWAD=freedoom\freedoom1.wad"
IF /I "%~1" == "FREEDOOM2" SET "IWAD=freedoom\freedoom2.wad"
REM # Adventures of Square (shareware)
IF /I "%~1" == "SQUARE1" SET "IWAD=SHAREWARE\adventures_of_square\square1.pk3"
REM # Harmony
IF /I "%~1" == "HARM1" SET "IWAD=harmony\harm1.wad"

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
REM # requires a limit-removing engine
IF /I "%~1" == "no-limit" (
	REM # disable Chocolate-* engines
	SET ENGINE_CHOCODOOM=0
	SET "REQ=%~1"
)
REM # requires boom-compatible engine
IF /I "%~1" == "boom" (
	REM # disable non-boom engines
	SET ENGINE_CHOCODOOM=0
	SET "REQ=%~1"
)
REM # requires prboom+ specifically
IF /I "%~1" == "prboom" (
	REM # disable non prboom+ engines
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_DOOM64EX=0
	SET ENGINE_GZDOOM=0
	SET ENGINE_ZANDRONUM=0
	SET ENGINE_ZDOOM=0
	SET "REQ=%~1"
)
REM # requires doom 64 capable engine; doom 64 ex only at this time
IF /I "%~1" == "doom64" (
	REM # disable all non DOOM-64 engines
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_GLBOOM=0
	SET ENGINE_GZDOOM=0
	SET ENGINE_PRBOOM=0
	SET ENGINE_ZANDRONUM=0
	SET ENGINE_ZDOOM=0
	SET "REQ=%~1"
)
REM # gzdoom only
IF /I "%~1" == "gzdoom" (
	REM # disable all non-GZDoom engines
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_DOOM64EX=0
	SET ENGINE_GLBOOM=0
	SET ENGINE_PRBOOM=0
	SET ENGINE_ZANDRONUM=0
	SET ENGINE_ZDOOM=0
	SET "REQ=%~1"
)
IF /I "%~1" == "gzdoom-22" (
	REM # disable all non-GZDoom engines
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_DOOM64EX=0
	SET ENGINE_GLBOOM=0
	SET ENGINE_PRBOOM=0
	SET ENGINE_ZANDRONUM=0
	SET ENGINE_ZDOOM=0
	SET "VER_GZDOOM=gzdoom-22"
	SET "REQ=%~1"
)
IF /I "%~1" == "gzdoom-23" (
	REM # disable all non-GZDoom engines
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_DOOM64EX=0
	SET ENGINE_GLBOOM=0
	SET ENGINE_PRBOOM=0
	SET ENGINE_ZANDRONUM=0
	SET ENGINE_ZDOOM=0
	SET "VER_GZDOOM=gzdoom-23"
	SET "REQ=%~1"
)
IF /I "%~1" == "gzdoom-24" (
	REM # disable all non-GZDoom engines
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_DOOM64EX=0
	SET ENGINE_GLBOOM=0
	SET ENGINE_PRBOOM=0
	SET ENGINE_ZANDRONUM=0
	SET ENGINE_ZDOOM=0
	SET "VER_GZDOOM=gzdoom-24"
	SET "REQ=%~1"
)
IF /I "%~1" == "gzdoom-31" (
	REM # disable all non-GZDoom engines
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_DOOM64EX=0
	SET ENGINE_GLBOOM=0
	SET ENGINE_PRBOOM=0
	SET ENGINE_ZANDRONUM=0
	SET ENGINE_ZDOOM=0
	SET "VER_GZDOOM=gzdoom-31"
	SET "REQ=%~1"
)
REM # hardware-renderers only
IF /I "%~1" == "hw" (
	REM # disable all non-hardware renderers
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_PRBOOM=0
	SET ENGINE_ZDOOM=0
	SET "REQ=%~1"
)
REM # software-renderers only
IF /I "%~1" == "sw" (
	REM # disable all non-software renderers
	SET ENGINE_DOOM64EX=0
	SET ENGINE_GLBOOM=0
	SET ENGINE_GZDOOM=0
	SET ENGINE_ZANDRONUM=0
	SET "REQ=%~1"
)
REM # z-based engines; zdoom, gzdoom, zandronum
IF /I "%~1" == "z" (
	REM # disable all non-zdoom-based engines
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_DOOM64EX=0
	SET ENGINE_GLBOOM=0
	SET ENGINE_PRBOOM=0
	SET "REQ=%~1"
)
REM # zandronum only
IF /I "%~1" == "zandronum" (
	REM # disable all non-Zandronum engines
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_DOOM64EX=0
	SET ENGINE_GLBOOM=0
	SET ENGINE_GZDOOM=0
	SET ENGINE_PRBOOM=0
	SET ENGINE_ZDOOM=0
	SET "REQ=%~1"
)
REM # zandronum v2 only
IF /I "%~1" == "zandronum-2" (
	REM # set zandronum specific version number
	SET "VER_ZANDRONUM=zandronum-2"
	REM # disable all non-Zandronum engines
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_DOOM64EX=0
	SET ENGINE_GLBOOM=0
	SET ENGINE_GZDOOM=0
	SET ENGINE_PRBOOM=0
	SET ENGINE_ZDOOM=0
	SET "REQ=%~1"
)
REM # zandronum v3 only
IF /I "%~1" == "zandronum-3" (
	REM # set zandronum specific version number
	SET "VER_ZANDRONUM=zandronum-3"
	REM # disable all non-Zandronum engines
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_DOOM64EX=0
	SET ENGINE_GLBOOM=0
	SET ENGINE_GZDOOM=0
	SET ENGINE_PRBOOM=0
	SET ENGINE_ZDOOM=0
	SET "REQ=%~1"
)
REM # zdoom or gzdoom
IF /I "%~1" == "zdoom" (
	REM # disable all non-ZDoom engines
	SET ENGINE_CHOCODOOM=0
	SET ENGINE_DOOM64EX=0
	SET ENGINE_GLBOOM=0
	SET ENGINE_PRBOOM=0
	SET ENGINE_ZANDRONUM=0
	SET "REQ=%~1"
)
GOTO:EOF

:complevel
REM ====================================================================================================================
SHIFT

SET "CMPLVL=%~1"

SHIFT
GOTO :params
