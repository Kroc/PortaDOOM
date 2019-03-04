'copyright (C) Kroc Camen 2018-2019, BSD 2-clause

'present game selection UI:
'walk through the list of games

IF Games(1).title <> "" THEN
    LET ui_statusbar_left$(1) = Games(1).title
END IF
CALL ui_cls

IF Games(1).blurb <> "" THEN
    COLOR WHITE
    CALL PRINTWRAP_X(2, UI_SCREEN_WIDTH - 2, Games(1).blurb)
    PRINT ""
END IF

COLOR UI_FORECOLOR
PRINT " Select game choice by pressing indicated number key:"
PRINT ""

FOR i = 1 TO Games_Count
    COLOR AQUA: PRINT " [" + STRINT$(i) + "]: ";
    REM PRINT TRUNCATE$(Games(i).title, UI_SCREEN_WIDTH - 5 - 2)
    REM PRINT " " + CHR$(214) + STRING$(UI_SCREEN_WIDTH - 3, ASC_BOX_H)
    IF Games(i).desc <> "" THEN
        COLOR LIME
        LET h = PRINTWRAP%( _
            7, CSRLIN, UI_SCREEN_WIDTH - 8, _
            Games(i).desc _
        ) - 1
        LET k = CSRLIN - h
        FOR j = k TO CSRLIN - 1
            LOCATE j, 3: COLOR YELLOW
            IF j = k THEN
                PRINT CHR$(214)
            ELSE
                PRINT CHR$(ASC_BOX_DBL_V)
            END IF
        NEXT j
    END IF
    PRINT ""
NEXT i

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
