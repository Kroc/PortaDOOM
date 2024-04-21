:: PortaDOOM, copyright (C) Kroc Camen 2016-2024, BSD 2-clause
@ECHO OFF & SETLOCAL ENABLEEXTENSIONS DISABLEDELAYEDEXPANSION

SET "LAUNCHER=..\launcher.exe /WAIT"

:menu
CLS
ECHO:
ECHO  Engine Test:
ECHO:
ECHO    [1] chocolate-doom ^(with setup^)
ECHO    [2] chocolate-heretic ^(with setup^)
ECHO    [3] chocolate-hexen ^(with setup^)
ECHO    [4] chocolate-strife ^(with setup^)
ECHO    [5] crispy-doom ^(with setup^)
ECHO    [6] crispy-heretic ^(with setup^)
ECHO    [7] crispy-hexen ^(with setup^)
ECHO    [8] crispy-strife ^(with setup^)
ECHO:
ECHO    [R] DOOM Retro
ECHO:
ECHO    [X] DOOM 64 EX
ECHO:
ECHO    [P] PRBoom+ hardware            [Q] PRBoom+ software
ECHO:
ECHO    [M] Zandronum v2.x
ECHO    [N] Zandronum v3.x
ECHO:
ECHO    [G] GZDoom ...
ECHO:
ECHO    [Z] ZDoom v2.8.1
ECHO:

SET CHOICE=?
SET /P "CHOICE=? "

IF /I "%CHOICE%" == "?" GOTO :menu
IF /I "%CHOICE%" == "1" %LAUNCHER% /USE choco-doom-setup     /IWAD DOOM
IF /I "%CHOICE%" == "2" %LAUNCHER% /USE choco-heretic-setup  /IWAD HERETIC
IF /I "%CHOICE%" == "3" %LAUNCHER% /USE choco-hexen-setup    /IWAD HEXEN
IF /I "%CHOICE%" == "4" %LAUNCHER% /USE choco-strife-setup   /IWAD STRIFE1
IF /I "%CHOICE%" == "5" %LAUNCHER% /USE crispy-doom-setup    /IWAD DOOM2
IF /I "%CHOICE%" == "6" %LAUNCHER% /USE crispy-heretic-setup /IWAD HERETIC
IF /I "%CHOICE%" == "7" %LAUNCHER% /USE crispy-hexen-setup   /IWAD HEXEN
IF /I "%CHOICE%" == "8" %LAUNCHER% /USE crispy-strife-setup  /IWAD STRIFE1

IF /I "%CHOICE%" == "R" %LAUNCHER% /USE doom-retro           /IWAD DOOM2

IF /I "%CHOICE%" == "X" %LAUNCHER% /USE doom64ex             /IWAD DOOM64

IF /I "%CHOICE%" == "P" %LAUNCHER% /USE prboom-plus-hw       /IWAD DOOM2
IF /I "%CHOICE%" == "Q" %LAUNCHER% /USE prboom-plus-sw       /IWAD DOOM2

IF /I "%CHOICE%" == "M" %LAUNCHER% /USE zandronum-2          /IWAD DOOM2
IF /I "%CHOICE%" == "N" %LAUNCHER% /USE zandronum-3          /IWAD DOOM2

IF /I "%CHOICE%" == "G" GOTO :gzdoom

IF /I "%CHOICE%" == "Z" %LAUNCHER% /USE zdoom               /IWAD DOOM2

GOTO :menu

:gzdoom
CLS
ECHO:
ECHO  GZDoom:
ECHO:
ECHO    [Z] GZDoom Current
ECHO:
ECHO    [0] GZDoom v1.0               [1] GZDoom v1.1
ECHO    [2] GZDoom v1.2               [3] GZDoom v1.3
ECHO    [4] GZDoom v1.4               [5] GZDoom v1.5
ECHO    [6] GZDoom v1.6               [7] GZDoom v1.7
ECHO    [8] GZDoom v1.8               [9] GZDoom v1.9
ECHO:
ECHO    [A] GZDoom v2.0               [B] GZDoom v2.1
ECHO    [C] GZDoom v2.2               [D] GZDoom v2.3
ECHO    [E] GZDoom v2.4
ECHO:
ECHO    [F] GZDoom v3.2               [G] GZDoom v3.3
ECHO    [H] GZDoom v3.4               [I] GZDoom v3.5
ECHO    [J] GZDoom v3.6               [K] GZDoom v3.7
ECHO    [L] GZDoom v4.1               [M] GZDoom v4.2
ECHO    [N] GZDoom v4.3               [O] GZDoom v4.4
ECHO    [P] GZDoom v4.5               [Q] GZDoom v4.6
ECHO    [R] GZDoom v4.7               [S] GZDoom v4.8
ECHO    [T] GZDoom v4.9               [U] GZDoom v4.10
ECHO    [V] GZDoom v4.11              [W] GZDoom v4.12
ECHO:

SET CHOICE=?
SET /P "CHOICE=? "

IF /I "%CHOICE%" == "?" GOTO :menu

IF /I "%CHOICE%" == "Z" %LAUNCHER% /USE gzdoom-default /IWAD DOOM2

IF /I "%CHOICE%" == "0" %LAUNCHER% /USE gzdoom-100 /IWAD DOOM2
IF /I "%CHOICE%" == "1" %LAUNCHER% /USE gzdoom-101 /IWAD DOOM2
IF /I "%CHOICE%" == "2" %LAUNCHER% /USE gzdoom-102 /IWAD DOOM2
IF /I "%CHOICE%" == "3" %LAUNCHER% /USE gzdoom-103 /IWAD DOOM2
IF /I "%CHOICE%" == "4" %LAUNCHER% /USE gzdoom-104 /IWAD DOOM2
IF /I "%CHOICE%" == "5" %LAUNCHER% /USE gzdoom-105 /IWAD DOOM2
IF /I "%CHOICE%" == "6" %LAUNCHER% /USE gzdoom-106 /IWAD DOOM2
IF /I "%CHOICE%" == "7" %LAUNCHER% /USE gzdoom-107 /IWAD DOOM2
IF /I "%CHOICE%" == "8" %LAUNCHER% /USE gzdoom-108 /IWAD DOOM2
IF /I "%CHOICE%" == "9" %LAUNCHER% /USE gzdoom-109 /IWAD DOOM2

IF /I "%CHOICE%" == "A" %LAUNCHER% /USE gzdoom-200 /IWAD DOOM2
IF /I "%CHOICE%" == "B" %LAUNCHER% /USE gzdoom-201 /IWAD DOOM2
IF /I "%CHOICE%" == "C" %LAUNCHER% /USE gzdoom-202 /IWAD DOOM2
IF /I "%CHOICE%" == "D" %LAUNCHER% /USE gzdoom-203 /IWAD DOOM2
IF /I "%CHOICE%" == "E" %LAUNCHER% /USE gzdoom-204 /IWAD DOOM2

IF /I "%CHOICE%" == "F" %LAUNCHER% /USE gzdoom-302 /IWAD DOOM2
IF /I "%CHOICE%" == "G" %LAUNCHER% /USE gzdoom-303 /IWAD DOOM2
IF /I "%CHOICE%" == "H" %LAUNCHER% /USE gzdoom-304 /IWAD DOOM2
IF /I "%CHOICE%" == "I" %LAUNCHER% /USE gzdoom-305 /IWAD DOOM2
IF /I "%CHOICE%" == "J" %LAUNCHER% /USE gzdoom-306 /IWAD DOOM2
IF /I "%CHOICE%" == "K" %LAUNCHER% /USE gzdoom-307 /IWAD DOOM2

IF /I "%CHOICE%" == "L" %LAUNCHER% /USE gzdoom-401 /IWAD DOOM2
IF /I "%CHOICE%" == "M" %LAUNCHER% /USE gzdoom-402 /IWAD DOOM2
IF /I "%CHOICE%" == "N" %LAUNCHER% /USE gzdoom-403 /IWAD DOOM2
IF /I "%CHOICE%" == "O" %LAUNCHER% /USE gzdoom-404 /IWAD DOOM2
IF /I "%CHOICE%" == "P" %LAUNCHER% /USE gzdoom-405 /IWAD DOOM2
IF /I "%CHOICE%" == "Q" %LAUNCHER% /USE gzdoom-406 /IWAD DOOM2
IF /I "%CHOICE%" == "R" %LAUNCHER% /USE gzdoom-407 /IWAD DOOM2
IF /I "%CHOICE%" == "S" %LAUNCHER% /USE gzdoom-408 /IWAD DOOM2
IF /I "%CHOICE%" == "T" %LAUNCHER% /USE gzdoom-409 /IWAD DOOM2
IF /I "%CHOICE%" == "U" %LAUNCHER% /USE gzdoom-410 /IWAD DOOM2
IF /I "%CHOICE%" == "V" %LAUNCHER% /USE gzdoom-411 /IWAD DOOM2
IF /I "%CHOICE%" == "W" %LAUNCHER% /USE gzdoom-412 /IWAD DOOM2

GOTO :gzdoom