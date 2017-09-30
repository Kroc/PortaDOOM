@ECHO OFF & SETLOCAL ENABLEEXTENSIONS DISABLEDELAYEDEXPANSION
PUSHD %~dp0

REM # detect 32-bit or 64-bit Windows
SET WINBIT=32
IF /I "%PROCESSOR_ARCHITECTURE%" == "EM64T" SET WINBIT=64	& REM # Itanium
IF /I "%PROCESSOR_ARCHITECTURE%" == "AMD64" SET WINBIT=64	& REM # Regular x64
IF /I "%PROCESSOR_ARCHITEW6432%" == "AMD64" SET WINBIT=64	& REM # 32-bit CMD on a 64-bit system (WOW64)

REM # select 7Zip executable
IF %WINBIT% EQU 64 SET "BIN_7ZA=bin\7za\7za_x64.exe"
IF %WINBIT% EQU 32 SET "BIN_7ZA=bin\7za\7za.exe"
REM # location of UPX executable
SET BIN_UPX="bin\upx\upx.exe"

REM # -ms=on    : solid-mode on (default)
REM # -mqs=on   : sort solid-files by type
REM # -mhc=on   : header compression on (default)
REM # -mx=9     : maximum compression (level 9)
REM # -myx=9    : maximum file analysis (level 9)
SET "ZIP_MAX=-ms=on -mqs=on -mhc=on -mx=9 -myx=9"
SET "ZIP_MIN=-ms=off -mhc=off -mx=0 -myx=0"

:menu
CLS
ECHO:
ECHO  Build PortaDOOM:
ECHO:
ECHO     [1]  Build PortaDOOM release
ECHO:
ECHO  Tools:
ECHO:
ECHO     [2]  Update PortaDOOM with DOSmag executable
ECHO     [3]  Compress executables ^(UPX^)
ECHO:
ECHO  Source Control:
ECHO:
ECHO     [8]  `git pull` DOSmag
ECHO     [9]  `git push` DOSmag
ECHO:
SET /P "$=Enter choice: "


IF "%$%" == "1" GOTO :do_release
IF "%$%" == "2" GOTO :do_dosmag_copy
IF "%$%" == "8" GOTO :do_dosmag_pull
IF "%$%" == "9" GOTO :do_dosmag_push

GOTO :menu

:select_compression
REM ====================================================================================================================
CLS
ECHO:
ECHO  Select Compression Level:
ECHO:
ECHO     [0]  None
ECHO     [1]  Maximum
ECHO:
SET /P "$=Enter choice: "
ECHO:

SET CMPLVL=0
IF "%$%" == "0" SET CMPLVL=0
IF "%$%" == "1" SET CMPLVL=1

GOTO:EOF


:do_release
REM ====================================================================================================================
CLS & TITLE Creating PortaDOOM release...
CALL :select_compression

ECHO * Clean Up
REM --------------------------------------------------------------------------------------------------------------------
DEL PortaDOOM\PortaDOOM.upx		>NUL 2>&1
DEL build\PortaDOOM.7z			>NUL 2>&1
DEL build\PortaDOOM_Cacowards2015.7z	>NUL 2>&1

ECHO * Copy DOSmag executable
REM --------------------------------------------------------------------------------------------------------------------
COPY /Y DOSmag\DOSmag.exe PortaDOOM\PortaDOOM.exe  >NUL 2>&1
ECHO:

IF %CMPLVL% EQU 1 (
	ECHO * Compress DOSmag executable
	ECHO:
	%BIN_UPX% --ultra-brute PortaDOOM\PortaDOOM.exe
	ECHO:
)

REM --------------------------------------------------------------------------------------------------------------------
REM # a         : add to archive
REM # -bso0	: disable message output
REM # -bsp1	: display only progress
REM # -r        : recurse sub-directories
REM # -stl	: sets the archive's timestamp to that of the latest file
REM # -sfx...   : Create self-extracting archive  # -sfx7z.sfx 
REM # -xr...	: exclude files (recursively)
IF %CMPLVL% EQU 0 SET "ZIP_LVL=%ZIP_MIN%"
IF %CMPLVL% EQU 1 SET "ZIP_LVL=%ZIP_MAX%"

