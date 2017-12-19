@ECHO OFF

:menu
CLS
ECHO:
ECHO  Engine Test:
ECHO:
ECHO    [A] chocolate-doom ^(with setup^)
ECHO    [B] chocolate-heretic ^(with setup^)
ECHO    [C] chocolate-hexen ^(with setup^)
ECHO    [D] chocolate-strife ^(with setup^)
ECHO:
ECHO    [E] DOOM 64 EX
ECHO:
ECHO    [F] PRBoom+ hardware            [G] PRBoom+ software
ECHO:
ECHO    [H] Zandronum v2.x
ECHO    [I] Zandronum v3.x
ECHO:
ECHO    [J] GZDoom ...
ECHO:
ECHO    [Z] ZDoom v2.8.1
ECHO:
CHOICE /C ABCDEFGHIJZ /N

IF %ERRORLEVEL% EQU 1  CALL ..\doom.bat /WAIT /CONSOLE     /USE choco-doom-setup    /IWAD DOOM.WAD
IF %ERRORLEVEL% EQU 2  CALL ..\doom.bat /WAIT /CONSOLE     /USE choco-heretic-setup /IWAD HERETIC.WAD
IF %ERRORLEVEL% EQU 3  CALL ..\doom.bat /WAIT /CONSOLE     /USE choco-hexen-setup   /IWAD HEXEN.WAD
IF %ERRORLEVEL% EQU 4  CALL ..\doom.bat /WAIT /CONSOLE     /USE choco-strife-setup  /IWAD STRIFE1.WAD
IF %ERRORLEVEL% EQU 5  CALL ..\doom.bat /WAIT /CONSOLE     /USE doom64ex            /IWAD DOOM64.WAD
IF %ERRORLEVEL% EQU 6  CALL ..\doom.bat /WAIT /CONSOLE     /USE prboom              /IWAD DOOM.WAD
IF %ERRORLEVEL% EQU 7  CALL ..\doom.bat /WAIT /CONSOLE /SW /USE prboom              /IWAD DOOM.WAD
IF %ERRORLEVEL% EQU 8  CALL ..\doom.bat /WAIT /CONSOLE     /USE zandronum-2         /IWAD DOOM.WAD
IF %ERRORLEVEL% EQU 9  CALL ..\doom.bat /WAIT /CONSOLE     /USE zandronum-3         /IWAD DOOM.WAD
IF %ERRORLEVEL% EQU 10 GOTO :gzdoom
IF %ERRORLEVEL% EQU 11 CALL ..\doom.bat /WAIT /CONSOLE     /USE zdoom               /IWAD DOOM.WAD

GOTO :menu

:gzdoom
CLS
ECHO:
ECHO  GZDoom:
ECHO:
ECHO    [A] GZDoom v3.2.x : 32-bit      [B] GZDoom v3.2.x : 64-bit
ECHO    [C] GZDoom v2.4.x : 32-bit      [D] GZDoom v2.4.x : 64-bit
ECHO    [E] GZDoom v2.3.x : 32-bit      [F] GZDoom v2.3.x : 64-bit
ECHO    [G] GZDoom v2.2.x : 32-bit      [H] GZDoom v2.2.x : 64-bit
ECHO    [I] GZDoom v2.1.x : 32-bit      [J] GZDoom v2.1.x : 64-bit
ECHO:
ECHO    [K] GZDoom v2.0.x
ECHO    [L] GZDoom v1.9.x
ECHO    [M] GZDoom v1.8.x
ECHO    [N] GZDoom v1.7.x
ECHO    [O] GZDoom v1.6.x
ECHO    [P] GZDoom v1.5.x
ECHO    [Q] GZDoom v1.4.x
ECHO    [R] GZDoom v1.3.x
ECHO    [S] GZDoom v1.2.x
ECHO    [T] GZDoom v1.1.x
ECHO    [U] GZDoom v1.0.x
ECHO    [V] GZDoom v0.9.x
ECHO:
CHOICE /C ABCDEFGHIJKLMNOPQRSTUV /N

