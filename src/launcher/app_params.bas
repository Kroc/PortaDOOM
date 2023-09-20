'copyright (C) Kroc Camen 2018-2023, BSD 2-clause
'app_params.bas : read in command-line parameters, enumerate environment

LET ui_statusbar_left$(1) = "Parsing Parameters..."
CALL UI_ClearScreen

'read command-line switches:
'=============================================================================
DIM CMD$

'no command-line parameters? display the command-line help
'launcher.exe does not yet provide a GUI interface without params
IF _COMMANDCOUNT = 0 THEN GOTO cmd_help

'the command-line switches are to allow drop-in replacement compatibility
'with "play.bat" / "doom.bat", the previous launcher setup. commands come
'in three varieties:
'
'1. commands that affect invocation:
'
DIM SHARED CMD_DEBUG` '..display detailed information
DIM SHARED CMD_WAIT` '...stall the launcher whilst the game is running
DIM SHARED CMD_AUTO` '...no user-interaction -- choose automatically
DIM SHARED CMD_DEFAULT` 'should default config file be used?
DIM SHARED CMD_QUIT` '...(ZDoom-based engines only), quit after launching
DIM SHARED CMD_INI$ '....use an INI file for all the game definitions
DIM SHARED CMD_GAME$ '...game index (in INI file) to select automatically
'
'2. commands for engine selection / compatibility:
'
DIM SHARED CMD_USE$ '....a specific engine-id to use
DIM SHARED CMD_REQ$ '....a tag-list of engine requirements
DIM SHARED CMD_SW` '.....require 8-bit (typically "software") rendering
DIM SHARED CMD_32` '.....always use 32-bit executable on 64-bit system

DIM cmd_hasEngine` '.....flag, select engine(s) from command-line
'
'3. commands to specify what game to play:
'
DIM SHARED CMD_IWAD$ '...IWAD to use
DIM SHARED CMD_PRE$ '....optional files to load *before* the PWAD
DIM SHARED CMD_PWAD$ '...optional PWAD to play
DIM SHARED CMD_FILES$ '..list of extra files to include
DIM SHARED CMD_EXEC$ '...extra script to execute
DIM SHARED CMD_DEH$ '....optional ".DEH" (DeHackEd) file to include
DIM SHARED CMD_BEX$ '....optional ".BEX" (Boom-EXtneded DeHackEd) file to include
DIM SHARED CMD_DEMO$ '...demo lump to play
DIM SHARED CMD_WARP$ '...episode/map number to warp to
DIM SHARED CMD_SKILL$ '..skill level number
DIM SHARED CMD_CMPLVL$ '.compatibility level

