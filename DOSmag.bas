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
'$INCLUDE: 'unicode.bas'


'our text-formatting control codes
'-----------------------------------------------------------------------------
CONST CTL_ESCAPE = ASC_CARET '  ^
CONST CTL_HEADING = ASC_COLON ' :
CONST CTL_BOLD = ASC_ASTERISK ' *
CONST CTL_ITALIC = ASC_FSLASH ' /
CONST CTL_LINE1 = ASC_EQUALS '  =
CONST CTL_LINE2 = ASC_DASH '    -
CONST CTL_PAREN = ASC_LPAREN '  (
CONST CTL_KEY = ASC_LSQB '      [


'screen layout
'-----------------------------------------------------------------------------
CONST HEAD_TOP = 1 'row where the header starts
CONST HEAD_HEIGHT = 3 'size of the header area

CONST HEAD_FGND = ROSE 'header foreground colour
CONST HEAD_BKGD = RED 'header background colour

CONST TABS_FGND = AQUA
CONST TABS_BKGD = BLUE

'row number where the page begins (immediately after the header)
CONST PAGE_TOP = HEAD_TOP + HEAD_HEIGHT
'height of the page display on the screen;
'(screen height less breadcrumb, title line, page and status bar)
CONST PAGE_HEIGHT = SCREEN_HEIGHT - PAGE_TOP - 1

CONST PAGE_WIDTH = 77

CONST PAGE_FGND = LTGREY
CONST PAGE_BKGD = BLUE

'extended height of the status area at the bottom of the screen;
'note that heights above 0 actually overlap the page, not squash it.
'this is used to slide the help bar up and display the instructions
DIM SHARED StatusHeight%%: StatusHeight%% = 0


'page data:
'-----------------------------------------------------------------------------
CONST PAGE_DIR = "pages\" 'path where to find the .dosmag pages

DIM SHARED PageName AS STRING 'base name of page, without page number
DIM SHARED PageTitle AS STRING
DIM SHARED PageGroup AS STRING
DIM SHARED PageNum AS INTEGER
DIM SHARED PageCount AS INTEGER
REDIM SHARED PageLines(1) AS STRING
DIM SHARED PageLine AS INTEGER 'line number at top of screen
DIM SHARED PageLineCount AS INTEGER

CONST ACTION_GOTO = 1
CONST ACTION_SHELL = 2

'a page can define keys and their actions
TYPE PageKey
    keycode AS INTEGER 'ASCII key code
    action AS INTEGER 'the action to take, e.g. ACTION_GOTO
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

'=============================================================================
SUB scrollTo (line_num%)
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

    LOCATE PAGE_TOP, 1
    COLOR PAGE_FGND, PAGE_BKGD
    FOR n% = 0 TO PAGE_HEIGHT
        IF PageLine% + n% > PageLineCount% THEN EXIT FOR
        LOCATE (PAGE_TOP + n%), 2
        printLine PageLines$(PageLine% + n%)
    NEXT
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
    PRINT " [F1]:HELP  [BKSP]:BACK                            [F11]:FULLSCREEN  [ESC]:QUIT";

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
    IF ASC(page_name$, LEN(page_name$) - 2) = ASC("#") THEN
        'extract the page number off the end of the name
        page_number% = VAL(RIGHT$(page_name$, 2))
        'remove the page number from the name
        file_base$ = TRIM$(LEFT$(page_name$, LEN(page_name$) - 3))
        file_path$ = PAGE_DIR + file_base$ + " " _
                   + pageNumber$(page_number%) + ".dosmag"
    ELSE
        'no page number
        page_number% = 0
        file_base$ = TRIM$(page_name$)
        file_path$ = PAGE_DIR + file_base$ 'file extension omitted for now

        'does the file exist?
        IF NOT _FILEEXISTS(file_path$ + ".dosmag") THEN
            'if not, it may be that the page does exist, but with page number
            IF _FILEEXISTS(file_path$ + " #01.dosmag") THEN
                'add a default page number
                file_path$ = file_path$ + " #01"
                page_number% = 1
            END IF
        END IF

        file_path$ = file_path$ + ".dosmag"
    END IF

    'does the page exist?
    IF NOT _FILEEXISTS(file_path$) THEN
        fatalError "Cannot locate file '" + file_path$ + "'"
    END IF

    '-------------------------------------------------------------------------

    OPEN file_path$ FOR BINARY AS #1

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
        PAGE_DIR + file_base$ + " " + pageNumber$(PageCount% + 1) + ".dosmag" _
    )
        PageCount% = PageCount% + 1
    LOOP

    '-------------------------------------------------------------------------

    DO UNTIL EOF(1)
        DIM line$
        LINE INPUT #1, line$
        'shortcut for blank lines
        IF line$ = "" THEN
            addLine ""

        ELSEIF LEFT$(line$, 2) = "^C" THEN
            'centre line:
            wrapLine MID$(line$, 3), ALIGN_CENTER

        ELSEIF LEFT$(line$, 2) = "^-" OR LEFT$(line$, 2) = "^=" THEN
            'line-markers "----..." / "====..."
            addLine LEFT$(line$, 2)

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

'convert a page number to a string for use in file names, i.e. "#01"
'=============================================================================
FUNCTION pageNumber$ (page_number%)
    'ensure that it's always double-digit
    IF page_number% < 10 THEN
        pageNumber$ = "#0" + STRINT$(page_number%)
    ELSE
        pageNumber$ = "#" + STRINT$(page_number%)
    END IF
END FUNCTION

