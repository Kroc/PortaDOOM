'copyright (C) Kroc Camen 2018-2023, BSD 2-clause
'app_select_engine.bas : present engine selection UI

select_engine:
'-----------------------------------------------------------------------------
'filter the known engines according to the game
'requirements and the user's preferences
CALL Engines_Filter

'if only one engine remains (or `/AUTO` is defined),
'no choice needed
IF Engines_ListCount = 1 _
    OR CMD_AUTO` = TRUE _
THEN
    CALL Engines_Select(Engines_List(1))
    'note that this skips the saving of the launch
    'parameters to the user INI file
    GOTO launch
END IF

'try and pick out the best engine for
'the ultra / fast / retro tier categories
CALL Engines_SelectTiers

'if only 1 category remains, select that by default
DIM has_ultra%, has_fast%, has_retro%
IF Engines_SelectedUltra <> 0 THEN has_ultra% = 1
IF Engines_SelectedFast  <> 0 THEN has_fast%  = 1
IF Engines_SelectedRetro <> 0 THEN has_retro% = 1
IF (has_ultra% + has_fast% + has_retro%) = 1 THEN
    IF has_ultra% = 1 THEN CALL Engines_Select(Engines_SelectedUltra)
    IF has_fast%  = 1 THEN CALL Engines_Select(Engines_SelectedFast)
    IF has_retro% = 1 THEN CALL Engines_Select(Engines_SelectedRetro)
    GOTO launch
END IF

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
