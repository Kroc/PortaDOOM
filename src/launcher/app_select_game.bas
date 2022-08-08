'copyright (C) Kroc Camen 2018-2022, BSD 2-clause
'app_select_game.bas : present game selection UI

select_game:
'-----------------------------------------------------------------------------
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