PUSHD PortaDOOM

ECHO * Make PortaDOOM_5YearsOfDoom ...
REM --------------------------------------------------------------------------------------------------------------------
REM # swap over the homepages
REN "pages\Home #01.dosmag" "Home #01.old"
COPY "pages\PortaDOOM Cacowards 5 Years of Doom.dosmag" "pages\Home #01.dosmag"  >NUL 2>&1
IF ERRORLEVEL 1 PAUSE & EXIT

REM # 7ZIP
"..\%BIN_7ZA%" a -bso0 -bsp1 %ZIP_LVL% -stl -xr@..\bin\ignore.lst -i@..\bin\include_cacowards5years.lst -- ..\build\PortaDOOM_5YearsOfDoom.7z

REM # restore the original home page
ERASE "pages\Home #01.dosmag"
REN "pages\Home #01.old" "Home #01.dosmag"
IF ERRORLEVEL 1 PAUSE & EXIT

ECHO * Make PortaDOOM_Cacowards2015 ...
REM --------------------------------------------------------------------------------------------------------------------
REM # swap over the homepages
REN "pages\Home #01.dosmag" "Home #01.old"
COPY "pages\PortaDOOM Cacowards 2015.dosmag" "pages\Home #01.dosmag"  >NUL 2>&1
IF ERRORLEVEL 1 PAUSE & EXIT

REM # 7ZIP
"..\%BIN_7ZA%" a -bso0 -bsp1 %ZIP_LVL% -stl -xr@..\bin\ignore.lst -i@..\bin\include_cacowards2015.lst -- ..\build\PortaDOOM_Cacowards2015.7z

REM # restore the original home page
ERASE "pages\Home #01.dosmag"
REN "pages\Home #01.old" "Home #01.dosmag"
IF ERRORLEVEL 1 PAUSE & EXIT

ECHO * Make PortaDOOM_Cacowards2016 ...
REM --------------------------------------------------------------------------------------------------------------------
REM # swap over the homepages
REN "pages\Home #01.dosmag" "Home #01.old"
COPY "pages\PortaDOOM Cacowards 2016.dosmag" "pages\Home #01.dosmag"  >NUL 2>&1
IF ERRORLEVEL 1 PAUSE & EXIT

REM # 7ZIP
"..\%BIN_7ZA%" a -bso0 -bsp1 %ZIP_LVL% -stl -xr@..\bin\ignore.lst -i@..\bin\include_cacowards2016.lst -- ..\build\PortaDOOM_Cacowards2016.7z

REM # restore the original home page
ERASE "pages\Home #01.dosmag"
REN "pages\Home #01.old" "Home #01.dosmag"
IF ERRORLEVEL 1 PAUSE & EXIT

POPD
PAUSE & EXIT /B

ECHO * Make PortaDOOM ...
REM --------------------------------------------------------------------------------------------------------------------
REM # 7ZIP
"%BIN_7ZA%" a -bso0 -bsp1 -r %ZIP_LVL% -stl -xr@bin\ignore.lst -- build\PortaDOOM.7z PortaDOOM

ECHO:
ECHO Complete.
ECHO:
PAUSE
EXIT /B


:do_dosmag_copy
REM ====================================================================================================================
CLS
COPY /Y DOSmag\DOSmag.exe PortaDOOM\PortaDOOM.exe

START "" PortaDOOM\PortaDOOM.exe

EXIT /B


:do_dosmag_pull
REM ====================================================================================================================
REM # updates DOSmag from the GitLab repo

REM # TODO: check for existence of git

CLS
ECHO Pulling DOSmag updates from GitHub:
ECHO (working copy must be clean!)
ECHO:

git subtree pull --prefix DOSmag --squash dosmag master

COPY /Y DOSmag\DOSmag.exe PortaDOOM\PortaDOOM.exe >NUL

ECHO:
PAUSE
EXIT /B


:do_dosmag_push
REM ====================================================================================================================

CLS
ECHO Pushing DOSmag changes to GitHub:
ECHO:

git subtree push --prefix DOSmag dosmag master

ECHO:
PAUSE
EXIT /B