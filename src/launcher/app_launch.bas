'copyright (C) Kroc Camen 2018-2023, BSD 2-clause
'app_launch.bas : build a command string to launch a DOOM engine!

save_params:
'=============================================================================
'save the selected engine & parameters to the user INI file, to offer
'the player to re-use the previous engine setup in the future

launch:
'=============================================================================
'launch the selected game, with the selected engine, with the selected
'parameters, any mods (if selected) and so forth. we need to build the
'right command-line to do all of this
'
'   [01]: save game path
'   [02]: engine executable
'   [03]: config file
'   [04]: compatibility level
'   [05]: IWAD
'   [06]: auto-load files
'   [07]: PWAD
'   [08]: file-list
'   [09]: DEH & BEX
'   [10]: demo playback
'   [11]: warp & skill
'   [12]: resolution & full-screen
'   [13]: execute scripts / additional commands
'   [14]: launch!

CALL UI_ClearScreen

'NOTE: many doom engines save their config files in the 'current directory',
'which is typically expected to be that of the executable. however, we want
'to separate user-data (such as save-games) from the engines. whilst we can
'change the save directory, config files will still be dumped in the 'current
'directory'.

'we therefore need to change the current directory and rewrite
'all the WAD / file paths to be relative from there!

'this is the relative path from the WAD's save folder back to this executable.
'in the future, we may have to vary this if some engines won't co-operate
CONST FIX_PATH$ = "..\..\..\"

'we will remember the directory of the last file
'(used for finding side-by-side WADs)
DIM SHARED DIR_PREV$
'other directories that will be remembered as we go
DIM SHARED DIR_IWAD$
DIM SHARED DIR_PWAD$

'variables we use when searching for files
'(via `WADs_Find$`)
DIM file$
DIM find$

'some engines require different methods of passing extra files, e.g. PWAD
'and mods. as we go, we'll build up a list of files to include (in the right
'order) and worry about the specific invocation at the end
LET CMD_FILES$ = ""

'-----------------------------------------------------------------------------
'[01] save game path:
'-----------------------------------------------------------------------------
'the "saves" folder should exist (it's part of PortaDOOM),
'but just in case, check
CALL Launch_MkDir(DIR_EXE$ + DIR_SAVES$)

'add the save-folder name for the selected engine; there can be
'multiple folder names and IDs for engines, such as 32/64-bit and
'differing versions, so a common save name is provided in the INI
DIM DIR_SAVE_ENGINE$
LET DIR_SAVE_ENGINE$ = Paths_AddSlash$( _
    DIR_SAVES$ + Engines_Selected.save _
)

'does this folder exist?
CALL Launch_MkDir(DIR_EXE$ + DIR_SAVE_ENGINE$)

'the saves folder will contain a sub-folder for each engine (above),
'and then another sub-folder for the IWAD or PWAD
DIM DIR_SAVE_GAME$
LET DIR_SAVE_GAME$ = ""

'pre:
'-----------------------------------------------------------------------------
'if there are pre-files, include those in the save-slug
IF Games_Selected.pre <> "" THEN
    'there may be multiple...
    'read the first file from the list
    LET file$ = Games_Selected.pre
    LET file$ = WADs_Split$(file$)
    DO
        'strip any path + extension and add to the list
        LET DIR_SAVE_GAME$ = DIR_SAVE_GAME$ + Paths_GetFileBaseName$(file$)
        'get the next file in the list
        LET file$ = WADs_Split$("")
        'if there is more, add a separator
        IF file$ <> "" THEN LET DIR_SAVE_GAME$ = DIR_SAVE_GAME$ + "-"
    LOOP WHILE file$ <> ""
END IF

'IWAD / PWAD:
'-----------------------------------------------------------------------------
'only include the IWAD name if there is no PWAD
'e.g. we want to use "scythe" instead of "doom2-scythe"
IF Games_Selected.pwad = "" THEN
    'if there were pre-files, a separator is needed
    IF DIR_SAVE_GAME$ <> "" THEN LET DIR_SAVE_GAME$ = DIR_SAVE_GAME$ + "-"
    'append the IWAD name
    LET DIR_SAVE_GAME$ = DIR_SAVE_GAME$ _
      + Paths_GetFileBaseName$(IWADs_Selected.path)
