'DOSmag : a DOS-like portable front-end for hyperlinked textual content.
'         copyright (C) Kroc Camen, 2016; MIT license (see LICENSE.TXT)
'=============================================================================
'WARNING: THIS IS A QB64.NET SOURCE FILE, ENCODED AS ANSI CODE-PAGE 437
'         (SOMETIMES REFERRED TO AS "DOS" OR "OEM-US" ENCODING).
'         DO NOT OPEN AND SAVE THIS FILE AS UNICODE / UTF-8!
'=============================================================================

'TODO: error check eveywhere before we attempt something so that we're water-
'      tight and can turn off the compiled-in error checking (slow)
' $CHECKING:OFF

''ON ERROR GOTO error_handler

'$INCLUDE: 'consts.bas'


'our text-formatting control codes
'-----------------------------------------------------------------------------
CONST CTL_ESCAPE = ASC_CARET '     ^
CONST CTL_CENTER = ASC_C '         C
CONST CTL_HEADING = ASC_COLON '    :
CONST CTL_BOLD = ASC_ASTERISK '    *...*
CONST CTL_ITALIC = ASC_USCORE '    _..._
CONST CTL_LINE1 = ASC_EQUALS '     =
CONST CTL_LINE2 = ASC_DASH '       -
CONST CTL_PAREN_ON = ASC_LPAREN '  (
CONST CTL_PAREN_OFF = ASC_RPAREN ' )
CONST CTL_KEY_ON = ASC_LSQB '      [
CONST CTL_KEY_OFF = ASC_RSQB '     ]
CONST CTL_INDENT = ASC_BAR '       |
CONST CTL_BREAK = ASC_BSLASH '     \\ (manual line-break)


'screen layout
'-----------------------------------------------------------------------------
CONST HEAD_TOP = 1 '    row where the header starts
CONST HEAD_HEIGHT = 3 ' size of the header area

CONST HEAD_FGND = ROSE 'header foreground colour
CONST HEAD_BKGD = RED ' header background colour

CONST TABS_FGND = AQUA
CONST TABS_BKGD = BLUE

'row number where the page begins (immediately after the header)
CONST PAGE_TOP = HEAD_TOP + HEAD_HEIGHT
'height of the page display on the screen;
'(screen height less breadcrumb, title line, page and status bar)
CONST PAGE_HEIGHT = SCREEN_HEIGHT - PAGE_TOP - 1
'the page is padded either side by a column, plus the scrollbar
CONST PAGE_WIDTH = SCREEN_WIDTH - 3

CONST PAGE_FGND = LTGREY
CONST PAGE_BKGD = BLUE

'extended height of the status area at the bottom of the screen;
'note that heights above 0 actually overlap the page, not squash it.
'this is used to slide the help bar up and display the instructions
DIM SHARED StatusHeight%%: StatusHeight%% = 0


'page data:
'-----------------------------------------------------------------------------
CONST PAGE_DIR = "pages\" ' path where to find the dosmag pages
CONST PAGE_EXT = ".dosmag" 'file extension name used for pages
CONST PAGE_ASC = ASC_HASH ' which character is used to separate page numbers

DIM SHARED PageName AS STRING '  base name of page, without page number
DIM SHARED PageNum AS INTEGER '  page number,
DIM SHARED PageCount AS INTEGER 'and number of pages in the set

REDIM SHARED PageLines(1) AS STRING
DIM SHARED PageLineCount AS INTEGER
DIM SHARED PageLine AS INTEGER 'line number at top of screen

CONST ACTION_GOTO = 1 ' key binding action to load another page
CONST ACTION_SHELL = 2 'key binding action to open a file

'a page can define keys and their actions
TYPE PageKey
    keycode AS INTEGER '   ASCII key code
    action AS INTEGER '    the action to take, e.g. ACTION_GOTO
    param AS STRING * 256 'the action parameter, e.g. the page name to load
END TYPE

'the list of keys the page defines
REDIM SHARED PageKeys(1) AS PageKey
DIM SHARED PageKeyCount%

'alignment constants
CONST ALIGN_LEFT = 0
CONST ALIGN_CENTER = 1 '"^C"
CONST ALIGN_RIGHT = 2

'prepare a blank page in case nothing is loaded
PageName$ = ""
PageNum% = 0
PageCount% = 0
PageLines$(1) = ""
PageLine% = 0
PageLineCount% = 0
PageKeyCount% = 0


'the navigation history (filenames)
REDIM SHARED historyPages(1) AS STRING
DIM SHARED historyDepth AS INTEGER: historyDepth% = 1


'help screen
'-----------------------------------------------------------------------------
DIM SHARED HelpText$(14)
HelpText$(1) = "  [F1] = Hide / show these instructions"
HelpText$(2) = ""
HelpText$(3) = "Press the keys indicated between square brackets to navigate to a section."
HelpText$(4) = "Press [BKSP] (backspace) to return to the previous section."
HelpText$(5) = ""
HelpText$(6) = "Each section will have one or more pages:"
HelpText$(7) = ""
HelpText$(8) = "   [] = Previous page       [] = Next page (or right-mouse-click)"
HelpText$(9) = ""
HelpText$(10) = "   [] = Scroll-up page (or mouse-wheel up)"
HelpText$(11) = "   [] = Scroll-down page (or mouse-wheel down)"
HelpText$(12) = ""
HelpText$(13) = "   [PgUp] = scroll-up one screen-full    [HOME] = Scroll to top of page"
HelpText$(14) = "   [PgDn] = scroll-down one screen-full   [END] = Scroll to bottom of page"


'=============================================================================
'disallow resizing of the window. this adds a great deal of complexity for
'very little gain right now and there isn't an easy way to restore a window
'to its 1:1 size
$RESIZE:OFF

_TITLE "DOSmag"

'set graphics mode, screen size, colour and clear screen
SCREEN 0, , 0, 0: WIDTH SCREEN_WIDTH, SCREEN_HEIGHT
COLOR PAGE_FGND, PAGE_BKGD: CLS

'display the front-page
clearScreen
loadPage "Home"
refreshScreen

'input processing: (main loop)
DO
    'limit this processing loop to 30 fps to reduce CPU usage
    _LIMIT 30

    'if mouse input is on the qeue then fetch and process it
    DO WHILE _MOUSEINPUT
        'scroll?
        wheel% = _MOUSEWHEEL: IF wheel% <> 0 THEN
            'scroll up or  down?
            IF wheel% = 1 THEN scrollDown ELSE scrollUp
        END IF

        'right-click?
        IF _MOUSEBUTTON(2) = TRUE THEN
            nextPage
        END IF

        'clear the mouse buffer
        DO WHILE _MOUSEINPUT: LOOP
    LOOP

    key$ = UCASE$(INKEY$)
    IF key$ <> "" THEN
        'get that as a keycode
        keycode% = ASC(key$)

        'ESC - quit instantly
        IF keycode% = ASC_ESC THEN SYSTEM

        'special key?
        IF keycode% = 0 THEN
            'get the special keycode
            keycode% = ASC(key$, 2)

            SELECT CASE keycode%
                CASE ASC_F1 'F1 = HELP
                    helpScreen

                CASE ASC_F5 'reload the current page
                    'remember the current scroll position
                    old_line% = PageLine%
                    loadPage historyPages$(historyDepth%)
                    'restore the scroll position
                    scrollTo old_line%

                CASE ASC_F11 'F11 = FULLSCREEN ENTER/EXIT
                    'flip the full-screen mode
                    IF _FULLSCREEN = 0 THEN
                        'use 1:1 pixel sizing as best as possible;
                        '(the other option blurs the picture)
                        _FULLSCREEN _SQUAREPIXELS
                    ELSE
                        _FULLSCREEN _OFF
                    END IF

                CASE ASC_UP 'up arrow - scroll page up
                    scrollUp

                CASE ASC_DOWN 'down arrow - scroll page down
                    scrollDown

                CASE ASC_PGDN 'Page Down
                    scrollPageDown

                CASE ASC_PGUP 'Page Up
                    scrollPageUp

                CASE ASC_HOME 'HOME - top of page
                    scrollTop

                CASE ASC_END 'END - scroll to bottom of page
                    scrollBottom

                CASE ASC_RIGHT 'right arrow - next page
                    nextPage

                CASE ASC_LEFT 'left arrow - previous page
                    prevPage

                CASE ELSE
                    'unrecognised special key
                    BEEP

            END SELECT

        ELSEIF keycode% = ASC_BKSP THEN
            'pressing backspace will go up a level
            'check the history depth
            IF historyDepth% = 1 THEN
                'can't go any fyrther back
                BEEP
            ELSE
                historyDepth% = historyDepth% - 1
                loadPage historyPages$(historyDepth%)
                refreshScreen
            END IF

        ELSEIF keycode% = ASC_SPC THEN
            'pressing space will scroll down a screenfull
            scrollPageDown
        ELSE
            'any page-registered keys?
            IF PageKeyCount% > 0 THEN
                'check the keys registered by the page
                FOR n% = 1 TO PageKeyCount%
                    IF PageKeys(n%).keycode = keycode% THEN
                        'which action to take?
                        SELECT CASE PageKeys(n%).action
                            CASE ACTION_GOTO
                                'TODO: don't increase history for navigating
                                '      between pages of the same set
                                historyDepth% = historyDepth% + 1
                                REDIM _PRESERVE historyPages$(historyDepth%)
                                loadPage TRIM$(PageKeys(n%).param)
                                refreshScreen
                                'don't check for pressed keys,
                                'when the load will have chaged them!
                                EXIT FOR

                            CASE ACTION_SHELL
                                'switch to the files directory
                                cwd$ = _CWD$: CHDIR "files"
                                'exeute the shell command
                                SHELL PageKeys(n%).param
                                'return to the previous directory
                                CHDIR cwd$
                        END SELECT
                    END IF
                NEXT
            END IF
        END IF

        'clear keyboard buffer
        DO WHILE INKEY$ <> "": LOOP
    END IF
