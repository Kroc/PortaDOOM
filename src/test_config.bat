:: PortaDOOM, copyright (C) Kroc Camen 2016-2022, BSD 2-clause
@ECHO OFF & SETLOCAL ENABLEEXTENSIONS DISABLEDELAYEDEXPANSION

REM # switch to the directory of this script
PUSHD "%~dp0"

REM # compile "config.exe"
..\bin\qb64\qb64.exe -x -e ^
	-o "..\..\PortaDOOM\files\tools\config.exe" ^
	"..\..\src\config.qb64"
REM # if that errored, pause to be able to show the error message
IF ERRORLEVEL 1 POPD & PAUSE & GOTO:EOF

REM # compiled successfully, now run it
ECHO:
"..\PortaDOOM\files\tools\config.exe" ^
	"test.ini" ADD "test-field" "value"

IF ERRORLEVEL 1 (
	ECHO: & ECHO config.exe terminated with status code %ERRORLEVEL%.
)

POPD
PAUSE