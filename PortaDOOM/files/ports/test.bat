:: PortaDOOM, copyright (C) Kroc Camen 2016-2019, BSD 2-clause
@ECHO OFF & SETLOCAL ENABLEEXTENSIONS DISABLEDELAYEDEXPANSION

SET "LAUNCHER=..\launcher.exe /WAIT"

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
ECHO    [F] DOOM Retro
ECHO:
ECHO    [G] DOOM 64 EX
ECHO:
ECHO    [H] PRBoom+ hardware            [I] PRBoom+ software
ECHO:
ECHO    [J] Zandronum v2.x
ECHO    [K] Zandronum v3.x
ECHO:
ECHO    [L] GZDoom ...
ECHO:
ECHO    [Z] ZDoom v2.8.1
ECHO:

SET CHOICE=?
SET /P "CHOICE=? "

IF /I "%CHOICE%" == "?" GOTO :menu
IF /I "%CHOICE%" == "A" %LAUNCHER% /USE choco-doom-setup    /IWAD DOOM
IF /I "%CHOICE%" == "B" %LAUNCHER% /USE choco-heretic-setup /IWAD HERETIC
IF /I "%CHOICE%" == "C" %LAUNCHER% /USE choco-hexen-setup   /IWAD HEXEN
IF /I "%CHOICE%" == "D" %LAUNCHER% /USE choco-strife-setup  /IWAD STRIFE1
IF /I "%CHOICE%" == "E" %LAUNCHER% /USE crispy-doom-setup   /IWAD DOOM2
IF /I "%CHOICE%" == "F" %LAUNCHER% /USE doom-retro          /IWAD DOOM2
IF /I "%CHOICE%" == "G" %LAUNCHER% /USE doom64ex            /IWAD DOOM64
IF /I "%CHOICE%" == "H" %LAUNCHER% /USE prboom-plus-hw      /IWAD DOOM2
IF /I "%CHOICE%" == "I" %LAUNCHER% /USE prboom-plus-sw      /IWAD DOOM2
IF /I "%CHOICE%" == "J" %LAUNCHER% /USE zandronum-2         /IWAD DOOM2
IF /I "%CHOICE%" == "K" %LAUNCHER% /USE zandronum-3         /IWAD DOOM2
IF /I "%CHOICE%" == "L" GOTO :gzdoom
IF /I "%CHOICE%" == "Z" %LAUNCHER% /USE zdoom               /IWAD DOOM2

GOTO :menu

:gzdoom
CLS
ECHO:
ECHO  GZDoom:
ECHO:
ECHO    [0] GZDoom Current 32-bit     [1] GZDoom Current 64-bit
ECHO:
ECHO    [A] GZDoom v1.0               [B] GZDoom v1.1
ECHO    [C] GZDoom v1.2               [D] GZDoom v1.3
ECHO    [E] GZDoom v1.4               [F] GZDoom v1.5
ECHO    [G] GZDoom v1.6               [H] GZDoom v1.7
ECHO    [I] GZDoom v1.8               [J] GZDoom v1.9
ECHO:
ECHO    [K] GZDoom v2.0               [L] GZDoom v2.1
ECHO    [M] GZDoom v2.2               [N] GZDoom v2.3
ECHO    [O] GZDoom v2.4
ECHO:
ECHO    [P] GZDoom v3.2               [Q] GZDoom v3.3
ECHO    [R] GZDoom v3.4               [S] GZDoom v3.5
ECHO    [T] GZDoom v3.6               [U] GZDoom v3.7
ECHO 	[V] GZDoom v4.1
ECHO:

SET CHOICE=?
SET /P "CHOICE=? "

IF /I "%CHOICE%" == "?" GOTO :menu

IF /I "%CHOICE%" == "0" %LAUNCHER% /USE gzdoom-default /IWAD DOOM2 /32
IF /I "%CHOICE%" == "1" %LAUNCHER% /USE gzdoom-default /IWAD DOOM2

IF /I "%CHOICE%" == "A" %LAUNCHER% /USE gzdoom-10 /IWAD DOOM2
IF /I "%CHOICE%" == "B" %LAUNCHER% /USE gzdoom-11 /IWAD DOOM2
IF /I "%CHOICE%" == "C" %LAUNCHER% /USE gzdoom-12 /IWAD DOOM2
IF /I "%CHOICE%" == "D" %LAUNCHER% /USE gzdoom-13 /IWAD DOOM2
IF /I "%CHOICE%" == "E" %LAUNCHER% /USE gzdoom-14 /IWAD DOOM2
IF /I "%CHOICE%" == "F" %LAUNCHER% /USE gzdoom-15 /IWAD DOOM2
IF /I "%CHOICE%" == "G" %LAUNCHER% /USE gzdoom-16 /IWAD DOOM2
IF /I "%CHOICE%" == "H" %LAUNCHER% /USE gzdoom-17 /IWAD DOOM2
IF /I "%CHOICE%" == "I" %LAUNCHER% /USE gzdoom-18 /IWAD DOOM2
IF /I "%CHOICE%" == "J" %LAUNCHER% /USE gzdoom-19 /IWAD DOOM2

IF /I "%CHOICE%" == "K" %LAUNCHER% /USE gzdoom-20 /IWAD DOOM2
IF /I "%CHOICE%" == "L" %LAUNCHER% /USE gzdoom-21 /IWAD DOOM2
IF /I "%CHOICE%" == "M" %LAUNCHER% /USE gzdoom-22 /IWAD DOOM2
IF /I "%CHOICE%" == "N" %LAUNCHER% /USE gzdoom-23 /IWAD DOOM2
IF /I "%CHOICE%" == "O" %LAUNCHER% /USE gzdoom-24 /IWAD DOOM2

IF /I "%CHOICE%" == "P" %LAUNCHER% /USE gzdoom-32 /IWAD DOOM2
IF /I "%CHOICE%" == "Q" %LAUNCHER% /USE gzdoom-33 /IWAD DOOM2
IF /I "%CHOICE%" == "R" %LAUNCHER% /USE gzdoom-34 /IWAD DOOM2
IF /I "%CHOICE%" == "S" %LAUNCHER% /USE gzdoom-35 /IWAD DOOM2
IF /I "%CHOICE%" == "T" %LAUNCHER% /USE gzdoom-36 /IWAD DOOM2
IF /I "%CHOICE%" == "U" %LAUNCHER% /USE gzdoom-37 /IWAD DOOM2
IF /I "%CHOICE%" == "V" %LAUNCHER% /USE gzdoom-41 /IWAD DOOM2

GOTO :gzdoom