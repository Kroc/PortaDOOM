:: PortaDOOM, copyright (C) Kroc Camen 2016-2023, BSD 2-clause
@ECHO OFF & SETLOCAL ENABLEEXTENSIONS DISABLEDELAYEDEXPANSION

REM # switch to the directory of this script
PUSHD "%~dp0"

SET CFGINI_EXE=PortaDOOM\files\config\cfgini.exe

REM # compile "config.exe"
..\bin\qb64\qb64.exe -x -e ^
	-o "..\..\%CFGINI_EXE%" ^
	"..\..\src\cfgini.qb64"
REM # if that errored, pause to be able to show the error message
IF ERRORLEVEL 1 POPD & PAUSE & GOTO:EOF

SET TEST_INI="..\build\test.ini"

REM # create a dummy test file
IF EXIST %TEST_INI% ERASE /F %TEST_INI%  >NUL
COPY NUL %TEST_INI% >NUL

REM # compiled successfully, now run it
ECHO:
REM # add a [doom] section
"..\%CFGINI_EXE%" %TEST_INI% SET "[doom]"
REM # add a value, but not in the section
"..\%CFGINI_EXE%" %TEST_INI% SET "are_cacos_the_best" "yes"
REM # add a conflicting value but in a section
"..\%CFGINI_EXE%" %TEST_INI% SET "[doom]" "are_cacos_the_best" "no"
REM # delete the value outside the section
"..\%CFGINI_EXE%" %TEST_INI% DEL "are_cacos_the_best"

IF ERRORLEVEL 1 (
	ECHO: & ECHO cfgini.exe terminated with status code %ERRORLEVEL%.
)

POPD
PAUSE