LOOP
'illegal exit
SYSTEM 1


error_handler:
'-----------------------------------------------------------------------------
fatalError _
    "Error on line " + STRINT$(_ERRORLINE) + "." + CHR$(13) + CHR$(13) + _
    "  PageLine%      : " + STRINT$(PageLine%) + CHR$(13) + _
    "  PageLineCount% : " + STRINT$(PageLineCount%) + CHR$(13) + _
    STRINT$(UBOUND(PageLines$))
SLEEP: SYSTEM 1

'returns zero for any number below zero
'=============================================================================
FUNCTION ZERO% (number%)
    IF number% < 0 THEN ZERO% = 0 ELSE ZERO% = number%
END FUNCTION

'limit a number to a minimum or maximum
'=============================================================================
FUNCTION RANGE (number, min, max)
    IF number < min THEN RANGE = min: EXIT FUNCTION
    IF number > max THEN RANGE = max: EXIT FUNCTION
    RANGE = number
END FUNCTION

'limit a number to a maximum
'=============================================================================
FUNCTION CEIL (number, max)
    IF number > max THEN CEIL = nax: EXIT FUNCTION
    CEIL = number
END FUNCTION

'why isn't this built-in?
'=============================================================================
FUNCTION TRIM$ (text$)
    TRIM$ = LTRIM$(RTRIM$(text$))
END FUNCTION

'convert an integer into a string and trim it
'=============================================================================
FUNCTION STRINT$ (number%)
    STRINT$ = LTRIM$(STR$(number%))
END FUNCTION

'truncate a string to a maximum length, adding ellipsis if necessary
'=============================================================================
FUNCTION TRUNCATE$ (text$, length%)
    IF LEN(text$) > length% THEN
        'replace the end with an ellipsis
        TRUNCATE$ = LEFT$(text$, length% - 3) + "..."
    ELSE
        'text fits, no truncation needed
        TRUNCATE$ = text$
    END IF
END FUNCTION

'truncate the left hand side of a string to fit a maximum length
'=============================================================================
FUNCTION RTRUNCATE$ (text$, length%)
    IF LEN(text$) > length% THEN
        'replace the beginning with an ellipsis
        RTRUNCATE$ = "..." + RIGHT$(text$, length% - 3)
    ELSE
        'text fits, no truncation needed
        RTRUNCATE$ = text$
    END IF
END FUNCTION

'scroll the page down 1 line
'=============================================================================
SUB scrollDown
    'can't scroll if there is no scrollbar!
    IF PageLineCount% <= PAGE_HEIGHT THEN BEEP: EXIT SUB

    'can't scroll if already at the bottom
    pageBottom% = PageLineCount% - PAGE_HEIGHT + 1
    IF PageLine% = pageBottom% THEN BEEP: EXIT SUB

    'move the page
    PageLine% = PageLine% + 3
    'don't scroll past the end of the page
    IF PageLine% > pageBottom% THEN PageLine% = pageBottom%
    refreshScreen
END SUB

'scroll the page up 1 line
'=============================================================================
SUB scrollUp
    'can't scroll if there is no scrollbar!
    IF PageLineCount% <= PAGE_HEIGHT THEN BEEP: EXIT SUB

    'can't scroll up if already at the top
    IF PageLine% = 1 THEN BEEP: EXIT SUB

    'move the page
    PageLine% = PageLine% - 3
    'don't scroll past the top of the page
    IF PageLine% < 1 THEN PageLine% = 1
    refreshScreen
END SUB

'scroll down one page
'=============================================================================
SUB scrollPageDown
    'can't scroll if there is no scrollbar!
    IF PageLineCount% <= PAGE_HEIGHT THEN BEEP: EXIT SUB

    '(can't scroll past the last line of text)
    pageBottom% = PageLineCount% - PAGE_HEIGHT + 1

    'can't scroll down if at the bottom already
    IF PageLine% = pageBottom% THEN BEEP: EXIT SUB
    'move the page and redraw
    PageLine% = PageLine% + PAGE_HEIGHT
    IF PageLine% > pageBottom% THEN PageLine% = pageBottom%
    refreshScreen
END SUB

'scroll up one page
'=============================================================================
SUB scrollPageUp
    'can't scroll if there is no scrollbar!
    IF PageLineCount% <= PAGE_HEIGHT THEN BEEP: EXIT SUB

    'can't scroll up if at the top already
    IF PageLine% = 1 THEN BEEP: EXIT SUB
    'move the page and redraw
    PageLine% = PageLine% - PAGE_HEIGHT
    IF PageLine% < 1 THEN PageLine% = 1
    refreshScreen
END SUB

'scroll to the top of the page
'=============================================================================
SUB scrollTop
    'can't scroll if there is no scrollbar!
    IF PageLineCount% <= PAGE_HEIGHT THEN BEEP: EXIT SUB

    PageLine% = 1
    refreshScreen
END SUB

'scroll to the bottom of the page
'=============================================================================
SUB scrollBottom
    'can't scroll if there is no scrollbar!
    IF PageLineCount% <= PAGE_HEIGHT THEN BEEP: EXIT SUB

    PageLine% = PageLineCount% - PAGE_HEIGHT + 1
    refreshScreen
END SUB

