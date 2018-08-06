'copyright (C) Kroc Camen 2018, BSD 2-clause

'$INCLUDE:'strgui\strgui.bi'

'=============================================================================

'as we can only store fixed-length strings in custom types,
'this array acts as a pool of storage for various user-defined strings
REDIM SHARED TUI_Strings(0 TO 0) AS STRING

'-----------------------------------------------------------------------------

CONST TUI_ControlKind_None = 0
CONST TUI_ControlKind_DesktopBar = 1
CONST TUI_ControlKind_Window = 2
CONST TUI_ControlKind_Label = 3

TYPE TUI_Control
    x AS _UNSIGNED _BYTE
    y AS _UNSIGNED _BYTE
    width AS _UNSIGNED _BYTE
    height AS _UNSIGNED _BYTE
    foreColor AS _UNSIGNED _BYTE
    backColor AS _UNSIGNED _BYTE
    kind AS _UNSIGNED _BYTE
    kind_id AS _UNSIGNED _BYTE
END TYPE

DIM SHARED TUI_Controls(1 TO 255) AS TUI_Control
DIM SHARED TUI_Controls_index AS _UNSIGNED _BYTE

'=============================================================================

DIM SHARED TUI_Desktop_foreColor AS _UNSIGNED _BYTE
DIM SHARED TUI_Desktop_backColor AS _UNSIGNED _BYTE
DIM SHARED TUI_Desktop_fillChar AS _UNSIGNED _BYTE

LET TUI_Desktop_foreColor = LTGREY
LET TUI_Desktop_backColor = BLUE
LET TUI_Desktop_fillChar = ASC_BLOCK_MD

'-----------------------------------------------------------------------------

'a title / status bar that stretches across the screen.
'can display text from the left and right sides
TYPE TUI_DesktopBar
    textLeft AS _UNSIGNED LONG ' index into `TUI_Strings`
    textRight AS _UNSIGNED LONG 'index into `TUI_Strings`
END TYPE
'the bar(s) defined
REDIM SHARED TUI_DesktopBars(0 TO 0) AS TUI_DesktopBar

'-----------------------------------------------------------------------------

TYPE TUI_Window
    borderStyle AS _UNSIGNED _BYTE
    decoration AS _UNSIGNED LONG
    cache AS _UNSIGNED LONG
END TYPE
'the TUI_Window(s) defined
REDIM SHARED TUI_Windows(0 TO 0) AS TUI_Window

'-----------------------------------------------------------------------------

TYPE TUI_Label
    caption AS _UNSIGNED _BYTE
END TYPE
REDIM SHARED TUI_Labels(0 TO 0) AS TUI_Label
