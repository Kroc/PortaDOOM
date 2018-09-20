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
ECHO    [E] crispy-doom ^(with setup^)
ECHO:
ECHO    [F] DOOM 64 EX
ECHO:
ECHO    [G] DOOM Retro
ECHO    [H] PRBoom+ hardware            [I] PRBoom+ software
ECHO:
ECHO    [J] Zandronum v2.x
ECHO    [K] Zandronum v3.x
ECHO:
ECHO    [L] GZDoom ...
ECHO:
ECHO    [Z] ZDoom v2.8.1
ECHO:
CHOICE /C:ABCDEFGHIJKLZ /N

IF %ERRORLEVEL% EQU 1  ..\launcher.exe /WAIT     /USE choco-doom-setup    /IWAD DOOM
IF %ERRORLEVEL% EQU 2  ..\launcher.exe /WAIT     /USE choco-heretic-setup /IWAD HERETIC
IF %ERRORLEVEL% EQU 3  ..\launcher.exe /WAIT     /USE choco-hexen-setup   /IWAD HEXEN
IF %ERRORLEVEL% EQU 4  ..\launcher.exe /WAIT     /USE choco-strife-setup  /IWAD STRIFE1
IF %ERRORLEVEL% EQU 5  ..\launcher.exe /WAIT     /USE crispy-doom-setup   /IWAD DOOM
IF %ERRORLEVEL% EQU 6  ..\launcher.exe /WAIT     /USE doom64ex            /IWAD DOOM64
IF %ERRORLEVEL% EQU 7  ..\launcher.exe /WAIT     /USE doom-retro          /IWAD DOOM
IF %ERRORLEVEL% EQU 8  ..\launcher.exe /WAIT     /USE prboom-plus         /IWAD DOOM
IF %ERRORLEVEL% EQU 9  ..\launcher.exe /WAIT /SW /USE prboom-plus         /IWAD DOOM
IF %ERRORLEVEL% EQU 10 ..\launcher.exe /WAIT     /USE zandronum-2         /IWAD DOOM
IF %ERRORLEVEL% EQU 11 ..\launcher.exe /WAIT     /USE zandronum-3         /IWAD DOOM
IF %ERRORLEVEL% EQU 12 GOTO :gzdoom
IF %ERRORLEVEL% EQU 13 ..\launcher.exe /WAIT     /USE zdoom               /IWAD DOOM

GOTO :menu

:gzdoom
CLS
ECHO:
ECHO  GZDoom:
ECHO:
ECHO    [0] GZDoom v3.5.x : 32-bit      [1] GZDoom v3.5.x : 64-bit
ECHO    [A] GZDoom v3.4.x : 32-bit      [B] GZDoom v3.4.x : 64-bit
ECHO    [C] GZDoom v3.3.x : 32-bit      [D] GZDoom v3.3.x : 64-bit
ECHO    [E] GZDoom v3.2.x : 32-bit      [F] GZDoom v3.2.x : 64-bit
ECHO    [G] GZDoom v2.4.x : 32-bit      [H] GZDoom v2.4.x : 64-bit
ECHO    [I] GZDoom v2.3.x : 32-bit      [J] GZDoom v2.3.x : 64-bit
ECHO    [K] GZDoom v2.2.x : 32-bit      [L] GZDoom v2.2.x : 64-bit
ECHO    [M] GZDoom v2.1.x : 32-bit      [N] GZDoom v2.1.x : 64-bit
ECHO:
ECHO    [O] GZDoom v2.0.x
ECHO    [P] GZDoom v1.9.x
ECHO    [Q] GZDoom v1.8.x
ECHO    [R] GZDoom v1.7.x
ECHO    [S] GZDoom v1.6.x
ECHO    [T] GZDoom v1.5.x
ECHO    [U] GZDoom v1.4.x
ECHO    [V] GZDoom v1.3.x
ECHO    [W] GZDoom v1.2.x
ECHO    [X] GZDoom v1.1.x
ECHO    [Y] GZDoom v1.0.x
ECHO    [Z] GZDoom v0.9.x
ECHO:
CHOICE /C:01ABCDEFGHIJKLMNOPQRSTUVWXYZ /N