ELSE
    'if there were pre-files, a separator is needed
    IF DIR_SAVE_GAME$ <> "" THEN LET DIR_SAVE_GAME$ = DIR_SAVE_GAME$ + "-"
    'append the PWAD name
    LET DIR_SAVE_GAME$ = DIR_SAVE_GAME$ _
      + Paths_GetFileBaseName$(Games_Selected.pwad)
END IF

'files:
'-----------------------------------------------------------------------------
'any files to include after the IWAD/PWAD?
IF Games_Selected.files <> "" THEN
    'add a separator after the IWAD/PWAD
    LET DIR_SAVE_GAME$ = DIR_SAVE_GAME$ + "-"
    'there may be multiple files,
    'read the first file from the list
    LET file$ = Games_Selected.files
    LET file$ = WADs_Split$(file$)
    DO
        'strip any path + extension and add to the list
        LET DIR_SAVE_GAME$ = DIR_SAVE_GAME$ + Paths_GetFileBaseName$(file$)
        'get the next file in the list
        LET file$ = WADs_Split$("")
        'if there is more, add a separator
        IF file$ <> "" THEN LET DIR_SAVE_GAME$ = DIR_SAVE_GAME$ + "-"
    LOOP WHILE file$ <> ""
END IF

'does this folder exist?
CALL Launch_MkDir(DIR_EXE$ + DIR_SAVE_ENGINE$ + DIR_SAVE_GAME$)

'-----------------------------------------------------------------------------
'[02] engine executable:
'-----------------------------------------------------------------------------
DIM DIR_ENGINE$
LET DIR_ENGINE$ = DIR_PORTS$ + Paths_AddSlash$(Engines_Selected.dir)

'add the engine executable to the command-line
LET CMD$ = CHR$(34) _
         + Launch_FixPath$(DIR_ENGINE$) + Engines_Selected.exe _
         + CHR$(34)

COLOR YELLOW: PRINT "         port : ";: COLOR UI_FORECOLOR
PRINT RTRUNCATE$(Engines_Selected.title, UI_SCREEN_WIDTH - 17)
COLOR YELLOW: PRINT "       engine : ";: COLOR UI_FORECOLOR
PRINT RTRUNCATE$(DIR_ENGINE$ + Engines_Selected.exe, UI_SCREEN_WIDTH - 17)
PRINT ""

'-----------------------------------------------------------------------------
'[03] config file:
'-----------------------------------------------------------------------------
DIM CMD_CONFIG$

'which file-extension does the engine use? ZDoom-based engines
'use ".ini", everything else ".cfg" (including DOOM64EX)
DIM cfg$
IF Engines_Selected.kin >= KIN_Z THEN
    LET cfg$ = ".ini"
ELSE
    LET cfg$ = ".cfg"
END IF

'define the default config file path, as we will need to copy this if the
'engine's config file doesn't exist yet. note that this leaves off the
'file-extension, for now as we may have to add an extra slug to the name
DIM cfg_default$
LET cfg_default$ = DIR_CONFIG$ + "default." + Engines_Selected.cfg

