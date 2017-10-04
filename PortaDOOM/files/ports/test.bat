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
CHOICE /C XABCDEFGHIJKLMNOPQRS /N

IF %ERRORLEVEL% EQU 1  EXIT /B
IF %ERRORLEVEL% EQU 2  CALL ..\doom.bat /WAIT /CONSOLE     choco-doom-setup    SHAREWARE\DOOM1.WAD
IF %ERRORLEVEL% EQU 3  CALL ..\doom.bat /WAIT /CONSOLE     choco-heretic-setup SHAREWARE\HERETIC1.WAD
IF %ERRORLEVEL% EQU 4  CALL ..\doom.bat /WAIT /CONSOLE     choco-hexen-setup   SHAREWARE\HEXEN.WAD
IF %ERRORLEVEL% EQU 5  CALL ..\doom.bat /WAIT /CONSOLE     choco-strife-setup  SHAREWARE\STRIFE0.WAD
IF %ERRORLEVEL% EQU 6  CALL ..\doom.bat /WAIT /CONSOLE     doom64ex            DOOM64.WAD
IF %ERRORLEVEL% EQU 7  CALL ..\doom.bat /WAIT /CONSOLE     prboom              SHAREWARE\DOOM1.WAD
IF %ERRORLEVEL% EQU 8  CALL ..\doom.bat /WAIT /CONSOLE /SW prboom              SHAREWARE\DOOM1.WAD
IF %ERRORLEVEL% EQU 9  CALL ..\doom.bat /WAIT /CONSOLE     zandronum-2         SHAREWARE\DOOM1.WAD
IF %ERRORLEVEL% EQU 10 CALL ..\doom.bat /WAIT /CONSOLE     zandronum-3         SHAREWARE\DOOM1.WAD
IF %ERRORLEVEL% EQU 11 CALL ..\doom.bat /WAIT /CONSOLE /32 gzdoom-22           SHAREWARE\DOOM1.WAD
IF %ERRORLEVEL% EQU 12 CALL ..\doom.bat /WAIT /CONSOLE     gzdoom-22           SHAREWARE\DOOM1.WAD
IF %ERRORLEVEL% EQU 13 CALL ..\doom.bat /WAIT /CONSOLE /32 gzdoom-23           SHAREWARE\DOOM1.WAD
IF %ERRORLEVEL% EQU 14 CALL ..\doom.bat /WAIT /CONSOLE     gzdoom-23           SHAREWARE\DOOM1.WAD
IF %ERRORLEVEL% EQU 15 CALL ..\doom.bat /WAIT /CONSOLE /32 gzdoom-24           SHAREWARE\DOOM1.WAD
IF %ERRORLEVEL% EQU 16 CALL ..\doom.bat /WAIT /CONSOLE     gzdoom-24           SHAREWARE\DOOM1.WAD
IF %ERRORLEVEL% EQU 17 CALL ..\doom.bat /WAIT /CONSOLE /32 gzdoom-31           SHAREWARE\DOOM1.WAD
IF %ERRORLEVEL% EQU 18 CALL ..\doom.bat /WAIT /CONSOLE     gzdoom-31           SHAREWARE\DOOM1.WAD
IF %ERRORLEVEL% EQU 19 CALL ..\doom.bat /WAIT /CONSOLE /32 gzdoom-32           SHAREWARE\DOOM1.WAD
IF %ERRORLEVEL% EQU 20 CALL ..\doom.bat /WAIT /CONSOLE     gzdoom-32           SHAREWARE\DOOM1.WAD

GOTO :menu