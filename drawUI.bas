'does a complete redraw of the screen
'=============================================================================
SUB refreshScreen
    STATIC buffer%

    'switch focus to the backbuffer
    SCREEN 0, , 1 - buffer%, buffer%

    'draw in the textual content;
    'each of these clear their respective backgrounds themselves
    drawHeader
    drawPage
    drawStatus
    'draw the overlayed dialog box if one is currently present
    IF dialogOn` THEN drawDialog

    'flip the display buffers
    buffer% = 1 - buffer%
    SCREEN 0, , 1 - buffer%, buffer%
END SUB

'draw the title of the current page and the navigation breadcrumb
'=============================================================================
SUB drawHeader
    DIM HeadBack%, HeadFore%, HeadText%, HeadBold%
    HeadBack% = Themes(Themes(PageTheme%).themeHeader).colorBack
    HeadFore% = Themes(Themes(PageTheme%).themeHeader).colorPageTab
    HeadText% = Themes(Themes(PageTheme%).themeHeader).colorHead
    HeadBold% = Themes(Themes(PageTheme%).themeHeader).colorBold

    'clear the existing page line (title and page count)
    COLOR , HeadBack%
    DIM n%
    FOR n% = HEAD_TOP TO HEAD_TOP + HEAD_HEIGHT
        LOCATE n%, 1: PRINT SPACE$(SCREEN_WIDTH);
    NEXT

    'draw the lines for the tab background
    COLOR HeadFore%, HeadBack%
    LOCATE (HEAD_TOP + 1), 1
    PRINT STRING$(SCREEN_WIDTH, CHR$(ASC_BOX_DBL_H))
    COLOR Themes(PageTheme%).colorPageTab, Themes(PageTheme%).colorBack
    LOCATE (HEAD_TOP + 2), 1
    PRINT STRING$(SCREEN_WIDTH, CHR$(ASC_BOX_DBL_H));

    DIM tab_width%

    'draw the page number tab
    '-------------------------------------------------------------------------
    IF PageCount% > 1 THEN
        DIM tab_text$, text_len%

        tab_text$ = "pg. " + STRINT$(PageNum%) _
                  + " of " + STRINT$(PageCount%)

        'generate the tab graphic (according to the width of the title text)
        text_len% = LEN(tab_text$) + 2
        tab_width% = text_len% + 4

        'print the tab
        COLOR Themes(PageTheme%).colorPageTab, Themes(PageTheme%).colorBack
        LOCATE HEAD_TOP, SCREEN_WIDTH - tab_width%
        PRINT CHR$(ASC_BOX_TL) + CHR$(ASC_BOX_H) _
            + STRING$(text_len%, CHR$(ASC_BOX_H)) _
            + CHR$(ASC_BOX_H) + CHR$(ASC_BOX_TR);
        LOCATE (HEAD_TOP + 1), SCREEN_WIDTH - tab_width%
        PRINT CHR$(ASC_BOX_V);
        IF PageNum% > 1 THEN
            COLOR Themes(PageTheme%).colorPageTab + BLINK
            PRINT CHR$(ASC_ARR_LT);
            COLOR Themes(PageTheme%).colorPageTab
        ELSE
            PRINT " ";
        END IF
        PRINT " " + tab_text$ + " ";
        IF PageNum% < PageCount% THEN
            COLOR Themes(PageTheme%).colorPageTab + BLINK
            PRINT CHR$(ASC_ARR_RT);
            COLOR Themes(PageTheme%).colorPageTab
        ELSE
            PRINT " ";
        END IF
        PRINT CHR$(ASC_BOX_V);
        LOCATE (HEAD_TOP + 2), SCREEN_WIDTH - tab_width%
        PRINT CHR$(ASC_BOX_BR_DBL_B) _
            + " " + SPACE$(text_len%) + " " _
            + CHR$(ASC_BOX_BL_DBL_B);
    END IF

    'draw the breadcrumb
    '-------------------------------------------------------------------------
    DIM nav$, crumb$
    'begin with the 'root' mark
    nav$ = " " + CHR$(ASC_DIAMOND) + " "

    'is there a parent category / folder?
    IF PageNav$ <> "" THEN
        nav$ = nav$ + PageNav$ + " " + CHR$(ASC_LGLLMT) + " "
    END IF

    'get the name of the page from the history stack
    crumb$ = historyPages$(historyDepth%)
    'if it has a page number on the end, this can be removed
    'when we're display names on the breadcrumb
    IF ASC(crumb$, LEN(crumb$) - 2) = PAGE_ASC THEN
        'remove the page number from the name
        crumb$ = LEFT$(crumb$, LEN(crumb$) - 3)
    END IF
    'there could be a space between the name and page number
    nav$ = nav$ + TRIM$(crumb$) + " "

    'if the page has its own title, append that
    IF PageTitle$ <> "" THEN
        nav$ = nav$ + ": " + PageTitle$ + " "
    END IF

    'prevent the breadcrumb from being too long
    nav$ = RTRUNCATE$(nav$, SCREEN_WIDTH - tab_width% - 3)

    COLOR HeadFore%, HeadBack%
    LOCATE HEAD_TOP, 1
    PRINT STRING$(LEN(nav$), CHR$(ASC_BOX_H)) + CHR$(ASC_BOX_TR);
    LOCATE (HEAD_TOP + 1), 1

    'walk the breadcrumb string and pick out the separators
    FOR n% = 1 TO LEN(nav$)
        DIM char%: char% = ASC(nav$, n%)
        SELECT CASE char%
            CASE ASC_DIAMOND, ASC_LGLLMT
                COLOR HeadBold%: PRINT CHR$(char%);
            CASE ELSE
                COLOR HeadText%: PRINT CHR$(ASC(nav$, n%));
        END SELECT
    NEXT n%

    COLOR HeadFore%: PRINT CHR$(ASC_BOX_BL_DBL_B);
END SUB

'draw the page area where the content goes
'=============================================================================
SUB drawPage
    'clear the background before displaying the page
    '(not all lines will fill the full 80 cols)
    COLOR , Themes(PageTheme).colorBack
    DIM n%
    FOR n% = PAGE_TOP TO PAGE_TOP + PAGE_HEIGHT
        LOCATE n%, 1
        PRINT SPACE$(SCREEN_WIDTH);
    NEXT

    'if there's not enough text, no scroll bar is shown
    IF PageLineCount% > PAGE_HEIGHT THEN drawScrollbar

    '-------------------------------------------------------------------------

    _CONTROLCHR OFF

    LOCATE PAGE_TOP, 1
    COLOR PAGE_FGND, PAGE_BKGD
    FOR n% = 0 TO PAGE_HEIGHT
        IF PageLine% + n% > PageLineCount% THEN EXIT FOR
        LOCATE (PAGE_TOP + n%), 2
        printLine PageLines$(PageLine% + n%)
    NEXT

    _CONTROLCHR ON
END SUB

'draws the scroll bar and thumb
'=============================================================================
SUB drawScrollbar
    COLOR Themes(PageTheme).colorFore , Themes(PageTheme).colorBack

    'draw the bar
    DIM n%
    FOR n% = PAGE_TOP TO PAGE_TOP + PAGE_HEIGHT
        LOCATE n%, SCREEN_WIDTH
        PRINT CHR$(ASC_SCROLL_TRACK);
    NEXT

    'calculate the thumb size as a representation
    'of the screen size within the page length
    DIM thumblen!
    LET thumblen! = (PAGE_HEIGHT / PageLineCount%) * PAGE_HEIGHT

    'be doubly sure this is in range...
    IF thumblen! < 1 THEN thumblen! = 1
    IF thumblen! > PAGE_HEIGHT THEN thumblen! = PAGE_HEIGHT

    'and where vertically the thumb is located
    DIM thumbpos!
    IF PageLine% = 0 THEN
        thumbpos! = 0
    ELSE
        thumbpos! = (PAGE_HEIGHT / PageLineCount%) * PageLine%
    END IF

    'be doubly sure this is in range...
    IF thumbpos! < 0 THEN thumbpos! = 0
    IF thumbpos! + thumblen! > PAGE_HEIGHT THEN
        thumbpos! = PAGE_HEIGHT - thumblen!
    END IF

    'draw the thumb
    COLOR Themes(PageTheme).colorFore
    FOR n% = INT(thumbpos!) TO INT(thumbpos! + thumblen!)
        LOCATE PAGE_TOP + n%, SCREEN_WIDTH: PRINT CHR$(ASC_SCROLL_THUMB);
    NEXT
END SUB

'draw the status bar at the bottom of the screen
'=============================================================================
SUB drawStatus
    COLOR HELP_FGND, HELP_BKGD
    IF StatusHeight%% = 0 THEN
        LOCATE SCREEN_HEIGHT, 1
        PRINT SPACE$(SCREEN_WIDTH);

    ELSEIF StatusHeight%% > 0 THEN
        DIM n%
        FOR n% = 0 TO StatusHeight%%
            LOCATE SCREEN_HEIGHT - n%, 1
            PRINT SPACE$(SCREEN_WIDTH);
        NEXT
    END IF

    '-------------------------------------------------------------------------

    LOCATE SCREEN_HEIGHT - StatusHeight%%, 1
    PRINT " F1:HELP  BKSP:BACK                                    F11:FULLSCREEN  ESC:QUIT";

    IF StatusHeight%% > 0 THEN
        LOCATE SCREEN_HEIGHT - StatusHeight%% + 1, 2
        PRINT STRING$(SCREEN_WIDTH - 2, "-");

        _CONTROLCHR OFF

        FOR n% = 1 TO StatusHeight%% - 2
            IF n% > UBOUND(HelpText$) THEN EXIT FOR
            LOCATE SCREEN_HEIGHT - (StatusHeight%% - 2) + n%, 2
            PRINT HelpText$(n%);
        NEXT

        _CONTROLCHR ON
    END IF
END SUB

'draw a dialogue box, if present
'=============================================================================
SUB drawDialog
    'calculate the position of the border box on screen
    DIM boxWidth%: boxWidth% = dialogWidth% + 4
    DIM boxLeft%: boxLeft% = (SCREEN_WIDTH - boxWidth%) / 2
    DIM boxHeight%: boxHeight% = UBOUND(dialogLines$)
    DIM boxTop%: boxTop% = 1 + (SCREEN_HEIGHT - (boxHeight% + 2)) / 2

    'draw the dialogue border and background
    COLOR HELP_FGND + BLINK, HELP_BKGD
    LOCATE boxTop%, boxLeft%
    PRINT CHR$(ASC_BOX_TL) + STRING$(dialogWidth%+ 2, ASC_BOX_H) + _
          CHR$(ASC_BOX_TR);
    DIM i%
    FOR i% = (boxTop% + 1) TO (boxTop% + boxHeight%)
        LOCATE i%, boxLeft%
        PRINT CHR$(ASC_BOX_V) + SPACE$(dialogWidth% + 2) + CHR$(ASC_BOX_V);
    NEXT
    LOCATE i%, boxLeft%
    PRINT CHR$(ASC_BOX_BL) + STRING$(dialogWidth% + 2, ASC_BOX_H) + _
          CHR$(ASC_BOX_BR);

    'draw the dialogue contents
    COLOR HELP_FGND, HELP_BKGD
    FOR i% = 1 TO UBOUND(dialogLines$)
        LOCATE boxTop% + i%, boxLeft% + 2
        PRINT dialogLines$(i%)
    NEXT
END SUB