'was the command-line parameter given to use the default config-file?
IF CMD_DEFAULT` THEN
    'set the path to the default config file (sans-extension)
    LET CMD_CONFIG$ = cfg_default$
ELSE
    'build the path to the user's config file (for selected engine)
    'note that this leaves off the file extension, for now
    DIM cfg_engine$
    LET cfg_engine$ = DIR_SAVE_ENGINE$ + "config." + Engines_Selected.cfg

    'if the user's config file doesn't exist,
    'make a copy of the default:
    IF NOT _FILEEXISTS(cfg_engine$ + cfg$) THEN
        'copy across the default config file
        IF _SHELLHIDE("COPY /Y " _
            + CHR$(34) + cfg_default$ + cfg$ + CHR$(34) + " /A " _
            + CHR$(34) + cfg_engine$ + cfg$ + CHR$(34) + " /A" _
        ) <> 0 THEN
            CALL UIErrorScreen( _
                "ERROR: Write Error", _
                "Could not copy the default config file '" _
              + cfg_default$ + cfg$ + "' to the user config file '" _
              + cfg_engine$ + cfg$ + "'. Ensure that the media you are " _
              + "running launcher.exe from is not write protected, and " _
              + "that the 'files\saves' folder exists, and is writable." _
            )
        END IF
        
        'vanilla engines store non-original settings in an extra config file
        IF Engines_Selected.kin = KIN_V THEN
            IF _SHELLHIDE("COPY /Y " _
                + CHR$(34) + cfg_default$ + ".extra" + cfg$ + CHR$(34) + " /A " _
                + CHR$(34) + cfg_engine$ + ".extra" + cfg$ + CHR$(34) + " /A" _
            ) <> 0 THEN
                CALL UIErrorScreen( _
                    "ERROR: Write Error", _
                    "Could not copy the default config file '" _
                  + cfg_default$ + ".extra" + cfg$ + "' to the user " _
                  + "config file '" + cfg_engine$ + ".extra" + cfg$ _
                  + "'. Ensure that the media you are running " _ 
                  + "launcher.exe from is not write protected, and that " _
                  + "the 'files\saves' folder exists, and is writable." _
                )
            END IF
        END IF
    END IF
    
    LET CMD_CONFIG$ = cfg_engine$
END IF

'add the command-line parameter to select the config file
LET CMD$ = CMD$ + " -config " _
         + CHR$(34) + Launch_FixPath$(CMD_CONFIG$) + cfg$ + CHR$(34)
COLOR YELLOW: PRINT "      -config : ";: COLOR UI_FORECOLOR
PRINT RTRUNCATE$(CMD_CONFIG$ + cfg$, UI_SCREEN_WIDTH - 17)

'vanilla engines (Chocolate-Doom, Crispy-Doom) store non-original settings
'in an extra config file (this is why we omit the file extension until now)
IF Engines_Selected.kin = KIN_V THEN
    LET CMD$ = CMD$ + " -extraconfig " _
             + CHR$(34) + Launch_FixPath$(CMD_CONFIG$ + ".extra" + cfg$) _
             + CHR$(34)
    
    COLOR YELLOW: PRINT " -extraconfig : ";: COLOR UI_FORECOLOR
    PRINT RTRUNCATE$(CMD_CONFIG$ + ".extra" + cfg$, UI_SCREEN_WIDTH - 17)
END IF

'-----------------------------------------------------------------------------
'[04] compatibility level:
'-----------------------------------------------------------------------------
IF Games_Selected.cmplvl >= 0 THEN
    LET CMD$ = CMD$ + " -complevel " + STRINT$(Games_Selected.cmplvl)
    
    COLOR YELLOW: PRINT "   -complevel : ";: COLOR UI_FORECOLOR
    PRINT STRINT$(Games_Selected.cmplvl)
END IF

'-----------------------------------------------------------------------------
'[05] IWAD:
'-----------------------------------------------------------------------------
'try and locate the IWAD path
'FIXME: handle FreeDOOM replacement / BFG-edition patching
LET CMD_IWAD$ = IWADs_GetPath$(IWADs_Selected.path)
'TODO: IWAD not found at all (no substitution)
LET DIR_IWAD$ = Paths_GetPath$(CMD_IWAD$)

LET CMD_IWAD$ = Launch_ClipPath$(CMD_IWAD$)
LET CMD$ = CMD$ + " -iwad " _
         + CHR$(34) + Launch_FixPath$(CMD_IWAD$) + CHR$(34)
         
COLOR YELLOW: PRINT "        -iwad : ";: COLOR UI_FORECOLOR
PRINT RTRUNCATE$(CMD_IWAD$, UI_SCREEN_WIDTH - 17)

'-----------------------------------------------------------------------------
'[06] auto-load files:
'-----------------------------------------------------------------------------
'any files that should be automatically included with the engine?
'(e.g. "brightmaps.pk3", "lights.pk3")
IF Engines_Selected.auto <> "" THEN
    'read the first file from the list
    LET file$ = WADs_Split$(Engines_Selected.auto)
    DO
        'locate the file according to WAD search rules
        LET find$ = WADs_Find$(file$)
        'file missing?
        IF find$ = "" THEN CALL UIError_FileNotFound(file$)
        
        'add to the list of files for the command-line params
        LET CMD_FILES$ = CMD_FILES$ + find$ + ";"
        
        COLOR YELLOW: PRINT " (auto) -file : ";: COLOR UI_FORECOLOR
        PRINT RTRUNCATE$(Launch_ClipPath$(find$), UI_SCREEN_WIDTH - 17)
        
        LET file$ = WADs_Split$("")
    LOOP WHILE file$ <> ""
END IF

'games can also specify their own files to load
'before the PWAD as sometimes load order is sensitive
'-----------------------------------------------------------------------------
IF Games_Selected.pre <> "" THEN
    'read the first file from the list
    LET file$ = Games_Selected.pre
    LET file$ = WADs_Split$(file$)
    DO
        'locate the file according to WAD search rules
        LET find$ = WADs_Find$(file$)
        'file missing?
        IF find$ = "" THEN CALL UIError_FileNotFound(file$)
        
        'add to the list of files for the command-line params
        LET CMD_FILES$ = CMD_FILES$ + find$ + ";"
        
        COLOR YELLOW: PRINT " (auto) -file : ";: COLOR UI_FORECOLOR
        PRINT RTRUNCATE$(Launch_ClipPath$(find$), UI_SCREEN_WIDTH - 17)
        
        'get the next file in the list
        LET file$ = WADs_Split$("")
    LOOP WHILE file$ <> ""
END IF

'-----------------------------------------------------------------------------
'[07] PWAD:
'-----------------------------------------------------------------------------
'doom engines typically don't have a specific concept of a "PWAD", it's just
'an additional file to load like any other and it's not necessarily the first
'listed -- that will likely be the auto-load files
IF Games_Selected.pwad <> "" THEN
    'search for the PWAD
    LET file$ = Games_Selected.pwad
    LET find$ = WADs_GetPWADPath$(file$)
    'file not found?
    IF find$ = "" THEN CALL UIError_FileNotFound(file$)
    
    'remember the directory of the PWAD for searching for other files
    LET DIR_PWAD$ = Paths_GetPath$(find$)
    
    LET CMD_FILES$ = CMD_FILES$ + find$ + ";"
    
    COLOR YELLOW: PRINT " (pwad) -file : ";: COLOR UI_FORECOLOR
    PRINT RTRUNCATE$(Launch_ClipPath$(find$), UI_SCREEN_WIDTH - 17)
END IF

'-----------------------------------------------------------------------------
'[08] file-list:
'-----------------------------------------------------------------------------
IF Games_Selected.files <> "" THEN
    'read the first file from the list
    LET file$ = WADs_Split$(Games_Selected.files)
    DO
        'locate the file according to WAD search rules
        LET find$ = WADs_Find$(file$)
        'file missing?
        IF find$ = "" THEN CALL UIError_FileNotFound(file$)
        
        'add to the list of files for the command-line params
        LET CMD_FILES$ = CMD_FILES$ + find$ + ";"
        
        'announce
        COLOR YELLOW: PRINT "        -file : ";: COLOR UI_FORECOLOR
        PRINT RTRUNCATE$(Launch_ClipPath$(find$), UI_SCREEN_WIDTH - 17)
        
        'get the next file in the list (if any)
        LET file$ = WADs_Split$("")
    LOOP WHILE file$ <> ""
END IF

'add all files to the command-line:
'(note that all these files have been located beforehand)
'-----------------------------------------------------------------------------
IF CMD_FILES$ <> "" THEN
    'vanilla engines use `-merge`
    IF Engines_Selected.kin = KIN_V THEN
        CMD$ = CMD$ + " -merge"
    ELSE
        CMD$ = CMD$ + " -file"
    END IF
    
    'read the first file from the list
    LET file$ = WADs_Split$(CMD_FILES$)
    DO
        'add the file to the command-line
        LET CMD$ = CMD$ + " " + CHR$(34) + Launch_FixPath$(file$) + CHR$(34)
        'get the next file in the list (if any)
        LET file$ = WADs_Split$("")
    LOOP WHILE file$ <> ""
END IF

'-----------------------------------------------------------------------------
'[09] DEH & BEX:
'-----------------------------------------------------------------------------
'does the IWAD provide its own DEH file?
'CHEX.WAD does this, so does REKKR stand-alone
IF IWADs_Selected.deh <> "" THEN
    'the IWAD's DEH should probably come first
    LET CMD_DEH$ = IWADs_Selected.deh
    'if this is CHEX.WAD then PrBoom+ likes a `-exe chex` parameter for
    'demo compatibility. we don't have a generic way to sepecify this yet
    IF UCASE$(Paths_GetFileBaseName$(CMD_IWAD$)) = "CHEX" THEN
        LET CMD$ = CMD$ + " -exe chex"
    END IF
END IF

'has a DEH file been specified?
IF Games_Selected.deh <> "" THEN
    'if an IWAD DEH is already provided, append to the list
    IF CMD_DEH$ <> "" THEN LET CMD_DEH$ = CMD_DEH$ + ";"
    'append the game's DEH file(s)
    LET CMD_DEH$ = CMD_DEH$ + Games_Selected.deh
END IF

'any DEH files at all?
IF CMD_DEH$ <> "" THEN
    'read the first file from the list;
    'although rare, multiple DEH files are supported (e.g. DOOM 4 VANILLA)
    LET file$ = CMD_DEH$
    LET file$ = WADs_Split$(file$)
    'the command line only needs `-deh` once, so do that first
    LET CMD$ = CMD$ + " -deh"
    DO
        'locate the file according to WAD search rules
        LET find$ = WADs_Find$(file$)
        'file missing?
        IF find$ = "" THEN CALL UIError_FileNotFound(file$)
        
        'add it to the command-line
        LET CMD$ = CMD$ + " " + CHR$(34) + Launch_FixPath$(find$) + CHR$(34)
        'and announce
        COLOR YELLOW: PRINT "         -deh : ";: COLOR UI_FORECOLOR
        PRINT RTRUNCATE$(Launch_ClipPath$(find$), UI_SCREEN_WIDTH - 17)
        
        'get the next DEH file in the list
        LET file$ = WADs_Split$("")
    LOOP WHILE file$ <> ""
END IF

'has a BEX file been specified?
LET CMD_BEX$ = Games_Selected.bex
IF CMD_BEX$ <> "" THEN
    'read the first file from the list
    LET file$ = CMD_BEX$
    LET file$ = WADs_Split$(file$)
    'the command line only needs `-deh` once, so do that first
    LET CMD$ = CMD$ + " -bex"
    DO
        'locate the file according to WAD search rules
        LET find$ = WADs_Find$(file$)
        'file missing?
        IF find$ = "" THEN CALL UIError_FileNotFound(file$)
        
        'add it to the command-line
        LET CMD$ = CMD$ + " " + CHR$(34) + Launch_FixPath$(find$) + CHR$(34)
        'and announce
        COLOR YELLOW: PRINT "         -bex : ";: COLOR UI_FORECOLOR
        PRINT RTRUNCATE$(Launch_ClipPath$(find$), UI_SCREEN_WIDTH - 17)
        
        'get the next BEX file in the list
        LET file$ = WADs_Split$("")
    LOOP WHILE file$ <> ""
END IF

'-----------------------------------------------------------------------------
'[10] demo playback:
'-----------------------------------------------------------------------------
IF LEN(CMD_DEMO$) <> 0 THEN
    'try and find the file:
    'try the folder from which the launcher was called
    LET file$ = DIR_CUR$ + CMD_DEMO$
    'if it doesn't exist there...
    IF NOT _FILEEXISTS(file$) THEN
        'try the special demos folder
        LET file$ = DIR_DEMOS$ + CMD_DEMO$
        'if it doesn't exist there...
        IF NOT _FILEEXISTS(file$) THEN CALL UIError_FileNotFound(file$)
    END IF
    
    'add the command-line param to play the demo
    LET CMD$ = CMD$ + " -playdemo " _
             + CHR$(34) + Launch_FixPath$(file$) + CHR$(34)
             
    COLOR YELLOW: PRINT "    -playdemo : ";: COLOR UI_FORECOLOR
    PRINT RTRUNCATE$(Launch_ClipPath$(file$), UI_SCREEN_WIDTH - 17)
END IF

'-----------------------------------------------------------------------------
'[11] warp & skill:
'-----------------------------------------------------------------------------
'is a warp requested? (episode and/or map-number)
IF Games_Selected.warp_e >= 0 _
OR Games_Selected.warp_m >= 0 THEN
    'compose the -warp parameter for engines:
    DIM e$: LET e$ = STR$(Games_Selected.warp_e)
    DIM m$: LET m$ = STR$(Games_Selected.warp_m)
    DIM warp$
    
    IF Games_Selected.warp_e >= 0 THEN LET warp$ = warp$ + e$
    IF Games_Selected.warp_m >= 0 THEN LET warp$ = warp$ + m$
    
    'add to the command-line and announce
    LET CMD$ = CMD$ + " -warp" + warp$
    COLOR YELLOW: PRINT "        -warp :";: COLOR UI_FORECOLOR
    PRINT warp$
    
    'do we need to ask for a skill level?
    '(warp, but no skill-level provided)
    IF Games_Selected.skill < 0 THEN
        PRINT ""
        PRINT STRING$(80, ASC_BOX_H)
        PRINT ""
        COLOR YELLOW: PRINT "         CHOOSE YOUR SKILL LEVEL:"
        COLOR WHITE: PRINT "         (Press numbered key)"
        PRINT ""
        
        'if the PWAD provides its own skill-levels, use those:
        IF Games_Selected.skill1 <> "" THEN
            'work through the list of IWAD skill-levels (up to 9)
            IF Games_Selected.skill1 <> "" THEN
                COLOR AQUA: PRINT "         [1]  ";
                PRINT Games_Selected.skill1
            END IF
            IF Games_Selected.skill2 <> "" THEN
                COLOR AQUA: PRINT "         [2]  ";
                PRINT Games_Selected.skill2
            END IF
            IF Games_Selected.skill3 <> "" THEN
                COLOR AQUA: PRINT "         [3]  ";
                PRINT Games_Selected.skill3
            END IF
            IF Games_Selected.skill4 <> "" THEN
                COLOR AQUA: PRINT "         [4]  ";
                PRINT Games_Selected.skill4
            END IF
            IF Games_Selected.skill5 <> "" THEN
                COLOR AQUA: PRINT "         [5]  ";
                PRINT Games_Selected.skill5
            END IF
            IF Games_Selected.skill6 <> "" THEN
                COLOR AQUA: PRINT "         [6]  ";
                PRINT Games_Selected.skill6
            END IF
            IF Games_Selected.skill7 <> "" THEN
                COLOR AQUA: PRINT "         [7]  ";
                PRINT Games_Selected.skill7
            END IF
            IF Games_Selected.skill8 <> "" THEN
                COLOR AQUA: PRINT "         [8]  ";
                PRINT Games_Selected.skill8
            END IF
            IF Games_Selected.skill9 <> "" THEN
                COLOR AQUA: PRINT "         [9]  ";
                PRINT Games_Selected.skill9
            END IF
            
        'get the list of skill-levels from the IWAD meta-data;
        'if there is none, default to DOOM's descriptions
        ELSEIF Games_Selected.iwad > 0 _
            OR IWADs_Selected.skill1 = "" _
        THEN
            COLOR AQUA
            PRINT "         [1]  I'm Too Young To Die"
            PRINT "         [2]  Hey, Not Too Rough"
            PRINT "         [3]  Hurt Me Plenty"
            PRINT "         [4]  Ultra-Violence"
            PRINT "         [5]  Nightmare!"
        ELSE
            'work through the list of IWAD skill-levels (up to 9)
            IF IWADs_Selected.skill1 <> "" THEN
                COLOR AQUA: PRINT "         [1]  ";
                PRINT IWADs_Selected.skill1
            END IF
            IF IWADs_Selected.skill2 <> "" THEN
                COLOR AQUA: PRINT "         [2]  ";
                PRINT IWADs_Selected.skill2
            END IF
            IF IWADs_Selected.skill3 <> "" THEN
                COLOR AQUA: PRINT "         [3]  ";
                PRINT IWADs_Selected.skill3
            END IF
            IF IWADs_Selected.skill4 <> "" THEN
                COLOR AQUA: PRINT "         [4]  ";
                PRINT IWADs_Selected.skill4
            END IF
            IF IWADs_Selected.skill5 <> "" THEN
                COLOR AQUA: PRINT "         [5]  ";
                PRINT IWADs_Selected.skill5
            END IF
            IF IWADs_Selected.skill6 <> "" THEN
                COLOR AQUA: PRINT "         [6]  ";
                PRINT IWADs_Selected.skill6
            END IF
            IF IWADs_Selected.skill7 <> "" THEN
                COLOR AQUA: PRINT "         [7]  ";
                PRINT IWADs_Selected.skill7
            END IF
            IF IWADs_Selected.skill8 <> "" THEN
                COLOR AQUA: PRINT "         [8]  ";
                PRINT IWADs_Selected.skill8
            END IF
            IF IWADs_Selected.skill9 <> "" THEN
                COLOR AQUA: PRINT "         [9]  ";
                PRINT IWADs_Selected.skill9
            END IF
        END IF
        
        COLOR AQUA
        PRINT ""
        PRINT "         [?]";
        COLOR UI_FORECOLOR
        'position a blinking cursor over the question-mark
        LOCATE , POS(0)-2, 1, 0, 31
        
        DO
            LET key$ = INKEY$
        LOOP WHILE ISINT(key$) = FALSE
        
        'turn off the cursor
        LOCATE ,1 , 0
        
        PRINT STRING$(80, ASC_BOX_H)
        PRINT ""
        
        LET Games_Selected.skill = VAL(key$)
    END IF
END IF

IF Games_Selected.skill >= 0 THEN
    LET CMD$ = CMD$ + " -skill" + STR$(Games_Selected.skill)
    COLOR YELLOW: PRINT "       -skill :";: COLOR UI_FORECOLOR
    PRINT STR$(Games_Selected.skill)
END IF

'-----------------------------------------------------------------------------
'[12] resolution & full-screen:
'-----------------------------------------------------------------------------
'the full-screen parameter varies by engine-type;
IF Engines_Selected.kin = KIN_Z THEN
    'ZDoom-based engines use `+fullscreen`
    LET CMD$ = CMD$ + " +fullscreen"
ELSE
    'everything else `-fullscreen`
    LET CMD$ = CMD$ + " -fullscreen"
END IF

'a current bug/limitation of Choco-* engines in v3.0 is that
'specifying the screen size forces full-screen off
IF Engines_Selected.kin <> KIN_V THEN
    DIM screen_width AS LONG
    LET screen_width = _DESKTOPWIDTH
    DIM screen_height AS LONG
    LET screen_height = _DESKTOPHEIGHT

    LET CMD$ = CMD$ + " -width " + STRINT$(screen_width)
    LET CMD$ = CMD$ + " -height " + STRINT$(screen_height)
    
    COLOR YELLOW: PRINT "       -width :";
    COLOR UI_FORECOLOR: PRINT STR$(screen_width);
    COLOR YELLOW: PRINT "  -height :";
    COLOR UI_FORECOLOR: PRINT STR$(screen_height)
END IF

'-----------------------------------------------------------------------------
'[13] execute script / additional commands:
'-----------------------------------------------------------------------------
IF Games_Selected.exec <> "" THEN
    'try and find the file:
    LET file$ = Games_Selected.exec
    LET find$ = WADs_Find$(file$)
   'file missing?
    IF find$ = "" THEN CALL UIError_FileNotFound(file$)
    
    'add the command-line param to play the demo
    LET CMD$ = CMD$ + " -exec " _
             + CHR$(34) + Launch_FixPath$(find$) + CHR$(34)
             
    COLOR YELLOW: PRINT "        -exec : ";: COLOR UI_FORECOLOR
    PRINT RTRUNCATE$(Launch_ClipPath$(find$), UI_SCREEN_WIDTH - 17)
END IF

'any engine-specific command-line params to be added?
IF Engines_Selected.cmd <> "" THEN
    LET CMD$ = CMD$ + " " + Engines_Selected.cmd
    IF CMD_DEBUG` THEN
        COLOR YELLOW: PRINT "     (engine) : ";: COLOR UI_FORECOLOR
        PRINT RTRUNCATE$(Engines_Selected.cmd, UI_SCREEN_WIDTH - 17)
    END IF
