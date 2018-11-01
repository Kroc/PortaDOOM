'copyright (C) Kroc Camen 2018, BSD 2-clause

'present engine selection UI:

CLS 2
PRINT ""
COLOR UI_FORECOLOR
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
        LET H% = PRINTWRAP%( _
            5, CSRLIN, UI_SCREEN_WIDTH - 6, _
            Engines(Engines_SelectedUltra).desc _
        )
        FOR i = CSRLIN - H% - 2 TO CSRLIN - 1
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
        LET H% = PRINTWRAP%( _
            5, CSRLIN, UI_SCREEN_WIDTH - 6, _
            Engines(Engines_SelectedFast).desc _
        )
        FOR i = CSRLIN - H% - 2 TO CSRLIN - 1
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
        LET H% = PRINTWRAP%( _
            5, CSRLIN, UI_SCREEN_WIDTH - 6, _
            Engines(Engines_SelectedRetro).desc _
        )
        FOR i = CSRLIN - H% - 2 TO CSRLIN - 1
            LOCATE i, 2: COLOR YELLOW: PRINT CHR$(ASC_BOX_DBL_V)
        NEXT i
    END IF
END IF

DO
    'read the keyboard:
    LET key$ = INKEY$
    IF key$ = "" THEN _CONTINUE
    
    SELECT CASE UCASE$(key$)
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