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

SET CHOICE=?
SET /P "CHOICE=? "

IF /I "%CHOICE%" == "?" GOTO :menu
IF /I "%CHOICE%" == "A" ..\launcher.exe /WAIT     /USE choco-doom-setup    /IWAD DOOM
IF /I "%CHOICE%" == "B" ..\launcher.exe /WAIT     /USE choco-heretic-setup /IWAD HERETIC
IF /I "%CHOICE%" == "C" ..\launcher.exe /WAIT     /USE choco-hexen-setup   /IWAD HEXEN
IF /I "%CHOICE%" == "D" ..\launcher.exe /WAIT     /USE choco-strife-setup  /IWAD STRIFE1
IF /I "%CHOICE%" == "E" ..\launcher.exe /WAIT     /USE crispy-doom-setup   /IWAD DOOM2
IF /I "%CHOICE%" == "F" ..\launcher.exe /WAIT     /USE doom64ex            /IWAD DOOM64
IF /I "%CHOICE%" == "G" ..\launcher.exe /WAIT     /USE doom-retro          /IWAD DOOM2
IF /I "%CHOICE%" == "H" ..\launcher.exe /WAIT     /USE prboom-plus         /IWAD DOOM2
IF /I "%CHOICE%" == "I" ..\launcher.exe /WAIT /SW /USE prboom-plus         /IWAD DOOM2
IF /I "%CHOICE%" == "J" ..\launcher.exe /WAIT     /USE zandronum-2         /IWAD DOOM2
IF /I "%CHOICE%" == "K" ..\launcher.exe /WAIT     /USE zandronum-3         /IWAD DOOM2
IF /I "%CHOICE%" == "L" GOTO :gzdoom
IF /I "%CHOICE%" == "Z" ..\launcher.exe /WAIT     /USE zdoom               /IWAD DOOM2

GOTO :menu

:gzdoom
CLS
ECHO:
ECHO  GZDoom:
ECHO:
ECHO    [0] GZDoom v3.6.x : 32-bit      [1] GZDoom v3.6.x : 64-bit
ECHO    [2] GZDoom v3.5.x : 32-bit      [3] GZDoom v3.5.x : 64-bit
ECHO    [A] GZDoom v3.4.x : 32-bit      [B] GZDoom v3.4.x : 64-bit
ECHO    [C] GZDoom v3.3.x : 32-bit      [D] GZDoom v3.3.x : 64-bit
ECHO    [E] GZDoom v3.2.x : 32-bit      [F] GZDoom v3.2.x : 64-bit
ECHO    [G] GZDoom v2.4.x : 32-bit      [H] GZDoom v2.4.x : 64-bit
ECHO    [I] GZDoom v2.3.x : 32-bit      [J] GZDoom v2.3.x : 64-bit
ECHO    [K] GZDoom v2.2.x : 32-bit      [L] GZDoom v2.2.x : 64-bit
ECHO    [M] GZDoom v2.1.x : 32-bit      [N] GZDoom v2.1.x : 64-bit
ECHO:
ECHO    [O] GZDoom v2.0.x               [P] GZDoom v1.9.x
ECHO    [Q] GZDoom v1.8.x               [R] GZDoom v1.7.x
ECHO    [S] GZDoom v1.6.x               [T] GZDoom v1.5.x
ECHO    [U] GZDoom v1.4.x               [V] GZDoom v1.3.x
ECHO    [W] GZDoom v1.2.x               [X] GZDoom v1.1.x
ECHO    [Y] GZDoom v1.0.x
ECHO:

SET CHOICE=?
SET /P "CHOICE=? "

IF /I "%CHOICE%" == "?" GOTO :menu
IF /I "%CHOICE%" == "0" ..\launcher.exe /WAIT /32 /USE gzdoom-36 /IWAD DOOM2
IF /I "%CHOICE%" == "1" ..\launcher.exe /WAIT     /USE gzdoom-36 /IWAD DOOM2
IF /I "%CHOICE%" == "2" ..\launcher.exe /WAIT /32 /USE gzdoom-35 /IWAD DOOM2
IF /I "%CHOICE%" == "3" ..\launcher.exe /WAIT     /USE gzdoom-35 /IWAD DOOM2
IF /I "%CHOICE%" == "A" ..\launcher.exe /WAIT /32 /USE gzdoom-34 /IWAD DOOM2
IF /I "%CHOICE%" == "B" ..\launcher.exe /WAIT     /USE gzdoom-34 /IWAD DOOM2
IF /I "%CHOICE%" == "C" ..\launcher.exe /WAIT /32 /USE gzdoom-33 /IWAD DOOM2
IF /I "%CHOICE%" == "D" ..\launcher.exe /WAIT     /USE gzdoom-33 /IWAD DOOM2
IF /I "%CHOICE%" == "E" ..\launcher.exe /WAIT /32 /USE gzdoom-32 /IWAD DOOM2
IF /I "%CHOICE%" == "F" ..\launcher.exe /WAIT     /USE gzdoom-32 /IWAD DOOM2
IF /I "%CHOICE%" == "G" ..\launcher.exe /WAIT /32 /USE gzdoom-24 /IWAD DOOM2
IF /I "%CHOICE%" == "H" ..\launcher.exe /WAIT     /USE gzdoom-24 /IWAD DOOM2
IF /I "%CHOICE%" == "I" ..\launcher.exe /WAIT /32 /USE gzdoom-23 /IWAD DOOM2
IF /I "%CHOICE%" == "J" ..\launcher.exe /WAIT     /USE gzdoom-23 /IWAD DOOM2
IF /I "%CHOICE%" == "K" ..\launcher.exe /WAIT /32 /USE gzdoom-22 /IWAD DOOM2
IF /I "%CHOICE%" == "L" ..\launcher.exe /WAIT     /USE gzdoom-22 /IWAD DOOM2
IF /I "%CHOICE%" == "M" ..\launcher.exe /WAIT /32 /USE gzdoom-21 /IWAD DOOM2
IF /I "%CHOICE%" == "N" ..\launcher.exe /WAIT     /USE gzdoom-21 /IWAD DOOM2

IF /I "%CHOICE%" == "O" ..\launcher.exe /WAIT     /USE gzdoom-20 /IWAD DOOM2
IF /I "%CHOICE%" == "P" ..\launcher.exe /WAIT     /USE gzdoom-19 /IWAD DOOM2
IF /I "%CHOICE%" == "Q" ..\launcher.exe /WAIT     /USE gzdoom-18 /IWAD DOOM2
IF /I "%CHOICE%" == "R" ..\launcher.exe /WAIT     /USE gzdoom-17 /IWAD DOOM2
IF /I "%CHOICE%" == "S" ..\launcher.exe /WAIT     /USE gzdoom-16 /IWAD DOOM2
IF /I "%CHOICE%" == "T" ..\launcher.exe /WAIT     /USE gzdoom-15 /IWAD DOOM2
IF /I "%CHOICE%" == "U" ..\launcher.exe /WAIT     /USE gzdoom-14 /IWAD DOOM2
IF /I "%CHOICE%" == "V" ..\launcher.exe /WAIT     /USE gzdoom-13 /IWAD DOOM2
IF /I "%CHOICE%" == "W" ..\launcher.exe /WAIT     /USE gzdoom-12 /IWAD DOOM2
IF /I "%CHOICE%" == "X" ..\launcher.exe /WAIT     /USE gzdoom-11 /IWAD DOOM2
IF /I "%CHOICE%" == "Y" ..\launcher.exe /WAIT     /USE gzdoom-10 /IWAD DOOM2

GOTO :gzdoom