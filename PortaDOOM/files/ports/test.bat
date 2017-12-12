@ECHO OFF

:menu
CLS
ECHO:
ECHO  Engine Test:
ECHO:
ECHO    [X] EXIT
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
ECHO    [J] GZDoom v2.2.x : 32-bit      [K] GZDoom v2.2.x : 64-bit
ECHO    [L] GZDoom v2.3.x : 32-bit      [M] GZDoom v2.3.x : 64-bit
ECHO    [N] GZDoom v2.4.x : 32-bit      [O] GZDoom v2.4.x : 64-bit
ECHO    [P] GZDoom v3.1.x : 32-bit      [Q] GZDoom v3.1.x : 64-bit
ECHO    [R] GZDoom v3.2.x : 32-bit      [S] GZDoom v3.2.x : 64-bit
ECHO:
ECHO    [Z] ZDoom v2.8.1
ECHO:
CHOICE /C XABCDEFGHIJKLMNOPQRSZ /N

IF %ERRORLEVEL% EQU 1  EXIT /B
IF %ERRORLEVEL% EQU 2  CALL ..\doom.bat /WAIT /CONSOLE     /USE choco-doom-setup    /IWAD DOOM.WAD
IF %ERRORLEVEL% EQU 3  CALL ..\doom.bat /WAIT /CONSOLE     /USE choco-heretic-setup /IWAD HERETIC.WAD
IF %ERRORLEVEL% EQU 4  CALL ..\doom.bat /WAIT /CONSOLE     /USE choco-hexen-setup   /IWAD HEXEN.WAD
IF %ERRORLEVEL% EQU 5  CALL ..\doom.bat /WAIT /CONSOLE     /USE choco-strife-setup  /IWAD STRIFE1.WAD
IF %ERRORLEVEL% EQU 6  CALL ..\doom.bat /WAIT /CONSOLE     /USE doom64ex            /IWAD DOOM64.WAD
IF %ERRORLEVEL% EQU 7  CALL ..\doom.bat /WAIT /CONSOLE     /USE prboom              /IWAD DOOM.WAD
IF %ERRORLEVEL% EQU 8  CALL ..\doom.bat /WAIT /CONSOLE /SW /USE prboom              /IWAD DOOM.WAD
IF %ERRORLEVEL% EQU 9  CALL ..\doom.bat /WAIT /CONSOLE     /USE zandronum-2         /IWAD DOOM.WAD
IF %ERRORLEVEL% EQU 10 CALL ..\doom.bat /WAIT /CONSOLE     /USE zandronum-3         /IWAD DOOM.WAD
IF %ERRORLEVEL% EQU 11 CALL ..\doom.bat /WAIT /CONSOLE /32 /USE gzdoom-22           /IWAD DOOM.WAD
IF %ERRORLEVEL% EQU 12 CALL ..\doom.bat /WAIT /CONSOLE     /USE gzdoom-22           /IWAD DOOM.WAD
IF %ERRORLEVEL% EQU 13 CALL ..\doom.bat /WAIT /CONSOLE /32 /USE gzdoom-23           /IWAD DOOM.WAD
IF %ERRORLEVEL% EQU 14 CALL ..\doom.bat /WAIT /CONSOLE     /USE gzdoom-23           /IWAD DOOM.WAD
IF %ERRORLEVEL% EQU 15 CALL ..\doom.bat /WAIT /CONSOLE /32 /USE gzdoom-24           /IWAD DOOM.WAD
IF %ERRORLEVEL% EQU 16 CALL ..\doom.bat /WAIT /CONSOLE     /USE gzdoom-24           /IWAD DOOM.WAD
IF %ERRORLEVEL% EQU 17 CALL ..\doom.bat /WAIT /CONSOLE /32 /USE gzdoom-31           /IWAD DOOM.WAD
IF %ERRORLEVEL% EQU 18 CALL ..\doom.bat /WAIT /CONSOLE     /USE gzdoom-31           /IWAD DOOM.WAD
IF %ERRORLEVEL% EQU 19 CALL ..\doom.bat /WAIT /CONSOLE /32 /USE gzdoom-32           /IWAD DOOM.WAD
IF %ERRORLEVEL% EQU 20 CALL ..\doom.bat /WAIT /CONSOLE     /USE gzdoom-32           /IWAD DOOM.WAD
IF %ERRORLEVEL% EQU 21 CALL ..\doom.bat /WAIT /CONSOLE     /USE zdoom               /IWAD DOOM.WAD

GOTO :menu