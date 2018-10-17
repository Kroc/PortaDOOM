@ECHO OFF & SETLOCAL ENABLEEXTENSIONS DISABLEDELAYEDEXPANSION
PUSHD %~dp0

REM # detect 32-bit or 64-bit Windows
SET WINBIT=32
IF /I "%PROCESSOR_ARCHITECTURE%" == "EM64T" SET WINBIT=64 & REM # Itanium
IF /I "%PROCESSOR_ARCHITECTURE%" == "AMD64" SET WINBIT=64 & REM # Regular x64
REM # 32-bit CMD running on a 64-bit system (WOW64)
IF /I "%PROCESSOR_ARCHITEW6432%" == "AMD64" SET WINBIT=64

REM # select 7Zip executable
IF %WINBIT% EQU 64 SET BIN_7ZA="%~dp0bin\7za\7za_x64.exe"
IF %WINBIT% EQU 32 SET BIN_7ZA="%~dp0bin\7za\7za.exe"
REM # location of UPX executable
REM # (for compression EXE files)
SET BIN_UPX="%~dp0bin\upx\upx.exe"

REM # define ZIP compression profiles:
REM # -ms=on    : solid-mode on (default)
REM # -mqs=on   : sort solid-files by type
REM # -mhc=on   : header compression on (default)
REM # -mx=9     : maximum compression (level 9)
REM # -myx=9    : maximum file analysis (level 9)
SET "ZIP_MAX=-ms=on -mqs=on -mhc=on -mx=9 -myx=9"
SET "ZIP_MIN=-ms=off -mhc=off -mx=0 -myx=0"

:menu
CLS & TITLE PortaDOOM Build Tools:
ECHO:
ECHO  Build PortaDOOM:
ECHO:
ECHO     [1]  Build PortaDOOM release
ECHO:
ECHO  Tools:
ECHO:
ECHO     [2]  Update PortaDOOM with DOSmag executable
REM ECHO     [3]  Compress executables ^(UPX^)
ECHO:
ECHO  Source Control:
ECHO:
ECHO     [8]  `git pull` DOSmag
ECHO     [9]  `git push` DOSmag
ECHO:

SET "P="
SET /P "$=Enter choice: "

IF NOT EXIST "build" MKDIR "build"  >NUL 2>&1

IF "%$%" == "1" GOTO :do_release_menu
IF "%$%" == "2" GOTO :do_dosmag_copy
IF "%$%" == "3" GOTO :do_upx
IF "%$%" == "8" GOTO :do_dosmag_pull
IF "%$%" == "9" GOTO :do_dosmag_push

GOTO :menu

:select_compression
REM ============================================================================
REM # presents a menu to select the desired compression level
ECHO:
ECHO  Select Compression Level:
ECHO:
ECHO     [0]  None
ECHO     [1]  Maximum
ECHO:
SET /P "$=Enter choice: "

SET CMPLVL=0
IF "%$%" == "0" SET CMPLVL=0
IF "%$%" == "1" SET CMPLVL=1

IF %CMPLVL% EQU 0 SET "ZIP_LVL=%ZIP_MIN%"
IF %CMPLVL% EQU 1 SET "ZIP_LVL=%ZIP_MAX%"

REM # compile the launcher
REM ----------------------------------------------------------------------------
ECHO:
bin\qb64\qb64.exe -x -e -o "..\..\PortaDOOM\files\launcher.exe" "..\..\launcher\launcher.qb64"
REM # if that errored, pause to be able to show the error message
IF ERRORLEVEL 1 POPD & PAUSE & GOTO:EOF

REM # compress the launcher executable
IF %CMPLVL% EQU 1 (
	ECHO * Compress launcher executable
	ECHO:
	DEL PortaDOOM\files\launcher.upx  >NUL 2>&1
	%BIN_UPX% --ultra-brute PortaDOOM\files\launcher.exe
	ECHO:
)

REM # include and compress the DOSmag executable
REM ----------------------------------------------------------------------------
COPY /Y "DOSmag\DOSmag.exe" "PortaDOOM\PortaDOOM.exe"  >NUL 2>&1
ECHO:

IF %CMPLVL% EQU 1 (
	ECHO * Compress DOSmag executable
	ECHO:
	DEL PortaDOOM\PortaDOOM.upx  >NUL 2>&1
	%BIN_UPX% --ultra-brute PortaDOOM\PortaDOOM.exe
	ECHO:
)

GOTO:EOF


:do_release_menu
REM ============================================================================
CLS & TITLE PortaDOOM Build Tools:
ECHO:
ECHO  Select Release to Build:
ECHO:
ECHO     [A]  All
ECHO:
ECHO     [B]  Cacowards: 2017
ECHO     [C]  Cacowards: 2016
ECHO     [D]  Cacowards: 2015
ECHO     [E]  Cacowards: 5 Years of Doom
ECHO:
ECHO     [P]  PSX DOOM TC
ECHO:
ECHO     [X]  Launcher only
ECHO:

SET "$="
SET /P "$=Enter choice: "
IF /I "%$%" == "A" GOTO :do_release_all
IF /I "%$%" == "B" GOTO :do_release_cacowards2017
IF /I "%$%" == "C" GOTO :do_release_cacowards2016
IF /I "%$%" == "D" GOTO :do_release_cacowards2015
IF /I "%$%" == "E" GOTO :do_release_5yearsofdoom
IF /I "%$%" == "P" GOTO :do_release_psxdoomtc
IF /I "%$%" == "X" GOTO :do_release_launcher

GOTO :menu


:do_release_all
REM ============================================================================
CLS & TITLE Creating PortaDOOM release...
CALL :select_compression

CALL :do_5yearsofdoom
CALL :do_cacowards2015
CALL :do_cacowards2016
CALL :do_cacowards2017
CALL :do_psxdoomtc
CALL :do_launcher

ECHO:
ECHO Complete.
ECHO:
PAUSE
EXIT /B

ECHO * Make PortaDOOM ...
REM ----------------------------------------------------------------------------
REM # 7ZIP
%BIN_7ZA% a ^
	-bso0 -bsp1 -r %ZIP_LVL% -stl ^
	-xr@bin\ignore.lst ^
	-- build\PortaDOOM.7z PortaDOOM

ECHO:
ECHO Complete.
ECHO:
PAUSE
EXIT /B


:do_release_cacowards2017
REM ============================================================================
TITLE Creating PortaDOOM release...
CALL :select_compression
CALL :do_cacowards2017
PAUSE & GOTO:EOF

:do_cacowards2017
REM ----------------------------------------------------------------------------
ECHO * Make PortaDOOM_Cacowards2017 ...

REM # the archive will be built without a base folder
PUSHD PortaDOOM

REM # swap over the homepages
REN  "pages\Home #01.dosmag" "Home #01.old"
COPY "pages\PortaDOOM Cacowards 2017.dosmag" "pages\Home #01.dosmag"  >NUL 2>&1
IF ERRORLEVEL 1 PAUSE & EXIT

REM # 7ZIP
CALL :zip ^
	..\build\PortaDOOM_Cacowards2017.7z ^
	..\bin\include_cacowards2017.lst ^
	..\bin\ignore.lst
IF ERRORLEVEL 1 PAUSE

REM # restore the original home page
DEL "pages\Home #01.dosmag"
REN "pages\Home #01.old" "Home #01.dosmag"
IF ERRORLEVEL 1 PAUSE & EXIT

POPD
GOTO:EOF


:do_release_cacowards2016
REM ============================================================================
TITLE Creating PortaDOOM release...
CALL :select_compression
CALL :do_cacowards2016
PAUSE & GOTO:EOF

:do_cacowards2016
REM ----------------------------------------------------------------------------
ECHO * Make PortaDOOM_Cacowards2016 ...

REM # the archive will be built without a base folder
PUSHD PortaDOOM

