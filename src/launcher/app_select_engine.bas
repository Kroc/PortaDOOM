'copyright (C) Kroc Camen 2018-2020, BSD 2-clause
'app_select_engine.bas : present engine selection UI

select_engine:
'-----------------------------------------------------------------------------
'search through the "ports" folder for game engines and read in their details.
'this also builds a set of look-up tables for cross-referencing tags with
'games and engines so that we can filter out incompatible engines
CALL Engines_Enumerate

'filter the known engines according to the game
'requirements and the user's preferences
CALL Engines_Filter

'if only one engine remains (or `/AUTO` is defined),
'no choice needed
IF Engines_ListCount = 1 _
OR CMD_AUTO` = TRUE _
THEN
    CALL Engines_Select(Engines_List(1))
    GOTO launch
END IF

'try and pick out the best engine for
'the ultra / fast / retro tier categories
CALL Engines_SelectTiers

'setup UI:
'-----------------------------------------------------------------------------
CALL UIStatusbar_Clear
CALL UIMenubar_Clear

IF Games_Selected.name <> "" THEN
    LET ui_menubar_left$(1) = Games_Selected.name
ELSEIF Games_Selected.title <> "" THEN
    LET ui_menubar_left$(1) = Games_Selected.title
END IF

CALL UI_ClearScreen

'draw UI:
'-----------------------------------------------------------------------------
PRINT " We've selected the engines compatible with your computer and the chosen game;"
PRINT " choose an engine that suits you by pressing the indicated key below:"
PRINT ""

IF Engines_SelectedUltra <> 0 THEN
    COLOR AQUA: PRINT " [U] ULTRA: ";: COLOR YELLOW
    PRINT "For high-end computers with dedicated graphics (GPU)"
    PRINT " " + CHR$(214) + STRING$(UI_SCREEN_WIDTH - 3, ASC_BOX_H)
    COLOR WHITE
    PRINT TRUNCATE$( _
        "    " + Engines(Engines_SelectedUltra).title, _
        UI_SCREEN_WIDTH - 5 _
    )
    PRINT ""
    IF Engines(Engines_SelectedUltra).desc <> "" THEN
        COLOR LIME
        LET h = PRINTWRAP%( _
            5, CSRLIN, UI_SCREEN_WIDTH - 6, _
            Engines(Engines_SelectedUltra).desc _
        )
        FOR i = CSRLIN - h - 2 TO CSRLIN - 1
            LOCATE i, 2: COLOR YELLOW: PRINT CHR$(ASC_BOX_DBL_V)
        NEXT i
    END IF
    PRINT ""
END IF

IF Engines_SelectedFast <> 0 THEN
    COLOR AQUA: PRINT " [F] FAST: ";: COLOR YELLOW
    PRINT "For low-end computers or laptops with integrated graphics"
    PRINT " " + CHR$(214) + STRING$(UI_SCREEN_WIDTH - 3, ASC_BOX_H)
    COLOR WHITE
    PRINT TRUNCATE$( _
        "    " + Engines(Engines_SelectedFast).title, _
        UI_SCREEN_WIDTH - 5 _
    )
    PRINT ""
    IF Engines(Engines_SelectedFast).desc <> "" THEN
        COLOR LIME
        LET h = PRINTWRAP%( _
            5, CSRLIN, UI_SCREEN_WIDTH - 6, _
            Engines(Engines_SelectedFast).desc _
        )
        FOR i = CSRLIN - h - 2 TO CSRLIN - 1
            LOCATE i, 2: COLOR YELLOW: PRINT CHR$(ASC_BOX_DBL_V)
        NEXT i
    END IF
    PRINT ""
END IF

IF Engines_SelectedRetro <> 0 THEN
    COLOR AQUA: PRINT " [R] RETRO: ";: COLOR YELLOW
    PRINT "If you prefer the original chunky pixel graphics"
    PRINT " " + CHR$(214) + STRING$(UI_SCREEN_WIDTH - 3, ASC_BOX_H)
    COLOR WHITE
    PRINT TRUNCATE$( _
        "    " + Engines(Engines_SelectedRetro).title, _
        UI_SCREEN_WIDTH - 5 _
    )
    PRINT ""
    IF Engines(Engines_SelectedRetro).desc <> "" THEN
        COLOR LIME
        LET h = PRINTWRAP%( _
            5, CSRLIN, UI_SCREEN_WIDTH - 6, _
            Engines(Engines_SelectedRetro).desc _
        )
        FOR i = CSRLIN - h - 2 TO CSRLIN - 1
            LOCATE i, 2: COLOR YELLOW: PRINT CHR$(ASC_BOX_DBL_V)
        NEXT i
    END IF
END IF

'handle input:
'-----------------------------------------------------------------------------
DO
    'read the keyboard:
    LET key$ = INKEY$
    IF key$ = "" THEN _CONTINUE
    
    SELECT CASE UCASE$(key$)
        CASE CHR$(INKEY_ESC)
            SYSTEM 0
            
        CASE CHR$(INKEY_BKSPC)
            'back out of engine selection, and return to game selection
            'TODO: this should not be possible, if there is only one game
            GOTO select_game
            
        CASE "U"
            IF Engines_SelectedUltra = 0 THEN BEEP: _CONTINUE
            CALL Engines_Select(Engines_SelectedUltra)
            EXIT DO
        CASE "F"
            IF Engines_SelectedFast = 0 THEN BEEP: _CONTINUE
            CALL Engines_Select(Engines_SelectedFast)
            EXIT DO
        CASE "R"
            IF Engines_SelectedRetro = 0 THEN BEEP: _CONTINUE
            CALL Engines_Select(Engines_SelectedRetro)
            EXIT DO
        CASE ELSE
            'not a valid key
            BEEP
    END SELECT
LOOP
