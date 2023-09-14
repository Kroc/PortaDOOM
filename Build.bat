:: PortaDOOM, copyright (C) Kroc Camen 2016-2023, BSD 2-clause
@ECHO OFF & SETLOCAL ENABLEEXTENSIONS DISABLEDELAYEDEXPANSION
PUSHD %~dp0

REM # detect 32-bit or 64-bit Windows
SET WINBIT=32
IF /I "%PROCESSOR_ARCHITECTURE%" == "EM64T" SET WINBIT=64 & REM # Itanium
IF /I "%PROCESSOR_ARCHITECTURE%" == "AMD64" SET WINBIT=64 & REM # Regular x64
REM # 32-bit CMD running on a 64-bit system (WOW64)
IF /I "%PROCESSOR_ARCHITEW6432%" == "AMD64" SET WINBIT=64

REM # location of QB64 executable
SET BIN_QB64=bin\qb64\qb64.exe

REM # select 7Zip executable
IF %WINBIT% EQU 64 SET BIN_7ZA="%~dp0bin\7za\7za_x64.exe"
IF %WINBIT% EQU 32 SET BIN_7ZA="%~dp0bin\7za\7za_x86.exe"
REM # location of UPX executable
REM # (for compression EXE files)
SET BIN_UPX="%~dp0bin\upx\upx.exe"
SET "UPX_ULTRA=%BIN_UPX% --all-methods --all-filters --ultra-brute"

REM # define ZIP compression profiles:
REM # -ms=on    : solid-mode on (default)
REM # -mqs=on   : sort solid-files by type
REM # -mhc=on   : header compression on (default)
REM # -mx=9     : maximum compression (level 9)
REM # -myx=9    : maximum file analysis (level 9)
SET "ZIP_MAX=-ms=on -mqs=on -mhc=on -mx=9 -myx=9"
SET "ZIP_MIN=-ms=off -mhc=off -mx=0 -myx=0"


:menu
REM ============================================================================
CLS & TITLE PortaDOOM Build Tools:
ECHO:
ECHO  Select Release to Build:
ECHO:
ECHO     [A]  All
ECHO:
ECHO     [B]  Cacowards: 2018
ECHO     [C]  Cacowards: 2017
ECHO     [D]  Cacowards: 2016
ECHO     [E]  Cacowards: 2015
ECHO     [5]  Cacowards: 5 Years of Doom
ECHO:
ECHO     [P]  PSX DOOM TC
ECHO:
ECHO     [X]  Launcher only
ECHO:

SET "$="
SET /P "$=Enter choice: "
IF /I "%$%" == "A" CALL :do_release_all
IF /I "%$%" == "B" CALL :do_release_cacowards "2018"
IF /I "%$%" == "C" CALL :do_release_cacowards "2017"
IF /I "%$%" == "D" CALL :do_release_cacowards "2016"
IF /I "%$%" == "E" CALL :do_release_cacowards "2015"
IF /I "%$%" == "5" CALL :do_release_5yearsofdoom
IF /I "%$%" == "P" CALL :do_release_psxdoomtc
IF /I "%$%" == "X" CALL :do_release_launcher

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

:compress_portadoom
REM ----------------------------------------------------------------------------
ECHO:
ECHO * Compile "PortaDOOM.exe"
ECHO:
REM # compile source with QB64
%BIN_QB64% -x -e -o ^
	"..\..\PortaDOOM\PortaDOOM.exe" ^
	"..\..\src\portadoom.qb64"

REM # if that errored, pause to be able to show the error message
IF ERRORLEVEL 1 POPD & PAUSE & GOTO:EOF

IF %CMPLVL% EQU 1 (
	ECHO * Compress "PortaDOOM.exe"
	ECHO:
	DEL PortaDOOM\PortaDOOM.upx  >NUL 2>&1
	%UPX_ULTRA% "PortaDOOM\PortaDOOM.exe"
	ECHO:
)

:compress_launcher
REM ----------------------------------------------------------------------------
ECHO:
ECHO * Compile "launcher.exe"
ECHO:
REM # compile the launcher
%BIN_QB64% -x -e -o ^
	"..\..\PortaDOOM\files\launcher.exe" ^
	"..\..\src\launcher.qb64"