REM # swap over the homepages
REN  "pages\Home #01.dosmag" "Home #01.old"
COPY "pages\PortaDOOM Cacowards 2016.dosmag" "pages\Home #01.dosmag"  >NUL 2>&1
IF ERRORLEVEL 1 PAUSE & EXIT

REM # 7ZIP
CALL :zip ^
	..\build\PortaDOOM_Cacowards2016.7z ^
	..\bin\include_cacowards2016.lst ^
	..\bin\ignore.lst
IF ERRORLEVEL 1 PAUSE

REM # restore the original home page
DEL "pages\Home #01.dosmag"
REN "pages\Home #01.old" "Home #01.dosmag"
IF ERRORLEVEL 1 PAUSE & EXIT

POPD
GOTO:EOF


:do_release_cacowards2015
REM ============================================================================
TITLE Creating PortaDOOM release...
CALL :select_compression
CALL :do_cacowards2015
PAUSE & GOTO:EOF

:do_cacowards2015
REM ----------------------------------------------------------------------------
ECHO * Make PortaDOOM_Cacowards2015 ...

REM # the archive will be built without a base folder
PUSHD PortaDOOM

REM # swap over the homepages
REN  "pages\Home #01.dosmag" "Home #01.old"
COPY "pages\PortaDOOM Cacowards 2015.dosmag" "pages\Home #01.dosmag"  >NUL 2>&1
IF ERRORLEVEL 1 PAUSE & EXIT

REM # 7ZIP
CALL :zip ^
	..\build\PortaDOOM_Cacowards2015.7z ^
	..\bin\include_cacowards2015.lst ^
	..\bin\ignore.lst
IF ERRORLEVEL 1 PAUSE

REM # restore the original home page
DEL "pages\Home #01.dosmag"
REN "pages\Home #01.old" "Home #01.dosmag"
IF ERRORLEVEL 1 PAUSE & EXIT

POPD
GOTO:EOF


:do_release_5yearsofdoom
REM ============================================================================
TITLE Creating PortaDOOM release...
CALL :select_compression
CALL :do_5yearsofdoom
PAUSE & GOTO:EOF

:do_5yearsofdoom
REM ----------------------------------------------------------------------------
ECHO * Make PortaDOOM_5YearsOfDoom ...
DEL build\PortaDOOM_5YearsOfDoom.7z  >NUL 2>&1

REM # the archive will be built without a base folder
PUSHD PortaDOOM

REM # swap over the homepages
REN  "pages\Home #01.dosmag" "Home #01.old"
COPY "pages\PortaDOOM Cacowards 5 Years of Doom.dosmag" "pages\Home #01.dosmag"  >NUL 2>&1
IF ERRORLEVEL 1 PAUSE & EXIT

REM # 7ZIP
CALL :zip ^
	..\build\PortaDOOM_5YearsOfDoom.7z ^
	..\bin\include_cacowards5years.lst ^
	..\bin\ignore.lst
IF ERRORLEVEL 1 PAUSE

REM # restore the original home page
DEL "pages\Home #01.dosmag"
REN "pages\Home #01.old" "Home #01.dosmag"
IF ERRORLEVEL 1 PAUSE & EXIT

POPD
GOTO:EOF


:do_release_psxdoomtc
REM ============================================================================
TITLE Creating PortaDOOM release...
CALL :select_compression
CALL :do_psxdoomtc
PAUSE & GOTO:EOF

:do_psxdoomtc
REM ----------------------------------------------------------------------------
ECHO * Make PortaDOOM_PSXDOOMTC ...
DEL build\PortaDOOM_PSXDOOMTC.7z  >NUL 2>&1

REM # the archive will be built without a base folder
PUSHD PortaDOOM

REM # swap over the homepages
REN  "pages\Home #01.dosmag" "Home #01.old"
COPY "pages\PortaDOOM PSX DOOM TC.dosmag" "pages\Home #01.dosmag"  >NUL 2>&1
IF ERRORLEVEL 1 PAUSE & EXIT

REM # 7ZIP
CALL :zip ^
	..\build\PortaDOOM_PSXDOOMTC.7z ^
	..\bin\include_psxdoomtc.lst ^
	..\bin\ignore.lst
