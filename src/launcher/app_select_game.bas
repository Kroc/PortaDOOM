'copyright (C) Kroc Camen 2018-2023, BSD 2-clause
'app_select_game.bas : present game selection UI

'detect Steam/GOG WADs:
'=============================================================================
IF FALSE THEN
CALL UIStatusbar_Clear
CALL UIMenubar_Clear
CALL UI_ClearScreen

DIM wad_path$
COLOR YELLOW: PRINT " DOOM.WAD": COLOR LTGREY
'-----------------------------------------------------------------------------
'GOG: The Ultimate DOOM
IF WADs_GetGOGFileByRef(wad_path$, _
    GOG_DOOMU_ID, "DOOM.WAD" _
) THEN PRINT " - " + wad_path$
'GOG: DOOM I Enhanced
IF WADs_GetGOGFileByRef(wad_path$, _
    GOG_DOOMUE_ID, "DOOM_Data\StreamingAssets\doom.wad" _
) THEN PRINT " - " + wad_path$
'GOG: DOOM 3 BFG Edition
IF WADs_GetGOGFileByRef(wad_path$, _
    GOG_DOOM3BFG_ID, "base\wads\DOOM.WAD" _
) THEN PRINT " - " + wad_path$
'Steam: The Ultimate DOOM
IF WADs_GetSteamFileByRef(wad_path$, _
    STEAM_DOOMU_ID, STEAM_DOOMU_NAME, _
    "base\DOOM.WAD" _
) THEN PRINT " - " + wad_path$
'Steam: DOOM I Enhanced
IF WADs_GetSteamFileByRef(wad_path$, _
    STEAM_DOOMUE_ID, STEAM_DOOMUE_NAME, _
    "DOOM_Data\StreamingAssets\doom.wad" _
) THEN PRINT " - " + wad_path$
'Steam: DOOM 3 BFG Edition
IF WADs_GetSteamFileByRef(wad_path$, _
    STEAM_DOOM3BFG_ID, STEAM_DOOM3BFG_NAME, _
    "base\wads\DOOM.WAD" _
) THEN PRINT " - " + wad_path$
'-----------------------------------------------------------------------------
COLOR YELLOW: PRINT " DOOM2.WAD": COLOR LTGREY
'-----------------------------------------------------------------------------
'GOG: DOOM II + Master Levels
IF WADs_GetGOGFileByRef(wad_path$, _
    GOG_DOOM2M_ID, "doom2\DOOM2.WAD" _
) THEN PRINT " - " + wad_path$
'GOG: DOOM II Enhanced
IF WADs_GetGOGFileByRef(wad_path$, _
    GOG_DOOM2E_ID, "DOOM II_Data\StreamingAssets\doom2.wad" _
) THEN PRINT " - " + wad_path$
'GOG: DOOM 3 BFG Edition
IF WADs_GetGOGFileByRef(wad_path$, _
    GOG_DOOM3BFG_ID, "base\wads\DOOM2.WAD" _
) THEN PRINT " - " + wad_path$
'Steam: DOOM 2
IF WADs_GetSteamFileByRef(wad_path$, _
    STEAM_DOOM2_ID, STEAM_DOOM2_NAME, _
    "base\DOOM2.WAD" _
) THEN PRINT " - " + wad_path$
'Steam: Master Levels for DOOM II
IF WADs_GetSteamFileByRef(wad_path$, _
    STEAM_DOOM2M_ID, STEAM_DOOM2M_NAME, _
    "doom2\DOOM2.WAD" _
) THEN PRINT " - " + wad_path$
'Steam: DOOM II Enhanced
IF WADs_GetSteamFileByRef(wad_path$, _
    STEAM_DOOM2E_ID, STEAM_DOOM2E_NAME, _
    "DOOM II_Data\StreamingAssets\doom2.wad" _
) THEN PRINT " - " + wad_path$
'Steam: DOOM 3 BFG Edition
IF WADs_GetSteamFileByRef(wad_path$, _
    STEAM_DOOM3BFG_ID, STEAM_DOOM3BFG_NAME, _
    "base\wads\DOOM2.WAD" _
) THEN PRINT " - " + wad_path$

SLEEP
END IF

select_game:
'=============================================================================
'if only one game is defined (or `/AUTO` is defined),
'we don't need to offer a choice
IF CMD_GAME$ <> "" THEN
    'TODO: all sorts of errors
    CALL Games_Select(VAL(CMD_GAME$))
    GOTO select_engine
    
ELSEIF Games_Count = 1 _
    OR CMD_AUTO` = TRUE _
THEN
    CALL Games_Select(1)
    GOTO select_engine
END IF

CALL UIStatusbar_Clear
CALL UIMenubar_Clear

IF Games(1).title <> "" THEN
    LET ui_menubar_left$(1) = Games(1).title
END IF

CALL UI_ClearScreen

'-----------------------------------------------------------------------------

IF Games(1).blurb <> "" THEN
    COLOR WHITE
    CALL PRINTWRAP_X(2, UI_SCREEN_WIDTH - 2, Games(1).blurb)
    PRINT ""
END IF

COLOR UI_FORECOLOR
PRINT " Select game choice by pressing indicated number key:"
PRINT ""

'walk through the list of games
'
FOR i = 1 TO Games_Count
    COLOR AQUA: PRINT " [" + STRINT$(i) + "]: ";
    IF Games(i).name <> "" THEN
        COLOR WHITE
        PRINT TRUNCATE$(Games(i).name, UI_SCREEN_WIDTH - 5 - 2)
    END IF
    IF Games(i).desc <> "" THEN
        COLOR LIME
        LET h = PRINTWRAP%( _
            7, CSRLIN, UI_SCREEN_WIDTH - 8, _
            Games(i).desc _
        )
        LET k = CSRLIN - h
        IF Games(i).name = "" THEN LET k = k + 1
        LET l = CSRLIN - 1
        FOR j = k TO l
            LOCATE j, 3: COLOR YELLOW
            REM IF j = k THEN
            REM     PRINT CHR$(210)
            REM ELSE
            REM     PRINT CHR$(ASC_BOX_DBL_V)
            REM END IF
            IF j = l THEN
                PRINT CHR$(192)
            ELSE
                PRINT CHR$(ASC_BOX_V)
            END IF
        NEXT j
    END IF
    PRINT ""
NEXT i

'-----------------------------------------------------------------------------

DO
    'read the keyboard:
    LET key$ = INKEY$
    IF key$ = "" THEN _CONTINUE
    
    IF ASC(key$) = INKEY_ESC THEN
        SYSTEM 0
    END IF
    
    'is it a numeric key?
    IF ISINT(key$) = FALSE THEN
        'no, beep, and wait again
        BEEP: _CONTINUE
    END IF
    
    'is a number within range?
    IF VAL(key$) > 0 AND VAL(key$) <= Games_Count THEN
        'select that game
        Games_Select(VAL(key$))
        EXIT DO
    END IF
    
    'not a valid number key
    BEEP
LOOP