REM # if that errored, pause to be able to show the error message
IF ERRORLEVEL 1 POPD & PAUSE & GOTO:EOF

REM # compress the launcher executable
IF %CMPLVL% EQU 1 (
	ECHO:
	ECHO * Compress "launcher.exe"
	ECHO:
	DEL PortaDOOM\files\launcher.upx  >NUL 2>&1
	%UPX_ULTRA% PortaDOOM\files\launcher.exe
	ECHO:
)

:compress_config
REM ----------------------------------------------------------------------------
ECHO:
ECHO * Compile "config.exe"
ECHO:

REM # compile the config editor
%BIN_QB64% -x -e -o ^
	"..\..\PortaDOOM\files\config\config.exe" ^
	"..\..\src\config.qb64"

REM # if that errored, pause to be able to show the error message
IF ERRORLEVEL 1 POPD & PAUSE & GOTO:EOF

REM # compress the config executable
IF %CMPLVL% EQU 1 (
	ECHO:
	ECHO * Compress "config.exe"
	ECHO:
	DEL PortaDOOM\files\config\config.upx  >NUL 2>&1
	%UPX_ULTRA% PortaDOOM\files\config\config.exe
	ECHO:
)

ECHO:
GOTO:EOF


:do_release_all
REM ============================================================================
CLS & TITLE Creating PortaDOOM release...
CALL :select_compression

CALL :do_5yearsofdoom
CALL :do_cacowards "2015"
CALL :do_cacowards "2016"
CALL :do_cacowards "2017"
CALL :do_cacowards "2018"
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
	-- "build\PortaDOOM.7z" ^
	"PortaDOOM"

ECHO:
ECHO Complete.
ECHO:
PAUSE
EXIT /B


:do_release_cacowards
REM ============================================================================
TITLE Creating PortaDOOM release...
CALL :select_compression
CALL :do_cacowards "%~1"
PAUSE & GOTO:EOF

:do_cacowards
REM ----------------------------------------------------------------------------
ECHO * Make PortaDOOM_Cacowards%~1 ...

REM # the archive will be built without a base folder
PUSHD PortaDOOM

REM # swap over the homepages
REN  "pages\Home #01.dosmag" "Home #01.old"
IF ERRORLEVEL 1 PAUSE & EXIT
COPY "pages\PortaDOOM Cacowards %~1.dosmag" "pages\Home #01.dosmag"  >NUL 2>&1
IF ERRORLEVEL 1 (
	DEL "pages\Home #01.dosmag"
	REN "pages\Home #01.old" "Home #01.dosmag"
	PAUSE & EXIT
)

REM # 7ZIP
CALL :zip ^
	"..\build\PortaDOOM_Cacowards%~1.7z" ^
	"..\bin\include_cacowards%~1.lst" ^
	"..\bin\ignore.lst"

IF ERRORLEVEL 1 ECHO "Failure in 7Zip" & PAUSE

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
	"..\build\PortaDOOM_5YearsOfDoom.7z" ^
	"..\bin\include_cacowards5years.lst" ^
	"..\bin\ignore.lst"

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
	"..\build\PortaDOOM_PSXDOOMTC.7z" ^
	"..\bin\include_psxdoomtc.lst" ^
	"..\bin\ignore.lst"

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
SET CMPLVL=1
CALL :compress_launcher
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
	"..\..\build\PortaDOOM_Launcher.7z" ^
	"..\..\bin\include_launcher.lst" ^
	"..\..\bin\ignore.lst"

IF ERRORLEVEL 1 PAUSE

POPD
GOTO:EOF


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
	SET EXE_FILE=%%~F
	CALL :upx
)

ECHO:
PAUSE & GOTO:EOF

:upx
REM ----------------------------------------------------------------------------
REM # check if the file is already compressed
SET "EXE_INFO="
FOR /F "delims=" %%G IN ('%BIN_UPX% -qqq -l "%EXE_FILE%"') DO @SET EXE_INFO=%%G
REM # if not compressed, run UPX on the executable
IF "%EXE_INFO%" == "" (
	%UPX_ULTRA% "%EXE_FILE%"
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