END IF

'any game-specific command-line params to be added?
IF Games_Selected.cmd <> "" THEN
    LET CMD$ = CMD$ + " " + Games_Selected.cmd
    IF CMD_DEBUG` THEN
        COLOR YELLOW: PRINT "       (game) : ";: COLOR UI_FORECOLOR
        PRINT RTRUNCATE$(Games_Selected.cmd, UI_SCREEN_WIDTH - 17)
    END IF
END IF

'-----------------------------------------------------------------------------
'[14] launch!
'-----------------------------------------------------------------------------
'specify the save-game directory as the 'current' directory
'TODO: a more specific way of detecting this?
'TODO: DOOM Retro will support both in the next release
IF LEFT$(Engines_Selected.engine, 11) = "prboom-plus" THEN
    LET CMD$ = CMD$ + " -save " + CHR$(34) + "." + CHR$(34)
    COLOR YELLOW: PRINT "        -save : ";: COLOR UI_FORECOLOR
    PRINT RTRUNCATE$( _
        DIR_SAVE_ENGINE$ + DIR_SAVE_GAME$ + "\", UI_SCREEN_WIDTH - 17 _
    )
ELSE
    'all other engines use `-savedir`,
    'except doom64x which has no support yet
    LET CMD$ = CMD$ + " -savedir " + CHR$(34) + "." + CHR$(34)
    COLOR YELLOW: PRINT "     -savedir : ";: COLOR UI_FORECOLOR
    PRINT TRUNCATE$( _
        DIR_SAVE_ENGINE$ + DIR_SAVE_GAME$ + "\", UI_SCREEN_WIDTH - 17 _
    )
END IF

'where screen-shots get saved varies by engine; many put them in the engine's
'folder regardless of the 'current' directory and not all support changing the
'directory. to the best of our ability, try to put them in the "saves/<engine>"
'folder; one up from the 'current' directory used for save-games. we specify
'the path fully (and not relative) in case different engines interpret the
'relative path as from different starting directories to each other
DIM DIR_SCREENSHOT$
LET DIR_SCREENSHOT$ = Paths_StripSlash$(DIR_EXE$ + DIR_SAVE_ENGINE$)
LET CMD$ = CMD$ + " -shotdir " + CHR$(34) + DIR_SCREENSHOT$ + CHR$(34)

'DOOM 64 EX: fix for Sound Font not being found (it's looking in the 'current
'directory' rather than the executable's directory?)
IF Engines_Selected.engine = "doom64ex" THEN
    LET CMD$ = CMD$ + " -setvars s_soundfont " + CHR$(34) _
                    + Launch_FixPath$(DIR_ENGINE$ + "DOOMSND.SF2") + CHR$(34)
END IF

'auto-quit? (ZDoom-based engines only)
IF CMD_QUIT` THEN
    LET CMD$ = CMD$ + " +quit"
    COLOR YELLOW: PRINT "        +quit": COLOR UI_FORECOLOR
