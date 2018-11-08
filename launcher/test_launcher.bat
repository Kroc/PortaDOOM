@ECHO OFF & SETLOCAL ENABLEEXTENSIONS DISABLEDELAYEDEXPANSION

REM # switch to the directory of this script
PUSHD "%~dp0"
REM # compile "launcher.exe"
..\bin\qb64\qb64.exe -x -e -o "..\..\PortaDOOM\files\launcher.exe" "..\..\launcher\launcher.qb64"
REM # if that errored, pause to be able to show the error message
IF ERRORLEVEL 1 POPD & PAUSE & GOTO:EOF

REM # compiled successfully, now run it
..\PortaDOOM\files\launcher.exe /DEBUG "people\Sverre Kvernmo\cabal\play-cabal.ini"

IF %ERRORLEVEL% GT 0 (
	ECHO: & ECHO launcher.exe terminated with status code %ERRORLEVEL%.
	PAUSE
)