'scroll to a specific line number (used when refreshing page)
'=============================================================================
SUB scrollTo (line_num%)
    'validate given number:
    IF line_num% < 1 THEN
        'can't scroll above the page!
        PageLine% = 1

    ELSEIF PageLineCount% <= PAGE_HEIGHT THEN
        'if the page has no scrollbar?
        PageLine% = 1

    ELSE
        'can't scroll too far down (this is important when refreshing
        'a page and the length has changed)
        page_bottom% = PageLineCount% - PAGE_HEIGHT + 1
        IF line_num% > page_bottom% THEN line_num% = page_bottom%
        PageLine% = line_num%
    END IF
    refreshScreen
END SUB

'go to the next page in the set
'=============================================================================
SUB nextPage
    'if on the last page (or no pages) beep
    IF PageNum% = PageCount% THEN
        BEEP
    ELSE
        'switch pages, note that this doesn't increase
        'history depth, that's only for navigation between
        'different page sets
        loadPage PageName$ + pageNumber$(PageNum% + 1)
        refreshScreen
    END IF
END SUB

'go to the previous page in the set
'=============================================================================
SUB prevPage
    'if on the first page (or no pages) beep
    IF PageNum% < 2 THEN
        BEEP
    ELSE
        'switch pages, note that this doesn't increase
        'history depth, that's only for navigation between
        'different page sets
        loadPage PageName$ + pageNumber$(PageNum% - 1)
        refreshScreen
    END IF
END SUB

'show the built-in help screen
'=============================================================================
SUB helpScreen
    'slide the help bar up from the bottom of the screen
    FOR n% = 0 TO UBOUND(HelpText$) + 3
        StatusHeight%% = n%
        refreshScreen
        _DELAY 0.01
    NEXT

    DO
        'wait for any key press
        SLEEP

        key$ = INKEY$
        IF key$ <> "" THEN
            SELECT CASE ASC(key$)
                CASE ASC_ESC
                    SYSTEM

                CASE 0
                    IF ASC(key$, 2) = ASC_F1 THEN EXIT DO
                    IF ASC(key$, 2) = ASC_F11 THEN
                        'flip the full-screen mode
                        IF _FULLSCREEN = 0 THEN
                            'use 1:1 pixel sizing as best as possible;
                            '(the other option blurs the picture)
                            _FULLSCREEN _SQUAREPIXELS
                        ELSE
                            _FULLSCREEN _OFF
                        END IF
                    END IF
            END SELECT

            'clear the keyboard buffer
            DO WHILE INKEY$ = "": LOOP
        END IF
    LOOP

    FOR n% = UBOUND(HelpText$) + 3 TO 0 STEP -1
        StatusHeight%% = n%
        refreshScreen
        _DELAY 0.01
    NEXT

END SUB



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

    'flip the display buffers
    buffer% = 1 - buffer%
    SCREEN 0, , 1 - buffer%, buffer%
END SUB

'clears the screen and draws the base UI used everywhere
'=============================================================================
SUB clearScreen
    clearHeader
    clearPage
    clearStatus
END SUB

'draw the title of the current page and the navigation breadcrumb
'=============================================================================
SUB drawHeader
    'clear the existing page line (title and page count)
    clearHeader

    'draw the lines for the tab background
    COLOR HEAD_FGND, HEAD_BKGD
    LOCATE (HEAD_TOP + 1), 1
    PRINT STRING$(SCREEN_WIDTH, "Í")
    COLOR TABS_FGND, TABS_BKGD
    LOCATE (HEAD_TOP + 2), 1
    PRINT STRING$(SCREEN_WIDTH, "Í");

    DIM tab_width%

    'draw the page number tab
    '-------------------------------------------------------------------------
    IF PageCount% > 1 THEN
        DIM tab_text$, text_len%

        tab_text$ = "page " + STRINT$(PageNum%) + _
                    " of " + STRINT$(PageCount%)

        'if there's previous pages, show the indicator
        ''IF PageNum% > 1 THEN tab_text$ = " " + tab_text$
        'if there's more page that follow, show the indicator
        ''IF PageNum% < PageCount% THEN tab_text$ = tab_text$ + "  "

        'generate the tab graphic (according to the width of the title text)
        text_len% = LEN(tab_text$)
        tab_width% = text_len% + 4

        'print the tab
        COLOR TABS_FGND, TABS_BKGD
        LOCATE HEAD_TOP, SCREEN_WIDTH - tab_width%
        PRINT "ÚÄ" + STRING$(text_len%, "Ä") + "Ä¿";
        LOCATE (HEAD_TOP + 1), SCREEN_WIDTH - tab_width%
        PRINT "³ " + tab_text$ + " ³";
        LOCATE (HEAD_TOP + 2), SCREEN_WIDTH - tab_width%
        PRINT "¾ " + SPACE$(text_len%) + " Ô";
    END IF

    'draw the breadcrumb
    '-------------------------------------------------------------------------
    DIM bread_crumb$
    FOR n% = 1 TO historyDepth%
        'get the file name from the history
        DIM crumb$: crumb$ = historyPages$(n%)

        'if it has a page number on the end, this can be removed
        'when we're display names on the breadcrumb
        IF ASC(crumb$, LEN(crumb$) - 2) = ASC("#") THEN
            'remove the page number from the name
            crumb$ = LEFT$(crumb$, LEN(crumb$) - 3)
        END IF
        'there could be a space between the name and page number
        crumb$ = TRIM$(crumb$)
        'is this the root, or a sub-section?
        IF n% = 1 THEN
            'when on the front page, we show that name
            IF historyDepth% = 1 THEN
                bread_crumb$ = bread_crumb$ + "  " + crumb$ + " "
            ELSE
                'but on deeper levels we don't display the root name
                n% = n% + 1
                bread_crumb$ = bread_crumb$ + "  " + historyPages$(n%) + " "
            END IF
        ELSE
            bread_crumb$ = bread_crumb$ + "® " + crumb$ + " "
        END IF
    NEXT

    'prevent the breadcrumb from being too long
    bread_crumb$ = RTRUNCATE$(bread_crumb$, SCREEN_WIDTH - tab_width% - 3)

    COLOR HEAD_FGND, HEAD_BKGD
    LOCATE HEAD_TOP, 1
    PRINT STRING$(LEN(bread_crumb$), "Ä") + "¿";
    LOCATE (HEAD_TOP + 1), 1

    'walk the breadcrumb string and pick out the separators
    FOR n% = 1 TO LEN(bread_crumb$)
        char% = ASC(bread_crumb$, n%)
        SELECT CASE char%
            CASE ASC(""), ASC("®")
                COLOR WHITE: PRINT CHR$(char%);
            CASE ELSE
                COLOR YELLOW: PRINT CHR$(ASC(bread_crumb$, n%));
        END SELECT
    NEXT n%

    COLOR HEAD_FGND: PRINT "Ô";
END SUB

'clear the header area and colour its background
'=============================================================================
SUB clearHeader
    COLOR , HEAD_BKGD
    FOR n% = HEAD_TOP TO HEAD_TOP + HEAD_HEIGHT
        LOCATE n%, 1: PRINT SPACE$(SCREEN_WIDTH);
    NEXT
END SUB

'draw the page area where the content goes
'=============================================================================
SUB drawPage
    'clear the background before displaying the page
    '(not all lines will fill the full 80 cols)
    clearPage

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

'clear the page-display area to avoid garabge when scrolling
'=============================================================================
SUB clearPage
    COLOR , PAGE_BKGD
    FOR n% = PAGE_TOP TO PAGE_TOP + PAGE_HEIGHT
        LOCATE n%, 1
        PRINT SPACE$(SCREEN_WIDTH);
    NEXT

    'if there's not enough text, no scroll bar is shown
    IF PageLineCount% > PAGE_HEIGHT THEN drawScrollbar
END SUB

'draws the scroll bar and thumb
'=============================================================================
SUB drawScrollbar
    COLOR PAGE_FGND, PAGE_BKGD

    'draw the bar
    FOR n% = PAGE_TOP TO PAGE_TOP + PAGE_HEIGHT
        LOCATE n%, SCREEN_WIDTH
        PRINT "°";
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
    COLOR LTGREY, BLACK
    FOR n% = INT(thumbpos!) TO INT(thumbpos! + thumblen!)
        LOCATE PAGE_TOP + n%, SCREEN_WIDTH: PRINT "Û";
    NEXT
END SUB

'draw the status bar at the bottom of the screen
'=============================================================================
SUB drawStatus
    clearStatus
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

'=============================================================================
SUB clearStatus
    COLOR BLACK, CYAN
    IF StatusHeight%% = 0 THEN
        LOCATE SCREEN_HEIGHT, 1
        PRINT SPACE$(SCREEN_WIDTH);

    ELSEIF StatusHeight%% > 0 THEN
        FOR n% = 0 TO StatusHeight%%
            LOCATE SCREEN_HEIGHT - n%, 1
            PRINT SPACE$(SCREEN_WIDTH);
        NEXT
    END IF
END SUB


'load a page from disk
'=============================================================================
SUB loadPage (page_name$)
    DIM page_number%
    DIM file_base$ 'base name, without page number
    DIM file_path$ 'full file path, including extension

    'TODO: verify page number
    'is a page number attached to the name?
    IF ASC(page_name$, LEN(page_name$) - 2) = PAGE_ASC THEN
        'extract the page number off the end of the name
        page_number% = VAL(RIGHT$(page_name$, 2))
        'remove the page number from the name
        file_base$ = TRIM$(LEFT$(page_name$, LEN(page_name$) - 3))
        file_path$ = pagePath$(file_base$, page_number%)
    ELSE
        'no page number
        page_number% = 0
        file_base$ = TRIM$(page_name$)
        file_path$ = pagePath$(file_base$, 0)

        'does the file exist?
        IF NOT _FILEEXISTS(pagePath$(file_base$, 0)) THEN
            'if not, it may be that the page does exist, but with page number
            IF _FILEEXISTS(pagePath$(file_base$, 1)) THEN
                'add a default page number
                file_path$ = pagePath$(file_base$, 1)
                page_number% = 1
            END IF
        END IF
    END IF

    'does the page exist?
    IF NOT _FILEEXISTS(file_path$) THEN
        fatalError "Cannot locate file '" + file_path$ + "'"
    END IF

    '-------------------------------------------------------------------------

    'clear current page in memory
    PageName$ = file_base$
    PageNum% = 0
    PageCount% = 0
    PageLine% = 0
    ERASE PageLines$: PageLineCount% = 0
    ERASE PageKeys: PageKeyCount% = 0

    'get page number / count
    PageNum% = page_number%
    PageCount% = PageNum%
    'look for additionally numbered pages
    DO WHILE PageCount% < 99 AND _FILEEXISTS( _
        pagePath$(file_base$, PageCount% + 1) _
    )
        PageCount% = PageCount% + 1
    LOOP

    '-------------------------------------------------------------------------

    OPEN file_path$ FOR BINARY AS #1
    DO UNTIL EOF(1)
        'read a line of text from source
        DIM line$: LINE INPUT #1, line$
        'convert the line from UTF-8 to ANSI(cp437)
        line$ = UTF8ANSI$(line$)
        'shortcut for blank lines
        IF line$ = "" THEN
            addLine ""

        ELSEIF left$(line$, 2) = CHR$(CTL_HEADING) + CHR$(CTL_LINE1) _
            OR left$(line$, 2) = CHR$(CTL_HEADING) + CHR$(CTL_LINE2) THEN
            'dividing lines:
            '(the `printLine` routine handles the actual formatting of lines,
            ' it uses only escape codes rather than the "shorthand")
            addLine CHR$(CTL_ESCAPE) + MID$(line$, 2, 1)

        ELSEIF LEFT$(line$, 2) = CHR$(CTL_ESCAPE) + CHR$(CTL_CENTER) THEN
            'centre line:
            wrapLine MID$(line$, 3), ALIGN_CENTER

        ELSEIF LEFT$(line$, 5) = "$REM=" THEN
            'skip REM lines; allows authors to put comments into the page
            'without them appearing on-screen

        ELSEIF LEFT$(line$, 5) = "$KEY:" THEN
            'key definition, the key name follows
            'is there an equals sign?
            DIM keypos%: keypos% = INSTR(6, line$, "=")
            'if an equals sign doesn't follow,
            'this is not a valid key definition
            IF keypos% = 0 THEN
                fatalError "The page '" + file_path$ + "' " +_
                           "contains an invalid key definition"
            END IF
            'extract the keyname
            keyname$ = MID$(line$, 6, keypos% - 6)

            DIM keycode%
            SELECT CASE keyname$
                'at the moment, these are the key names supported
                CASE "A" TO "Z", "0" TO "9"
                    'just use the ASCII code
                    keycode% = ASC(keyname$)

                CASE ELSE
                    fatalError "The page '" + file_path$ + "' " +_
                               "contains an invalid key definition"
            END SELECT

            'extract the action & param portion of the key definition
            DIM action$, action%
            action$ = MID$(line$, keypos% + 1)

            IF LEFT$(action$, 5) = "GOTO:" THEN
                param$ = TRIM$(MID$(action$, 6))
                action% = ACTION_GOTO
            ELSEIF LEFT$(action$, 6) = "SHELL:" THEN
                param$ = TRIM$(MID$(action$, 7))
                action% = ACTION_SHELL
            ELSE
                fatalError "The page '" + file_path$ + "' " +_
                           "contains an invalid key definition"
            END IF

            PageKeyCount% = PageKeyCount% + 1
            REDIM _PRESERVE PageKeys(PageKeyCount%) AS PageKey
            PageKeys(PageKeyCount%).keycode = keycode%
            PageKeys(PageKeyCount%).action = action%
            PageKeys(PageKeyCount%).param = param$

        ELSE
            'not a code, just a line of text
            wrapLine line$, ALIGN_LEFT
        END IF
    LOOP
    CLOSE #1

    '-------------------------------------------------------------------------

    'set the current history to this page
    '(the key handling will increase history depth before loading the page)
    historyPages$(historyDepth%) = page_name$

    PageLine% = 1
END SUB

'build a path to a DOSmag page file
'=============================================================================
FUNCTION pagePath$ (page_name$, page_number%)
    'if a page number is provided (0 = ignore)
    IF page_number% > 0 THEN
        pagePath$ = PAGE_DIR + page_name$ + " " _
                  + pageNumber$(page_number%) + PAGE_EXT
    ELSE
        'no page number
        pagePath$ = PAGE_DIR + page_name$ + PAGE_EXT
    END IF
END FUNCTION

'convert a page number to a string for use in file names, i.e. "#01"
'=============================================================================
FUNCTION pageNumber$ (page_number%)
    'ensure that it's always double-digit
    IF page_number% < 10 THEN
        pageNumber$ = CHR$(PAGE_ASC) + "0" + STRINT$(page_number%)
    ELSE
        pageNumber$ = CHR$(PAGE_ASC) + STRINT$(page_number%)
    END IF
END FUNCTION

'walk throgh the line and word-wrap it
'(control codes will not count toward word-wrapping)
'=============================================================================
SUB wrapLine (line$, align%)
    'always right-trim a line as this can cause unexpected wrapping
    line$ = RTRIM$(line$)
    'if this is a blank line, process it quickly
    IF line$ = "" THEN addLine "": EXIT SUB

    '-------------------------------------------------------------------------

    DIM newline$: newline$ = "" 'the line we're building up
    DIM char% 'ASCII code of current character
    DIM c%: c% = 1 'current character position in the source line
    DIM l%: l% = 0 'current length of the line being built

    'an indent at the beginning of the line
    'will be maintained on wrapped lines
    DIM indent$: indent$ = ""
    DIM indent%: indent% = 0

    'check for an indent:
    DO
        'watch out for the possibility of a white-space only line
        IF c% >= LEN(line$) THEN EXIT DO
        'check the charcter
        SELECT CASE ASC(line$, c%)
            CASE ASC_TAB
                'if its a tab, account for 8 spaces in the line wrapping
                indent$ = indent$ + SPACE$(8)
                indent% = indent% + 8
                c% = c% + 1

            CASE ASC_SPC
                indent$ = indent$ + " "
                indent% = indent% + 1
                c% = c% + 1

            CASE ELSE
                'we've reached a non white-space character,
                'the line will begin with the indent we've detected
                newline$ = indent$: l% = indent%
                EXIT DO

        END SELECT
    LOOP

    'TODO: indent not valid on centre (throw indent away?)

    '-------------------------------------------------------------------------

    DIM word$: word$ = "" 'the current word being built
    DIM w%: w% = 0 '       length of the current word (excluding escapes)

    'if a line begins with ":" then it's a heading
    DIM is_heading`
    IF ASC(line$) = CTL_HEADING THEN
        'set the mode (incase of word-wrapping)
        is_heading` = TRUE
        'include the escape code
        word$ = CHR$(CTL_ESCAPE) + CHR$(CTL_HEADING)
        'first character can be skipped
        c% = c% + 1
    END IF

    'bold / italic are only valid on word-boundaries;
    'the beginning of a line is always a word-boundary
    DIM is_boundary`: is_boundary` = TRUE

    'we need to know if a word was already bold/italic &c. when it began,
    'so that if it's wrapped we can insert the control code on the new line
    DIM is_bold`, word_bold`
    DIM is_italic`, word_italic`
    DIM is_paren`, word_paren`
    DIM is_key`, word_key`

    'adding a space on the end allows us to do a 1-character look-ahead
    'without having to avoid indexing past the end of the string
    line$ = line$ + " "

    'process text:
    FOR c% = c% TO LEN(line$) - 1
        'get current character in the source line
        char% = ASC(line$, c%)

        'null is given by UTF8ANSI$ to mark unusable UTF8 characters
        IF char% = 0 THEN
            GOSUB addChar
            is_boundary` = FALSE
            GOTO continue
        END IF

        'within key link text no formatting occurs!
        IF is_key` = TRUE THEN
            'is this the end of the key text?
            IF char% = CTL_KEY_OFF THEN
                'add the closing bracket and control code for display
                GOSUB addChar
                GOSUB addControlChar
                is_key` = FALSE
                'a word boundary occurs after the closing bracket
                is_boundary` = TRUE
            ELSE
                'any other character, add as is
                GOSUB addChar
            END IF
            'process next letter...
            GOTO continue
        END IF

        SELECT CASE char%
            CASE CTL_INDENT
                '-------------------------------------------------------------
                'set the indent to the current position
                indent% = l% + w%: indent$ = SPACE$(indent%)
                'word-break immediately
                char% = 0: GOSUB addWord
                is_boundary` = TRUE

            CASE CTL_HEADING
                '-------------------------------------------------------------
                IF ( _
                    ASC(line$, c% - 1) = ASC_SPC _
                 OR ASC(line$, c% - 1) = ASC_TAB _
                ) AND ASC(line$, c% + 1) = ASC_SPC _
                THEN
                    GOSUB addWord
                    ''GOSUB addControlChar
                    'set the indent to the current position
                    indent% = l% + w% + 1: indent$ = SPACE$(indent%)
                ELSE
                    GOSUB addChar
                END IF

            CASE CTL_KEY_ON
                '-------------------------------------------------------------
                'don't allow within 'italic'
                IF is_italic` = FALSE THEN
                    'enable the key mode and include the bracket
                    is_key` = TRUE
                    GOSUB addControlChar
                END IF
                GOSUB addChar

            CASE CTL_PAREN_ON
                '-------------------------------------------------------------
                'automatic paren mode will only occur on a word boundary
                IF is_boundary` = TRUE THEN
                    'enable the paren mode and include the bracket
                    is_paren` = TRUE
                    GOSUB addControlChar
                END IF
                'add the parenethesis to the output
                GOSUB addChar
                'a word boundary occurs within the parens
                is_boundary` = TRUE

            CASE CTL_PAREN_OFF
                '-------------------------------------------------------------
                GOSUB addChar
                IF is_paren` = TRUE THEN
                    'end paren mode
                    is_paren` = FALSE
                    GOSUB addControlChar
                END IF
                'a word boundary occurs after the parens
                is_boundary` = TRUE

            CASE CTL_BOLD, CTL_ITALIC
                '-------------------------------------------------------------
                IF char% = CTL_BOLD THEN
                    'check the next character:
                    SELECT CASE ASC(line$, c% + 1)
                        CASE char%
                            'double is an escape, treat as single literal
                            c% = c% + 1: GOSUB addChar

                        CASE ASC_SPC, ASC_TAB, ASC_COMMA, ASC_COLON, _
                             ASC_SEMICOLON, ASC_PERIOD, ASC_APOS, _
                             ASC_FSLASH, ASC_BSLASH, CTL_ITALIC, _
                             CTL_PAREN_OFF
                            'word boundary? if bold is on, flip it off
                            IF is_bold` = TRUE THEN
                                is_bold` = FALSE
                                char% = CTL_BOLD
                                GOSUB addControlChar
                            ELSE
                                'treat as literal
                                GOSUB addChar
                            END IF

                        CASE ELSE
                            'bold can ony be enabled at a word-boundary
                            IF is_boundary` = TRUE THEN
                                is_bold` = TRUE
                                GOSUB addControlChar
                            ELSE
                                'middle of word, treat as literal
                                GOSUB addChar
                            END IF
                    END SELECT

                ELSEIF char% = CTL_ITALIC THEN
                    'check the next character:
                    SELECT CASE ASC(line$, c% + 1)
                        CASE char%
                            'double is an escape, treat as single literal
                            c% = c% + 1: GOSUB addChar

                        CASE ASC_SPC, ASC_TAB, ASC_COMMA, ASC_COLON, _
                             ASC_SEMICOLON, ASC_PERIOD, ASC_APOS, _
                             ASC_FSLASH, ASC_BSLASH, CTL_BOLD, _
                             CTL_PAREN_OFF
                            'word boundary? if bold is on, flip it off
                            IF is_italic` = TRUE THEN
                                is_italic` = FALSE
                                char% = CTL_ITALIC
                                GOSUB addControlChar
                            ELSE
                                'treat as literal
                                GOSUB addChar
                            END IF

                        CASE ELSE
                            'italic can ony be enabled at a word-boundary
                            IF is_boundary` = TRUE THEN
                                is_italic` = TRUE
                                GOSUB addControlChar
                            ELSE
                                'middle of word, treat as literal
                                GOSUB addChar
                            END IF
                    END SELECT
                END IF

            CASE CTL_BREAK
                '-------------------------------------------------------------
                'double back-slash creates a manual line-break
                IF ASC(line$, c% + 1) = CTL_BREAK THEN
                    char% = 0: GOSUB addWord: GOSUB lineBreak
                    'ignore the second slash
                    c% = c% + 1
                ELSE
                    'treat as normal
                    GOSUB addChar
                END IF

            CASE ASC_APOS
                '-------------------------------------------------------------
                'an apostrophe is a word-boundary, but not a word-break;
                'i.e. `_bob_'s italics`
                GOSUB addChar
                is_boundary` = TRUE

            CASE ASC_FSLASH, ASC_BSLASH
                '-------------------------------------------------------------
                'forward and back slash are word-breaks & word-boundaries
                GOSUB addWord

            CASE ASC_SPC, ASC_TAB, ASC_DASH
                '-------------------------------------------------------------
                IF char% = ASC_TAB THEN
                    'this is white-space so add the current word to the line
                    char% = 0: GOSUB addWord
                    'convert tab character to spaces as `_CONTROLCHR OFF`
                    'will prevent tabs from rendering
                    tabspc% = 8 - ((l% + w%) MOD 8)
                    word$ = word$ + SPACE$(tabspc%): w% = w% + tabspc%
                END IF
                'add the word to the line and wrap if necessary
                '(the text after a hypen is considered a new word
                'so that it can wrap to the next line if need be)
                GOSUB addWord

            CASE ELSE
                '-------------------------------------------------------------
                'add character to current word
                GOSUB addChar

        END SELECT
        continue:
    NEXT

    'add this word to the last line
    char% = 0: GOSUB addWord
    IF TRIM$(newline$) <> "" THEN GOSUB addLine

    EXIT SUB

    addChar:
    '-------------------------------------------------------------------------
    'add the current character to the current word
    word$ = word$ + CHR$(char%): w% = w% + 1
    'we are no longer at the beginning of a word!
    is_boundary` = FALSE

    RETURN

    addControlChar:
    '-------------------------------------------------------------------------
    'add the current character as an escape code
    '(does not increase the current word or line length)
    word$ = word$ + CHR$(CTL_ESCAPE) + CHR$(char%):

    RETURN

    addWord:
    '-------------------------------------------------------------------------
    'will this word go over the end of the line?
    IF l% + w% + 1 > PAGE_WIDTH THEN
        'break the line and begin the new line with the remaining word
        GOSUB lineBreak
    ELSE
        'include the splitting character if present (e.g. space, hyphen)
        IF char% > 0 THEN word$ = word$ + CHR$(char%): w% = w% + 1
        'add the word to the end of the line:
        newline$ = newline$ + word$: l% = l% + w%

        GOSUB newWord
    END IF
    RETURN

    lineBreak:
    '-------------------------------------------------------------------------
    'line has wrapped, dispatch the current line:
    GOSUB addLine

    'begin a new line (use the indent if detected)
    newline$ = indent$: l% = indent%

    'is this a heading we're processing?
    IF is_heading` = TRUE THEN
        newline$ = newline$ + CHR$(CTL_ESCAPE) + CHR$(CTL_HEADING)
    END IF
    'in key mode?
    IF is_key` = TRUE THEN
        newline$ = newline$ + CHR$(CTL_ESCAPE) + CHR$(CTL_KEY_ON)
    END IF
    'are we currently in parentheses?
    IF word_paren` = TRUE THEN
        newline$ = newline$ + CHR$(CTL_ESCAPE) + CHR$(CTL_PAREN_ON)
    END IF
    'are we currently bold?
    IF word_bold` = TRUE THEN
        newline$ = newline$ + CHR$(CTL_ESCAPE) + CHR$(CTL_BOLD)
    END IF
    'are we currently italic?
    IF word_italic` = TRUE THEN
        newline$ = newline$ + CHR$(CTL_ESCAPE) + CHR$(CTL_ITALIC)
    END IF

    'begin the line with the remaining word
    newline$ = newline$ + word$: l% = l% + w%
    IF char% > 0 THEN
        newline$ = newline$ + CHR$(char%): l% = l% + 1
    END IF

    newWord:
    '-------------------------------------------------------------------------
    'clear the 'current' word
    word$ = "": w% = 0
    'remember the bold/italic &c.  state at the beginning of the word;
    'if it gets wrapped, the bold/italic &c. state needs to be copied
    'to the new line
    word_bold` = is_bold`
    word_italic` = is_italic`
    word_paren` = is_paren`
    word_key` = is_key`
    'we are now at the beginning of a word
    is_boundary` = TRUE

    RETURN

    addLine:
    '-------------------------------------------------------------------------
    'does the line need to be centred?
    IF align% = ALIGN_CENTER THEN
        'is the line shorter than the screen?
        '(this is the width without the control code characters)
        IF l% < PAGE_WIDTH THEN
            'pad the left-side with enough spaces to centre the text
            newline$ = SPACE$((PAGE_WIDTH - l%) / 2) + newline$
        END IF
    END IF
    'add the line to the array of screen-ready converted lines
    addLine newline$

    RETURN
END SUB

'add a single line to the page
'=============================================================================
SUB addLine (line$)
    'increase the number of lines stored
    PageLineCount% = PageLineCount% + 1
    REDIM _PRESERVE PageLines$(PageLineCount%)
    PageLines$(PageLineCount%) = line$
END SUB

'prints a line of text with formatting codes
'=============================================================================
SUB printLine (line$)
    'divider lines can be handled with little processing
    IF line$ = CHR$(CTL_ESCAPE) + CHR$(CTL_LINE1) THEN
        COLOR YELLOW
        PRINT STRING$(PAGE_WIDTH, "Í");
        EXIT SUB

    ELSEIF line$ = CHR$(CTL_ESCAPE) + CHR$(CTL_LINE2) THEN
        COLOR YELLOW
        PRINT STRING$(PAGE_WIDTH, "Ä");
        EXIT SUB

    END IF

    '-------------------------------------------------------------------------

    'this will keep track of the nesting of modes
    REDIM mode_stack%(1)
    DIM mode_count%: mode_count% = 1
    'start with the page's default colour
    GOSUB setmode

    DIM is_heading`
    DIM is_key` '...if handling a key indicator "^[...^]"
    DIM is_paren` '.if in parentheses "^( ... ^)"
    DIM is_bold` '..if in bold mode "^B"
    DIM is_italic` 'if in italic mode "^I"

    DIM c%, char%
    FOR c% = 1 TO LEN(line$)
        'read a character
        char% = ASC(line$, c%)

        'is it a control code?
        IF char% = CTL_ESCAPE THEN
            'read the next character
            c% = c% + 1: char% = ASC(line$, c%)

            'which control code is it?
            SELECT CASE char%
                CASE CTL_HEADING '--------------------------------------------
                    'heading
                    is_heading` = NOT is_heading`
                    IF is_heading` = TRUE THEN
                        GOSUB pushmode
                    ELSE
                        GOSUB popmode
                    END IF

                CASE CTL_PAREN_ON '-------------------------------------------
                    'enter parentheses
                    is_paren` = TRUE
                    GOSUB pushmode

                CASE CTL_PAREN_OFF '------------------------------------------
                    'end parenetheses mode
                    is_paren` = FALSE
                    GOSUB popmode

                CASE CTL_KEY_ON '---------------------------------------------
                    'set key mode on, the closing bracket will turn it off
                    is_key` = TRUE
                    GOSUB pushmode

                CASE CTL_KEY_OFF '--------------------------------------------
                    'end key mode
                    is_key` = FALSE
                    GOSUB popmode

                CASE CTL_BOLD '-----------------------------------------------
                    'enable / disable bold
                    is_bold` = NOT is_bold`
                    IF is_bold` = TRUE THEN
                        GOSUB pushmode
                    ELSE
                        GOSUB popmode
                    END IF

                CASE CTL_ITALIC '---------------------------------------------
                    'enable / disable italic
                    is_italic` = NOT is_italic`
                    IF is_italic` = TRUE THEN
                        GOSUB pushmode
                    ELSE
                        GOSUB popmode
                    END IF

                CASE ELSE
                    'not a valid control code, print as normal text
                    PRINT CHR$(CTL_ESCAPE) + CHR$(char%);

            END SELECT

        ELSEIF char% = 0 THEN
            char% = ASC("?")
            GOSUB pushmode
            PRINT "?";
            GOSUB popmode
        ELSE
            'print the character as-is to screen
            PRINT CHR$(char%);
        END IF
    NEXT
    EXIT SUB

    pushmode:
    '-------------------------------------------------------------------------
    mode_count% = mode_count% + 1
    REDIM _PRESERVE mode_stack%(mode_count%)
    mode_stack%(mode_count%) = char%
    GOTO setmode

    popmode:
    '-------------------------------------------------------------------------
    mode_count% = mode_count% - 1
    GOTO setmode

    setmode:
    '-------------------------------------------------------------------------
    SELECT CASE mode_stack%(mode_count%)
        CASE CTL_HEADING
            COLOR YELLOW
        CASE CTL_BOLD
            COLOR WHITE
        CASE CTL_ITALIC
            COLOR LIME
        CASE CTL_KEY_ON
            COLOR AQUA
        CASE CTL_PAREN_ON
            COLOR CYAN
        CASE ASC("?")
            COLOR 28
        CASE ELSE
            COLOR PAGE_FGND
    END SELECT
    RETURN
END SUB

'show an error screen and stop the program
'=============================================================================
SUB fatalError (msg$)
    'error could have occurred during display drawing,
    'so just create a new screen
    SCREEN 0, , 0, 0: COLOR YELLOW, RED: CLS
    'leave fullscreen
    _FULLSCREEN _OFF

    'write the message
    LOCATE 3, 32: PRINT "! FATAL ERROR !"

    COLOR WHITE
    LOCATE 6, 3: PRINT msg$;

    'wait for keypress before exiting
    SLEEP: SYSTEM 1
END SUB

'convert a UTF-8 string to an ANSI(cp437) string, with some transliteration
'=============================================================================
FUNCTION UTF8ANSI$ (text$)
    DIM b~%%, c~%%, d~%% '=_UNSIGNED _BYTE
    DIM p~% '=_UNSIGNED INTEGER

    'we'll need to walk the string as bytes
    '(this is the assumption of QB64, it doesn't handle wide-strings)
    FOR i% = 1 TO LEN(text$)
        'read a byte
        b~%% = ASC(text$, i%)
        'if byte is <128 then it's the same in ASCII/ANSI/UTF-8,
        p~& = b~%%

        IF (b~%% AND &HE0) = &HC0 THEN
            'this is a 2-byte UTF-8 sequence;
            '(the top three bits are "110?????")
            'read the next byte to determine the character
            i% = i% + 1: c~%% = ASC(text$, i%)
            'combine the two bytes into a single (integer) character
            p~& = (b~%% AND &H1F&) * &H40 + (c~%% AND &H3F&)

        ELSEIF (b~%% AND &HF0) = &HE0 THEN
            'this is a 3-byte UTF-8 sequence:
            '(the top four bits are "1110????")
            i% = i% + 1: c~%% = ASC(text$, i%)
            i% = i% + 1: d~%% = ASC(text$, i%)
            p~& = (b~%% and &HF) * &H1000 _
                + (c~%% AND &H3F) * &H40 _
                + (d~%% AND &H3F)
        END IF

        SELECT CASE p~&
            CASE IS < 128
                'if byte is <128 then it's the same in ASCII/ANSI/UTF-8
                UTF8ANSI$ = UTF8ANSI$ + CHR$(b~%%)

            CASE &H263A: UTF8ANSI$ = UTF8ANSI$ + CHR$(1)
            CASE &H263B: UTF8ANSI$ = UTF8ANSI$ + CHR$(2)
            CASE &H2665: UTF8ANSI$ = UTF8ANSI$ + CHR$(3)
            CASE &H2666: UTF8ANSI$ = UTF8ANSI$ + CHR$(4)
            CASE &H2663: UTF8ANSI$ = UTF8ANSI$ + CHR$(5)
            CASE &H2660: UTF8ANSI$ = UTF8ANSI$ + CHR$(6)
            CASE &H2022: UTF8ANSI$ = UTF8ANSI$ + CHR$(7)
            CASE &H25D8: UTF8ANSI$ = UTF8ANSI$ + CHR$(8)
            CASE &H25CB: UTF8ANSI$ = UTF8ANSI$ + CHR$(9)
            CASE &H25D9: UTF8ANSI$ = UTF8ANSI$ + CHR$(10)
            CASE &H2642: UTF8ANSI$ = UTF8ANSI$ + CHR$(11)
            CASE &H2640: UTF8ANSI$ = UTF8ANSI$ + CHR$(12)
            CASE &H266A: UTF8ANSI$ = UTF8ANSI$ + CHR$(13)
            CASE &H266B: UTF8ANSI$ = UTF8ANSI$ + CHR$(14)
            CASE &H263C: UTF8ANSI$ = UTF8ANSI$ + CHR$(15)
            CASE &H25BA: UTF8ANSI$ = UTF8ANSI$ + CHR$(16)
            CASE &H25C4: UTF8ANSI$ = UTF8ANSI$ + CHR$(17)
            CASE &H2195: UTF8ANSI$ = UTF8ANSI$ + CHR$(18)
            CASE &H203C: UTF8ANSI$ = UTF8ANSI$ + CHR$(19)
            CASE &H00B6: UTF8ANSI$ = UTF8ANSI$ + CHR$(20)
            CASE &H00A7: UTF8ANSI$ = UTF8ANSI$ + CHR$(21)
            CASE &H25AC: UTF8ANSI$ = UTF8ANSI$ + CHR$(22)
            CASE &H21A8: UTF8ANSI$ = UTF8ANSI$ + CHR$(23)
            CASE &H2191: UTF8ANSI$ = UTF8ANSI$ + CHR$(24)
            CASE &H2193: UTF8ANSI$ = UTF8ANSI$ + CHR$(25)
            CASE &H2192: UTF8ANSI$ = UTF8ANSI$ + CHR$(26)
            CASE &H2190: UTF8ANSI$ = UTF8ANSI$ + CHR$(27)
            CASE &H221F: UTF8ANSI$ = UTF8ANSI$ + CHR$(28)
            CASE &H2194: UTF8ANSI$ = UTF8ANSI$ + CHR$(29)
            CASE &H25B2: UTF8ANSI$ = UTF8ANSI$ + CHR$(30)
            CASE &H25BC: UTF8ANSI$ = UTF8ANSI$ + CHR$(31)
            CASE &H2302: UTF8ANSI$ = UTF8ANSI$ + CHR$(127)
            CASE &H00C7: UTF8ANSI$ = UTF8ANSI$ + CHR$(128)
            CASE &H00FC: UTF8ANSI$ = UTF8ANSI$ + CHR$(129)
            CASE &H00E9: UTF8ANSI$ = UTF8ANSI$ + CHR$(130)
            CASE &H00E2: UTF8ANSI$ = UTF8ANSI$ + CHR$(131)
            CASE &H00E4: UTF8ANSI$ = UTF8ANSI$ + CHR$(132)
            CASE &H00E0: UTF8ANSI$ = UTF8ANSI$ + CHR$(133)
            CASE &H00E5: UTF8ANSI$ = UTF8ANSI$ + CHR$(134)
            CASE &H00E7: UTF8ANSI$ = UTF8ANSI$ + CHR$(135)
            CASE &H00EA: UTF8ANSI$ = UTF8ANSI$ + CHR$(136)
            CASE &H00EB: UTF8ANSI$ = UTF8ANSI$ + CHR$(137)
            CASE &H00E8: UTF8ANSI$ = UTF8ANSI$ + CHR$(138)
            CASE &H00EF: UTF8ANSI$ = UTF8ANSI$ + CHR$(139)
            CASE &H00EE: UTF8ANSI$ = UTF8ANSI$ + CHR$(140)
            CASE &H00EC: UTF8ANSI$ = UTF8ANSI$ + CHR$(141)
            CASE &H00C4: UTF8ANSI$ = UTF8ANSI$ + CHR$(142)
            CASE &H00C5: UTF8ANSI$ = UTF8ANSI$ + CHR$(143)
            CASE &H00C9: UTF8ANSI$ = UTF8ANSI$ + CHR$(144)
            CASE &H00E6: UTF8ANSI$ = UTF8ANSI$ + CHR$(145)
            CASE &H00C6: UTF8ANSI$ = UTF8ANSI$ + CHR$(146)
            CASE &H00F4: UTF8ANSI$ = UTF8ANSI$ + CHR$(147)
            CASE &H00F6: UTF8ANSI$ = UTF8ANSI$ + CHR$(148)
            CASE &H00F2: UTF8ANSI$ = UTF8ANSI$ + CHR$(149)
            CASE &H00FB: UTF8ANSI$ = UTF8ANSI$ + CHR$(150)
            CASE &H00F9: UTF8ANSI$ = UTF8ANSI$ + CHR$(151)
            CASE &H00FF: UTF8ANSI$ = UTF8ANSI$ + CHR$(152)
            CASE &H00D6: UTF8ANSI$ = UTF8ANSI$ + CHR$(153)
            CASE &H00DC: UTF8ANSI$ = UTF8ANSI$ + CHR$(154)
            CASE &H00A2: UTF8ANSI$ = UTF8ANSI$ + CHR$(155)
            CASE &H00A3: UTF8ANSI$ = UTF8ANSI$ + CHR$(156)
            CASE &H00A5: UTF8ANSI$ = UTF8ANSI$ + CHR$(157)
            CASE &H20A7: UTF8ANSI$ = UTF8ANSI$ + CHR$(158)
            CASE &H0192: UTF8ANSI$ = UTF8ANSI$ + CHR$(159)
            CASE &H00E1: UTF8ANSI$ = UTF8ANSI$ + CHR$(160)
            CASE &H00ED: UTF8ANSI$ = UTF8ANSI$ + CHR$(161)
            CASE &H00F3: UTF8ANSI$ = UTF8ANSI$ + CHR$(162)
            CASE &H00FA: UTF8ANSI$ = UTF8ANSI$ + CHR$(163)
            CASE &H00F1: UTF8ANSI$ = UTF8ANSI$ + CHR$(164)
            CASE &H00D1: UTF8ANSI$ = UTF8ANSI$ + CHR$(165)
            CASE &H00AA: UTF8ANSI$ = UTF8ANSI$ + CHR$(166)
            CASE &H00BA: UTF8ANSI$ = UTF8ANSI$ + CHR$(167)
            CASE &H00BF: UTF8ANSI$ = UTF8ANSI$ + CHR$(168)
            CASE &H2310: UTF8ANSI$ = UTF8ANSI$ + CHR$(169)
            CASE &H00AC: UTF8ANSI$ = UTF8ANSI$ + CHR$(170)
            CASE &H00BD: UTF8ANSI$ = UTF8ANSI$ + CHR$(171)
            CASE &H00BC: UTF8ANSI$ = UTF8ANSI$ + CHR$(172)
            CASE &H00A1: UTF8ANSI$ = UTF8ANSI$ + CHR$(173)
            CASE &H00AB: UTF8ANSI$ = UTF8ANSI$ + CHR$(174)
            CASE &H00BB: UTF8ANSI$ = UTF8ANSI$ + CHR$(175)
            CASE &H2591: UTF8ANSI$ = UTF8ANSI$ + CHR$(176)
            CASE &H2592: UTF8ANSI$ = UTF8ANSI$ + CHR$(177)
            CASE &H2593: UTF8ANSI$ = UTF8ANSI$ + CHR$(178)
            CASE &H2502: UTF8ANSI$ = UTF8ANSI$ + CHR$(179)
            CASE &H2524: UTF8ANSI$ = UTF8ANSI$ + CHR$(180)
            CASE &H2561: UTF8ANSI$ = UTF8ANSI$ + CHR$(181)
            CASE &H2562: UTF8ANSI$ = UTF8ANSI$ + CHR$(182)
            CASE &H2556: UTF8ANSI$ = UTF8ANSI$ + CHR$(183)
            CASE &H2555: UTF8ANSI$ = UTF8ANSI$ + CHR$(184)
            CASE &H2563: UTF8ANSI$ = UTF8ANSI$ + CHR$(185)
            CASE &H2551: UTF8ANSI$ = UTF8ANSI$ + CHR$(186)
            CASE &H2557: UTF8ANSI$ = UTF8ANSI$ + CHR$(187)
            CASE &H255D: UTF8ANSI$ = UTF8ANSI$ + CHR$(188)
            CASE &H255C: UTF8ANSI$ = UTF8ANSI$ + CHR$(189)
            CASE &H255B: UTF8ANSI$ = UTF8ANSI$ + CHR$(190)
            CASE &H2510: UTF8ANSI$ = UTF8ANSI$ + CHR$(191)
            CASE &H2514: UTF8ANSI$ = UTF8ANSI$ + CHR$(192)
            CASE &H2534: UTF8ANSI$ = UTF8ANSI$ + CHR$(193)
            CASE &H252C: UTF8ANSI$ = UTF8ANSI$ + CHR$(194)
            CASE &H251C: UTF8ANSI$ = UTF8ANSI$ + CHR$(195)
            CASE &H2500: UTF8ANSI$ = UTF8ANSI$ + CHR$(196)
            CASE &H253C: UTF8ANSI$ = UTF8ANSI$ + CHR$(197)
            CASE &H255E: UTF8ANSI$ = UTF8ANSI$ + CHR$(198)
            CASE &H255F: UTF8ANSI$ = UTF8ANSI$ + CHR$(199)
            CASE &H255A: UTF8ANSI$ = UTF8ANSI$ + CHR$(200)
            CASE &H2554: UTF8ANSI$ = UTF8ANSI$ + CHR$(201)
            CASE &H2569: UTF8ANSI$ = UTF8ANSI$ + CHR$(202)
            CASE &H2566: UTF8ANSI$ = UTF8ANSI$ + CHR$(203)
            CASE &H2560: UTF8ANSI$ = UTF8ANSI$ + CHR$(204)
            CASE &H2550: UTF8ANSI$ = UTF8ANSI$ + CHR$(205)
            CASE &H256C: UTF8ANSI$ = UTF8ANSI$ + CHR$(206)
            CASE &H2567: UTF8ANSI$ = UTF8ANSI$ + CHR$(207)
            CASE &H2568: UTF8ANSI$ = UTF8ANSI$ + CHR$(208)
            CASE &H2564: UTF8ANSI$ = UTF8ANSI$ + CHR$(219)
            CASE &H2565: UTF8ANSI$ = UTF8ANSI$ + CHR$(210)
            CASE &H2559: UTF8ANSI$ = UTF8ANSI$ + CHR$(211)
            CASE &H2558: UTF8ANSI$ = UTF8ANSI$ + CHR$(212)
            CASE &H2552: UTF8ANSI$ = UTF8ANSI$ + CHR$(213)
            CASE &H2553: UTF8ANSI$ = UTF8ANSI$ + CHR$(214)
            CASE &H256B: UTF8ANSI$ = UTF8ANSI$ + CHR$(215)
            CASE &H256A: UTF8ANSI$ = UTF8ANSI$ + CHR$(216)
            CASE &H2518: UTF8ANSI$ = UTF8ANSI$ + CHR$(217)
            CASE &H250C: UTF8ANSI$ = UTF8ANSI$ + CHR$(218)
            CASE &H2588: UTF8ANSI$ = UTF8ANSI$ + CHR$(219)
            CASE &H2584: UTF8ANSI$ = UTF8ANSI$ + CHR$(220)
            CASE &H258C: UTF8ANSI$ = UTF8ANSI$ + CHR$(221)
            CASE &H2590: UTF8ANSI$ = UTF8ANSI$ + CHR$(222)
            CASE &H2580: UTF8ANSI$ = UTF8ANSI$ + CHR$(223)
            CASE &H03B1: UTF8ANSI$ = UTF8ANSI$ + CHR$(224)
            CASE &H00DF: UTF8ANSI$ = UTF8ANSI$ + CHR$(225)
            CASE &H0393: UTF8ANSI$ = UTF8ANSI$ + CHR$(226)
            CASE &H03C0: UTF8ANSI$ = UTF8ANSI$ + CHR$(227)
            CASE &H03A3: UTF8ANSI$ = UTF8ANSI$ + CHR$(228)
            CASE &H03C3: UTF8ANSI$ = UTF8ANSI$ + CHR$(229)
            CASE &H00B5: UTF8ANSI$ = UTF8ANSI$ + CHR$(230)
            CASE &H03C4: UTF8ANSI$ = UTF8ANSI$ + CHR$(231)
            CASE &H03A6: UTF8ANSI$ = UTF8ANSI$ + CHR$(232)
            CASE &H0398: UTF8ANSI$ = UTF8ANSI$ + CHR$(233)
            CASE &H03A9: UTF8ANSI$ = UTF8ANSI$ + CHR$(234)
            CASE &H03B4: UTF8ANSI$ = UTF8ANSI$ + CHR$(235)
            CASE &H221E: UTF8ANSI$ = UTF8ANSI$ + CHR$(236)
            CASE &H03C6: UTF8ANSI$ = UTF8ANSI$ + CHR$(237)
            CASE &H03B5: UTF8ANSI$ = UTF8ANSI$ + CHR$(238)
            CASE &H2229: UTF8ANSI$ = UTF8ANSI$ + CHR$(239)
            CASE &H2261: UTF8ANSI$ = UTF8ANSI$ + CHR$(240)
            CASE &H00B1: UTF8ANSI$ = UTF8ANSI$ + CHR$(241)
            CASE &H2265: UTF8ANSI$ = UTF8ANSI$ + CHR$(242)
            CASE &H2264: UTF8ANSI$ = UTF8ANSI$ + CHR$(243)
            CASE &H2320: UTF8ANSI$ = UTF8ANSI$ + CHR$(244)
            CASE &H2321: UTF8ANSI$ = UTF8ANSI$ + CHR$(245)
            CASE &H00F7: UTF8ANSI$ = UTF8ANSI$ + CHR$(246)
            CASE &H2248: UTF8ANSI$ = UTF8ANSI$ + CHR$(247)
            CASE &H00B0: UTF8ANSI$ = UTF8ANSI$ + CHR$(248)
            CASE &H2219: UTF8ANSI$ = UTF8ANSI$ + CHR$(249)
            CASE &H00B7: UTF8ANSI$ = UTF8ANSI$ + CHR$(250)
            CASE &H221A: UTF8ANSI$ = UTF8ANSI$ + CHR$(251)
            CASE &H207F: UTF8ANSI$ = UTF8ANSI$ + CHR$(252)
            CASE &H00B2: UTF8ANSI$ = UTF8ANSI$ + CHR$(253)
            CASE &H25A0: UTF8ANSI$ = UTF8ANSI$ + CHR$(254)
            CASE &H00A0: UTF8ANSI$ = UTF8ANSI$ + CHR$(255)
            CASE ELSE
                'not a mappable Unicode point
                UTF8ANSI$ = UTF8ANSI$ + CHR$(0)
        END SELECT
    NEXT
END FUNCTION

