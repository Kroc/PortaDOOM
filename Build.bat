@ECHO OFF & SETLOCAL ENABLEEXTENSIONS DISABLEDELAYEDEXPANSION
PUSHD %~dp0

REM # detect 32-bit or 64-bit Windows
SET "WINBIT=32"
IF /I "%PROCESSOR_ARCHITECTURE%" == "EM64T" SET "WINBIT=64"	& REM # Itanium
IF /I "%PROCESSOR_ARCHITECTURE%" == "AMD64" SET "WINBIT=64"	& REM # Regular x64
IF /I "%PROCESSOR_ARCHITEW6432%" == "AMD64" SET "WINBIT=64"	& REM # 32-bit CMD on a 64-bit system (WOW64)


:menu
CLS
ECHO:
ECHO  Build PortaDOOM:
ECHO:
ECHO     [1]  Build PortaDOOM release
ECHO:
ECHO  Tools:
ECHO:
ECHO     [2]  Update PortaDOOM with DOSmag executable
ECHO     [3]  Compress executables ^(UPX^)
ECHO:
ECHO  Source Control:
ECHO:
ECHO     [8]  `git pull` DOSmag
ECHO     [9]  `git push` DOSmag
ECHO:
SET /P "$=Enter choice: "


IF "%$%" == "1" GOTO :do_release
IF "%$%" == "2" GOTO :do_dosmag_copy
IF "%$%" == "8" GOTO :do_dosmag_pull
IF "%$%" == "9" GOTO :do_dosmag_push

GOTO :menu



:do_release
REM ====================================================================================================================
CLS & TITLE Creating PortaDOOM release...

REM # select 7Zip executable
IF "%WINBIT%" == "64" SET BIN_7ZA="bin\7za\7za_x64.exe"
IF "%WINBIT%" == "32" SET BIN_7ZA="bin\7za\7za.exe"
REM # select WinRAR executable (if present)
REM # it's assumed you installed 64-bit WinRAR on a 64-bit system
SET BIN_RAR="%PROGRAMFILES%\WinRAR\rar.exe"
IF NOT EXIST %BIN_RAR% SET "BIN_RAR=" 
REM # location of UPX executable
SET BIN_UPX="bin\upx\upx.exe"


ECHO [1] Clean Up
REM --------------------------------------------------------------------------------------------------------------------
DEL PortaDOOM.7z  >NUL 2>&1
DEL PortaDOOM.rar  >NUL 2>&1


ECHO [2] Copy DOSmag executable and UPX compress it...
REM --------------------------------------------------------------------------------------------------------------------
REM COPY /Y DOSmag\DOSmag.exe PortaDOOM\PortaDOOM.exe  >NUL 2>&1
ECHO:

REM %BIN_UPX% --ultra-brute PortaDOOM\PortaDOOM.exe

ECHO:
ECHO [3] Make PortaDOOM.7z...
REM --------------------------------------------------------------------------------------------------------------------
ECHO:
REM # a         : add to archive
REM # -bso0	: disable message output
REM # -bsp1	: display only progress
REM # -r        : recurse sub-directories
REM # -ms=on    : solid-mode on (default)
REM # -mqs=on   : sort solid-files by type
REM # -mhc=on   : header compression on (default)
REM # -mx=9     : maximum compression (level 9)
REM # -myx=9    : maximum file analysis (level 9)
REM # -sfx...   : Create self-extracting archive  # -sfx7z.sfx 
REM # -xr...	: exclude files (recursively)
REM %BIN_7ZA% a -bso0 -bsp1 -r -ms=on -mqs=on -mhc=on -mx=9 -myx=9 -xr@bin\ignore.lst -- PortaDOOM.7z PortaDOOM
REM %BIN_7ZA% a -bso0 -bsp1 -r -ms=on -mqs=on -mhc=on -mx=0 -myx=0 -xr@bin\ignore.lst -- PortaDOOM.7z PortaDOOM

IF NOT %BIN_RAR% == "" (
REM # a		: add to archive
REM # -cfg-	: ignore RAR default profile and environment settings
REM # -dh	: process shared files
REM # -htb	: use BLAKE2 file hashes (stronger than CRC32)
REM # -k	: lock the archive from further modification
REM # -m5	: best compression
REM # -ma5	: use RAR5 format (this is the default since v5.50)
REM # -md1g	: use 1 GB dictionary (approx 6-10 GB used during compression!)
REM # -ms...	: don't compress these files (DOOM-Crusher will have done its best already)
REM # -qo-	: don't add quick-open info
REM # -r	: recurse sub-folders
REM # -rr3	: add 3% recovery record (protects against random corruption)
REM # -s	: create solid archive
REM # -ts-	: DO NOT save time accessed / modified / created to archive (saves space)
REM # -x@...	: ignore files using the list file given
%BIN_RAR% a -cfg- -dh -htb -k -m5 -ma5 -md1g -mspng;jpeg;jpg -qo- -r -rr3 -s -ts- -x@bin\ignore.lst PortaDOOM.rar -- PortaDOOM 
)

ECHO:
ECHO Complete.
ECHO:
PAUSE
EXIT /B


:do_dosmag_copy
REM ====================================================================================================================
CLS
COPY /Y DOSmag\DOSmag.exe PortaDOOM\PortaDOOM.exe

START "" PortaDOOM\PortaDOOM.exe

EXIT /B


:do_dosmag_pull
REM ====================================================================================================================
REM # updates DOSmag from the GitLab repo

REM # TODO: check for existence of git

CLS
ECHO Pulling DOSmag updates from GitHub:
ECHO (working copy must be clean!)
ECHO:

git subtree pull --prefix DOSmag --squash dosmag master

COPY /Y DOSmag\DOSmag.exe PortaDOOM\PortaDOOM.exe >NUL

ECHO:
PAUSE
EXIT /B


:do_dosmag_push
REM ====================================================================================================================

CLS
ECHO Pushing DOSmag changes to GitHub:
ECHO:

git subtree push --prefix DOSmag dosmag master

ECHO:
PAUSE
EXIT /B