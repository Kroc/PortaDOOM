'DOSmag : a DOS-like portable front-end for hyperlinked textual content.
'         copyright (C) Kroc Camen, 2016-2017; MIT license (see LICENSE.TXT)
'=============================================================================
'WARNING: THIS IS A QB64.NET SOURCE FILE, ENCODED AS ANSI CODE-PAGE 437
'         (SOMETIMES REFERRED TO AS "DOS" OR "OEM-US" ENCODING).
'         DO NOT OPEN AND SAVE THIS FILE AS UNICODE / UTF-8!
'=============================================================================


'scroll the page down 1 line
'=============================================================================
SUB scrollDown
    'can't scroll if there is no scrollbar!
    IF PageLineCount% <= PAGE_HEIGHT THEN BEEP: EXIT SUB

    'can't scroll if already at the bottom
    DIM pageBottom%
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
    DIM pageBottom%
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
        DIM page_bottom%
        page_bottom% = PageLineCount% - PAGE_HEIGHT + 1
        IF line_num% > page_bottom% THEN line_num% = page_bottom%
        PageLine% = line_num%
    END IF
    refreshScreen
END SUB