DIM cmd_hasGame` '.......flag, define game from command-line

'FIXME: do not allow mix of command params & INI files?
LET i = 1
DO WHILE COMMAND$(i) <> ""
    SELECT CASE UCASE$(COMMAND$(i))
        CASE "/?", "--HELP"
            '-----------------------------------------------------------------
cmd_help:   PRINT ""
            PRINT " No default UI yet, use command-line parameters to invoke:"
            PRINT ""
            PRINT " launcher.exe <ini-file> [/GAME <number>]"
            PRINT ""
            PRINT " launcher.exe [/WAIT] [/AUTO] [/DEFAULT] [/QUIT]"
            PRINT "     [/REQ <tags>] [/USE <engine>] [/SW] [/32]"
            PRINT "     [/IWAD <file> | /DOOM | /DOOM2 | /TNT | /PLUTONIA | /HERETIC | /HEXEN"
            PRINT "                   | /STRIFE | /CHEX | /FREEDOOM1 | /FREEDOOM2 ]"
            PRINT "     [/PRE <file> ]* [/PWAD <file>] [/DEH <file>] [/BEX <file>]"
            PRINT "     [/DEMO <file>] [/WARP <number>] [/SKILL <number>]"
            PRINT "     [/CMPLVL <number>] [/EXEC <file>] "
            PRINT "     [-- <file>* ]"
            PRINT ""
            PRINT ""
            PRINT " Or press ";: COLOR AQUA: PRINT "[O]";: COLOR UI_FORECOLOR
            PRINT " to visit the on-line documentation @"
            COLOR LIME
            PRINT " https://github.com/Kroc/PortaDOOM/wiki/Launcher"
            COLOR UI_FORECOLOR
            PRINT ""
            COLOR WHITE
            PRINT " Press Any Key to Exit"
            PRINT ""
            
            DO: LET key$ = INKEY$: LOOP WHILE key$ = ""
            IF key$ = "o" THEN
                SHELL _DONTWAIT "https://github.com/Kroc/PortaDOOM/wiki/Launcher"
            END IF
            
            SYSTEM
            
        CASE "/DEBUG"
            '-----------------------------------------------------------------
            'enable debugging mode; will print
            'additional information to the screen
            LET CMD_DEBUG` = TRUE
            'log command switch
            REM PRINT #LOGFILE, "/DEBUG"
            'if this is the only param then nothing useful can be done,
            'print out the command-line usage
            IF _COMMANDCOUNT = 1 THEN GOTO cmd_help
            
        CASE "/WAIT"
            '-----------------------------------------------------------------
            'keep launcher.exe on screen whilst the game runs
            LET CMD_WAIT` = TRUE
            'log command switch
            REM PRINT #LOGFILE, "/WAIT"
            
        CASE "/AUTO"
            '-----------------------------------------------------------------
            'no user-interaction, choose automatically
            LET CMD_AUTO` = TRUE
            'log command switch
            REM PRINT #LOGFILE, "/AUTO"
            
        CASE "/DEFAULT"
            '-----------------------------------------------------------------
            'set the flag to use the default config file;
            'on its own, this does not select an engine
            LET CMD_DEFAULT` = TRUE
            'log command switch
            REM PRINT #LOGFILE, "/DEFAULT"
            
        CASE "/32"
            '-----------------------------------------------------------------
            'set the flag to use 32-bit binaries (on 64-bit systems);
            'on its own, this does not select an engine
            LET CMD_32` = TRUE
            'this is implemented simply by tricking the program
            'into believing the machine is on a 32-bit CPU
            LET CPU_BIT = 32
            'log command switch
            REM PRINT #LOGFILE, "/32"
            
        CASE "/QUIT"
            '-----------------------------------------------------------------
            'for ZDoom-based engines only (ZDoom, Zandronum, GZDoom);
            'the engine loads and then quits. useful only for automation tasks
            LET CMD_QUIT` = TRUE
            'log command switch
            REM PRINT #LOGFILE, "/QUIT"
            
        CASE "/USE"
            '-----------------------------------------------------------------
            'cannot be defined twice!
            IF CMD_USE$ <> "" THEN CALL UIErrorScreen( _
                "ERROR: /USE Defined Twice", _
                "The /USE parameter cannot be defined more than once." _
            )
            'capture the parameter that follows
            LET i = i + 1: LET CMD_USE$ = COMMAND$(i)
            'note that we will have to select engine(s) using this
            LET cmd_hasEngine` = TRUE
            'log command switch
            REM PRINT #LOGFILE, "/USE " + CMD_USE$
            
        CASE "/REQ"
            '-----------------------------------------------------------------
            'cannot be defined twice!
            IF CMD_REQ$ <> "" THEN CALL UIErrorScreen( _
                "ERROR: /REQ Defined Twice", _
                "The /REQ parameter cannot be defined more than once." _
            )
            'capture the parameter that follows
            LET i = i + 1: LET CMD_REQ$ = COMMAND$(i)
            'note that we will have to select engine(s) using this
            LET cmd_hasEngine` = TRUE
            'log command switch
            REM PRINT #LOGFILE, "/REQ " + CMD_REQ$
            
        CASE "/SW"
            '-----------------------------------------------------------------
            'set the flag to favour software / 8-bit rendering;
            'on its own, this does not select an engine
            LET CMD_SW` = TRUE
            'log command switch
            REM PRINT #LOGFILE, "/SW"
            
        CASE "/IWAD", "/DOOM", "/DOOM2", "/TNT", "/PLUTONIA", "/HERETIC", _
             "/HEXEN", "/STRIFE", "/CHEX", "/FREEDOOM1", "/FREEDOOM2"
            '-----------------------------------------------------------------
            'you can't define an IWAD twice, e.g. `/IWAD DOOM /HEXEN`
            IF CMD_IWAD$ <> "" THEN CALL UIErrorScreen( _
                "ERROR: IWAD Defined Twice", _
                "/IWAD parameter cannot be used twice. Note that the " _
              + "/DOOM, /DOOM2, /TNT, /PLUTONIA, /HERETIC, /HEXEN, " _
              + "/STRIFE, /CHEX, /FREEDOOM1 & /FREEDOOM2 switches are " _
              + "shortcuts to /IWAD so these cannot be combined with " _
              + "/IWAD, or each other." _
            )
            SELECT CASE UCASE$(COMMAND$(i))
                CASE "/IWAD"
                    'capture the parameter that follows
                    LET i = i + 1: LET CMD_IWAD$ = COMMAND$(i)
                    
                CASE "/DOOM": LET CMD_IWAD$ = "DOOM"
                CASE "/DOOM2": LET CMD_IWAD$ = "DOOM2"
                CASE "/TNT": LET CMD_IWAD$ = "TNT"
                CASE "/PLUTONIA": LET CMD_IWAD$ = "PLUTONIA"
                CASE "/HERETIC": LET CMD_IWAD$ = "HERETIC"
                CASE "/HEXEN": LET CMD_IWAD$ = "HEXEN"
                CASE "/STRIFE": LET CMD_IWAD$ = "STRIFE1"
                CASE "/CHEX": LET CMD_IWAD$ = "CHEX"
                CASE "/FREEDOOM1": LET CMD_IWAD$ = "FREEDOOM1"
                CASE "/FREEDOOM2": LET CMD_IWAD$ = "FREEDOOM2"
            END SELECT
            'note that we will have to define a game using this
            LET cmd_hasGame` = TRUE
            'log command switch
            REM IF CMD_IWAD$ <> "" THEN
            REM     PRINT #LOGFILE, "/IWAD " + CMD_IWAD$
            REM ELSE
            REM     PRINT #LOGFILE, UCASE$(COMMAND$(i))
            REM END IF
        
        CASE "/PRE"
            '-----------------------------------------------------------------
            'capture the parameter that follows and append it
            'to the list of preload files. *CAN* be defined more than once
            LET i = i + 1: LET CMD_PRE$ = CMD_PRE$ + COMMAND$(i) + ";"
            'note that we will have to define a game using this
            LET cmd_hasGame` = TRUE
            'log command switch
            REM PRINT #LOGFILE, "/PRE " + COMMAND$(i)
            
        CASE "/PWAD"
            '-----------------------------------------------------------------
            'cannot be defined twice!
            IF CMD_PWAD$ <> "" THEN
                CALL UIErrorScreen_Begin("ERROR: /PWAD Defined Twice")
                PRINTWRAP_X 2, UI_SCREEN_WIDTH - 2, _
                    "The /PWAD parameter cannot be defined more than once. " _
                  + "If a mod has more than one file, use the files list " _
                  + "(after '--') to include the file; for example:"
                PRINT ""
                PRINT "     launcher.exe /PWAD pwad1.wad -- pwad2.wad"
                CALL UIErrorScreen_End
            END IF
            'capture the parameter that follows
            LET i = i + 1: LET CMD_PWAD$ = COMMAND$(i)
            'note that we will have to define a game using this
            LET cmd_hasGame` = TRUE
            'log command switch
            REM PRINT #LOGFILE, "/PWAD " + CMD_PWAD$
            
        CASE "/DEH"
            '-----------------------------------------------------------------
            'cannot be defined twice!
            IF CMD_DEH$ <> "" THEN CALL UIErrorScreen( _
                "ERROR: /DEH Defined Twice", _
                "The /DEH parameter cannot be defined more than once. " _
              + "Only one DeHackEd file can be loaded at a time." _
            )
            'capture the parameter that follows
            LET i = i + 1: LET CMD_DEH$ = COMMAND$(i)
            'note that we will have to define a game using this
            LET cmd_hasGame` = TRUE
            'log command switch
            REM PRINT #LOGFILE, "/DEH " + CMD_DEH$
            
        CASE "/BEX"
            '-----------------------------------------------------------------
            'cannot be defined twice!
            IF CMD_BEX$ <> "" THEN CALL UIErrorScreen( _
                "ERROR: /BEX Defined Twice", _
                "The /BEX parameter cannot be defined more than once. " _
              + "Only one Boom-Extended DeHackEd file can be loaded at " _
              + "a time." _
            )
            'capture the parameter that follows
            LET i = i + 1: LET CMD_BEX$ = COMMAND$(i)
            'note that we will have to define a game using this
            LET cmd_hasGame` = TRUE
            'log command switch
            REM PRINT #LOGFILE, "/BEX " + CMD_BEX$
            
        CASE "/DEMO"
            '-----------------------------------------------------------------
            'cannot be defined twice!
            IF CMD_DEMO$ <> "" THEN CALL UIErrorScreen( _
                "ERROR: /DEMO Defined Twice", _
                "The /DEMO parameter cannot be defined more than once. " _
              + "Only one demo file can be played back at a time. " _
            )
            'capture the parameter that follows
            LET i = i + 1: LET CMD_DEMO$ = COMMAND$(i)
            'note that we will have to define a game using this
            LET cmd_hasGame` = TRUE
            'log command switch
            REM PRINT #LOGFILE, "/DEMO " + CMD_DEMO$
            
        CASE "/WARP"
            '-----------------------------------------------------------------
            'cannot be defined twice!
            IF CMD_WARP$ <> "" THEN CALL UIErrorScreen( _
                "ERROR: /WARP Defined Twice", _
                "The /WARP parameter cannot be defined more than once." _
            )
            'capture the parameter that follows
            LET i = i + 1: LET CMD_WARP$ = COMMAND$(i)
            'note that we will have to define a game using this
            LET cmd_hasGame` = TRUE
            'log command switch
            REM PRINT #LOGFILE, "/WARP " + CMD_WARP$
            
        CASE "/SKILL"
            '-----------------------------------------------------------------
            'cannot be defined twice!
            IF CMD_SKILL$ <> "" THEN CALL UIErrorScreen( _
                "ERROR: /SKILL Defined Twice", _
                "The /SKILL parameter cannot be defined more than once." _
            )
            'capture the parameter that follows
            LET i = i + 1: LET CMD_SKILL$ = COMMAND$(i)
            'note that we will have to define a game using this
            LET cmd_hasGame` = TRUE
            'log command switch
            REM PRINT #LOGFILE, "/SKILL " + CMD_SKILL$
            
        CASE "/CMPLVL"
            '-----------------------------------------------------------------
            'cannot be defined twice!
            IF CMD_CMPLVL$ <> "" THEN CALL UIErrorScreen( _
                "ERROR: /CMPLVL Defined Twice", _
                "The /CMPLVL parameter cannot be defined more than once." _
            )
            'capture the parameter that follows
            LET i = i + 1: LET CMD_CMPLVL$ = COMMAND$(i)
            'log command switch
            REM PRINT #LOGFILE, "/CMPLVL " + CMD_CMPLVL$
            
        CASE "/EXEC"
            '-----------------------------------------------------------------
            'cannot be defined twice!
            IF CMD_EXEC$ <> "" THEN CALL UIErrorScreen( _
                "ERROR: /EXEC Defined Twice", _
                "The /EXEC parameter cannot be defined more than once." _
            )
            'capture the parameter that follows
            LET i = i + 1: LET CMD_EXEC$ = COMMAND$(i)
            'note that we will have to define a game using this
            LET cmd_hasGame` = TRUE
            'log command switch
            REM PRINT #LOGFILE, "/EXEC " + CMD_EXEC$
        
        CASE "/GAME"
            '-----------------------------------------------------------------
            'cannot be defined twice!
            IF CMD_GAME$ <> "" THEN CALL UIErrorScreen( _
                "ERROR: /GAME Defined Twice", _
                "The /GAME parameter cannot be defined more than once." _
            )
            'capture the parameter that follows
            LET i = i + 1: LET CMD_GAME$ = COMMAND$(i)
            'log command switch
            REM PRINT #LOGFILE, "/GAME " + CMD_GAME$
            
        CASE "--"
            '-----------------------------------------------------------------
            'once the 'end-of-command' marker is encountered, everything
            'that follows is a WAD file to be given to the engine
            LET i = i + 1
            DO WHILE COMMAND$(i) <> ""
                LET CMD_FILES$ = CMD_FILES$ + COMMAND$(i) + ";"
                'log command switch
                REM PRINT #LOGFILE, " -- " + COMMAND$(i)
                'any one file implies that a game is to be defined
                LET cmd_hasGame` = TRUE
                'continue searching
                LET i = i + 1
            LOOP
            
            EXIT DO
            
        CASE ELSE
            '-----------------------------------------------------------------
            'if an INI file is given,
            IF UCASE$(Paths_GetFileExtension$(COMMAND$(i))) = "INI" THEN
                'cannot be defined twice!
                IF CMD_INI$ <> "" THEN CALL UIErrorScreen( _
                    "ERROR: Cannot use more than one INI file", _
                    "Only one INI file can be used to define parameters." _
                )
                'hold the filename for later
                LET CMD_INI$ = COMMAND$(i)
                'log command switch
                REM PRINT #LOGFILE, "INI: " + CMD_INI$
                
            ELSE
                'no other command / file is allowed until the
                'end-of-command marker is encountered "--"
                CALL UIErrorScreen_Begin("ERROR: Invalid Parameters!")
                PRINTWRAP_X 2, UI_SCREEN_WIDTH - 2, _
                    "Unrecognised parameter: '" + COMMAND$(i) + "'." _
                  + "The first parameter may be an INI file, otherwise " _
                  + "only switches are allowed until the '--' marker, " _
                  + "where upon files can be listed."
                PRINT ""
                PRINT " launcher.exe <ini-file> [/GAME <number>]"
                PRINT ""
                PRINT " launcher.exe [/WAIT] [/AUTO] [/DEFAULT] [/32] [/QUIT]"
                PRINT "     [/REQ <tags>] [/USE <engine>] [/SW]"
                PRINT "     [/IWAD <file> | /DOOM | /DOOM2 | /TNT | /PLUTONIA | /HERETIC | /HEXEN"
                PRINT "                   | /STRIFE | /CHEX | /FREEDOOM1 | /FREEDOOM2 ]"
                PRINT "     [/PRE <file> ]* [/PWAD <file>] [/DEH <file>] [/BEX <file>]"
                PRINT "     [/DEMO <file>] [/WARP <number>] [/SKILL <number>]"
                PRINT "     [/CMPLVL <number>] [/EXEC <file>] "
                PRINT "     [-- <file>* ]"
                CALL UIErrorScreen_End
            END IF
    END SELECT
    LET i = i + 1