'walk throgh the line and word-wrap it
'(control codes will not count toward word-wrapping)
'=============================================================================
SUB wrapLine (line$, align%)
    'always right-trim a line as this can cause unexpected wrapping
    line$ = RTRIM$(line$)
    'if this is a blank line,  process it quickly
    IF line$ = "" THEN addLine "": EXIT SUB

    DIM newline$: newline$ = "" 'the line we're building up
    DIM word$: word$ = "" 'the current word being built
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
                indent$ = indent$ + CHR$(ASC_TAB)
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

    'length of the current word
    DIM w%: w% = 0

    DIM is_heading`
    DIM is_bold`
    DIM is_italic`
    DIM is_paren`
    DIM is_key`

    'we need to know if a word was already bold/italic &c. when it began,
    'so that if it's wrapped we can insert the control code on the new line
    DIM word_paren`
    DIM word_bold`
    DIM word_italic`
    DIM word_key`

    'process text:
    FOR c% = c% TO LEN(line$)
        'get current character in the source line
        char% = ASC(line$, c%)
        SELECT CASE char%
            'is this a control code?
            CASE CTL_ESCAPE
                'check the control character
                c% = c% + 1: char% = ASC(line$, c%)

                'add the control code to the word string,
                'but don't include it in the length of the word (`w%`)
                word$ = word$ + CHR$(CTL_ESCAPE) + CHR$(char%)

                'manage control state
                SELECT CASE char%
                    CASE CTL_HEADING
                        'a heading applies to the whole line,
                        'so needs to be copied when wrapping the line
                        is_heading` = TRUE

                    CASE CTL_BOLD
                        'flip the bold mode
                        is_bold` = NOT is_bold`

                    CASE CTL_ITALIC
                        'flip the italic mode
                        is_italic` = NOT is_italic`

                    CASE CTL_PAREN
                        'begin parentheses "^( ... )"
                        is_paren` = TRUE
                        'the paren will be printed
                        word$ = word$ + CHR$(CTL_PAREN): w% = w% + 1

                    CASE CTL_KEY
                        'begin key "^[ ... ]"
                        is_key` = TRUE
                        'the opening bracket will be printed
                        word$ = word$ + CHR$(CTL_KEY): w% = w% + 1

                END SELECT

            CASE ASC_SPC, ASC_TAB, ASC_DASH
                'add the word to the line and wrap if necessary
                '(the text after a hypen is considered a new word
                'so that it can wrap to the next line if need be)
                GOSUB addWord

            CASE ELSE
                'end of parentheses?
                IF char% = ASC_RPAREN THEN is_paren` = FALSE
                'end of key?
                IF char% = ASC_RSQB THEN is_key` = FALSE
                'add character to current word
                word$ = word$ + CHR$(char%): w% = w% + 1

        END SELECT
    NEXT

    'add this word to the last line
    char% = 0: GOSUB addWord: GOSUB addLine

    EXIT SUB

    addWord:
    '-------------------------------------------------------------------------
    'will this word go over the end of the line?
    IF l% + w% + 1 > PAGE_WIDTH THEN
        'line has wrapped, dispatch the current line:
        GOSUB addLine

        'begin a new line (use the indent if detected)
        newline$ = indent$: l% = indent%

        'is this a heading we're processing?
        IF is_heading` = TRUE THEN
            newline$ = newline$ + CHR$(CTL_ESCAPE) + CHR$(CTL_HEADING)
        END IF
        'are we currently in parentheses?
        IF word_paren` = TRUE THEN
            newline$ = newline$ + CHR$(CTL_ESCAPE) + CHR$(CTL_PAREN)
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
    ELSE
        'include the splitting character if present (e.g. space, hyphen)
        IF char% > 0 THEN word$ = word$ + CHR$(char%): w% = w% + 1
        'add the word to the end of the line:
        newline$ = newline$ + word$: l% = l% + w%
    END IF

    'clear the 'current' word
    word$ = "": w% = 0
    'remember the bold/italic &c.  state at the beginning of the word;
    'if it gets wrapped, the bold/italic &c. state needs to be copied
    'to the new line
    word_bold` = is_bold`
    word_italic` = is_italic`
    word_paren` = is_paren`

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
    IF line$ = "^=" THEN
        COLOR YELLOW
        PRINT STRING$(PAGE_WIDTH, "Í");
        EXIT SUB

    ELSEIF line$ = "^-" THEN
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

    DIM is_key` '...if handling a key indicator "^[...]"
    DIM is_paren` '.if in parentheses "^( ... )"
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
                    GOSUB pushmode

                CASE CTL_PAREN '----------------------------------------------
                    'enter parentheses
                    is_paren` = TRUE
                    GOSUB pushmode

                CASE CTL_KEY '------------------------------------------------
                    'set key mode on, the closing bracket will turn it off
                    is_key` = TRUE
                    GOSUB pushmode

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
        ELSE
            'print the character as-is to screen
            PRINT CHR$(char%);

            'check for control modes that might have ended
            IF (char% = ASC_RSQB) AND (is_key` = TRUE) THEN
                GOSUB popmode: is_key` = FALSE

            ELSEIF (char% = ASC_RPAREN) AND (is_paren`) = TRUE THEN
                GOSUB popmode: is_paren` = FALSE

            END IF

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
            COLOR WHITE
        CASE CTL_BOLD
            COLOR YELLOW
        CASE CTL_ITALIC
            COLOR LIME
        CASE ASC_LSQB
            COLOR AQUA
        CASE CTL_PAREN
            COLOR CYAN
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
