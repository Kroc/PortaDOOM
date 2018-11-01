'copyright (C) Kroc Camen 2018, BSD 2-clause

'present game selection UI:
'walk through the list of games

CLS 2
PRINT ""
COLOR UI_FORECOLOR
PRINT " Select game choice by pressing indicated number key:"
PRINT ""

DIM H%
FOR i = 1 TO Games_Count
    COLOR AQUA: PRINT " [" + STRINT$(i) + "]: ";: COLOR YELLOW
    PRINT TRUNCATE$(Games(i).title, UI_SCREEN_WIDTH - 5 - 2)
    PRINT " " + CHR$(214) + STRING$(UI_SCREEN_WIDTH - 3, ASC_BOX_H)
    COLOR LIME
    IF Games(i).desc <> "" THEN
        COLOR LIME
        LET H% = PRINTWRAP%( _
            5, CSRLIN, UI_SCREEN_WIDTH - 6, _
            Games(i).desc _
        )
        FOR j = CSRLIN - H% TO CSRLIN - 1
            LOCATE j, 2: COLOR YELLOW: PRINT CHR$(ASC_BOX_DBL_V)
        NEXT j
    END IF
    PRINT ""
NEXT i

DO
    'read the keyboard:
    LET key$ = INKEY$
    IF key$ = "" THEN _CONTINUE
    
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