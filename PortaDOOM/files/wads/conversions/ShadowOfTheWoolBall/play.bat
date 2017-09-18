@ECHO OFF
REM # requires a few manual settings originally provided in "ShadowOfTheWoolBall_Settings.cfg"
PUSHD "%~dp0" & CALL "..\..\..\doom.bat" /SW gzdoom DOOM2 ShadowOfTheWoolBall.wad +wipetype 0 +movebob 0.015 +language=enu
REM # original play.bat call, but doesn't yet support manual settings
REM PUSHD "%~dp0" & CALL "..\..\..\play.bat" /REQ zdoom+sw /PWAD ShadowOfTheWoolBall.wad