IF %ERRORLEVEL% EQU 1  CALL ..\doom.bat /WAIT /CONSOLE /32 /USE gzdoom-32 /IWAD DOOM.WAD
IF %ERRORLEVEL% EQU 2  CALL ..\doom.bat /WAIT /CONSOLE     /USE gzdoom-32 /IWAD DOOM.WAD
IF %ERRORLEVEL% EQU 3  CALL ..\doom.bat /WAIT /CONSOLE /32 /USE gzdoom-24 /IWAD DOOM.WAD
IF %ERRORLEVEL% EQU 4  CALL ..\doom.bat /WAIT /CONSOLE     /USE gzdoom-24 /IWAD DOOM.WAD
IF %ERRORLEVEL% EQU 5  CALL ..\doom.bat /WAIT /CONSOLE /32 /USE gzdoom-23 /IWAD DOOM.WAD
IF %ERRORLEVEL% EQU 6  CALL ..\doom.bat /WAIT /CONSOLE     /USE gzdoom-23 /IWAD DOOM.WAD
IF %ERRORLEVEL% EQU 7  CALL ..\doom.bat /WAIT /CONSOLE /32 /USE gzdoom-22 /IWAD DOOM.WAD
IF %ERRORLEVEL% EQU 8  CALL ..\doom.bat /WAIT /CONSOLE     /USE gzdoom-22 /IWAD DOOM.WAD
IF %ERRORLEVEL% EQU 9  CALL ..\doom.bat /WAIT /CONSOLE /32 /USE gzdoom-21 /IWAD DOOM.WAD
IF %ERRORLEVEL% EQU 10 CALL ..\doom.bat /WAIT /CONSOLE     /USE gzdoom-21 /IWAD DOOM.WAD

IF %ERRORLEVEL% EQU 11 CALL ..\doom.bat /WAIT /CONSOLE     /USE gzdoom-20 /IWAD DOOM.WAD
IF %ERRORLEVEL% EQU 12 CALL ..\doom.bat /WAIT /CONSOLE     /USE gzdoom-19 /IWAD DOOM.WAD
IF %ERRORLEVEL% EQU 13 CALL ..\doom.bat /WAIT /CONSOLE     /USE gzdoom-18 /IWAD DOOM.WAD
IF %ERRORLEVEL% EQU 14 CALL ..\doom.bat /WAIT /CONSOLE     /USE gzdoom-17 /IWAD DOOM.WAD
IF %ERRORLEVEL% EQU 15 CALL ..\doom.bat /WAIT /CONSOLE     /USE gzdoom-16 /IWAD DOOM.WAD
IF %ERRORLEVEL% EQU 16 CALL ..\doom.bat /WAIT /CONSOLE     /USE gzdoom-15 /IWAD DOOM.WAD
IF %ERRORLEVEL% EQU 17 CALL ..\doom.bat /WAIT /CONSOLE     /USE gzdoom-14 /IWAD DOOM.WAD
IF %ERRORLEVEL% EQU 18 CALL ..\doom.bat /WAIT /CONSOLE     /USE gzdoom-13 /IWAD DOOM.WAD
IF %ERRORLEVEL% EQU 19 CALL ..\doom.bat /WAIT /CONSOLE     /USE gzdoom-12 /IWAD DOOM.WAD
IF %ERRORLEVEL% EQU 20 CALL ..\doom.bat /WAIT /CONSOLE     /USE gzdoom-11 /IWAD DOOM.WAD
IF %ERRORLEVEL% EQU 21 CALL ..\doom.bat /WAIT /CONSOLE     /USE gzdoom-10 /IWAD DOOM.WAD
IF %ERRORLEVEL% EQU 22 CALL ..\doom.bat /WAIT /CONSOLE     /USE gzdoom-09 /IWAD DOOM.WAD

GOTO :gzdoom