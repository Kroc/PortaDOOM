'copyright (C) Kroc Camen 2018, BSD 2-clause

'the default size (in char cols/rows) of the screen
CONST SCREEN_MODE = 0 '...text mode
CONST SCREEN_WIDTH = 80 '.640 width
CONST SCREEN_HEIGHT = 30 '480 height

'=============================================================================

'as we can only store fixed-length strings in custom types,
'this array acts as a pool of storage for various user-defined strings
REDIM SHARED UI.Strings(0 TO 0) AS STRING

'=============================================================================

CONST UIControlKind_None = 0
CONST UIControlKind_DesktopBar = 1
CONST UIControlKind_Window = 2
CONST UIControlKind_Label = 3

TYPE UIControl
    x AS _UNSIGNED _BYTE
    y AS _UNSIGNED _BYTE
    width AS _UNSIGNED _BYTE
    height AS _UNSIGNED _BYTE
    foreColor AS _UNSIGNED _BYTE
    backColor AS _UNSIGNED _BYTE
    kind AS _UNSIGNED _BYTE
    kind_id AS _UNSIGNED _BYTE
END TYPE

DIM SHARED UI.Controls(1 TO 255) AS UIControl
DIM SHARED UI.Controls.index AS _UNSIGNED _BYTE

'=============================================================================

DIM SHARED UI.Desktop.foreColor AS _UNSIGNED _BYTE
DIM SHARED UI.Desktop.backColor AS _UNSIGNED _BYTE
DIM SHARED UI.Desktop.fillChar AS _UNSIGNED _BYTE

LET UI.Desktop.foreColor = LTGREY
LET UI.Desktop.backColor = BLUE
LET UI.Desktop.fillChar = ASC_BLOCK_MD

'-----------------------------------------------------------------------------

'a title / status bar that stretches across the screen.
'can display text from the left and right sides
TYPE UIDesktopBar
    textLeft AS _UNSIGNED LONG ' index into `UI.Strings`
    textRight AS _UNSIGNED LONG 'index into `UI.Strings`
END TYPE
'the UIBar(s) defined
REDIM SHARED UI.DesktopBars(0 TO 0) AS UIDesktopBar

'-----------------------------------------------------------------------------

TYPE UIWindow
    borderStyle AS _UNSIGNED _BYTE
    decoration AS _UNSIGNED LONG
    cache AS _UNSIGNED LONG
END TYPE
'the UIWindow(s) defined
REDIM SHARED UI.Windows(0 TO 0) AS UIWindow

'-----------------------------------------------------------------------------

TYPE UILabel
    caption AS _UNSIGNED _BYTE
END TYPE
REDIM SHARED UI.Labels(0 TO 0) AS UILabel