IF ERRORLEVEL 1 PAUSE

REM # restore the original home page
DEL "pages\Home #01.dosmag"
REN "pages\Home #01.old" "Home #01.dosmag"
IF ERRORLEVEL 1 PAUSE & EXIT

POPD
GOTO:EOF


:do_release_launcher
REM ============================================================================
TITLE Creating PortaDOOM Launcher release...
ECHO:
CALL :do_launcher
PAUSE & GOTO:EOF

:do_launcher
REM ----------------------------------------------------------------------------
ECHO * Make PortaDOOM_Launcher ...
DEL build\PortaDOOM_Launcher.7z  >NUL 2>&1

REM # the archive will be built without a base folder
REM # and without the PortaDOOM executable / pages
PUSHD PortaDOOM\files

REM # Launcher is always maximum compression
REM # as it doesn't use the PortaDOOM executable
CALL :zip ^
	..\..\build\PortaDOOM_Launcher.7z ^
	..\..\bin\include_launcher.lst ^
	..\..\bin\ignore.lst
IF ERRORLEVEL 1 PAUSE

POPD
GOTO:EOF


:do_dosmag_copy
REM ============================================================================
CLS
COPY /Y "DOSmag\DOSmag.exe" "PortaDOOM\PortaDOOM.exe"

START "" PortaDOOM\PortaDOOM.exe

EXIT /B


:do_dosmag_pull
REM ============================================================================
REM # updates DOSmag from the GitHub repo

REM # TODO: check for existence of git

CLS
ECHO Pulling DOSmag updates from GitHub:
ECHO (working copy must be clean!)
ECHO:

git subtree pull --prefix=DOSmag --squash dosmag master

COPY /Y "DOSmag\DOSmag.exe" "PortaDOOM\PortaDOOM.exe"  >NUL

ECHO:
PAUSE
EXIT /B


:do_dosmag_push
REM ============================================================================
CLS
ECHO Pushing DOSmag changes to GitHub:
ECHO:

git subtree push --prefix=DOSmag dosmag master

ECHO:
PAUSE
EXIT /B

:do_upx
REM ============================================================================
CLS & TITLE UPX Compress DOOM Engines...
ECHO:
ECHO Compress DOOM Engines using UPX:
ECHO - This may take a long time
ECHO - This will permenantly alter the EXEs!
ECHO - Already compressed EXEs will be skipped;
ECHO   only run this script when the engines are updated
ECHO:

SET "FILES="

FOR /R ".\PortaDOOM\files\ports" %%F IN (*.exe) DO (
	REM # test if the executable is already compressed
	SET EXE_FILE=%%~F
	SET "EXE_INFO="
	CALL :upx
)

ECHO:
PAUSE & GOTO:EOF

:upx
REM ----------------------------------------------------------------------------
REM # check if the file is already compressed
FOR /F "delims=" %%G IN ('%BIN_UPX% -qqq -l "%EXE_FILE%"') DO @SET EXE_INFO=%%G
REM # if not compressed, run UPX on the executable
IF "%EXE_INFO%" == "" (
	%BIN_UPX% --all-methods --all-filters --ultra-brute "%EXE_FILE%"
)
GOTO:EOF

:zip
REM ----------------------------------------------------------------------------
REM # run a zip-compression command;
REM # assumes `ZIP_LVL` has been set
REM #
REM #	%1	= archive path
REM #	%2	= include list, e.g. "include.lst"
REM #	%3	= ignore list, e.g. "ignore.lst"

REM # a         : add to archive
REM # -bso0     : disable message output
REM # -bsp1     : display only progress
REM # -r        : recurse sub-directories
REM # -stl      : sets the archive's timestamp to that of the latest file
REM # -xr...    : exclude files (recursively)
%BIN_7ZA% a -bso0 -bsp1 %ZIP_LVL% -stl -xr@%3 -i@%2 -- %1
REM # return the error code from 7Zip
EXIT /B %ERRORLEVEL%
