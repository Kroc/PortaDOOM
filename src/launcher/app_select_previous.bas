'copyright (C) Kroc Camen 2018-2023, BSD 2-clause
'ui_select_previous.bas : select last-used engine, or choose another

select_previous:
'-----------------------------------------------------------------------------

CALL UIStatusbar_Clear
LET ui_statusbar_right$(1) = "ENTER:play"

CALL UIMenubar_Clear
IF Games_Selected.name <> "" THEN
    LET ui_menubar_left$(1) = Games_Selected.name
ELSEIF Games_Selected.title <> "" THEN
    LET ui_menubar_left$(1) = Games_Selected.title
END IF

CALL UI_ClearScreen

'-----------------------------------------------------------------------------

PRINT " Press ";: COLOR AQUA: PRINT "[RETURN]";: COLOR UI_FORECOLOR
PRINT " to play using the same engine as the last time"
PRINT " you played this game, or press ";: COLOR AQUA: PRINT "[C]";
COLOR UI_FORECOLOR: PRINT " to change engine:"
PRINT ""

COLOR YELLOW
PRINT " " + CHR$(ASC_BOX_TL) + STRING$(UI_SCREEN_WIDTH - 5, ASC_BOX_H);
PRINT CHR$(ASC_BOX_TR)

COLOR YELLOW
PRINT " " + CHR$(ASC_BOX_V) + " ";
COLOR WHITE
PRINT TRUNCATE$( _
    Engines(1).title, _
    UI_SCREEN_WIDTH - 5 _
);
COLOR YELLOW
LOCATE CSRLIN, UI_SCREEN_WIDTH - 2
PRINT CHR$(ASC_BOX_V)

PRINT " " + CHR$(ASC_BOX_V_DBL_HR);
PRINT STRING$(UI_SCREEN_WIDTH - 5, ASC_BOX_DBL_H);
PRINT CHR$(ASC_BOX_V_DBL_HL)

COLOR LIME
LET h = PRINTWRAP%( _
    4, CSRLIN, UI_SCREEN_WIDTH - 7, _
    Engines(1).desc _
)
COLOR YELLOW
FOR i = CSRLIN - h TO CSRLIN - 1
    LOCATE i, 2: PRINT CHR$(ASC_BOX_V)
    LOCATE i, UI_SCREEN_WIDTH - 2: PRINT CHR$(ASC_BOX_V)
NEXT i

PRINT " " + CHR$(ASC_BOX_BL) + STRING$(UI_SCREEN_WIDTH - 5, ASC_BOX_H);
PRINT CHR$(ASC_BOX_BR)

'-----------------------------------------------------------------------------

DO
    'read the keyboard:
    LET key$ = INKEY$
    IF key$ = "" THEN _CONTINUE
    
    EXIT DO
LOOP
