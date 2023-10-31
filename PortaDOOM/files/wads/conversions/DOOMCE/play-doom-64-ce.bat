:: PortaDOOM, copyright (C) Kroc Camen 2016-2023, BSD 2-clause
:: (find and convert DOOM64.WAD first)
@CALL "%~dp0doom64-install.bat"
@IF NOT EXIST "DOOM64.IWAD" PAUSE & EXIT
@PUSHD "%~dp0" & "..\..\..\launcher.exe" "play-doom-64-ce.ini" %*