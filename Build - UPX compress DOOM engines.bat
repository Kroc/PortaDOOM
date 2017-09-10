@ECHO OFF & SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
CD %~dp0

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
	REM # test if the exeutable is already compressed
	SET EXE_FILE=%%~F
	SET "EXE_INFO="
	CALL :upx
)

ECHO:
PAUSE
EXIT /B

:upx
FOR /F "delims=" %%G IN ('bin\upx\upx.exe -qqq -l "%EXE_FILE%"') DO @SET EXE_INFO=%%G  
IF "%EXE_INFO%" == "" (
	bin\upx\upx.exe --all-methods --all-filters --ultra-brute "%EXE_FILE%"
)
GOTO:EOF
