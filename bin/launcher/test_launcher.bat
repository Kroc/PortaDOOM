@ECHO OFF & SETLOCAL ENABLEEXTENSIONS DISABLEDELAYEDEXPANSION

REM # switch to the directory of this script
PUSHD "%~dp0"
REM # compile Launher.exe
..\qb64\qb64.exe -x -e -o ..\launcher\launcher.exe ..\launcher\launcher.qb64
REM # if that errored, pause to be able to show the error message
IF ERRORLEVEL 1 POPD & PAUSE & GOTO:EOF

REM # compiled successfully, now run it
launcher.exe /USE gzdoom /32 /SW /DEFAULT /IWAD DOOM2.WAD /PWAD DTWID.WAD /DEH DeHackED.deh /WARP 22 /SKILL 4 / CMPLVL 19