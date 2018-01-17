@ECHO OFF & SETLOCAL ENABLEEXTENSIONS DISABLEDELAYEDEXPANSION
REM # this script compiles a fresh copy of DOSmag and updates PortaDOOM with it

REM # switch to the directory of this script
PUSHD "%~dp0"
REM # compile DOSmag
bin\qb64\qb64.exe -x -e -o ..\DOSmag\DOSmag.exe ..\DOSmag\DOSmag.qb64
REM # if that errored, pause to be able to show the error message
IF ERRORLEVEL 1 POPD & PAUSE & GOTO:EOF

REM # copy the DOSmag executable to PortaDOOM
COPY /Y bin\DOSmag\DOSmag.exe PortaDOOM\PortaDOOM.exe
REM # and run it
START "" PortaDOOM\PortaDOOM.exe
POPD