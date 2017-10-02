@ECHO OFF
REM # will not work as-is in chocolate-doom due to NWT format,
REM # see https://doomwiki.org/wiki/Mordeth for details
PUSHD "%~dp0" & CALL "..\..\..\play.bat" /REQ boom /PWAD MORDETH.WAD -- MDEUGRAP.WAD MORDETH.DEH