@ECHO OFF & SETLOCAL ENABLEEXTENSIONS DISABLEDELAYEDEXPANSION
REM # this script compiles a fresh copy of DOSmag and updates PortaDOOM with it

REM # switch to the directory of this script
PUSHD "%~dp0"
REM # compile DOSmag
CALL DOSmag\compile.bat
REM # if that errored, pause to be able to show the error message
IF ERRORLEVEL 1 POPD & PAUSE & GOTO:EOF

REM # copy the DOSmag executable to PortaDOOM
COPY /Y DOSmag\DOSmag.exe PortaDOOM\PortaDOOM.exe
REM # and run it
START "" PortaDOOM\PortaDOOM.exe
POPD