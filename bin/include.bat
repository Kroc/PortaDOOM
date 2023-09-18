:: PortaDOOM, copyright (C) Kroc Camen 2016-2023, BSD 2-clause
@ECHO OFF & SETLOCAL ENABLEEXTENSIONS DISABLEDELAYEDEXPANSION

REM # this script builds a list of include files for 7-zip:
REM # if a line is prefixed by "@" this file is considered a nested list

:list
REM # ==========================================================================
IF NOT EXIST "%~1" ECHO Could not find list file %~1 >&2 & EXIT /B 1

REM ECHO "FILE: %~1"
FOR /F "tokens=* usebackq eol=#" %%F IN ( "%~1" ) DO CALL :item "%%~F"

GOTO:EOF

:item
REM # --------------------------------------------------------------------------
SET "LINE=%~1"

REM # ignore comments
IF [%LINE:~0,1%] == [#] GOTO:EOF
REM # is the first character an "@", indicating a nested list?
IF [%LINE:~0,1%] == [@] CALL :list "%LINE:~1%" & GOTO:EOF
REM # otherwise, echo the line as-is; it's up to the caller
REM # to re-rout stdout to a list file or into 7-zip
ECHO %LINE%

GOTO:EOF