END IF

COLOR WHITE
PRINT ""
PRINT "   GET PSYCHED!"
PRINT ""

IF CMD_DEBUG` THEN
    PRINT CMD$
    PRINT ""
    PRINT ""
    
    VIEW PRINT
    
    LOCATE UI_SCREEN_HEIGHT, 1
    COLOR BLACK+BLINK, WHITE
    
    LET w = LEN("PRESS ANY KEY!")
    PRINT SPACE$((UI_SCREEN_WIDTH - w) / 2) _
        + "PRESS ANY KEY!" _
        + SPACE$((UI_SCREEN_WIDTH - w) / 2);
    COLOR WHITE, BLACK
    
    SLEEP
END IF

'set the directory for the game engine to assume as default; note that all
'paths on the command-line must be relative to the save-game folder!
CHDIR DIR_EXE$ + DIR_SAVE_ENGINE$ + DIR_SAVE_GAME$

'has the `/WAIT` command-line option been specified?
IF CMD_WAIT` THEN
    'start the engine and wait for it to close
    SHELL CMD$
ELSE
    'start the engine, but continue running here
    SHELL _DONTWAIT CMD$
END IF

'introduce a brief pause and force the screen to refresh;
'if we just launch the executable, the screen doesn't get time to update
SLEEP 1

