@ECHO OFF
REM # requires a few manual settings provided in "ShadowOfTheWoolBall_Settings.cfg"
PUSHD "%~dp0" & CALL "..\..\..\doom.bat" /USE zdoom /PWAD ShadowOfTheWoolBall.wad /EXEC ShadowOftheWoolBall_Settings.cfg