:: PortaDOOM, copyright (C) Kroc Camen 2016-2019, BSD 2-clause
@ECHO OFF & SETLOCAL ENABLEEXTENSIONS DISABLEDELAYEDEXPANSION

REM # switch to the directory of this script
PUSHD "%~dp0"
REM # compile "PortaDOOM.exe"
..\bin\qb64\qb64.exe -x -e -o "..\..\PortaDOOM\PortaDOOM.exe" "..\..\src\PortaDOOM.qb64"
REM # if that errored, pause to be able to show the error message
IF ERRORLEVEL 1 POPD & PAUSE & GOTO:EOF

REM # compiled successfully, now run it
..\PortaDOOM\PortaDOOM.exe

IF %ERRORLEVEL% GT 0 (
	ECHO: & ECHO PortaDOOM.exe terminated with status code %ERRORLEVEL%.
	PAUSE
)