LOOP

'was an INI file provided to define parameters?
'-----------------------------------------------------------------------------
IF CMD_INI$ <> "" THEN
    Games_EnumerateINI(CMD_INI$)
    GOTO cmd_done
END IF

'-----------------------------------------------------------------------------

'are there enough parameters to define a game from the command-line?
IF cmd_hasGame` THEN
    DIM vid, bit
    
    'default to no hard requirement for rendering colour-depth 
    LET vid = 0
    'require "software" renderer? (8-bit, 256-colours)
    IF CMD_SW` = TRUE THEN LET vid = 8
    
    'default to no hard requirement for binary-type
    LET bit = 0
    'force 32-bit?
    IF CMD_32` = TRUE THEN LET bit = 32
    
    'if no IWAD is provided, we will default to "DOOM2"
    IF CMD_IWAD$ = "" THEN LET CMD_IWAD$ = "DOOM2"
    
    'TODO: get game name / title from the IWAD meta-data
    DIM CMD_IWAD%%
    LET CMD_IWAD%% = IWADs_FindMeta&(CMD_IWAD$)
    
    CALL Games_Add ( _
        "cmd", "", "", "", "", CMD_CMPLVL$, _
        CMD_IWAD%%, CMD_PRE$, CMD_PWAD$, CMD_FILES$, _
        CMD_EXEC$, "", CMD_DEH$, CMD_BEX$, _
        CMD_USE$, CMD_REQ$, bit, vid, "", _
        CMD_WARP$, CMD_SKILL$, _
        "", "", "", "", "", "", "", "", "" _
    )
ELSE
    CALL UIErrorScreen( _
        "ERROR: No Game Defined", _
        "Not enough information has been provided to define a game to " _
      + "launch. One or more of the parameters /IWAD, /PRE, /PWAD, /DEH, " _
      + "/BEX, /DEMO, /SKILL or /EXEC are required to define a game." _
    )
END IF

cmd_done:
'=============================================================================
REM LET CMD_DEBUG` = TRUE

'search through the "ports" folder for game engines and read in their details.
'this also builds a set of look-up tables for cross-referencing tags with
'games and engines so that we can filter out incompatible engines
CALL Engines_Enumerate