IF %ERRORLEVEL% EQU 1  ..\launcher.exe /WAIT /32 /USE gzdoom-35 /IWAD DOOM
IF %ERRORLEVEL% EQU 2  ..\launcher.exe /WAIT     /USE gzdoom-35 /IWAD DOOM
IF %ERRORLEVEL% EQU 3  ..\launcher.exe /WAIT /32 /USE gzdoom-34 /IWAD DOOM
IF %ERRORLEVEL% EQU 4  ..\launcher.exe /WAIT     /USE gzdoom-34 /IWAD DOOM
IF %ERRORLEVEL% EQU 5  ..\launcher.exe /WAIT /32 /USE gzdoom-33 /IWAD DOOM
IF %ERRORLEVEL% EQU 6  ..\launcher.exe /WAIT     /USE gzdoom-33 /IWAD DOOM
IF %ERRORLEVEL% EQU 7  ..\launcher.exe /WAIT /32 /USE gzdoom-32 /IWAD DOOM
IF %ERRORLEVEL% EQU 8  ..\launcher.exe /WAIT     /USE gzdoom-32 /IWAD DOOM
IF %ERRORLEVEL% EQU 9  ..\launcher.exe /WAIT /32 /USE gzdoom-24 /IWAD DOOM
IF %ERRORLEVEL% EQU 10 ..\launcher.exe /WAIT     /USE gzdoom-24 /IWAD DOOM
IF %ERRORLEVEL% EQU 11 ..\launcher.exe /WAIT /32 /USE gzdoom-23 /IWAD DOOM
IF %ERRORLEVEL% EQU 12 ..\launcher.exe /WAIT     /USE gzdoom-23 /IWAD DOOM
IF %ERRORLEVEL% EQU 13 ..\launcher.exe /WAIT /32 /USE gzdoom-22 /IWAD DOOM
IF %ERRORLEVEL% EQU 14 ..\launcher.exe /WAIT     /USE gzdoom-22 /IWAD DOOM
IF %ERRORLEVEL% EQU 15 ..\launcher.exe /WAIT /32 /USE gzdoom-21 /IWAD DOOM
IF %ERRORLEVEL% EQU 16 ..\launcher.exe /WAIT     /USE gzdoom-21 /IWAD DOOM

IF %ERRORLEVEL% EQU 17 ..\launcher.exe /WAIT     /USE gzdoom-20 /IWAD DOOM
IF %ERRORLEVEL% EQU 18 ..\launcher.exe /WAIT     /USE gzdoom-19 /IWAD DOOM
IF %ERRORLEVEL% EQU 19 ..\launcher.exe /WAIT     /USE gzdoom-18 /IWAD DOOM
IF %ERRORLEVEL% EQU 20 ..\launcher.exe /WAIT     /USE gzdoom-17 /IWAD DOOM
IF %ERRORLEVEL% EQU 21 ..\launcher.exe /WAIT     /USE gzdoom-16 /IWAD DOOM
IF %ERRORLEVEL% EQU 22 ..\launcher.exe /WAIT     /USE gzdoom-15 /IWAD DOOM
IF %ERRORLEVEL% EQU 23 ..\launcher.exe /WAIT     /USE gzdoom-14 /IWAD DOOM
IF %ERRORLEVEL% EQU 24 ..\launcher.exe /WAIT     /USE gzdoom-13 /IWAD DOOM
IF %ERRORLEVEL% EQU 25 ..\launcher.exe /WAIT     /USE gzdoom-12 /IWAD DOOM
IF %ERRORLEVEL% EQU 26 ..\launcher.exe /WAIT     /USE gzdoom-11 /IWAD DOOM
IF %ERRORLEVEL% EQU 27 ..\launcher.exe /WAIT     /USE gzdoom-10 /IWAD DOOM
IF %ERRORLEVEL% EQU 28 ..\launcher.exe /WAIT     /USE gzdoom-09 /IWAD DOOM

GOTO :gzdoom