SYSTEM

errMkDir:
'=============================================================================
CALL UIErrorScreen( _
    "ERROR: Write Error", _
    "Could not create a required folder. Ensure that the media you are " _
  + "running launcher.exe from is not write protected, and that the " _
  + "'files\saves' folder exists, and is writable." _
)

'make a folder if it doesn't exist; capture errors (e.g. read-only)
'=============================================================================
SUB Launch_MkDir(path$)
    ON ERROR GOTO errMkDir
    
    IF NOT _DIREXISTS(path$) THEN
        'folder is missing? attempt to make it, but be aware
        'of that potentially failing (read-only media?)
        MKDIR (path$)
    END IF
    
    'reset the error handler
    ON ERROR GOTO 0
END SUB

'correct a relative path from the save-game folder
'=============================================================================
FUNCTION Launch_FixPath$(path$)
    'is the path relative?
    IF NOT Paths_IsAbsolute(path$) THEN
        LET Launch_FixPath$ = FIX_PATH$ + path$
    ELSE
        'if the path is a sub-folder of PortaDOOM, convert it to relative
        IF LEFT$(path$, LEN(DIR_EXE$)) = DIR_EXE$ THEN
            LET Launch_FixPath$ = FIX_PATH$ + MID$(path$, LEN(DIR_EXE$) + 1)
        ELSE
            LET Launch_FixPath$ = path$
        END IF
    END IF
END FUNCTION

'if an absolute path is within PortaDOOM's folders, make it relative
'=============================================================================
FUNCTION Launch_ClipPath$(path$)
    IF LEFT$(path$, LEN(DIR_EXE$)) = DIR_EXE$ THEN
        LET Launch_ClipPath$ = MID$(path$, LEN(DIR_EXE$) + 1)
    ELSE
        LET Launch_ClipPath$ = path$
    END IF
END FUNCTION
