@ECHO OFF & SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
CD %~dp0

CLS & TITLE UPX Compress DOOM Engines...
ECHO:
ECHO Compress DOOM Engines using UPX:
ECHO - This may take a long time
ECHO - This will permenantly alter the DLL/EXEs!
ECHO - Already compressed DLL/EXEs will be skipped;
ECHO   only run this script when the engines are updated
ECHO:

SET "FILES="

FOR /R ".\PortaDOOM\files" %%F IN (*.exe,*.dll) DO (
	REM # TODO: use UPX to check if a file is already compressed?
	REM # test if the exeutable is already compressed
	bin\upx\upx.exe -qqq -l "%%~F"
	IF %ERRORLEVEL% EQU 2 (
		bin\upx\upx.exe --all-methods --all-filters --ultra-brute "%%~F"
	)
)

ECHO:
PAUSE
